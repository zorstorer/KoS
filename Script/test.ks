PRINT "Electric charge capacity: " + ROUND(ship_resource("electriccharge"):CAPACITY,1).
PRINT "Current electric charge is: " + ROUND(ship_resource("electriccharge"):amount,1).


FUNCTION ship_resource {
	PARAMETER resName.
	FOR res in SHIP:RESOURCES {
		IF res:NAME = resName {
			RETURN res.
		}
	}
}

//function elec_charge {
    set x to + ROUND(ship_resource("electriccharge"):CAPACITY,1).
    set y to + ROUND(ship_resource("electriccharge"):amount,1).
    set z to + round(y/x,2).


//}
Print "If charge falls below 50% the panels will deploy." + (z).
//print x.
//print y.
//print z.