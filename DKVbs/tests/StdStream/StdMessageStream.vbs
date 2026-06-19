Class StdMessageStream
  REM@description
  ' Allows synchronous communication between VBScripts, if you call one from the other. Works with HTA files as well.
  ' If one file is reading, the other needs to be writing.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@mini
  ' Class StdMessageStream:Private s,f,x:Private Sub Class_Initialize:Set s=CreateObject("WScript.Shell"):Set f=CreateObject("Scripting.FileSystemObject"):End Sub:Property Let RunFile(a,p):Set x=s.Exec(a&" """&p&""""):End Property:Function Read:If IsObject(x)Then:Read=x.StdOut.ReadLine:Else:Read=f.GetStandardStream(0).ReadLine:End If:End Function:Sub Write(v):If IsObject(x)Then:x.StdIn.WriteLine(v):Else:f.GetStandardStream(1).WriteLine(v):End If:End Sub:End Class
  Private oWss, oFso, oExe

  Private Sub Class_Initialize
    Set oWss = CreateObject( "WScript.Shell" )
    Set oFso = CreateObject( "Scripting.FileSystemObject" )
  End Sub
  
  Property Let RunFile( pWin32App, pFilePath )
    Set oExe = oWss.Exec( pWin32App & " """ & pFilePath & """" )
  End Property
  
  Function Read()
    If IsObject( oExe ) Then
      Read = oExe.StdOut.ReadLine()
    Else
      Read = oFso.GetStandardStream( 0 ).ReadLine()
    End If
  End Function
  
  Sub Write( value )
    If IsObject( oExe ) Then
      oExe.StdIn.WriteLine( value )
    Else
      oFso.GetStandardStream( 1 ).WriteLine( value )
    End If
  End Sub

End Class
