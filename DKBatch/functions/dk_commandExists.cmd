@echo off
call DK

::################################################################################
::# dk_commandExists(<command>)
::#
::#
:dk_commandExists () {
	call dk_debugFunc
	
    ::set "command=%1"
    
	cmd /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
    if %ERRORLEVEL% EQU 0 call dk_info "%~1 found" & goto:eof
    call dk_info "%~1 NOT found"
goto:eof








:DKTEST ########################################################################
	echo dk_commandExists TEST