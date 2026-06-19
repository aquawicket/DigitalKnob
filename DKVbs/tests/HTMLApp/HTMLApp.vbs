Class HTMLApp 
  REM@description
  ' A class for creating an HTA window with the ability to return a value on close to the VBScript that called it.
  ' Use the r() javascript function to return a message and close the window.
  ' The return value will be returned to the VBScript Start() function.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@mini
  ' Class HTMLApp:Public OnXReturn:Private h,b:Sub AppendHead(c):h=h&Replace(c,"""","&quot;"):End Sub:Sub AppendBody(c):b=b&Replace(c,"""","&quot;"):End Sub:Function Start:Start=CreateObject("WScript.Shell").Exec("mshta ""about:<html><head><style>html{background:#fff}</style><script>var c=1;function r(s){c=0;new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(s);close()}onbeforeunload=function(){if(c)r("&OnXReturn&")}</script>"&h&"</head><body>"&b&"</body></html>""").StdOut.ReadLine:End Function:End Class
  Public OnXReturn
  Private sHead, sBody
  
  Sub AppendHead( html )
    sHead = sHead & Replace(html, """", "&quot;")
  End Sub
  Sub AppendBody( html )
    sBody = sBody & Replace(html, """", "&quot;")
  End Sub

  Function Start()
    Start = CreateObject( "WScript.Shell" ).Exec( "mshta ""about:<html><head><style>html{background:#fff}</style><script>var c=1;function r(s){c=0;new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(s);close()}onbeforeunload=function(){if(c)r(" _
      & OnXReturn & ")}</script>" & sHead & "</head><body>" & sBody & "</body></html>""" ).StdOut.ReadLine()
  End Function
End Class
