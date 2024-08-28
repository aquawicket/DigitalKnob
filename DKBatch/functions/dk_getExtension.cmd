@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_getExtension(path rtn_var)
::#
::#
:dk_getExtension
 setlocal
	call dk_debugFunc 2

	set "_input_=%1"
	set "_input_=%_input_:"=%"
	if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
	if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
	for %%Z in ("%_input_%") do set "_extension_=%%~xZ"
	endlocal & set "%2=%_extension_%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_set myPath "/test/test2/xfile.extension"
	%dk_call% dk_getExtension "%myPath%" extension
	%dk_call% dk_printVar extension
goto:eof