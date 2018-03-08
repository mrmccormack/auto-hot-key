
; -----------------------------------------------
;                InputBox Creator
; -----------------------------------------------
; Resize and/or reposition the test InputBox to
; automatically upate the w, h, x, y parameters.
; -----------------------------------------------
;             boiler at ahkscript.org
;   Based on MsgBox Creator in SciTE4Autohotkey
; -----------------------------------------------

#SingleInstance, Force

OnMessage(0x110, "WM_INITDIALOG")
OnMessage(0x231, "WM_ENTERSIZEMOVE")
OnMessage(0x232, "WM_EXITSIZEMOVE")
SysGet, ScrXMin, 76 ; SM_XVIRTUALSCREEN
SysGet, ScrYMin, 77 ; SM_XVIRTUALSCREEN
SysGet, ScrW, 78 ; SM_CXVIRTUALSCREEN
SysGet, ScrH, 79 ; SM_CYVIRTUALSCREEN
ScrXMax := ScrXmin + ScrW - 100
ScrYMax := ScrYmin + ScrH - 50

Gui, +HwndMainHwnd +OwnDialogs
Gui, Add, Text, x10 y10 section, Title:
Gui, Add, Edit, xs+0 ys+15 section w350 vTitle gCreate_InputBox_Command,
Gui, Add, Text, xs+0 ys+25 section, Prompt:
Gui, Add, Edit, xs+0 ys+15 section r2 w350 vText gCreate_InputBox_Command WantTab,
Gui, Add, Text, xs+0 ys+40 section, Default edit field text:
Gui, Add, Edit, xs+0 ys+15 section w350 vDefault gCreate_InputBox_Command WantTab,

Gui, Add, Checkbox, x15 y165 vHide gCreate_InputBox_Command, Password Field
Gui, Add, Groupbox, x130 y150 h45 w110 section, Timeout
Gui, Add, Checkbox, xs+10 ys+20 w23 vTimeoutEnable gCreate_InputBox_Command
Gui, Add, Edit, xs+33 ys+17 w67 vTimeout gCreate_InputBox_Command
Gui, Add, UpDown, Range0-2147483, 1
Gui, Add, Groupbox, x10 yp+40 h45 w110 section, Width
Gui, Add, Checkbox, xs+10 ys+20 w23 vWEnable gCreate_InputBox_Command
Gui, Add, Edit, xs+33 ys+17 w67 vWidth gCreate_InputBox_Command
Gui, Add, UpDown, Range0-%ScrXMax%, 375
Gui, Add, Groupbox, x130 ys h45 w110 section, Height
Gui, Add, Checkbox, xs+10 ys+20 w23 vHEnable gCreate_InputBox_Command
Gui, Add, Edit, xs+33 ys+17 w67 vHeight gCreate_InputBox_Command
Gui, Add, UpDown, Range0-%ScrYMax%, 189
Gui, Add, Groupbox, x10 yp+40 h45 w110 section, X Position
Gui, Add, Checkbox, xs+10 ys+20 w23 vXEnable gCreate_InputBox_Command
Gui, Add, Edit, xs+33 ys+17 w67 vXpos gCreate_InputBox_Command
Gui, Add, UpDown, Range%ScrXMin%-%ScrXMax%
Gui, Add, Groupbox, x130 ys h45 w110 section, Y Postion
Gui, Add, Checkbox, xs+10 ys+20 w23 vYEnable gCreate_InputBox_Command
Gui, Add, Edit, xs+33 ys+17 w67 vYpos gCreate_InputBox_Command
Gui, Add, UpDown, Range%ScrYMin%-%ScrYMax%

Gui, Add, Button, x270 y175 h30 w65 section vTest gTest, &Test
Gui, Font, s12
Gui, Add, Button, xs+70 yp h30 w20 vHelp gHelp, &?
Gui, Font, s8
Gui, Add, Button, xs yp+40 h30 w90 Default gCopyResult, &Copy Result
Gui, Add, Button, xs yp+40 h30 w90 gReset, &Reset

Gui, Add, Text, x10 y325 h75 section, Result:
Gui, Add, Edit, xs ys+20 w350 r3 vInputBox_Command

GuiControl, Disable, Timeout
GuiControl, Disable, Width
GuiControl, Disable, Height
GuiControl, Disable, Xpos
GuiControl, Disable, Ypos

Gui, Show, , InputBox Creator

GoSub, Reset      ;Initalize GUI
return
; ---------------------------
; End of Auto-Execute Section
; ---------------------------

WM_INITDIALOG()
{
	Global
	PositionChange := 0
	SizeChange := 0
}

WM_ENTERSIZEMOVE()
{
	Global
	IfWinNotActive, ahk_id %MainHwnd%
	{
		if not PositionChange
			WinGetPos, InitX, InitY,,, A
		if not SizeChange
			WinGetPos,,, InitW, InitH, A
	}
}

WM_EXITSIZEMOVE()
{
	Global
	IfWinNotActive, ahk_id %MainHwnd%
	{
		WinGetPos, NewX, NewY, NewW, NewH, A
		if (NewX != InitX) or (NewY != InitY)
			PositionChange := 1
		if (NewW != InitW) or (NewH != InitH)
			SizeChange := 1
	}
}

Help:
	MsgBox, % 64 + 8192, Automatic Size and Position Change, Resize the test InputBox by dragging the borders, and the new width and height will automatically update when you close it by clicking 'OK'.  Click 'Cancel' and it will not update the parameters.`n`nMoving the InputBox will similarly change the X,Y position automatically.
return

Create_InputBox_Command:
	Gui, Submit, NoHide

	if TimeoutEnable
		GuiControl, Enable, Timeout
	else
		GuiControl, Disable, Timeout
	if WEnable
		GuiControl, Enable, Width
	else
		GuiControl, Disable, Width
	if HEnable
		GuiControl, Enable, Height
	else
		GuiControl, Disable, Height
	if XEnable
		GuiControl, Enable, Xpos
	else
		GuiControl, Disable, Xpos
	if YEnable
		GuiControl, Enable, Ypos
	else
		GuiControl, Disable, Ypos
	
	if TestMode
		return

	Escape_Characters(Title)
	Escape_Characters(Text)
	Escape_Characters(Default)

	;Create command and set it to Edit-Control
	InputBox_Command := "InputBox, OutputVar, " . Title . ", " . Text . ", " . (Hide ? "HIDE, " : ", ") . (WEnable ? Width : "") . ", " . (HEnable ? Height : "") . ", " . (XEnable ? Xpos : "") . ", " . (YEnable ? Ypos : "") . ", , " . (TimeoutEnable ? Timeout : "") . ", " . Default
	GuiControl, , InputBox_Command, %InputBox_Command%
return

Test:
	TestMode := true
	GoSub, Create_InputBox_Command
	TestMode := false
	Gui, +OwnDialogs
	Title := Title ? Title : "%A_ScriptName%"
	InputBox, Dummy, %Title%, %Text%, % Hide ? "HIDE" : "", % WEnable ? Width : "", % HEnable ? Height: "", % XEnable ? Xpos : "", % YEnable ? Ypos : "",, % TimeoutEnable ? Timeout : "", %Default%
	if (PositionChange and not ErrorLevel)
	{
		GuiControl,, XEnable, 1
		GuiControl,, YEnable, 1
		GuiControl, Enable, Xpos
		GuiControl, Enable, Ypos
		GuiControl,, Xpos, %NewX%
		GuiControl,, Ypos, %NewY%
	}
	if (SizeChange and not ErrorLevel)
	{
		GuiControl,, WEnable, 1
		GuiControl,, HEnable, 1
		GuiControl, Enable, Width
		GuiControl, Enable, Height
		GuiControl,, Width, %NewW%
		GuiControl,, Height, %NewH%

	}
return

;Escapes Characters like ","
Escape_Characters(byref Var)
{
	StringReplace, Var, Var, `n, ``n, All      ;Translate line breaks in entered text
	StringReplace, Var, Var, `,, ```,, All      ;Escapes ","
	StringReplace, Var, Var, `;, ```;, All      ;Escapes ";"
}

GuiClose:
ExitApp

Open:
	Gui, Show
return

Reset:
	GuiControl,, Title
	GuiControl,, Text
	GuiControl,, Default
	GuiControl,, Hide, 0
	GuiControl,, TimeoutEnable, 0
	GuiControl,, WEnable, 0
	GuiControl,, HEnable, 0
	GuiControl,, XEnable, 0
	GuiControl,, YEnable, 0
	GuiControl, Disable, Timeout
	GuiControl, Disable, Width
	GuiControl, Disable, Height
	GuiControl, Disable, Xpos
	GuiControl, Disable, Ypos
	GuiControl,, Timeout, 1
	GuiControl,, Width, 375
	GuiControl,, Height, 189
	GuiControl,, Xpos, 0
	GuiControl,, Ypos, 0
return

CopyResult:
	Clipboard := InputBox_Command
	MsgBox, 8256, Copied to ClipBoard, The InputBox command has been copied to the clipboard and is ready to paste into your editor.
return
