print "T-minus 5....". wait 1.2.
print "........4....". wait 1.2.
print "........3....". wait 1.2.
print "........2....". wait 1.2.
print "........1....". wait 1.2.
print "Launch!!!!!!!".
set th to 1.
lock throttle to th.
stage.
wait 2.
lock steering to heading(90,90).
set st to 0.
set oldThrust to ship:avaiLablethrUST.
WHEN ship:availablethrust < oldthrust - 10 THEN {
    print "Stage " + (st + 1) + " seperation go!!". 
    wait .1. 
    stage. 
    wait .5.
    set oldThrust to ship:availablethrust.
    set st to st + 1.
    print + round(ship:verticalspeed,1)+ " m/s.".
    print "The thrust is " +round(ship:availablethrust,2)+ " k/N.".
    return true.
  }
lock steering to heading(90,85).
print time.
print ship:availablethrust.
print + round(ship:verticalspeed,1)+ " m/s.".
wait until ship:verticalspeed>125.

    {print "The ships vertical speed is " +round(ship:verticalspeed,1)+ " m/s.".
    wait 1.
    print "68 deg pitch.".
    lock steering to heading(90,68).
    print "" + time.   }


when ship:altitude >25000 then {ag1 on.}.
// WHEN ship:availablethrust < oldthrust - 10 THEN {
//     print "Stage sep...2". 
//     wait .1. 
//     lock throttle to .85.
//     stage. 
//     wait 1.5.
//     lock throttle to 1.
//     wait .5.
//     set oldThrust to ship:availablethrust.
//   }
lock steering to heading (90,60).
wait until ship:altitude>10000.

set oldThrust to ship:avaiLablethrUST.
print "The thrust is " +round(ship:availablethrust,2)+ " k/N.".
lock steering to heading(90,42).
lock throttle to .80.
print "Throttle to 80% and a 42 deg pitch.".
print "" + time.
//print "The thrust is " +round(engine:thrust,2)+ " k/N.".

wait until ship:apoapsis>95000.
lock steering to prograde.
lock throttle to 0.
print "Waiting to finish orbit.".
print "" + time.

wait until ETA:APOAPSIS<32.
lock throttle to 1.
print "Firing last burn to gain orbit.".

wait until ship:periapsis>80000.
sas on.
lock throttle to 0.
wait 1.
print "" + time.
print "Welcome to orbit!!".
unlock all.