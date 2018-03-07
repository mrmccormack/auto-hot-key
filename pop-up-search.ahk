Gui, Add, Edit, vMySearch
Gui, Add, Button, Default gSearch, Search
Return
^!r::
Gui, Show
Return
Search:
Gui, Submit, Nohide
Run, http://www.food.com/recipe-finder/all/%MySearch%
Return
