@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_source(function_name)
::#
::#    @function_name   - the function name of the file to source and download if needed
::#
:dk_source2
::%setlocal%
    ::%dk_call% dk_debugFunc 1
	
	if "%~1" equ "" (echo ERROR: dk_source %* argument 1 is empty & exit /b 13)
	
	set "_fnc_=%~1"
	
	if not defined DKHOME_DIR 	echo "ERROR  DKHOME_DIR invalid"
	if not defined DKHTTP_DIR 	set "DKHTTP_DIR="https://raw.githubusercontent.com/aquawicket"
	
	::############ Correct the path delimiters ############
	set "_fnc_=%_fnc_:\=/%"
		
	::############ Get the full path and extension ############
	if not exist "%_fnc_%"	set "_fnc__noext=%_fnc_:.*=%
	if not exist "%_fnc_%"	if "%_fnc_%" equ "%_fnc__noext%" (set "_fnc_=%_fnc_%.cmd")

	::###### If func doesn't contain C:/  ...prepend C:/Users/Administrator/DigitalKnob/Development/DKBash/functions/ ######
	if "%_fnc_:C:/=%" equ "%_fnc_%" (set "_fnc_=%DKHOME_DIR%/DigitalKnob/Development/DKBatch/functions/%_fnc_%")

	::############ Download the file if missing #############
	if exist "%_fnc_%" 	goto:end_download
		rem ###### Replace C:/Users/Administrator with ########
		rem ###### https://raw.githubusercontent.com/aquawicket
		set "_url_=%_fnc_:C:/Users/Administrator=https://raw.githubusercontent.com/aquawicket%"
	
		rem ###### DOWNLOAD ######
		for %%Z in ("%_fnc_%") do set "dirn=%%~dpZ"
		if "%dirn:~-1%" equ "\" set "dirn=%dirn:~0,-1%"
		if "%dirn:~-1%" equ "/" set "dirn=%dirn:~0,-1%"
		if not exist %dirn% mkdir %dirn%	

		echo downloading '%_url_%' - '%_fnc_%'
		if not exist "%_fnc_%"  curl.exe --help 1>nul 2>nul && curl.exe -L "%_url_%" -o "%_fnc_%"
		if not exist "%_fnc_%"  certutil.exe 1>nul 2>nul && certutil.exe -urlcache -split -f "%_url_%" "%_fnc_%"
		if not exist "%_fnc_%"	bitsadmin.exe /transfer /Download /priority Foreground "%_url_%" "%_fnc_%"
	:end_download
	
	::############ Final Check ############
	if not exist "%_fnc_%"   echo ERROR   Failed to download %_fnc_%  &&  exit /b 13
	
	if exist "%_fnc_%"    echo #####  Sourced %_fnc_%
	
%endfunction%	
	
%endfunction%	
    :: load if it's an existing full path file
	set "_file_=%~1"
    if exist "%_file_:.cmd=%.cmd" exit /b 0    &:: NOTE: should we add the dirpath to the PATH environment variable here?
	if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_:/cmd=%.cmd" exit /b 0
	
    :: If it's a dk_function, download if it doesn't exist then load it
    if not defined DKHTTP_DKBATCH_FUNCTIONS_DIR (echo [31m ERROR: DKHTTP_DKBATCH_FUNCTIONS_DIR is invalid [0m & pause)
   
    echo downloading %_file_:.cmd=%.cmd &::to %DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd
   
	::%dk_call% dk_dirname %DKBATCH_FUNCTIONS_DIR_%%~1.cmd source_dir
	for %%Z in ("%DKBATCH_FUNCTIONS_DIR_%%_file_:/cmd=%.cmd") do set "_dirname_=%%~dpZ"
	if not exist "%_dirname_%"   mkdir "%_dirname_%"
	
    :: FIXME: causes infinate recursion loop
    :: Try dk_download
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%dk_download.cmd" %dk_call% dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd" "%DKBATCH_FUNCTIONS_DIR_%%~1.cmd"
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%%~1.cmd" exit /b 0
   
    :: FIXME: causes infinate recursion loop
    :: Try dk_powershell
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%dk_powershell.cmd" %dk_call% dk_powershell "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd', '%DKBATCH_FUNCTIONS_DIR_%%~1.cmd')"
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%%~1.cmd" exit /b 0
  
	:: Try curl    NOTE: -L='follow redirects' -S='show errors' -s='silent'
    %CURL_EXE% --help %NO_STDOUT% && %CURL_EXE% -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%_file_:.cmd=%.cmd" -o "%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd" 1>nul
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd" exit /b 0
	
	:: Try certutil
    %CERTUTIL_EXE% /? %NO_STDOUT% && %CERTUTIL_EXE% -urlcache -split -f "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%_file_:.cmd=%.cmd" "%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd"
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd" exit /b 0
	
    :: Try powershell
    %POWERSHELL_EXE% /? %NO_STDOUT% && %POWERSHELL_EXE% -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%_file_:.cmd=%.cmd', '%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd')"
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd" exit /b 0
   
    :: Try dk_powershell
    %dk_call% dk_powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%_file_:.cmd=%.cmd', '%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd')"
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd" exit /b 0
   
    if not exist "%DKBATCH_FUNCTIONS_DIR_%%_file_:.cmd=%.cmd" echo [31m failed to download %_file_:.cmd=%.cmd [0m
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
    call dk_info "test message using dk_source to download it first"
%endfunction%