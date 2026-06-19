REM@usage
' Put the full or mini class/sub/function in your script to use.
Function QuickClip(s):If IsNull(s)Then:QuickClip=CreateObject("HTMLFile").parentWindow.clipboardData.getData("Text"):If IsNull(QuickClip) Or IsEmpty(QuickClip)Then:QuickClip="":End If:Else:CreateObject("WScript.Shell").Run"mshta javascript:eval(""document.parentWindow.clipboardData.setData('text','"&Replace(Replace(s,"'","\\u0027"),"""","\\u0022")&"');close()"")",0,-1:End If:End Function

'CLEAR
QuickClip( "" )

'SET
QuickClip( "Hello, world!" )

'GET
Dim Result
Result = QuickClip( Null )
