;^ = ctrl
;+ = shift
;! = alt
;# = super
Menu, Tray, Icon, volume.png.ico, 1, 1
;Ctrl Shift num+ = Volume_UP
^+NumpadSub::
send {Volume_UP}
return

;Ctrl Shift num- = Volume_DOWN
^+NumpadAdd::
send {Volume_DOWN}
return

 ;Ctrl Shift numEnter = Volume_MUTE
^+NumpadEnter::
send {Volume_MUTE}
return

;Shift + MouseButtonForward = F5
+XButton2::
send {F5}
return

;Shift + MouseButtonBack = F6
+XButton1::
send {F6}
return

^+ScrollLock::
send {Media_Play_Pause}
return

^+PrintScreen::
send {Media_Prev}
return

^+CtrlBreak::
send {Media_Next}
return
