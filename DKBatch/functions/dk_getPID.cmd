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


rem #####################################################################
rem # dk_getPID(set) get
rem #
rem # Store the Process ID (PID) of the currently running script in environment variable
rem # RtnVar. If called without any argument, then simply write the PID to stdout.
rem #
:dk_getPID
setlocal disableDelayedExpansion

	:getLock
	set "lock=%temp%\%~nx0.%time::=.%.lock"
	set "uid=%lock:\=:b%"
	set "uid=%uid:,=:c%"
	set "uid=%uid:'=:q%"
	set "uid=%uid:_=:u%"
	setlocal enableDelayedExpansion
		set "uid=!uid:%%=:p!"
	endlocal & (set "uid=%uid%")

	%dk_call% dk_validate WMIC.exe %dk_call% dk_findFile WMIC.exe

	2>nul ( 9>"%lock%" (
		for /f "skip=1" %%A in ('%WMIC.exe:/=\% process where "name='cmd.exe' and CommandLine like '%%<%uid%>%%'" get ParentProcessID') do (
			for %%B in (%%A) do (
				set "dk_getPID=%%B"
			)
			(call )
		)
	) || goto:getLock
	
	del "%lock%" 2>nul
	
	
	:return
	endlocal & (
		set "dk_getPID=%dk_getPID%"
		if "%~1" neq "" (set "%~1=%dk_getPID%")
	)
	rem %dk_call% dk_debug "dk_getPID = '%dk_getPID%'"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_getPID
	%dk_call% dk_debug "dk_getPID = '%dk_getPID%'"
%endfunction%
