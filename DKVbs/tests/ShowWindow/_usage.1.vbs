REM@usage
' Put the full or mini class/sub/function in your script to use.
Function ShowWindow(n,t):With CreateObject("WScript.Shell"):ShowWindow=.Run "PowerShell -Ex Bypass -Com ""Add-Type -M '[DllImport(\""user32.dll\"")] public static extern bool ShowWindow(IntPtr h,int c);[DllImport(\""user32.dll\"")] public static extern int SetForegroundWindow(IntPtr h);' -Name ps -Names w;$d=(gps "&n&").Where({$_.MainWindowTitle -Match '"&t&"'},1).MainWindowHandle;[w.ps]::ShowWindow($d,4);[w.ps]::SetForegroundWindow($d)""",0,-1:End With:End Function

' activate windows with the process name and title
ShowWindow "chrome", "Nekomesha - Youtube"
ShowWindow "notepad", "Untitled - Notepad"

' don't know the title? use a period for the title
ShowWindow "iexplore", "."

' don't know the processes name? leave it blank
ShowWindow "", "Control Panel"

' not sure which process will be running? use commmas to add more processes to the search
ShowWindow "cscript, wscript", "Form Entry"

' the title changes depending on if minimzed or maximized? use a regular expression to get it
ShowWindow "", "(\d{1,3}% complete)|(Compressing...)"

' if your process name includes a space use single quotes around it.
ShowWindow "'my proccess'", "."

' the window is not being activated? use the return value to check if you typed the process name or title correctly
Dim isFound
isFound = ShowWindow( "notepad", "Untitled" )
If( isFound )Then
  Call MsgBox( "Found it, here is your window!", vbInformation )
Else
  Call MsgBox( "Sorry, I couldn't find that window.", vbCritical )
End If