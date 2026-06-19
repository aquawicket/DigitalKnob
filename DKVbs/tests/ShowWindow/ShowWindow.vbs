Function ShowWindow( name, title )
  REM@description
  ' An AppActivate alternative that shows and activates a window using its process name, window title, or both.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@params
  ' name <string> The process name running the window. Use a comma delimited string to add more processes if you're unsure what process will be used. Leave blank "" if you don't know the process.
  ' title <regex> A regular expression string, to match the correct window title. Use "." if you don't know the title.
  REM@returns
  ' ShowWindow <bool> Returns false if it doesn't find the window; true if it does.
  REM@mini
  ' Function ShowWindow(n,t):With CreateObject("WScript.Shell"):ShowWindow=.Run "PowerShell -Ex Bypass -Com ""Add-Type -M '[DllImport(\""user32.dll\"")] public static extern bool ShowWindow(IntPtr h,int c);[DllImport(\""user32.dll\"")] public static extern int SetForegroundWindow(IntPtr h);' -Name ps -Names w;$d=(gps "&n&").Where({$_.MainWindowTitle -Match '"&t&"'},1).MainWindowHandle;[w.ps]::ShowWindow($d,4);[w.ps]::SetForegroundWindow($d)""",0,-1:End With:End Function
  With CreateObject( "WScript.Shell")
    ShowWindow = .Run( "PowerShell -ExecutionPolicy Bypass -Command ""Add-Type -MemberDefinition '" & _
      "[DllImport(\""user32.dll\"")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);" & _
      "[DllImport(\""user32.dll\"")] public static extern int SetForegroundWindow(IntPtr hwnd);' -Name PS -Namespace WindowsAPI;" & _
      "$hWnd = (Get-Process " & name & ").Where({ $_.MainWindowTitle -Match '" & title & "' }, 1).MainWindowHandle;" & _
      "[WindowsAPI.PS]::ShowWindow( $hWnd, 4 );[WindowsAPI.PS]::SetForegroundWindow( $hWnd );""", 0, True ) = 0
  End With
End Function