@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_source(function_name)
::#
::#    @function_name   - the function name of the file to source and download if needed
::#
:dk_source
    if exist "%DKBATCH_FUNCTIONS_DIR_%dk_debugFunc.cmd" %dk_call% dk_debugFunc 1
 setlocal
	::echo dk_source %*
	
    :: load if it's an existing full path file
	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
    if exist "%_file_%" %return%    &:: NOTE: should we add the dirpath to the PATH environment variable here?
    
    
    :: If it's a dk_function, download if it doesn't exist then load it
    if not defined DKHTTP_DKBATCH_FUNCTIONS_DIR echo [31m ERROR: DKHTTP_DKBATCH_FUNCTIONS_DIR is invalid [0m & pause
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd" %return%
    
    echo downloading %_file_%.cmd to %DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd
    
	::%dk_call% dk_dirname %DKBATCH_FUNCTIONS_DIR_%%~1.cmd source_dir
	for %%Z in ("%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd") do set "_dirname_=%%~dpZ"
	if not exist %_dirname_%   mkdir %_dirname_%
	::%dk_call% dk_makeDirectory %source_dir%
	
    :: FIXME: causes infinate recursion loop
    :: Try dk_download
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%dk_download.cmd" %dk_call% dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd" "%DKBATCH_FUNCTIONS_DIR_%%~1.cmd"
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%%~1.cmd" %return%
    
    :: FIXME: causes infinate recursion loop
    :: Try dk_powershell
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%dk_powershell.cmd" %dk_call% dk_powershell "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd', '%DKBATCH_FUNCTIONS_DIR_%%~1.cmd')"
    ::if exist "%DKBATCH_FUNCTIONS_DIR_%%~1.cmd" %return%
    
    :: Try powershell
    powershell /? %NO_STDOUT% && powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%_file_%.cmd', '%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd')"
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd" %return%
    
    :: Try dk_powershell
    %dk_call% dk_powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%_file_%.cmd', '%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd')"
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd" %return%
    
    :: Try curl
    curl --help %NO_STDOUT% && curl "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%_file_%.cmd" -o "%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd"
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd" %return%
    
    :: Try certutil
    certutil.exe /? %NO_STDOUT% && certutil.exe -urlcache -split -f "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%_file_%.cmd" "%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd"
    if exist "%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd" %return%
    
    if not exist "%DKBATCH_FUNCTIONS_DIR_%%_file_%.cmd" echo [31m failed to download %_file_%.cmd [0m
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_source dk_info
    %dk_call% dk_info "test message using dk_source to download it first"
%endfunction%