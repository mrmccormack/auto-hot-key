; Example 2
searchsting := "Starwars vader zz!"
datetoken := "zz"
If InStr(searchsting, datetoken)
  MsgBox, The string was found.
Else
  MsgBox, The string was not found.
