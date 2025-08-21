@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::###############################################################################
::# dk_fileReplace(filePath, find, replace)
::#
::#
::#	@filePath	- Path to the file to be altered.
::#	@find		- The string to search for in the file.
::#	@replace	- The string to replace the found string with
::#
:dk_fileReplace
%setlocal%
	%dk_call% dk_debugFunc 3 4
	
	set "filePath=%~1"
	set "find=%~2"
	set "replace=%~3"
	
	%dk_call% dk_callDKCMake dk_fileReplace %filePath% %find% %replace%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_fileReplace %USERPROFILE:\=/%/DigitalKnob/Development/README.md Digitalknob replaced
	
%endfunction%
