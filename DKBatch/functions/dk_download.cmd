::call dk_includeGuard

::####################################################################
::# dk_download(<url> <destination>)
::#
::#
:dk_download () {
	call dk_debugFunc
	
    echo Downloading %~1
    if exist "%~2" (
        echo %~2 already exist
        goto:eof
    )

    echo please wait . . .
    ::certutil.exe -urlcache -split -f %~1 %~2
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%~1', '%~2')"
    call dk_checkError
goto:eof