// setting variables for the launch profile.
wait 3.
set th to 1.
lock throttle to th.
lock steering to heading (90,90).
stage.
print "Initiate roll program.".
set thrust to ship:availablethrust.
set st to 0.
when ship:availablethrust < (thrust -10) then {
    wait 3.
    set st to st +1.
    set th to .8.
    stage.
    wait 2.
    set th to 1.
    wait 1.
    print "Stage " + st + " seperation successful.".
    set thrust to ship:availablethrust.
    return true.
}.
when ship:verticalspeed > 125  then {
    set steering to heading (90,80).
    print "Initiate pitch program. Starting at 80 deg.".
}.
when ship:verticalspeed > 225 then {
    lock steering to heading (90,70).
    print "Pitch over to 70 deg.".
}.
when ship:verticalspeed > 300 then {
    lock steering to heading (90,60).
    print "Pitch over to 60 deg.".
}.
when ship:verticalspeed > 375 then {
    lock steering to heading (90,50).
    print "Pitch over to 50 deg.".
}.
when ship:groundspeed > 600 then {
    lock steering to heading (90,20).
    print "Pitch over to 20 deg for final ascent to space.".
}.
when ship:altitude > 50000 then {
    SET AG1 TO TRUE.
    print "Jettison aeroshell.".
}.

wait until ship:apoapsis > 85000.
print "Coasting until near apoapsis.".
lock steering to heading (90,0).
set th to 0.

wait until eta:apoapsis < 15.
set th to 1.
print "Firing last burn to gain orbit.".





wait until ship:periapsis > 75000. 
set th to 0.
sas on.
wait 2.
print "Welcome to orbit.".


