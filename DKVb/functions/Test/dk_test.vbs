executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
ForceConsole()

'##################################################################################
'# dk_test()
'#
public function dk_test()
	WScript.Echo "dk_test()"
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if DKSCRIPT_FILE = "dk_test.vbs" then
	dk_test()
end if