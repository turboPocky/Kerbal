clearscreen.
print "* Adjust Orbital Period *".

// adjust orbital period to as specified
DECLARE PARAMETER orbitalPeriod.

print "orbitalPeriod: " + orbitalPeriod.

HUDTEXT("setting orbital period to "+orbitalPeriod, 5, 1, 12, white, true).


DECLARE FUNCTION STATIONARY_ALTITUDE { 
	//SET ANGULAR_SPEED TO (2*Constant():PI)/(KERBIN:ROTATIONPERIOD).
	
	SET ORBITAL_RADIUS TO ((KERBIN:MU*KERBIN:ROTATIONPERIOD^2)/(4*Constant():PI^2))^(1/3) - KERBIN:RADIUS.
	PRINT "Orbital radius: "+ORBITAL_RADIUS/1000+"m".
	RETURN ORBITAL_RADIUS.	
}

print "current orbital period: "+SHIP:OBT:PERIOD / 60 + "min".
