REM@usage
' Put the full or mini class/sub/function in your script to use.
Function CmdOut(p):Dim w,e,r,o:Set w=CreateObject("WScript.Shell"):Set e=w.Exec("Cmd.exe"):e.StdIn.WriteLine p&" 2>&1":e.StdIn.Close:While(InStr(e.StdOut.ReadLine,">"&p)=0)::Wend:Do:o=e.StdOut.ReadLine:If(e.StdOut.AtEndOfStream)Then:Exit Do:Else:r=r&o&vbLf:End If:Loop:CmdOut=r:End Function

' returns the result of whatever command you run
Dim Result
Result = CmdOut( "ECHO Hello, world!" )
MsgBox Result

' if you run with cscript instead of wscript you can see the full output when using wscript.echo because msgbox has a character limit
Dim IpConfig
IpConfig = CmdOut( "ipconfig /all" )
WScript.Echo IpConfig
