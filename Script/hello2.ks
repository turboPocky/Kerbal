clearscreen.
print "hellO!".

print "Countdown initiated:".
FROM { local x is 10. } UNTIL x = 0 STEP {set x to x-1.} DO {
  print "T -" + x.
}

HUDTEXT("eeehhhh... HOG", 5, 4, 15, blue, true).
