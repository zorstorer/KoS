set somevessel to ship.
set partlist to somevessel:partstagged("solar").
print "There is " + ship:electriccharge + " electric charge left on the ship,".
print "out of a total of " + ship:capacity.
print partlist.
//FOR somesolar IN somevessel:partstagged("solar") {
    //print  partlist:allmodules.
  
  //GETMODULE("setiminisolarretr"):doevent("extend panel").
//}.
print partlist[0]:getmodule("kopernicussolarpanel"):alleventnames.
partlist[0]:getmodule("kopernicussolarpanel"):doevent("extend panel").
partlist[1]:getmodule("kopernicussolarpanel"):doevent("extend panel").