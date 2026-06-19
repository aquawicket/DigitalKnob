REM@usage
' Put the full or mini class/sub/function in your script to use.
Class StdMessageStream:Private s,f,x:Private Sub Class_Initialize:Set s=CreateObject("WScript.Shell"):Set f=CreateObject("Scripting.FileSystemObject"):End Sub:Property Let RunFile(a,p):Set x=s.Exec(a&" """&p&""""):End Property:Function Read:If IsObject(x)Then:Read=x.StdOut.ReadLine:Else:Read=f.GetStandardStream(0).ReadLine:End If:End Function:Sub Write(v):If IsObject(x)Then:x.StdIn.WriteLine(v):Else:f.GetStandardStream(1).WriteLine(v):End If:End Sub:End Class

REM initialize the object
Set oSms = New StdMessageStream

REM run a file and communicate with it via the std stream
oSms.RunFile("mshta") = "_usage.2b.hta"

REM send a message to the called script
oSms.Write( "Hello, from 1st file." )

REM get a message from the called script
Dim Response : Response = oSms.Read()
MsgBox Response
