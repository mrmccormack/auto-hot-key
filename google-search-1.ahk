;-----------------------------------------------------------***
;### Search Google for selection, or open URL ###
browser="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

#g::
;Copy Clipboard to prevClipboard variable, clear Clipboard.
prevClipboard := ClipboardAll
Clipboard =
;Copy current selection, continue if no errors.
SendInput, ^c
ClipWait, 2
if !(ErrorLevel) {
;Convert Clipboard to text, auto-trim leading and trailing spaces and tabs.
Clipboard = %Clipboard%
;Clean Clipboard: change carriage returns to spaces, change >=1 consecutive spaces to +
Clipboard := RegExReplace(RegExReplace(Clipboard, "\r?\n"," "), "\s+","+")
;Open URLs, Google non-URLs. URLs contain . but do not contain + or .. or @
if Clipboard contains +,..,@
Run, %browser% www.google.co.uk/search?q=%Clipboard%&num=50
else if Clipboard not contains .
Run, %browser% www.google.co.uk/search?q=%Clipboard%&num=50
else
Run, %browser% %Clipboard%&num=50
}
;Restore Clipboard, clear prevClipboard variable.
Clipboard := prevClipboard
prevClipboard =
return
;-----------------------------------------------------------***
