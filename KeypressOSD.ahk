; KeypressOSD.ahk

#SingleInstance force
#NoEnv
#MaxHotkeysPerInterval 20000
SetBatchLines, -1
ListLines, Off
CoordMode, Mouse, Screen
Menu, Tray, Icon, C:\Users\it12\Documents\AHK\Jonas-Rask-Danish-Royalty-Free-Monitor.ico, 1, 1

; Settings
transN                            := 255                                              ; 0=transparent, 255=opaque
ShowSingleKey                     := True                                             ; display A-Z, Enter and other keys pressed without modifier (Ctr, Alt, ...)
DisplayTime                       := 000                                              ; time to fade, in milliseconds
DisplayTime2                      := 500                                              ; time staying after
Font                               = script                                           ; font
Xpos                               = 75                                               ; x position
BackgroundColor                    = White                                            ; background color
Trans_A                            := 200                                              ; transparency after





; Create GUI
Gui, +AlwaysOnTop -Caption +Owner +LastFound +E0x20
Gui, Margin, 0, 0
Gui, Color, %BackgroundColor%
Gui, Font, cRed s30 Bold, %Font%                     ; Font
Gui, Add, Text, vHotkeyText Center y50
WinSet, Transparent, %transN%
Winset, AlwaysOnTop, On
SetTimer, ShowHotkey, 1

; Create hotkey
Loop, 95
    Hotkey, % "~*" Chr(A_Index + 31), Display
Loop, 24 ; F1-F24
    Hotkey, % "~*F" A_Index, Display
Loop, 10 ; Numpad0 - Numpad9
    Hotkey, % "~*Numpad" A_Index - 1, Display
Hotkey, ~*LButton, Display
Hotkey, ~*RButton, Display
Hotkey, ~*MButton, Display
Hotkey, ~*WheelUp, Display
Hotkey, ~*WheelDown, Display
Otherkeys := "NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|Tab|Enter|Esc|BackSpace|Del|Insert|Home|End|PgUp|PgDn|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|Pause|Space|NumpadDot|NumpadEnter|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Volume_Mute|Volume_Up|Volume_Down|Browser_Home|AppsKey|PrintScreen|Sleep"
Loop, parse, Otherkeys, |
    Hotkey, % "~*" A_LoopField, Display
return

; Display
PreviousKey := ""
Display:
    If (A_ThisHotkey = "")
        Return
    mods   := "Ctrl|Shift|Alt|LWin|RWin"
    prefix := ""
    if GetKeyState(A_LoopField)
            prefix .= A_LoopField "+"
    if (!prefix && !ShowSingleKey)
        return
    key := PreviousKey prefix SubStr(A_ThisHotkey, 3)
    PreviousKey := key " "
    if (key = " ")
        key := "Space"
	else if (key = "Numpad0")
        key := "0"
	else if (key = "Numpad1")
        key := "1"
	else if (key = "Numpad2")
        key := "2"
	else if (key = "Numpad3")
        key := "3"
	else if (key = "Numpad4")
        key := "4"
	else if (key = "Numpad5")
        key := "5"
	else if (key = "Numpad6")
       key := "6"
	else if (key = "Numpad7")
       key := "7"
	else if (key = "Numpad8")
       key := "8"
	else if (key = "Numpad9")
        key := "9"
	else if (key = "NumpadDot")
        key := "."
  else if (key = "NumpadEnter")
        key := "Enter"
  else if (key = "NumpadAdd")
        key := "+"
  else if (key = "NumpadSub")
        key := "-"
  else if (key = "NumpadDiv")
        key := "/"
  else if (key = "NumpadMult")
        key := "*"
  else if (key = "LButton")
        key := "MB1"
  else if (key = "RButton")
        key := "MB2"
  else if (key = "MButton")
        key := "Middle"
  else if (key = "WheelUp")
        key := " WheelUp "
  ;else if (key = "WheelDown")
    LastHotkeyPressedTime := A_TickCount
Return

; Show Gui element with the hotkeys, move with mouse and fade into transparency
ShowHotkey:
    prev_X := -999
    prev_Y := -999
    prev_LastHotkeyPressedTime := "999"
    Gui, +LastFound
    Loop {
        Elapsed := A_TickCount - LastHotkeyPressedTime
        Faded := 1 - Elapsed/DisplayTime
        if (prev_LastHotkeyPressedTime != LastHotkeyPressedTime) {
            WinSet, Transparent, % transN
        } else if (Faded > 0.1) {
            ;WinSet, Transparent, % transN * 1
        }
        MouseGetPos, X, Y
        if (prev_LastHotkeyPressedTime != LastHotkeyPressedTime or (((abs(prev_X - X) > 1 or abs(prev_Y - Y) > 1) or Faded < 0) and PreviousKey != "")) {
            text_w := StrLen(key) * 25 + 25                                           ;;;;;;;;Padding X
            if (Faded < 0.1) {
                adjusted_X = %Xpos%                                                      ;;;;;;;;X pos after
                adjusted_Y := A_ScreenHeight - 100                                    ;;;;;;;;Y pos after
                WinSet, Transparent, % %Trans_A%                                            ;;;;;;;;transparency after
                PreviousKey :=
            } else {
                adjusted_X = %Xpos%                                                       ;;;;;;;;X pos during
                adjusted_Y := A_ScreenHeight - 100                                    ;;;;;;;;Y pos during
            }
            GuiControl,, HotkeyText, %key%
            GuiControl, Move, HotkeyText, +AlwaysOnTop w%text_w%
            WinSet, Region, 0-0 W%text_w% H50 R10-10
            Gui, Show, NoActivate x%adjusted_X% y%adjusted_Y% w%text_w%
            prev_X := X
            prev_Y := Y
            prev_LastHotkeyPressedTime := LastHotkeyPressedTime
			SetTimer, HideGUI, % -1 * DisplayTime2
        }
        Sleep, 20
    }
Return

HideGUI() {
	Gui, Hide
}
