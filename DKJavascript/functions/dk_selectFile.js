var objShell = new ActiveXObject('WScript.Shell');
var oDlg = objShell.Exec("mshta.exe ""about:<object id=d classid=clsid:3050f4e1-98b5-11cf-bb82-00aa00bdce0b></object><script>moveTo(0,-9999);eval(new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0).Read(" & (Len(sIniDir) + Len(sFilter) + Len(sTitle) + 41) & "));function window.onload(){var p=/[^\0]*/;new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(p.exec(d.object.openfiledlg(iniDir,null,filter,title)));close();}</script><hta:application showintaskbar=no />""")
oDlg.StdIn.Write("var iniDir='"+sIniDir+"';var filter='"+sFilter+"';var title='"+sTitle+"';"

/*
close();

Function GetFileDlgEx(sIniDir, sFilter)
  sTitle = "Choose File"
  'Set objShell = WScript.CreateObject("WScript.Shell")
  Set objShell = CreateObject("WScript.Shell")
  If InStr(sIniDir, ":") <= 0 Then
    sIniDir = objShell.CurrentDirectory & "\" & sIniDir
  End If
  sIniDir = Replace(sIniDir, "\", "\\")
  Set oDlg = objShell.Exec("mshta.exe ""about:<object id=d classid=clsid:3050f4e1-98b5-11cf-bb82-00aa00bdce0b></object><script>moveTo(0,-9999);eval(new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0).Read(" & (Len(sIniDir) + Len(sFilter) + Len(sTitle) + 41) & "));function window.onload(){var p=/[^\0];new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(p.exec(d.object.openfiledlg(iniDir,null,filter,title)));close();}</script><hta:application showintaskbar=no />""")
  oDlg.StdIn.Write "var iniDir='" & sIniDir & "';var filter='" & sFilter & "';var title='" & sTitle & "';"
  GetFileDlgEx = oDlg.StdOut.ReadAll
End Function

Sub demo()
    sIniDir = "*.*pdf" ' will look in current folder - note extension must be preceded by an asterisk *.
    'sIniDir = "docs\*.*pdf" ' will look in a relative folder
    'sIniDir = "C:\Windows\*.*pdf" ' will look in an absolute folder
    sFilter = "Adobe pdf (*.pdf)|*.pdf|All files (*.*)|*.*|Microsoft Word (*.doc;*.docx)|*.doc;*.docx|Image files (*.gif;*.png;*jpg;*.bmp)|*.gif;*.png;*jpg;*.bmp|Html files (*.htm;*.html;*.mht)|*.htm;*.html;*.mht|"
    rep = GetFileDlgEx(sIniDir, sFilter)
    MsgBox rep
End Sub

' Comment out in VBA as the Sub must be called interactively there!
demo()
*/