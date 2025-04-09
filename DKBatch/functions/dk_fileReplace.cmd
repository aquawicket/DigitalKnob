@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::###############################################################################
::# dk_fileReplace(filePath, find, replace)
::#
::#
::#	@filePath	- Path to the file to be altered.
::#	@find		- The string to search for in the file.
::#	@replace	- The string to replace the found string with
::#
:dk_fileReplace
setlocal
	%dk_call% dk_debugFunc 3 4
	
	set "filePath=%~1"
	set "find=%~2"
	set "replace=%~3"
	
	%dk_call% dk_callDKCMake dk_fileReplace %filePath% %find% %replace%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_fileReplace C:/Users/Administrator/digitalknob/Development/README.md Digitalknob replaced
	
%endfunction%
