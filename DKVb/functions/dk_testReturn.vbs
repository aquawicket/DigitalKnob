if(NOT DK_VBS = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
end if

public testReturn
'##################################################################################
'# dk_testReturn(input, output)
'#
'#
public function dk_testReturn(arg1, ByRef arg2)

	testReturn = Replace(arg1, "input", "output")	
	arg2 = testReturn
	dk_testReturn = testReturn
end function










'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
	public function DKTEST()	

		'### Result as global variable
		dk_echo("")
		call dk_testReturn("inputA", "")
		dk_echo("testReturn = "+testReturn)
	
		'### Result as parameter variable
		dk_echo("")
		call dk_testReturn("inputB", resultB)
		dk_echo("resultB = "+resultB)
		dk_echo("testReturn = "+testReturn)
	
		'### Result as return value
		dk_echo(" ")
		resultC = dk_testReturn("inputC", "")
		dk_echo("resultC = "+resultC)
		dk_echo("testReturn = "+testReturn)			'#NOTE: export cannot be seen outside of command substituion
		
	end function	
end if



