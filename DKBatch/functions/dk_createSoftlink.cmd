@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_createSoftlink(softlink_path, pointed_to_path)
::#
::#
:dk_createSoftlink
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_todo "dk_createSoftlink not implemented"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_createSoftlink "C:\Users\Administrator\Desktop\digitalknob" "C:\Users\Administrator\digitalknob"
goto:eof
