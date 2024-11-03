executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

Public Function dk_messageBox(message)
	MsgBox(message)
End Function

Call dk_messageBox("test dk_messageBox()")
