/* -----------------------------------------------------------------------------
--------------------------- JiffyKeys-------------------------------------------
--------------------------------------------------------------------------------
             CapsLock for navigation and SetCapsLockState
--------------------------------------------------------------------------------
# HELP Files
- Press CapsLock + F1 for all Keys
___________________
# Symbol	Description
!n::Run Notepad ; this means Alt+n
^n::Run Notepad ; this means Ctrl+n
+n::Run Notepad ; this means Shift+n
#n::Run Notepad ; this means the Win+n

&	An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

_______________
 # ROB TO DO:
- add a button to MsgBox to search google within last year
- have app switcher , like CapsLock + tab - be Alt-Tab
- add markdown feature- ref: https://github.com/koepalex/autohotkey-markdown/blob/master/markdown.ahkF
- httplifehacker.com5277383use-caps-lock-for-hand+friendly-text-navigation
- Originally written by Philipp Otto, Germany


*/
;-------------------------------------------------------------------------------

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

version:=0.1
; this changes the tray icon to a little keyboard!
Menu, Tray, Icon, jiffykeys.ico
;SoundBeep  ; Play the default pitch and duration.
SoundPlay, %A_WinDir%\Media\ding.wav
SoundPlay *-1  ; Simple beep. If the sound card is not available, the sound is generated using the speaker.

; Splash Screen
OnMessage(0x44, "OnMsgBox")
MsgBox 0x40080, Jiffy Keys , Welcome! `n`n`nversion: %version%, 2
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

; ------------------------------------------------------------------------------
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetCapsLockState, AlwaysOff


; HELP FILE
CapsLock & F1::
    Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app="C:\Users\Rob Acer Aspire 3\Documents\GitHub\auto-hot-key\keyboardfonts.html"
    Return
;C:\Users\Rob Acer Aspire 3>"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app="C:\Users\Rob Acer Aspire 3\Documents\GitHub\auto-hot-key\keyboardfonts.html"

;CapsLock & Tab:: AltTab
;  h::AltTabMenu

; ----------------------Navigation Keys-----------------------------------------


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
  Send,+^{End
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


; ----------------------Other Keys----------------------------------------------
CapsLock & BS::Send,{Del}
CapsLock & F4::Send,!{F4}  ; Alt-F4 close

CapsLock & Escape::
  {
    SetCapsLockState, AlwaysOff  ; needed or cap-esc will toggle state of CapsLock
    Run, taskmgr,,   ; run taskmanager
  }

  ; ----------------------Remap Control Key----------------------------------------------
CapsLock & s::Send ^s   ; save
CapsLock & x::Send ^x
CapsLock & w::Send ^w
CapsLock & r::Send ^r
CapsLock & c::Send ^c
CapsLock & v::Send ^v
CapsLock & z::Send ^z
CapsLock & y::Send ^y  ; redo in some programs.
CapsLock & a::Send ^a
CapsLock & t::Send ^t   ; just like Ctrl-tab for New Tabss
CapsLock & n::Send ^n   ; New Documnet
CapsLock & m::Send #m   ; windows min.
CapsLock & e::Send #e   ; windows min.
CapsLock & d::Send #d   ; windows desktop toggle.
CapsLock & f::Send ^f   ; find

; ----------------------Other Functions-----------------------------------------
; date and time insert
CapsLock & /::
FormatTime, time, A_now, ddd d-MMM-yy hh:mm tt
send %time%
return

; ----------------------Symbols-------------------------------------------------



; ----------------------Other Apps Quick Launch---------------------------------

CapsLock & 1::Run, http://www.google.com ;

; ----------------------Media Functions-----------------------------------------

CapsLock & Up::Send {Volume_Up}
CapsLock & Down::Send {Volume_Down}
CapsLock & Left::Send {Media_Prev}
CapsLock & Right::Send {Media_Next}
CapsLock & RShift::Send {Media_Play_Pause}

CapsLock & \::Send {Enter}
; convient Enter on Notebook
CapsLock & Space::Send {Enter}
; CapsLock by itself is |ENTER
; NOT A GOOD IDEA CapsLock::Send {Enter}
; two fast CapsLock is enter
lastShift := 0

; ----------------------Double Click-------------------------------------------------

;example of double click
$Capslock::
if ((A_TickCount - lastShift) <= 250)
  Send {Enter}
else
  Send {Shift}
lastShift := A_TickCount
return

;Prevents CapsState-Shifting
*Capslock::SetCapsLockState, AlwaysOff

; this was causing all the trouble, so remove it+Capslock::SetCapsLockState, On
CapsLock & PrintScreen::LaunchSnippingTool()

; ----------------------HotStrings----------------------------------------------

::btw::
MsgBox You typed "btw".
return

; use of semicolons for short cut keys
:*:`;ram::rob.a.mccormack@gmail.com
:*:`;wil::What I Learned Document
:*:`;rm::Rob McCormack
:*:`;tb::Thunder Bay
:*:`;rpc::ReadPlease Corporation
:*:`;ty::Thanks for your email.
:*:`;copy::{ASC 0169}
:*:`;up::{U+2192}
:*:`;down::{U+2193}

:*:`;today::  ; current date and time
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

; ----------------------Snipiping Tool------------------------------------------

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

; ----------------------Search for Google-------------------------------------------------
CapsLock & g::
{
  ; Send, ^c
  Send, {ctrl down}c{ctrl up} ; More secure way to Copy things
  Sleep 50

  StringLen, Length, Clipboard
  if (Length < 4)
      Clipboard := ""
  ;InputBox, OutputVar [, Title, Prompt, HIDE, Width, Height, X, Y,, Timeout, Default]
  InputBox, OutputVar, Jiffy Keys, Add to selection`nTIP: `n`;`; to search last year `n:: search StackOverFlow, , , , , , , ,%Clipboard%
  if ErrorLevel
    ;MsgBox, CANCEL was pressed.
    Return


  Word := Trim(Clipboard)

  ;Word := StrReplace(Word, "`r`n")
  ; search last year https://supple.com.au/tools/google-advanced-search-operators/
  ; https://www.google.com.au/search?q=star+wars&tbs=qdr:y

  datetoken := ";;"
  If InStr(OutputVar, datetoken)
    {
      searchstring:= StrReplace(OutputVar, datetoken)
      Run, http://www.google.com/search?q=%searchstring%&tbs=qdr:y
      Return
    }

    datetoken := "::"
    If InStr(OutputVar, datetoken)
      {
        searchstring:= StrReplace(OutputVar, datetoken)
        Run, https://stackoverflow.com/search?q=%searchstring%
        Return
      }


    Run, http://www.google.com/search?q=%OutputVar%

  Return








}

; -------------------------Windows ---------------------------------------------




; ------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
