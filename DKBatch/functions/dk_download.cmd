@echo off
call DK

::####################################################################
::# dk_download(<url> <destination>)
::#
::#
:dk_download () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    call dk_info "Downloading %~1 . . ."
    if exist "%~2" (
        call dk_info "%~2 already exist"
        goto:eof
    )

    call dk_info "please wait . . ."
    ::certutil.exe -urlcache -split -f %~1 %~2
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%~1', '%~2')"
	::FIXME - download as temporary name like myFile.txt_DOWNLOADING
	::		  then rename it to it's original upon completion
	
	call dk_load dk_checkError
    call dk_checkError
goto:eof




:DKTEST ########################################################################
	
	call dk_download https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBuilder.cmd DKBuilder.cmd