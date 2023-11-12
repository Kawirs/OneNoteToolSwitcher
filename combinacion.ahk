#IfWinActive, ahk_class Framework::CFrame
; Shared variables and setup
toggleState1 := 0 ; Toggle state for the first key combination
toggleState2 := 0 ; Toggle state for the second key combination
lastSection := 0
areaX1 := 188
areaY1 := 83
areaX2 := 827
areaY2 := 122
numSections := 16

~LButton::
    MouseGetPos, mouseX, mouseY
    if (mouseX >= areaX1 and mouseX <= areaX2 and mouseY >= areaY1 and mouseY <= areaY2)
    {
        sectionWidth := (areaX2 - areaX1) // numSections
        lastSection := (mouseX - areaX1) // sectionWidth
    }
return

; Hotkey 1 (^!g)
^!g::GoSub, Hotkey1Actions
return

; Hotkey 2 (^!F7)
^!F7::GoSub, Hotkey2Actions
return

; Subroutine for Hotkey 1 Actions
Hotkey1Actions:
    if (toggleState2 = 1) ; If the second tool was active, return to pen first
    {
        GoSub, ReturnToPen
    }
    if (toggleState1 = 0)
    {
        ; Actions for the first tool
        KeyWait, Ctrl
        KeyWait, Alt
        Send, {Alt Down}
        Send, 9
        Send, {Alt Up}
        toggleState1 := 1
    }
    else
    {
        GoSub, ReturnToPen
    }
return

; Subroutine for Hotkey 2 Actions
Hotkey2Actions:
    if (toggleState1 = 1) ; If the first tool was active, return to pen first
    {
        GoSub, ReturnToPen
    }
    if (toggleState2 = 0)
    {
        ; Actions for the second tool
        Send, {Alt Down}
        Send, 3
        Send, {Alt Up}
        toggleState2 := 1
    }
    else
    {
        GoSub, ReturnToPen
    }
return

; Subroutine to Return to the Last Pen
ReturnToPen:
    Send, {Alt Down}
    Send, 6
    Send, {Alt Up}
    if (lastSection > 0)
    {
        Send, {Right %lastSection%}
    }
    Send, {Enter}
    toggleState1 := 0
    toggleState2 := 0
return
#IfWinActive

