clearscreen.
print "* Adjust Orbital Inclination *".

// adjust orbital orbitalInclination to degrees specified

DECLARE PARAMETER DESIREDINC.
print "orbitalInclination: " + DESIREDINC.

LOCK SHIPINC to ROUND(SHIP:OBT:INCLINATION, 2).
LOCK DIFF to DESIREDINC - SHIPINC.
SET MARGIN TO 0.5.

IF ABS(DIFF) < MARGIN { 
	PrintHud("Ship is close enough at "+SHIPINC).
} ELSE { 
	SetInclination().
}

// ********** 

DECLARE FUNCTION SetInclination { 
	PrintHud("desired Inclination: " + DESIREDINC).
	PrintHud("current orbital inclination: "+SHIPINC +"deg").
	PrintHud("Difference: "+DIFF).
	
	SET THROTTLE TO 0. 
	SAS ON.
	
	IF DIFF > 0 { 
		SET DESIRED_STEER TO NORMAL.
	}
	ELSE { 
		SET DESIRED_STEER TO ANTINORMAL.
	}
	
	LOCK STEERING TO DESIRED_STEER.
	
	lock align to abs( cos(facing:pitch) - cos(mySteer:pitch) )
                  + abs( sin(facing:pitch) - sin(mySteer:pitch) )
                  + abs( cos(facing:yaw) - cos(mySteer:yaw) )
                  + abs( sin(facing:yaw) - sin(mySteer:yaw) ).
	
	
	WAIT UNTIL align < 0.2.
	
	SET DESIRED_THROTTLE TO 0.0.
	LOCK THROTTLE TO DESIRED_THROTTLE.
	
	UNTIL DIFF < MARGIN { 
		IF DIFF > 20 { 
			DESIRED_THROTTLE = 1.0.
		}
		ELSE IF DIFF > 10 { 
			DESIRED_THROTTLE = 0.6.
		}
		ELSE IF DIFF > 5 { 
			DESIRED_THROTTLE = 0.4.
		}
		ELSE IF DIFF > 2 { 
			DESIRED_THROTTLE = 0.25.
		}
		ELSE { 
			DESIRED_THROTTLE = 0.1.
		}
	}
	
	UNLOCK THROTTLE.
	SET THROTTLE TO 0.
}


DECLARE FUNCTION PrintHud  {
	PARAMETER message.
	HUDTEXT("kOS Script: "+message, 8, 1, 14, white, true).
}
