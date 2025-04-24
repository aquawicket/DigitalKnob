<<<<<<< HEAD
executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
'ForceConsole()
=======
if(NOT DK_VBS = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
	'ForceConsole()
end if

>>>>>>> Development

'##################################################################################
'# dk_messageBox(<message>)
'#
public function dk_messageBox(message)
	MsgBox(message)
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
<<<<<<< HEAD
if DKSCRIPT_FILE = "dk_messageBox.vbs" then
	dk_messageBox("test dk_messageBox()")
=======
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()
	
	dk_messageBox("test dk_messageBox()")
	
end function
>>>>>>> Development
end if
