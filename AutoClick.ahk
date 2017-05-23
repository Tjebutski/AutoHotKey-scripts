;^ = ctrl
;+ = shift
;! = alt
;# = super

Menu, Tray, Icon, Graphicloads-Seo-Services-Pay-per-click.ico, 1, 1

toggle = 0
#MaxThreadsPerHotkey 2

^+!NumpadEnter::
    Toggle := !Toggle
     While Toggle{
        Click
        Send a
        sleep 100
    }
return

^+XButton2::
    Toggle := !Toggle
    While Toggle{
      Click
      Send a
      sleep 20
    }
return
