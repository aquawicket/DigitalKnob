executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

'##################################################################################
'# dk_source(<message>)
'#
public function dk_source(file)
<<<<<<< HEAD
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile(file+".vbs").readAll()
=======
	executeGlobal FileSystemObject.openTextFile(file+".vbs").readAll()
>>>>>>> Development
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
<<<<<<< HEAD
if DKSCRIPT_FILE = "dk_source.vbs" then
	dk_source("dk_messageBox")
	dk_messageBox("test dk_source() successful")
=======
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()

	dk_source("dk_messageBox")
	dk_messageBox("test dk_source() successful")

end function
>>>>>>> Development
end if