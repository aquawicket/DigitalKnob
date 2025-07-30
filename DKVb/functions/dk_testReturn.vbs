if(NOT DK_VBS = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
end if

'##################################################################################
'# dk_testReturn(input, output)
'#
public function dk_testReturn(args)

	'TODO
	
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()	

	' TODO
	
end function	
end if