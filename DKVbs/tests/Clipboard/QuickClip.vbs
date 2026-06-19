Function QuickClip( sText )
  REM@description
  ' A quick way to set, get, or clear clipboard text.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@params
  ' sText <string/null> - null will get the clipboard; a string will set it.
  REM@return
  ' QuickClip <string> - The contents of your clipboard as a string.
  REM@mini
  ' Function QuickClip(s):If IsNull(s)Then:QuickClip=CreateObject("HTMLFile").parentWindow.clipboardData.getData("Text"):If IsNull(QuickClip) Or IsEmpty(QuickClip)Then:QuickClip="":End If:Else:CreateObject("WScript.Shell").Run"mshta javascript:eval(""document.parentWindow.clipboardData.setData('text','"&Replace(Replace(s,"'","\\u0027"),"""","\\u0022")&"');close()"")",0,-1:End If:End Function

  If IsNull( sText )Then
    QuickClip = CreateObject( "HTMLFile" ).parentWindow.clipboardData.getData( "Text" )
    If IsNull( QuickClip ) Or IsEmpty( QuickClip )Then QuickClip = ""    
  Else
    Call CreateObject( "WScript.Shell" ).Run( _
      "mshta javascript:eval(""document.parentWindow.clipboardData.setData('text','" _
      & Replace(Replace(sText, "'", "\\u0027"), """", "\\u0022") & "');window.close()"")", 0, True )    
  End If
End Function
