LaunchSnippingTool()
{
	IfWinExist , Snipping Tool
	{
		WinActivate , Snipping Tool
		Send ^+n
	} else {
	  Run, C:\Windows\explorer.exe C:\Windows\system32\SnippingTool.exe
		WinWait , Snipping Tool
		WinActivate , Snipping Tool
		Send ^+n
	}

}
#s::LaunchSnippingTool()
