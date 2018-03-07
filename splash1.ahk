;Progress, b w200, My SubText, My MainText, My Title
;Progress, 100 ; Set the position of the bar to 50%.
;Sleep, 1000
;Progress, Off

; Create a window just to display some 18-point Courier text:
;Progress, m2 b fs18 zh0, This is the Text.`nThis is a 2nd line., , , Courier New

; Create a simple SplashImage window:
SplashImage, C:\Users\Rob Acer Aspire 3\Desktop\logo.jpg

; Create a borderless SplashImage window with some large text beneath the image:
SplashImage, C:\Users\Rob Acer Aspire 3\Desktop\logo.jpg, b fs18, JiffyKeys v1.0S
Sleep, 1000
SplashImage, Off
