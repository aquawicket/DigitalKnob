@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::#####################################################################
::# dk_Host_Tuple()
::#
::#
:dk_Host_Tuple
%setlocal%
	%dk_call% dk_debugFunc 0 1
 		
	rem ###### SET ######
	if "%~1" neq "" (
		set "Host_Tuple=%~1"
	
	rem ###### GET ######	
	) else (
		if not defined Host_Os		(%dk_call% dk_Host_Os)
		if not defined Host_Arch	(%dk_call% dk_Host_Arch)
	
		set "Host_Tuple=!Host_os!_!Host_Arch!"
	)
	
	endlocal & (
		set "Host_Tuple=%Host_Tuple%"
		set "%Host_Tuple%_Host=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    ::###### GET ######
    %dk_call% dk_Host_Tuple
	%dk_call% dk_printVar Host_Tuple
	%dk_call% dk_printVar %Host_Tuple%_Host
	
	::###### SET ######
	%dk_call% dk_Host_Tuple "Linux_I686"
	%dk_call% dk_printVar Host_Tuple
	%dk_call% dk_printVar %Host_Tuple%_Host
%endfunction%