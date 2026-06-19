'Declare The DLL to be used
 sDLL = "user32.dll"
 
'Declare the returrn type - Which is boolean
 sRet = "bool"
 
'Declare the method string
 sDec = "static extern bool SetForegroundWindow(IntPtr hWnd)"
 
'Fetch the handle of the application
 hwndCalculator = Native.GetHandleByCaption("Calculator")
 
'Declare the Method string
 sFunc = "SetForegroundWindow((IntPtr)" &amp; hwndCalculator &amp;" )"
 
'Run the method from the DLL
 Call dll.LoadAndRun(sDLL,sRet,sDec,sFunc)
 
'All the available DLL's and methods can be found <a href="https://pinvoke.net/default.aspx/user32.SetForegroundWindow" target="_blank" rel="noopener">here</a>.
