executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
'ForceConsole()

'##################################################################################
'# dk_messageBox(<message>)
'#
public function dk_messageBox(message)
	MsgBox(message)
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if DKSCRIPT_FILE = "dk_messageBox.vbs" then
	dk_messageBox("test dk_messageBox()")
end if
