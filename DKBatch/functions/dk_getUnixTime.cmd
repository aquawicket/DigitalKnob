@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_getUnixTime(<ret>:OPTIONAL)
rem #
rem #    REFERENCE: https://ss64.com/nt/syntax-gettime.html
rem #
:dk_getUnixTime
%setlocal%
	
	%dk_call% dk_validate WMIC.exe %dk_call% dk_findFile WMIC.exe
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
    for /f %%x in ('%WMIC.exe:/=\% path win32_utctime get /format:list ^| %findstr.exe:/=\% "="') do (set %%x)
    set /a z=(14-100%Month%%%100)/12, y=10000%Year%%%10000-z
    set /a ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+Day-719469
    set /a dk_getUnixTime=ut*86400+100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
    
	
	:return
	endlocal & (
		set "dk_getUnixTime=%dk_getUnixTime%"
		if "%~1" neq "" (set "%~1=%dk_getUnixTime%")
	)
	rem %dk_call% dk_debug "dk_getUnixTime = '%dk_getUnixTime%'"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_getUnixTime
    %dk_call% dk_debug "dk_getUnixTime = '%dk_getUnixTime%'"
%endfunction%
