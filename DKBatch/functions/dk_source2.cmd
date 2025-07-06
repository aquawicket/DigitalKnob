@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_source2(function_name)
::#
::#    @function_name   - the function name of the file to source and download if needed
::#
:dk_source2
::%setlocal%
    ::%dk_call% dk_debugFunc 1
	
	if "%~1" equ "" (echo ERROR: dk_source2 %* argument 1 is empty & exit /b 13)
	set "_fnc_=%~1"
	if exist "%_fnc_%" exit /b 0
		
	if not defined DKHOME_DIR 	set "DKHOME_DIR=%USERPROFILE:\=/%"
	if not defined DKHTTP_DIR 	set "DKHTTP_DIR="https://raw.githubusercontent.com/aquawicket"
	
	::############ Correct the path delimiters ############
	set "_fnc_=%_fnc_:\=/%"
	if exist "%_fnc_%" exit /b 0
		
	::############ Get the full path and extension ############
	call set _fnc__noext=%%_fnc_:.%_fnc_:*.=%=%%
	::set "_fnc__noext=%_fnc_:.*=%
	if "%_fnc_%" equ "%_fnc__noext%" (set "_fnc_=%_fnc_%.cmd")
	if exist "%_fnc_%" exit /b 0

	::###### If func doesn't contain C:/  ...prepend C:/Users/Administrator/DigitalKnob/Development/DKBash/functions/ ######
	if "%_fnc_:C:/=%" equ "%_fnc_%" (set "_fnc_=%DKHOME_DIR%/DigitalKnob/Development/DKBatch/functions/%_fnc_%")
	if exist "%_fnc_%" exit /b 0

	::############ Download the file if missing #############
	rem ###### Replace C:/Users/Administrator with ########
	rem ###### https://raw.githubusercontent.com/aquawicket
	set "_url_=%_fnc_:C:/Users/Administrator=https://raw.githubusercontent.com/aquawicket%"
	
	rem ###### DOWNLOAD ######
	for %%Z in ("%_fnc_%") do set "dirn=%%~dpZ"
	if "%dirn:~-1%" equ "\" set "dirn=%dirn:~0,-1%"
	if "%dirn:~-1%" equ "/" set "dirn=%dirn:~0,-1%"
	if not exist %dirn% mkdir %dirn%	

	echo curl.exe -L "%_url_%" -o "%_fnc_%"
	if not exist "%_fnc_%"  curl.exe --help 1>nul 2>nul && curl.exe -L "%_url_%" -o "%_fnc_%"
	if exist "%_fnc_%" exit /b 0
	
	::if not exist "%_fnc_%"  certutil.exe 1>nul 2>nul 	&& certutil.exe -urlcache -split -f "%_url_%" "%_fnc_%"
	::if exist "%_fnc_%" exit /b 0
	
	::if not exist "%_fnc_%"	bitsadmin.exe /transfer /Download /priority Foreground "%_url_%" "%_fnc_%"
	::if exist "%_fnc_%" exit /b 0
	
	::############ Final Check ############
	if not exist "%_fnc_%"   echo ERROR   Failed to download %_fnc_%  &&  exit /b 13	
%endfunction%	
	






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	del "dk_info.cmd_BACKUP"
	ren "dk_info.cmd" "dk_info.cmd_BACKUP"
	del "dk_info.cmd"
	pause
    %dk_call% dk_source2 dk_info
    call dk_info "test message using dk_source2 to download it first"
%endfunction%