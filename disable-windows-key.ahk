; windows shift + L works, windows l always logs off
#+u::Send, hello
AppsKey::Send, AppsKey
;+AppsKey & e::Send, AppsKey with E ; this is shift appskey
AppsKey & e::Send, appskey with e


; ref: https://stackoverflow.com/questions/30917259/autohotkey-script-triggered-by-shift-g-appskey
AppsKey & G::
    If GetKeyState("Shift", "P")
        Send hello shift appskey g
return
