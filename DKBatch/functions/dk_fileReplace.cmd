@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###############################################################################
::# dk_fileReplace(filePath, find, replace)
::#
::#	TODO
::#
::#	@filePath	- TODO
::#	@find		- TODO
::#	@replace	- TODO
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
