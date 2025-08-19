@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#####################################################################
::# dk_Host_Tuple()
::#
::#
:dk_Host_Tuple
%setlocal%
	%dk_call% dk_debugFunc 0 1
 		
	:: ###### SET ######
	if "%~1" neq "" (
		set "Host_Tuple=%~1"
	
	rem ###### GET ######	
	) else (
		if NOT defined Host_Os		(%dk_call% dk_Host_Os)
		if NOT defined Host_Arch	(%dk_call% dk_Host_Arch)
		set "Host_Tuple=!Host_Os!_!Host_Arch!"
	)
	
	:: ###### FINALIZE ######
	endlocal & (
		set "Host_Os=%Host_Os%"
		set "Host_Arch=%Host_Arch%"
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
	%dk_call% dk_echo "Host_Tuple = %Host_Tuple%"
	%dk_call% dk_echo "%Host_Tuple%_Host =  !%Host_Tuple%_Host!"
	
	::###### SET ######
	%dk_call% dk_Host_Tuple "Linux_I686"
	%dk_call% dk_echo "Host_Tuple = %Host_Tuple%"
	%dk_call% dk_echo "%Host_Tuple%_Host =  !%Host_Tuple%_Host!"
%endfunction%