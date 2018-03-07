MsgBox Welcome to Jiffy Keys for Windows.


; ListHotkeys
^#j::Send, {left}
^#l::Send, {right}
^#i::Send, {up}
^#k::Send, {down}
^#h::Send, ^{home}
^#`;::Send, ^{end} ; thats how you send a semi colon
^#'::Send, ^a
^#m::Send, ^a

^#u::Send, {PgUp}
^#o::Send, {PgDn}

^!j::Send, +{left}
^!l::Send, +{right}
^!i::Send, +{up}
^!k::Send, +{down}

; Win Shift Ctrl for selecting text
^#+j::Send, +{left}
^#+l::Send, +{right}
^#+i::Send, +{up}
^#+k::Send, +{down}
^#+h::Send, ^+{home}
^#+'::Send, ^a


; this works, just keep hitting the first key to cycle through
; this works, just keep hitting the first key to cycle through
; n::AltTab
; nor working   ^#Enter::LeftAltTab

::.ram::rob.a.mccormack@gmail.com
; now work  ::.`#::`!`[`]`(`)
