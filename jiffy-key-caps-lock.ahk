/*

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

    b cut

    c copy

    v paste



    If you keep pressing "Shift" in addition to Capslock it works as if you are pressing Shift — you highlight the text. Shift + Capslock activates the actual Capslock functionality (normal capslock-hitting deactivates it again).



*/



#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.



SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



SetCapsLockState, AlwaysOff



CapsLock & i::

       if getkeystate("Shift") = 0

                        {

                        Send,{Up}

                        }

       else           {

               Send,+{Up}

                        }

return



CapsLock & l::

       if getkeystate("Shift") = 0

               Send,{Right}

       else

               Send,+{Right}

return



CapsLock & j::

       if getkeystate("Shift") = 0

               Send,{Left}

       else

               Send,+{Left}

return



CapsLock & k::

       if getkeystate("Shift") = 0

               Send,{Down}

       else

               Send,+{Down}

return



CapsLock & ,::

       if getkeystate("Shift") = 0

               Send,^{Down}

       else

               Send,+^{Down}

return



CapsLock & 8::

       if getkeystate("Shift") = 0

               Send,^{Up}

       else

               Send,+^{Up}

return



CapsLock & u::

       if getkeystate("Shift") = 0

               Send,{Home}

       else

               Send,+{Home}

return



CapsLock & o::

       if getkeystate("Shift") = 0

               Send,{End}

       else

               Send,+{End}

return



CapsLock & H::

       if getkeystate("Shift") = 0

               Send,^{Left}

       else

               Send,+^{Left}

return



       CapsLock & SC027::                                  ;has to be changed (depending on the keyboard-layout)

               if getkeystate("Shift") = 0

                       Send,^{Right}

               else

                       Send,+^{Right}

       return



CapsLock & BS::Send,{Del}

CapsLock & x::Send ^x
CapsLock & w::Send ^w
CapsLock & r::Send ^r

CapsLock & c::Send ^c

CapsLock & v::Send ^v

; maybe add a kehy to select all copy and paste ??? not sure
CapsLock & a::Send ^a



;Prevents CapsState-Shifting

CapsLock & Space::Send,{Space}



*Capslock::SetCapsLockState, AlwaysOff

+Capslock::SetCapsLockState, On

/*

Rob McCormack's mods

*/

; search google for selected text
CapsLock & g::
{
Send, ^c

InputBox, UserInput, Search Google for: %clipboard% and: ,enter additional search term, , 240, 240
;if ErrorLevel
    ;MsgBox, CANCEL was pressed.
;else
    ;MsgBox, You entered "%UserInput%"


Sleep 50
Run, http://www.google.com/search?q=%clipboard% %UserInput%
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
