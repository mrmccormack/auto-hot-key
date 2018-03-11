/*

fixes:
- CapsLock + Esc  forced all caps all the time- but is a TOGGLE - why?

Symbol	Description
!n::Run Notepad ; this means Alt+n
^n::Run Notepad ; this means Ctrl+n
+n::Run Notepad ; this means Shift+n
#n::Run Notepad ; this means the Win+n

&	An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.


*/



/*
 ROB TO DO:

- maybe < and > to do word at a time, and shift too.
 have app switcher , like CapsLock + tab - be Alt-Tab

 - add markdown feature- ref: https://github.com/koepalex/autohotkey-markdown/blob/master/markdown.ahkF


Use Caps Lock for Hand-Friendly Text Navigation

httplifehacker.com5277383use-caps-lock-for-hand+friendly-text-navigation

Written by Philipp Otto, GermanyKK
Script Function

Template script (you can customize this template by editing ShellNewTemplate.ahk in your Windows folder)



    Normal usage with capslock as a modifier

    j left

    k down

    l right

    i up

    h simulates CTRL+left (jumps to the next word)

    ; simulates CTRL+right

    , simulates CTRL+Down

    8 simulates CTRL+Up

    u simulates Home (jumps to the beginning of the current line) (i forgot to mention this in my comment)

    o simulates End

    Backspace simulates Delete

    x cut

    c copy

    v paste



    If you keep pressing "Shift" in addition to Capslock it works as if you are pressing Shift — you highlight the text. Shift + Capslock activates the actual Capslock functionality (normal capslock-hitting deactivates it again).



*/



#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

Menu, Tray, Icon, jiffykeys.ico ; this changes the tray icon to a little keyboard!
;SoundBeep  ; Play the default pitch and duration.
SoundPlay, %A_WinDir%\Media\ding.wav
SoundPlay *-1  ; Simple beep. If the sound card is not available, the sound is generated using the speaker.

OnMessage(0x44, "OnMsgBox")
MsgBox 0x40080, Jiffy Keys , Welcome!, 2
OnMessage(0x44, "")

IfMsgBox Timeout, {
}

OnMsgBox() {
  DetectHiddenWindows, On
  Process, Exist
  If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel))
  {
    hIcon := LoadPicture("imageres.dll", "w32 Icon140", _)
    SendMessage 0x172, 1, %hIcon% , Static1 ;STM_SETIMAGE
  }
}


; HELP FILE
CapsLock & F1::
    Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app="C:\Users\Rob Acer Aspire 3\Documents\GitHub\auto-hot-key\keyboardfonts.html"
    Return
;C:\Users\Rob Acer Aspire 3>"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app="C:\Users\Rob Acer Aspire 3\Documents\GitHub\auto-hot-key\keyboardfonts.html"

SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetCapsLockState, AlwaysOff

CapsLock & i::
if getkeystate("Shift") = 0
  Send,{Up}
else
  Send,+{Up}
return

CapsLock & j::
  if getkeystate("Shift") = 0
    Send,{left}
  else
    Send,+{left}
return

CapsLock & k::
  if getkeystate("Shift") = 0
    Send,{Down}
  else
    Send,+{Down}
return

CapsLock & l::
  if getkeystate("Shift") = 0
    Send,{Right}
  else
    Send,+{Right}
return

; < for HOME, very top
CapsLock & ,::

       if getkeystate("Shift") = 0

               Send,^{Home}

       else

               Send,+^{Home}

return
; > for END, very end
CapsLock & .::

       if getkeystate("Shift") = 0

               Send,^{End}

       else

               Send,+^{End}

return



CapsLock & 8::

       if getkeystate("Shift") = 0

               Send,^{Up}

       else

               Send,+^{Up}

return



CapsLock & u::

       if getkeystate("Shift") = 0

               Send,{PgUp}

       else

               Send,+{PgUp}

return



CapsLock & o::

       if getkeystate("Shift") = 0

               Send,{PgDn}

       else

               Send,+{PgDn}

return



CapsLock & h::

       if getkeystate("Shift") = 0

               Send,{Home}

       else

               Send,+{Home}

return

CapsLock & `;::   ;     ; thats how you send a semi colon


       if getkeystate("Shift") = 0

               Send,{End}

       else

               Send,+{End}

return


CapsLock & '::

       if getkeystate("Shift") = 0

               Send,^{End}

       else

               Send,+^{End}

return



;       CapsLock & SC027::                                  ;has to be changed (depending on the keyboard-layout);
;
;               if getkeystate("Shift") = 0
;
;                       Send,^{Right}
;
;               else
;
;                       Send,+^{Right}
;
;       return


;; try to just Ctrl
;; no workCapsLock::Send,{Control}
; ^#`;::Send, ^{end} ; thats how you send a semi colon
; ^#`;::Send, ^{end} ; thats how you send a semi colon


CapsLock & BS::Send,{Del}
CapsLock & F4::Send,!{F4}


CapsLock & Escape::SetCapsLockState, AlwaysOff  ; needed or cap-esc will toggle state of CapsLock
CapsLock & s::Send ^s   ; save
CapsLock & x::Send ^x
CapsLock & w::Send ^w
CapsLock & r::Send ^r

CapsLock & c::Send ^c

CapsLock & v::Send ^v
CapsLock & z::Send ^z
CapsLock & y::Send ^y  ; redo in some programs.

; maybe add a kehy to select all copy and paste ??? not sure
CapsLock & a::Send ^a

CapsLock & t::Send ^t   ; just like Ctrl-tab for New Tabss
CapsLock & n::Send ^n   ; New Documnet

CapsLock & m::Send #m   ; windows min.
CapsLock & e::Send #e   ; windows min.
CapsLock & d::Send #d   ; windows desktop toggle.
CapsLock & f::Send ^f   ; find


; date and time insert
CapsLock & /::
FormatTime, time, A_now, ddd d-MMM-yy hh:mm tt
send %time%
return


; symbols
CapsLock & 4::Send ©
CapsLock & 1::Run, http://www.google.com ; i.e. any URL can be launched.
CapsLock & 3::Run, atom ; i.e. any URL can be launched.


CapsLock & Up::Send {Volume_Up}
CapsLock & Down::Send {Volume_Down}
CapsLock & Left::Send {Volume_Mute}
CapsLock & Right::Send {Volume_Mute}


CapsLock & \::Send {Enter}

; convient Enter on Notebook
CapsLock & Space::Send {Enter}

; CapsLock by itself is |ENTER
; NOT A GOOD IDEA CapsLock::Send {Enter}

; two fast CapsLock is enter
lastShift := 0


;example of double click
$Capslock::
if ((A_TickCount - lastShift) <= 250)
	Send {Enter}
else
	Send {Shift}
lastShift := A_TickCount
return


;Prevents CapsState-Shifting

;CapsLock & Space::Send,{Space}

*Capslock::SetCapsLockState, AlwaysOff

; this was causing all the trouble, so remove it+Capslock::SetCapsLockState, On


CapsLock & PrintScreen::LaunchSnippingTool()


; ***** HOTSTRINGS *****************

::btw::
MsgBox You typed "btw".
return

; use of semicolons for short cut keys
:*:`;ram::rob.a.mccormack@gmail.com
:*:`;rpc::ReadPlease Corporation
:*:`;ty::Thanks for your email.
:*:`;copy::{ASC 0169}
:*:`;up::{U+2192}
:*:`;down::{U+2193}


:*:.today::  ; This hotstring replaces "]d" with the current date and time via the commands below.
;FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt  ; It will look like 9/1/2005 3:53 PM
FormatTime, CurrentDateTime, A_now, ddd d-MMM-yy hh:mm tt
SendInput %CurrentDateTime%
return

::!text::
(
Any text between the top and bottom parentheses is treated literally, including commas and percent signs.
By default, the hard carriage return (Enter) between the previous line and this one is also preserved.
    By default, the indentation (tab) to the left of this line is preserved.

See continuation section for how to change these default behaviors.
)

LaunchSnippingTool()
{
	IfWinExist , Snipping Tool
	{
		WinActivate , Snipping Tool
		Send ^+n
	} else {
	  Run, C:\Windows\explorer.exe C:\Windows\system32\SnippingTool.exe
		WinWait , Snipping Tool
		WinActivate , Snipping Tool
		Send ^+n
	}

}


/*

Rob McCormack's mods

*/

; search google for selected text.
CapsLock & g::
{
; Send, ^c
Send, {ctrl down}c{ctrl up} ; More secure way to Copy things
Sleep 50

StringLen, Length, Clipboard

;MsgBox, You clipboard "%Length%"

if (Length < 4)
    Clipboard := ""
;InputBox, OutputVar [, Title, Prompt, HIDE, Width, Height, X, Y, Font, Timeout, Default]
InputBox, OutputVar, Jiffy Keys, Add to clipboard contents `n %Clipboard%, , , , , , , 15 ,%Clipboard%
if ErrorLevel
    ;MsgBox, CANCEL was pressed.
    Return
else
    ;MsgBox, You entered "%OutputVar%"

Word := Trim(Clipboard)
Run, http://www.google.com/search?q=%OutputVar%
Return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                      ;;
;; KDE-Style Alt-Grab Window Move Convenience Script    ;;
;;                                                      ;;
;; version 0.1 - 07/24/04                               ;;
;; ck <use www.autohotkey.com forum to contact me>      ;;
;;                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Usage Instructions:
;; -------------------
;; Load Script into AutoHotKey (only verified to work properly with 1.0.16 and Windows XP)
;; - Hold down the Alt key and lef-click anywhere in a window to move the window

LAlt & LButton::
; If this command isn't used, all commands except those documented otherwise (e.g. WinMove and InputBox)
; use coordinates that are relative to the active window
CoordMode, Mouse, Screen

; speed things up
SetWinDelay, 0

; get current mouse position
MouseGetPos, OLDmouseX, OLDmouseY, WindowID

; get the postition and ID of the window under the mouse cursor
WinGetPos, winX, winY, winW, winH ,ahk_id %WindowID%

; Turn off Window Animation
;RegRead, BoolMinAni, HKEY_CURRENT_USER,Control Panel\Desktop\WindowMetrics, MinAnimate
;if BoolMinAni = 1
;{
;	; this has no effect until it's reloaded / re-logon... (-> disabled code)
;	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, MinAnimate, 0
;}

; this restore (= undo max or min) call tells the OS that originally
; maximized windows are now restored/normal and can be moved even after this script takes off
; this is absolutely mandatory for windows which remember their last location like IE windows
; otherwise you cannot properly maximize them anymore

;WinHide, ahk_id %WindowID%
WinRestore, ahk_id %WindowID%
WinMove, ahk_id %WindowID%,,%winX%,%winY%,%winW%,%winH%
;WinShow, ahk_id %WindowID%

Loop
{
	; is the User still keeping that Alt key down?
	GetKeyState, AltKeyState, Alt, P
	if AltKeyState = U ; key has been released
	{
		break
	}

	; get new mouse position
	MouseGetPos, newMouseX, newMouseY

	; get relative mouse X movement
	if newMouseX < %OLDmouseX%
	{
		; mouse was moved to the left
		Xdistance = %OLDmouseX%
		EnvSub, Xdistance, %newMouseX%
		EnvSub, winX, %Xdistance%
	}
	else if newMouseX > %OLDmouseX%
	{
		; mouse was moved to the right
		Xdistance = %newMouseX%
		EnvSub, Xdistance, %OLDmouseX%
		EnvAdd, winX, %Xdistance%
	}
	else
	{
		; mouse X coordinate wasn't changed
	}

	; set OLDmouseX
	OLDmouseX = %newMouseX%

	; repeat the same stuff for the Y-axis
	if newMouseY < %OLDmouseY%
	{
		Ydistance = %OLDmouseY%
		EnvSub, Ydistance, %newMouseY%
		EnvSub, winY, %Ydistance%
	}
	else if newMouseY > %OLDmouseY%
	{
		Ydistance = %newMouseY%
		EnvSub, Ydistance, %OLDmouseY%
		EnvAdd, winY, %Ydistance%
	}
	else
	{
	}
	OLDmouseY = %newMouseY%

	; move Window accordingly
	WinMove, ahk_id %WindowID%,,%winX%,%winY%
}
return



; from https://www.autohotkey.com/docs/scripts/EasyWindowDrag.htm
; Note: You can optionally release CapsLock or the middle mouse button after
; pressing down the mouse button rather than holding it down the whole time.
; This script requires v1.0.25+.

~MButton & LButton::
CapsLock & LButton::
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
if EWD_WinState = 0  ; Only if the window isn't maximized
    SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
    SetTimer, EWD_WatchMouse, Off
    return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
{
    SetTimer, EWD_WatchMouse, Off
    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
    return
}
; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return
