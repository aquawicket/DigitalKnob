@echo off
call DK

::####################################################################
::# dk_extract(<url> <destination>)
::#
::#
:dk_extract () {
	call dk_debugFunc
	
	echo Extracting %~1 to %2
	if not exist "%~1" (
        echo cannot find %~1
        goto:eof
    )
	::if exist "%~2" (
    ::    echo %~2 already exist
    ::    goto:eof
    ::)
    powershell Expand-Archive "%1" -DestinationPath "%2"
goto:eof