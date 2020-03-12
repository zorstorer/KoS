lock throttle to 1.
print "3...".

wait 1.
print "2...".

wait 1.
print "1...".

wait 1.
stage.

print "Lift Off!!". 
//LOCK STEERING TO HEADING(0, 90).

// until ship:ALTITUDE > 2000 { WAIT 2. }

lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
set targetDirection to 90.
lock steering to heading(targetDirection, targetPitch).

set oldThrust to ship:avaiLablethrUST.
until ship:apoapsis > 175000 {
    //print "available: " + ship:availablethrust.
    //print "old: " + oldthrust.
  if ship:availablethrust < oldthrust - 10 {
    print "Stage sep...". 
    wait 15. 
    // lock throttle to .85.
    stage. 
    // wait .5.
    // lock throttle to 1.
    wait .5.
    set oldThrust to ship:availablethrust.
  }
}

lock throttle to 0.
lock steering to prograde.
sas on.

PRINT "Welcome to orbit!!".