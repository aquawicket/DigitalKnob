REM@usage
' Put the full or mini class/sub/function in your script to use.
Class HTMLApp:Public OnXReturn:Private h,b:Sub AppendHead(c):h=h&Replace(c,"""","&quot;"):End Sub:Sub AppendBody(c):b=b&Replace(c,"""","&quot;"):End Sub:Function Start:Start=CreateObject("WScript.Shell").Exec("mshta ""about:<html><head><style>html{background:#fff}</style><script>var c=1;function r(s){c=0;new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(s);close()}onbeforeunload=function(){if(c)r("&OnXReturn&")}</script>"&h&"</head><body>"&b&"</body></html>""").StdOut.ReadLine:End Function:End Class

' really simple example
Dim oHta : Set oHta = New HTMLApp
oHta.AppendBody "Hello, world!"
oHta.Start

' returning some values, setting a title and size
Dim oHta2 : Set oHta2 = New HTMLApp
oHta2.AppendHead "<title>My Title</title>"
oHta2.AppendHead "<script>window.resizeTo(350,250)</script>"
oHta2.AppendBody "<button onclick='r(""The Button was clicked"")'>My Button</button>"    
Msgbox oHta2.Start
  
' if you know html, css, and javascript you can configure the window in all sorts of ways
 Dim oHta3 : Set oHta3 = New HTMLApp

oHta3.OnXReturn = "0"

oHta3.AppendHead "<title>Hta Window</title>"
oHta3.AppendHead "<hta:application scroll=no contextmenu=no selection=no icon='C:\Windows\System32\grpconv.exe'>"
oHta3.AppendHead "<style>body{font-family:arial;font-size:14pt;text-align:center;background:#ddd;}input{border:0;padding:8px 15px;cursor:pointer;margin:5px;}</style>"
oHta3.AppendHead "<script>window.resizeTo(400,280)</script>"

oHta3.AppendBody "<div>To change the return value when clicking [x] use the OnXReturn field.<br><br>Clicking on the buttons will send back a message</div><br>"
oHta3.AppendBody "Make sense?<br><br>"
oHta3.AppendBody "<input type='button' value='Perfectly!' onclick='r(1)'>"
oHta3.AppendBody "<input type='button' value='No Clue!' onclick='r(2)'>"

Dim rMessage
rMessage = oHta3.Start
If (rMessage = "0") Then 
  MsgBox "You closed the window"
ElseIf (rMessage = "1") Then
  MsgBox "I'm glad it made sense"
ElseIf (rMessage = "2" ) Then 
  MsgBox "You'll have to mess around with it a bit then"
End If
