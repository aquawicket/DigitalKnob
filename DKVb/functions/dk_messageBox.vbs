executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

'##################################################################################
'# dk_messageBox(<message>)
'#
Public Function dk_messageBox(message)
	MsgBox(message)
End Function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
If DKSCRIPT_FILE = "dk_messageBox.vbs" Then
	dk_messageBox("test dk_messageBox()")
End If
