Progress, b w200, My SubText, My MainText, My Title
Progress, 50 ; Set the position of the bar to 50%.
Sleep, 4000
Progress, Off

; Create a window just to display some 18-point Courier text:
Progress, m2 b fs18 zh0, This is the Text.`nThis is a 2nd line., , , Courier New

; Create a simple SplashImage window:
SplashImage, C:\Users\Rob Acer Aspire 3\Desktop\logo.jpg

; Create a borderless SplashImage window with some large text beneath the image:
SplashImage, C:\Users\Rob Acer Aspire 3\Desktop\logo.jpg, b fs18, This is our company logo.
Sleep, 4000
SplashImage, Off

; Here is a working example that demonstrates how a Progress window can be
; overlayed on a SplashImage to make a professional looking Installer screen:
IfExist, C:\WINDOWS\system32\ntimage.gif, SplashImage, %A_WinDir%\system32\ntimage.gif, A,,, Installation
Loop, %A_WinDir%\system32\*.*
{
    Progress, %A_Index%, %A_LoopFileName%, Installing..., Draft Installation
    Sleep, 50
    if A_Index = 100
        break
}
; There is similar example at the bottom of the GUI page. Its advantage is that it uses only a single
; window and it gives you more control over window layout.
