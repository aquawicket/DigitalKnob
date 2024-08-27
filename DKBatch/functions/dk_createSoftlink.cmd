@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_createSoftlink(softlink_path, pointed_to_path)
::#
::#
:dk_createSoftlink
 setlocal
	call dk_debugFunc 2
	
	%dk_call% dk_todo "dk_createSoftlink not implemented"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_createSoftlink "C:\Users\Administrator\Desktop\digitalknob" "C:\Users\Administrator\digitalknob"
goto:eof
