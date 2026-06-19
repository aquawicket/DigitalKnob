Class FileMessageStream
  REM@description
  ' Send messages to other scripts whether they're running or not using NTFS multiple data streams. Works with HTA files as well.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@mini
  ' Class FileMessageStream:Private o:Private Sub Class_Initialize:Set o=CreateObject("Scripting.FileSystemObject"):End Sub:Function ReadMessages(w):Dim f:If Not IsObject(wscript) And IsObject(window)Then:f=window.location.pathname:Else:f=wscript.scriptfullname:End If:With o.OpenTextFile(f&":FMStream",1,-1):If(.AtEndOfStream And Not w)Then:Exit Function:End If:Do While(.AtEndOfStream And w)::Loop:ReadMessages=.ReadAll():.Close():End With:WriteTo(f,0)="":End Function:Property Let WriteTo(f,a,d):Dim m:If(a)Then:m=8:Else:m=2:End If:If o.FileExists(f)Then:With o.OpenTextFile(f&":FMStream",m,-1):.Write(d):.Close():End With:Else:Err.Raise(53):End If:End Property:End Class
  Private oFso, gFileNotFound
  
  Private Sub Class_Initialize()
    Set oFso = CreateObject( "Scripting.FileSystemObject" )
    gFileNotFound = 53
  End Sub

  Function ReadMessages( waitForMessage )
    Dim file
    If Not IsObject(wscript) And IsObject(window) Then 
      file = window.location.pathname
    Else
      file = wscript.scriptfullname
    End If
    With oFso.OpenTextFile( file & ":FMStream", 1, True )
      If(.AtEndOfStream And Not waitForMessage )Then Exit Function 
      Do While(.AtEndOfStream And waitForMessage )::Loop
      ReadMessages = .ReadAll() : .Close()
    End With
    WriteTo( file, False ) = ""
  End Function

  Property Let WriteTo( file, append, data )
    Dim iomode
    If( append )Then 
      iomode = 8
    Else
      iomode = 2
    End If
    If oFso.FileExists(file) Then 
      With oFso.OpenTextFile( file & ":FMStream", iomode, True )
        .Write( data ) : .Close()
      End With
    Else
      Err.Raise( gFileNotFound )      
    End If
  End Property

End Class
