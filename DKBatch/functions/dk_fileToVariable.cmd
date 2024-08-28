@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_fileToVariable(path rtn_var)
::#
::#  Read lines of a file into an array and echo them back
::#
::#  reference: https://stackoverflow.com/a/49042678
::#
:dk_fileToVariable
 setlocal
	call dk_debugFunc 2
	
    ::call set "file=%~1"
	set "\n=\n"
	::if "!DE!" neq "" for /f "delims=" %%x in (%~1) do call set "_fileVar_=%%_fileVar_%%%\n%%%x"	&:: FIXME: remove the need for call here
	for /f "delims=" %%x in (%~1) do call set "_fileVar_=%%_fileVar_%%%\n%%%x"	&:: FIXME: remove the need for call here
	::if "!DE!" equ "" for /f "delims=" %%x in (%~1) do call set "_fileVar_=!_fileVar_!%\n%%%x"
	::endlocal & %dk_call% dk_set %2 "%_fileVar_%"
	endlocal & set "%2=%_fileVar_%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0

	%dk_call% dk_fileToVariable "DK.cmd" myVar
	%dk_call% dk_echo "myVar = %myVar%"
%endfunction%
