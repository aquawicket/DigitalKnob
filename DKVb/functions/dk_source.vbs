executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()

'##################################################################################
'# dk_source(<message>)
'#
public function dk_source(file)
	executeGlobal FileSystemObject.openTextFile(file+".vbs").readAll()
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()

	dk_source("dk_messageBox")
	dk_messageBox("test dk_source() successful")

end function
end if