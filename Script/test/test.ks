//////////
// This script will attempt to launch a ship into a stable (equatorial) orbit.
// It started life as the sample launch script from the wiki, but has since
// evolved into something a bit more useful.
//
// It is assumed that any stages are fair game for getting to orbit and that
// there is a single radially mounted SRB stage at the initial launch that
// overlaps with the main liquid engine(s).
//
// - al [2/14/2017]

//////////

// Orbital wishlist
SET TARGET_AP TO 90000.
SET TARGET_PE TO 80000.

// Gravity turn params
SET SPEED_MIN TO 100.
SET SPEED_STEP TO 50.
SET PITCH_MAX TO 90.
SET PITCH_MIN TO 10.
SET PITCH_STEP TO 5.

// Row to display orbit stats on
SET ROW_STATE TO 20.

// Max fuel not to count as a separator
SET SEP_SOLID TO 25.

//////////

// Identify SRB's and count any fuel in the separators
SET SOLID_EMPTY TO 1.

LIST ENGINES IN ENGLIST.
FOR ENG IN ENGLIST {
	IF ENG:ALLOWSHUTDOWN = FALSE {
		// PRINT "Found SRB " + ENG:NAME.
		FOR RES IN ENG:RESOURCES {
			// PRINT "  - " + RES:NAME + " = " + RES:AMOUNT.
			IF RES:AMOUNT < SEP_SOLID {
				SET SOLID_EMPTY TO SOLID_EMPTY + RES:AMOUNT.
			}.
		}.
	}.
}.

CLEARSCREEN.
SET V0 TO GetVoice(0).

PRINT "Counting down".
FROM {local countdown is 3.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "  ... " + countdown + " " AT (0,1).
	V0:PLAY( NOTE( 440, 0.25) ).
    WAIT 1.
}.

V0:PLAY( NOTE( 880, 1) ).
PRINT "Blast off!".
LOCK THROTTLE TO 1.0.
RCS OFF.
stage.
SET HEAD TO HEADING(90,90).
LOCK STEERING TO HEAD.
set oldthrust to ship:availablethrust.
//print ship:availablethrust.
print oldthrust + " k/N.".
WHEN ship:availablethrust < (oldthrust - 10) THEN {
    PRINT "Staging".
    STAGE.
	wait 1.
	set oldthrust to ship:availablethrust.
    PRESERVE.
}.

// Jettison srb's... ONCE
// WHEN STAGE:SOLIDFUEL < SOLID_EMPTY THEN {
// 	PRINT "Staging SRB's".
// 	STAGE.
// 	wait 1.
// }.

// Open the throttle, but save the mono


// Point straight up

UNTIL SHIP:APOAPSIS > TARGET_AP {

	// Resist burning up
	IF SHIP:APOAPSIS < 45000 AND SHIP:VELOCITY:SURFACE:MAG >= 1500 {
		IF THROTTLE > 0.5 PRINT "Too fast in atmo, cutting throttle to 50%".
		LOCK THROTTLE TO 0.50.
	} ELSE IF SHIP:APOAPSIS < 60000 AND SHIP:VELOCITY:SURFACE:MAG >= 2000 {
		IF THROTTLE > 0.75 PRINT "Too fast in atmo, cutting throttle to 75%".
		LOCK THROTTLE TO 0.75.
	} ELSE IF THROTTLE < 1.0 {
		PRINT "Restoring 100% throttle".
		LOCK THROTTLE TO 1.0.
	}.
	
	// Handle steering
	
	SET SPEED TO SHIP:VELOCITY:SURFACE:MAG.
	
	IF SPEED < SPEED_MIN {
		SET HEAD TO HEADING(90,PITCH_MAX).
		PRINT "Pitching straight up." AT (0,ROW_STATE).
	} ELSE {
		SET SPEED_INC TO (SPEED - SPEED_MIN) / SPEED_STEP.
		SET PITCH TO ROUND(PITCH_MAX - (SPEED_INC * PITCH_STEP),1).
		IF PITCH < PITCH_MIN SET PITCH TO PITCH_MIN.
		
		PRINT "Pitching to "+ROUND(PITCH,0)+" degrees..." AT (0,ROW_STATE).
		PRINT "  AP = "+ROUND(SHIP:APOAPSIS,0)+"      " AT (0,ROW_STATE+1).
		PRINT "  PE = "+ROUND(SHIP:PERIAPSIS,0)+"      " AT (0,ROW_STATE+2).
		
		SET HEAD TO HEADING(90,PITCH).
	}.
	
}.

PRINT "Target apoapsis reached, cutting throttle".
LOCK THROTTLE TO 0.

// We haven't engaged our burn yet
SET BURNING TO FALSE.

// We will want RCS here in case something goes wrong (like fast forward)
RCS ON.

UNTIL SHIP:PERIAPSIS > TARGET_PE {
	// Hold the ship pointing prograde
	SET HEAD TO SHIP:PROGRADE.

	IF BURNING {
		PRINT "Burning into stable orbit"  AT (0,ROW_STATE).
		PRINT "  AP = "+ROUND(SHIP:APOAPSIS,0)+"      " AT (0,ROW_STATE+1).
		PRINT "  PE = "+ROUND(SHIP:PERIAPSIS,0)+"      " AT (0,ROW_STATE+2).
	} ELSE IF ETA:APOAPSIS < 5 {
		PRINT "Burning.".
		PRINT " ETA = NOW               " AT (0,ROW_STATE+3).
		LOCK THROTTLE TO 1.
		SET BURNING TO TRUE.
	} ELSE {
		PRINT "Waiting until apoapsis..."  AT (0,ROW_STATE).
		PRINT "  AP = "+ROUND(SHIP:APOAPSIS,0)+"      " AT (0,ROW_STATE+1).
		PRINT "  PE = "+ROUND(SHIP:PERIAPSIS,0)+"      " AT (0,ROW_STATE+2).
		PRINT " ETA = "+ROUND(ETA:APOAPSIS,0)+"      " AT (0,ROW_STATE+3).
	}.
}.

PRINT "Target periapsis reached, cutting throttle".
LOCK THROTTLE TO 0.

// Because we can
PRINT "Deploying panels...".
PANELS ON.
RADIATORS ON.

// TODO: deploy antennae

// This sets the user's throttle setting to zero to prevent the throttle
// from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.