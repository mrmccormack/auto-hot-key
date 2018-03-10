#SingleInstance, force
#o::
Gui, Add, Edit, vMyEdit -WantReturn
Gui, Add, Button, Default, OK
Gui, Show
return

Escape::
Gui, Destroy
return

GuiClose:
Gui, Destroy
return

ButtonOK:
Gui, Submit
SendInput <%MyEdit%>{Enter 2}</%MyEdit%>{Up}{Tab}
Gui, Destroy
Return