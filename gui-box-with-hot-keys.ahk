#NoEnv
#SingleInstance force

; TODO, if press F1 again, destory or get error
F1::

    aa := "1) opt 1 or (f)"
    bb := "2) opt 2 (v)"
    cc := "3) open opt 3"
    dd := "4) open opt 4"

    Gui, Add,   Text, x50  y50  w100 h30, %aa%
    Gui, Add,   Text, x50  y70  w100 h30, %bb%
    Gui, Add,   Text, x50  y90  w300 h30, %cc%
    Gui, Add,   Text, x50  y110 w300 h30, %dd%

    Gui, Add,   Text, x50  y140 w50  h20, Selection:
    Gui, Add,   Edit, x100 y140 w100 h20 vChoice
    Gui, Add,   Text, x205 y140 w300 h30, (press ENTER)

    Gui, Add, Button, x50  y170 w50 h30  gCancel, Cancel
    Gui, Add, Button, x130 y170 w50 h30  default gSubmit, Submit

    Gui, Color, EEAA99
    WinSet, TransColor, ff00ff
    Gui, Show, w350 h250, Enter Selection

return

#If WinActive("Enter Selection")
    f:: Send 1{Tab 2}{Enter}
    v:: Send 2{Tab 2}{Enter}
#If

Submit:
    Gui, Submit

    if (Choice = "2")
    {
        msgbox chose 2
    }
    else if (Choice = "3")
    {
        msgbox chose 3
    }
    else if (Choice = "4")
    {
        msgbox chose 4
    }
    else
    {
        msgbox chose 1
    }

    Gui, Destroy
return

Cancel:
    Gui, Destroy
return
