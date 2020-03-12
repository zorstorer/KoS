print "T-minus 5....". wait 1.2.
print "T-minus 4....". wait 1.2.
print "T-minus 3....". wait 1.2.
print "T-minus 2....". wait 1.2.
print "T-minus 1....". wait 1.2.
print "Launch".
lock throttle to 1.
lock steering to heading(270,90).
stage.
set launchTime to time:seconds + 69.
wait 2.
//when time:seconds > launchtime then {print "Staging now.". stage.wait 2.}.
set oldThrust to ship:avaiLablethrUST.
WHEN ship:availablethrust < oldthrust - 10 THEN {
    print "Stage sep...1". 
    wait .1. 
    stage. 
    wait .5.
    set oldThrust to ship:availablethrust.
    return true.
  }
lock steering to heading(270,85).
print "" + time.
print ship:availablethrust.
print + round(ship:verticalspeed,1)+ " m/s.".
wait until ship:verticalspeed>125.

    {print "The ships vertical speed is " +round(ship:verticalspeed,1)+ " m/s.".
    wait 1.
    print "68 deg pitch.".
    lock steering to heading(270,68).
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
lock steering to heading (270,60).
wait until ship:altitude>10000.

set oldThrust to ship:avaiLablethrUST.
print "The thrust is " +round(ship:availablethrust,2)+ " k/N.".
lock steering to heading(270,42).
lock throttle to .80.
print "Throttle to 80% and a 42 deg pitch.".
print "" + time.
print "The thrust is " +round(ship:availablethrust,2)+ " k/N.".
wait until ship:apoapsis>75000.
lock steering to prograde.
lock throttle to 0.
print "Waiting to finish orbit.".
print "" + time.

wait until ETA:APOAPSIS<22.
lock throttle to 1.
print "Firing last burn to gain orbit.".
wait until ship:periapsis>70000.
lock throttle to 0.
sas on.
print "" + time.
print "Welcome to orbit!!".