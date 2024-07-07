@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_getBasename
call dk_source dk_getDKPaths
call dk_source dk_getFullPath
call dk_source dk_info
call dk_source dk_set
call dk_source dk_validate
::####################################################################
::# dk_download(url, destination)
::#
::#
:dk_download () {
	call dk_debugFunc
	if %__ARGC__% lss 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "destination=%~2"
	if defined destination goto:destination_set
	call dk_getBasename %~1 DL_FILE
	call dk_validate DKDOWNLOAD_DIR "call dk_getDKPaths"
	call dk_set destination "%DKDOWNLOAD_DIR%\%DL_FILE%"
	:destination_set
	
	call dk_getFullPath %destination% fullPath
	if %destination% neq %fullPath% call dk_error "destination is invalid: full path required"
	
    if exist "%destination%" (
        call dk_info "%destination% already exist"
        goto:eof
    )

	call dk_info "Downloading %~1 . . ."
    ::certutil.exe -urlcache -split -f %~1 %~2
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%~1', '%destination%')"
	::FIXME - download as temporary name like myFile.txt_DOWNLOADING
	::		  then rename it to it's original upon completion
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_download https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd
goto:eof