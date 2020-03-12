lock throttle to 1.
print "3...".

wait 1.
print "2...".

wait 1.
print "1...".

wait 1.
stage.

print "Lift Off!!". 
// until ship:ALTITUDE > 2000 { WAIT 2. }

lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
set targetDirection to 0.
lock steering to heading(targetDirection, targetPitch).

set oldThrust to ship:avaiLablethrUST.
WHEN ship:availablethrust < oldthrust - 10 THEN {
    print "Stage sep...". 
    wait .1. 
    lock throttle to .85.
    stage. 
    wait .5.
    lock throttle to 1.
    wait .5.
    set oldThrust to ship:availablethrust.
    //return true.
  }


until ship:apoapsis > 80000 {
    //print "available: " + ship:availablethrust.
    //print "old: " + oldthrust.
  
}
//wait until ship:apoapsis>75000.
lock steering to HEADING (0,0).
lock throttle to 0.
print "Waiting to finish orbit.".


wait until ETA:APOAPSIS<15.
lock throttle to 1.
print "Firing last burn to gain orbit.".
wait until ship:periapsis>75000.



lock throttle to 0.
lock steering to prograde.
sas on.

PRINT "Welcome to orbit!!".