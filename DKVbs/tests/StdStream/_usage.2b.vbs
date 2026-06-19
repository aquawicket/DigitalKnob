<!DOCTYPE html>
<head>
  <meta http-equiv="X-UA-Compatible" content="ie=9">
  <title>StdStreamConnect Example</title>
  <hta:application name="exampleApp" />
  <script language="VBScript">
    REM@usage
    ' Put the full or mini class/sub/function in your script to use.
    Class StdMessageStream:Private s,f,x:Private Sub Class_Initialize:Set s=CreateObject("WScript.Shell"):Set f=CreateObject("Scripting.FileSystemObject"):End Sub:Property Let RunFile(a,p):Set x=s.Exec(a&" """&p&""""):End Property:Function Read:If IsObject(x)Then:Read=x.StdOut.ReadLine:Else:Read=f.GetStandardStream(0).ReadLine:End If:End Function:Sub Write(v):If IsObject(x)Then:x.StdIn.WriteLine(v):Else:f.GetStandardStream(1).WriteLine(v):End If:End Sub:End Class
    
    REM initialize the object
    Set oSms = New StdMessageStream
  </script>
</head>
<body>

  <!--get a message from the caller script-->
  <div id="readPane"></div>
  <script>readPane.innerText = oSms.Read()</script>
  
  <!--send a message to the caller script-->
  <textarea id="writePane"></textarea>
  <input type="button" value="Send Message" onclick="oSms.Write(writePane.value)">
  
</body>
</html>
