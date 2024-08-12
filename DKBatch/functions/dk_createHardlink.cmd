@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_createHardlink(softlink_path, pointed_to_path)
::#
::#
:dk_createHardlink
	call dk_debugFunc 2
	
	%dk_call% dk_todo "dk_createHardlink not implemented"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_createHardlink "C:\Users\Administrator\Desktop\digitalknob" "C:\Users\Administrator\digitalknob"
goto:eof
