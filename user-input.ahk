
InputBox, UserInput, Email to: ,enter name here, , 240, 240
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    MsgBox, You entered "%UserInput%"
    send %UserInput%
