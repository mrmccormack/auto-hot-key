ShowToolsDialog:
    Gui ToolsDlg: New, +LabelToolsDlg +hWndhToolsDlg
    SetWindowIcon(hToolsDlg, IconLib, 43)
    Gui Font, s9, Segoe UI
    Gui Color, White
    Gui Add, Text, x13 y7 w120 h23 +0x200, Tools:
    Gui Add, ListView, hWndhToolList gToolListHandler x13 y33 w305 h194 -Hdr -Multi +LV0x14000 AltSubmit, Tools
    Gui Add, Button, gAddTool x327 y33 w84 h24 +Default, &Add
    Gui Add, Button, gRemoveTool x327 y64 w84 h24, &Remove

    Gui Add, Button, gMoveToolUp x327 y172 w84 h24, Move &Up
    Gui Add, Button, gMoveToolDown x327 y203 w84 h24, Move &Down
    Gui Add, Text, x13 y239 w84 h23 +0x200 Disabled, Title:
    Gui Add, Edit, hWndhEdtToolTitle vToolTitle gUpdateToolTitle x100 y240 w281 h21 Disabled
    Gui Add, Text, x13 y269 w84 h23 +0x200 Disabled, File:
    Gui Add, Edit, vToolFile x100 y270 w281 h21 Disabled
    Gui Add, Button, vToolBtnFile gSelectTool x387 y269 w23 h23 Disabled, ...
    Gui Add, Text, x13 y299 w84 h23 +0x200 Disabled, Parameters:
    Gui Add, Edit, vToolParams x100 y300 w281 h21 Disabled
    Gui Add, Button, hWndhBtnParams vToolBtnParams gShowPlaceholdersMenu x387 y299 w23 h23 Disabled, ?
    Gui Add, Text, x13 y329 w84 h23 +0x200 Disabled, Working Dir:
    Gui Add, Edit, vToolWorkingDir x100 y330 w281 h21 Disabled
    Gui Add, Button, vToolBtnWorkingDir gSelectWorkingDir x387 y329 w23 h23 Disabled, ...
    Gui Add, Text, x13 y359 w84 h23 +0x200 Disabled, Icon:
    Gui Add, Edit, vToolIcon x100 y360 w234 h21 Disabled
    Gui Add, Edit, vToolIconIndex x341 y360 w40 h21 Disabled
    Gui Add, Button, vToolBtnIcon gChooseToolIcon x387 y359 w23 h23 Disabled, ...
    Gui Add, Text, x-1 y401 w425 h49 +Border -Background
    Gui Add, Button, gToolsDlgOK x80 y414 w84 h24, &OK
    Gui Add, Button, gToolsDlgClose x170 y414 w84 h24, &Cancel
    Gui Add, Button, gToolsDlgApply x260 y414 w84 h24, A&pply
    Gui Show, w423 h449, Configure Tools
    DllCall("UxTheme.dll\SetWindowTheme", "Ptr", hToolList, "WStr", "Explorer", "Ptr", 0)

    GoSub LoadTools
Return

LoadTools:
    Global Tools := []
    Global CurrentRow := 0
    Global ToolsImageList := IL_Create(100)

    IniRead IniSections, %g_IniTools%

    Loop Parse, IniSections, `n, `r
    {
        File       := ReadIni(g_IniTools, A_LoopField, "File")
        Params     := ReadIni(g_IniTools, A_LoopField, "Params", "")
        WorkingDir := ReadIni(g_IniTools, A_LoopField, "WorkingDir", "")
        Icon       := ReadIni(g_IniTools, A_LoopField, "Icon", "")
        IconIndex  := ReadIni(g_IniTools, A_LoopField, "IconIndex", 1)

        ILIndex := IL_Add(ToolsImageList, GetToolIconPath(Icon), IconIndex)
        LV_Add("Icon" . ILIndex, A_LoopField)

        SetToolValues(A_Index, A_LoopField, File, Params, WorkingDir, Icon, IconIndex)
    }

    LV_SetImageList(ToolsImageList)

    LV_ModifyCol(1, "AutoHdr")
Return

ReloadTools:
    Gui ToolsDlg: Default

    ToolsImageList := IL_Create(100)
    LV_Delete()
    LV_SetImageList(ToolsImageList)

    For Each, Item in Tools {
        If (Item.Icon != "") {
            IconIndex := IL_Add(ToolsImageList, GetToolIconPath(Item.Icon), Item.IconIndex)
        } Else {
            IconIndex := 0
        }

        LV_Add("Icon" . IconIndex, Item.Title)
    }

    LV_ModifyCol(1, "AutoHdr")
Return

ToolsDlgEscape:
ToolsDlgClose:
    Gui ToolsDlg: Destroy
Return

ToolsDlgClear:
    GuiControl,, ToolTitle
    GuiControl,, ToolFile
    GuiControl,, ToolParams
    GuiControl,, ToolWorkingDir
    GuiControl,, ToolIcon
    GuiControl,, ToolIconIndex
Return

AddTool:
    GoSub ToolsEnableFields

    Gui ListView, %hToolList%
    CurrentRow := LV_Add("Icon 0", "")
    LV_Modify(CurrentRow, "Select")

    GoSub ToolsDlgClear

    GoSub SelectTool

    LV_ModifyCol(1, "AutoHdr")
    SendMessage 0x115, 7, 0,, ahk_id %hToolList% ; WM_VSCROLL, SB_BOTTOM
Return

RemoveTool:
    Gui ListView, %hToolList%
    Row := LV_GetNext()
    If (Row) {
        LV_Delete(Row)
        Tools.RemoveAt(Row)
        GoSub ToolsDlgClear
        CurrentRow := 0
        LV_ModifyCol(1, "AutoHdr")
    }
Return

MoveToolUp:
    Gui ListView, %hToolList%
    Index := LV_GetNext()
    If (Index == 0 || Index == 1) {
        Return
    }

    TempItem := Tools[Index]
    PrevItem := Tools[Index - 1]
    Tools[Index] := PrevItem
    Tools[Index - 1] := TempItem
    CurrentRow--

    GoSub ReloadTools

    GuiControl Focus, %hToolList%
    LV_Modify(Index - 1, "Select")
Return

MoveToolDown:
    Gui ListView, %hToolList%
    Index := LV_GetNext()
    If (Index == 0 || Index == LV_GetCount()) {
        Return
    }

    TempItem := Tools[Index]
    NextItem := Tools[Index + 1]
    Tools[Index] := NextItem
    Tools[Index + 1] := TempItem
    CurrentRow++

    GoSub ReloadTools

    GuiControl Focus, %hToolList%
    LV_Modify(Index + 1, "Select")
Return

SelectTool:
    Gui ToolsDlg: +OwnDialogs
    FileSelectFile SelectedFile, 3,, Select File
    If (ErrorLevel) {
        Return
    }

    GuiControl, ToolsDlg:, ToolFile, %SelectedFile%

    Gui ToolsDlg: Submit, NoHide
    If (ToolTitle == "") {
        SplitPath SelectedFile,,,, NameNoExt
        If (IsToolTitleAvailable(NameNoExt)) {
            GuiControl, ToolsDlg:, ToolTitle, %NameNoExt%
        }
    }
Return

ChooseToolIcon:
    If !(Row := LV_GetNext()) {
        Return
    }

    Gui ToolsDlg: Submit, NoHide
    If (ToolIcon == "" || !FileExist(ToolIcon)) {
        SplitPath ToolFile,,, ToolExt
        ToolIcon := (ToolExt = "exe") ? ToolFile : "shell32.dll"
    }

    If (ChooseIcon(ToolIcon, ToolIconIndex, hToolsDlg)) {
        Gui ToolsDlg: Default
        GuiControl,, ToolIcon, %ToolIcon%
        GuiControl,, ToolIconIndex, %ToolIconIndex%
        ILIndex := IL_Add(ToolsImageList, ToolIcon, ToolIconIndex)
        LV_Modify(Row, "Icon" . ILIndex)
    }
Return

ToolsDlgOK:
ToolsDlgApply:
    Gui ToolsDlg: Submit, NoHide
    Gui ListView, %hToolList%

    Row := LV_GetNext()
    If (Row) {
        SetToolValues(Row, ToolTitle, ToolFile, ToolParams, ToolWorkingDir, ToolIcon, ToolIconIndex)
    }

    ; Check for tools with the same title
    Loop % Tools.Length() {
        i := A_Index
        Loop % Tools.Length() {
            If (i <= A_Index) {
                Continue
            }

            If (Tools[i].Title == Tools[A_Index].Title) {
                Message := "More than one tool has the title """ . Tools[i].Title . """."
                Edit_ShowBalloonTip(hEdtToolTitle, Message, "The title must be unique", 2)
            }
        }
    }

    Loop 100 {
        Try {
            Menu AutoToolsMenu, Delete, 3&
        }
    }

    Loop % Tools.Length() {
        If (Tools[A_Index].Title == "" || Tools[A_Index].File == "") {
            Continue
        }

        Icon := GetToolIconPath(Tools[A_Index].Icon)
        Try {
            AddMenu("AutoToolsMenu", Tools[A_Index].Title, "RunTool", Icon, Tools[A_Index].IconIndex)
        }
    }

    If (Tools.Length()) {
        Menu AutoToolsMenu, Add
    }
    AddMenu("AutoToolsMenu", "Configure Tools...", "ShowToolsDialog", IconLib, 43)

    ; Check for writing permission
    FileAppend,, %g_IniTools%, UTF-16
    If (ErrorLevel) {
        FileCreateDir %A_AppData%\AutoGUI
        g_IniTools := A_AppData . "\AutoGUI\Tools.ini"
    }

    FileDelete %g_IniTools%

    Loop % Tools.Length() {
        Section := Tools[A_Index].Title
        If (Section == "" || Tools[A_Index].File == "") {
            Continue
        }

        IniWrite % Tools[A_Index].File, %g_IniTools%, %Section%, File

        If (Tools[A_Index].Params != "") {
            IniWrite % Tools[A_Index].Params, %g_IniTools%, %Section%, Params
        }

        If (Tools[A_Index].WorkingDir != "") {
            IniWrite % Tools[A_Index].WorkingDir, %g_IniTools%, %Section%, WorkingDir
        }

        If (Tools[A_Index].Icon != "") {
            IniWrite % Tools[A_Index].Icon, %g_IniTools%, %Section%, Icon
            If (Tools[A_Index].IconIndex > 1) {
                IniWrite % Tools[A_Index].IconIndex, %g_IniTools%, %Section%, IconIndex
            }
        }
    }

    If (A_ThisLabel == "ToolsDlgOK") {
        Gui ToolsDlg: Destroy
    } Else {
        If (Row) {
            ILIndex := IL_Add(ToolsImageList, GetToolIconPath(Tools[Row].Icon), Tools[Row].IconIndex)
            LV_Modify(Row, "Icon" . ILIndex)
        }
    }
Return

ToolListHandler:
    If (A_GuiEvent == "Normal" || A_GuiEvent == "K") {
        If (CurrentRow) {
            Gui ToolsDlg: Submit, NoHide
            SetToolValues(CurrentRow, ToolTitle, ToolFile, ToolParams, ToolWorkingDir, ToolIcon, ToolIconIndex)
        }

        Gui ToolsDlg: Default
        CurrentRow := LV_GetNext()
        GuiControl,, ToolTitle, % Tools[CurrentRow].Title
        GuiControl,, ToolFile, % Tools[CurrentRow].File
        GuiControl,, ToolParams, % Tools[CurrentRow].Params
        GuiControl,, ToolWorkingDir, % Tools[CurrentRow].WorkingDir
        GuiControl,, ToolIcon, % Tools[CurrentRow].Icon
        GuiControl,, ToolIconIndex, % Tools[CurrentRow].IconIndex
        GoSub ToolsEnableFields
    }
Return

SetToolValues(Index, Title, File, Params, WorkingDir, Icon, IconIndex) {
    Tools[Index] := {}
    Tools[Index].Title := Title
    Tools[Index].File := File
    Tools[Index].Params := Params
    Tools[Index].WorkingDir := WorkingDir
    Tools[Index].Icon := Icon
    Tools[Index].IconIndex := IconIndex
}

UpdateToolTitle:
    Gui ToolsDlg: Submit, NoHide
    Gui ListView, %hToolList%
    Row := LV_GetNext()
    If (Row) {
        LV_Modify(Row,, ToolTitle)
        Tools[Row].Title := ToolTitle
    }
Return

SelectWorkingDir:
    GuiControlGet ToolFile, ToolsDlg:, ToolFile
    SplitPath ToolFile,, StartingFolder
    Gui ToolsDlg: +OwnDialogs
    FileSelectFolder SelectedFolder, *%StartingFolder%,, Select Folder
    If (!ErrorLevel) {
        GuiControl, ToolsDlg:, ToolWorkingDir, %SelectedFolder%
    }
Return

ToolsEnableFields:
    Gui ToolsDlg: Default
    GuiControl Enable, Title:
    GuiControl Enable, ToolTitle

    GuiControl Enable, File:
    GuiControl Enable, ToolFile
    GuiControl Enable, ToolBtnFile

    GuiControl Enable, Parameters:
    GuiControl Enable, ToolParams
    GuiControl Enable, ToolBtnParams

    GuiControl Enable, Working Dir:
    GuiControl Enable, ToolWorkingDir
    GuiControl Enable, ToolBtnWorkingDir

    GuiControl Enable, Icon:
    GuiControl Enable, ToolIcon
    GuiControl Enable, ToolIconIndex
    GuiControl Enable, ToolBtnIcon
Return

GetToolIconPath(Icon) {
    If (Icon != "" && !FileExist(Icon)) {
        If (FileExist(A_ScriptDir . "\Icons\" . Icon)) {
            Return A_ScriptDir . "\Icons\" . Icon
        }
    }

    Return Icon
}

ShowPlaceholdersMenu:
    Menu Placeholders, Add, "{FILENAME}", InsertPlaceholder
    Menu Placeholders, Add, "{FILEDIR}", InsertPlaceholder
    Menu Placeholders, Add, "{SELECTEDTEXT}", InsertPlaceholder
    Menu Placeholders, Add, "{AUTOGUIDIR}", InsertPlaceholder

    hParamsMenu := MenuGetHandle("Placeholders")
    WingetPos wx, wy, ww, wh, ahk_id %hToolsDlg%
    ControlGetPos cx, cy, cw, ch,, ahk_id %hBtnParams%
    x := wx + cx + cw
    y := wy + cy + ch
    DllCall("TrackPopupMenu", "Ptr", hParamsMenu, "UInt", 0x8, "Int", x, "Int", y, "Int", 0, "Ptr", hToolsDlg, "Ptr", 0)
Return

InsertPlaceholder:
    GuiControlGet hWnd, ToolsDlg: Hwnd, ToolParams
    Control EditPaste, %A_ThisMenuItem%,, ahk_id %hWnd%
Return

IsToolTitleAvailable(ToolTitle) {
    For Each, Tool in Tools {
        If (Tool.Title == ToolTitle) {
            Return False
        }
    }
    Return True
}

; IniRead doesn't preserve trailing quotes
ReadIni(IniFile, Section, Key, Default := "ERROR") {
    IniRead IniSections, %IniFile%
    Loop Parse, IniSections, `n, `r
    {
        SectionName := A_LoopField

        If (SectionName == Section) {
            IniRead SectionContent, %IniFile%, %SectionName%
            Loop Parse, SectionContent, `n, `r
            {
                SectionKey := SubStr(A_LoopField, 1, Pos := InStr(A_LoopField, "=") - 1)
                If (SectionKey == Key) {
                    Value := SubStr(A_LoopField, Pos + 2)
                    Return (Value == "") ? Default : Value
                }
            }
        }
    }

    Return Default
}
