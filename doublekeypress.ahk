lastShift := 0

$Capslock::
if ((A_TickCount - lastShift) <= 250)
	Send {Enter}
else
	Send {Shift}
lastShift := A_TickCount
return
