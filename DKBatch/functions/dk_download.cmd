@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_basename
call dk_source dk_getDKPaths
call dk_source dk_getFullPath
call dk_source dk_info
call dk_source dk_realpath
call dk_source dk_set
call dk_source dk_validate
::####################################################################
::# dk_download(url, destination)
::#
::#
:dk_download
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set "destination=%~2"
	if defined destination goto:destination_set
	call dk_basename %~1 DL_FILE
	call dk_validate DKDOWNLOAD_DIR "call dk_getDKPaths"
	::call dk_set destination "%DKDOWNLOAD_DIR%\%DL_FILE%"
	set "destination=%DKDOWNLOAD_DIR%\%DL_FILE%"
	:destination_set
	
	call dk_realpath %destination% fullPath
	if %destination% neq %fullPath% call dk_error "destination is invalid: full path required"
	
    if exist "%destination%" call dk_info "%destination% already exist" && goto:eof

	call dk_info "Downloading %~1 . . ."
    
	set "User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
    
	:: Try powershell
	powershell /? 1>nul && powershell -command { $cli = New-Object System.Net.WebClient; $cli.Headers['%User-Agent%'] = 'myUserAgentString'; $cli.DownloadFile('%~1', '%destination%')" && goto:eof }
	
	:: Try curl
	curl --help 1>nul && curl "%~1" -o "%destination%" && goto:eof
	
	:: Try certutil
	certutil.exe /? 1>nul && certutil.exe -urlcache -split -f "%~1" "%destination%" && goto:eof
	
	::FIXME - download as temporary name like myFile.txt_DOWNLOADING
	::		  then rename it to it's original upon completion
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_download https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd
goto:eof
