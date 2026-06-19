Function Import( vbsFile )
  REM@description
  ' Import/include/using code from an external VBScript file.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@params
  ' vbsFile <string> - A relative, absolute, or URL path to a file containing vbscript code.
  REM@returns
  ' Import <bool> - Returns False if the import failed, and True if it succeeded.
  REM@mini
  ' Function Import(p):Import = False:Dim f,m:Set f=CreateObject("Scripting.FileSystemObject"):If(f.FileExists(f.GetAbsolutePathName(p)))Then:ExecuteGlobal(f.OpenTextFile(f.GetAbsolutePathName(p)).ReadAll):Import=-1:Exit Function:End If:Set m=CreateObject("Microsoft.XMLHTTP"):On Error Resume Next:m.Open "GET",p,0:If Not(Err.Number=-2147012890)Then:m.Send:If(m.Status=200)Then:ExecuteGlobal(m.ResponseText):Import=-1:End If:End If:End Function
  Import = False

  Dim oFso, oMxh
  Set oFso = CreateObject( "Scripting.FileSystemObject" )
  If( oFso.FileExists( oFso.GetAbsolutePathName( vbsFile ) ) )Then
    ExecuteGlobal( oFso.OpenTextFile( oFso.GetAbsolutePathName( vbsFile ) ).ReadAll() )
    Import = True    
    Exit Function
  End If
    
  Set oMxh = CreateObject( "Microsoft.XMLHTTP" )
  On Error Resume Next
  Call oMxh.Open( "GET", vbsFile, False )
  If Not( Err.Number = -2147012890 )Then
    Call oMxh.Send()    
    If( oMxh.Status = 200 )Then
      ExecuteGlobal( oMxh.ResponseText )
      Import = True
    End If
  End If

End Function