rem shebang
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


rem ####################################################################
rem # file(name.extension)
rem # 
rem #		search for a file and place the path to the file in a variable of it's own name if found
rem #     if NOT found.  The variable will be assigned to just the filename
rem #
:DKINSTALL
%setlocal%
	
	rem ### Test if already valid
	if EXIST "!%~1!" (%return%)
	(set %~1=%~1)

	rem ### locate
	if NOT EXIST "!%~1!" (
		for /f "usebackq delims=" %%G in (`call where %~1 2^>nul`) do (
			(set "%~1=%%~G")
		)
	)
rem 	if NOT EXIST "!%~1!" (
rem 		for /f "usebackq delims=" %%G in (`call where /R C:\ %~1 2^>nul`) do (
rem 			(set "%~1=%%~G")
rem 		)
rem 	)
	
	rem ### Test if exists
	if NOT EXIST "!%~1!" (
		%dk_call% dk_error "%~1:'!%~1!' not found"
	)	
	set value=!%~1!
	
	
	:return
	rem %dk_call% dk_firewallAllow "%value%"
	endlocal & (
		set "%~1=%value:\=/%"
	)
	rem %dk_call% dk_debug "value = %value%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate curl.exe %dk_call% dk_depend file curl.exe
	%dk_call% dk_debug "curl.exe = %curl.exe%"
	
	%dk_call% dk_validate where.exe %dk_call% dk_depend file where.exe
	%dk_call% dk_debug "where.exe = %where.exe%"
	
	%dk_call% dk_validate unknown.exe %dk_call% dk_depend file unknown.exe
	%dk_call% dk_debug "unknown.exe = %unknown.exe%"
	
	%dk_call% dk_validate DK.cmake %dk_call% dk_depend DK.cmake
	%dk_call% dk_debug "DK.cmake = %DK.cmake%"
%endfunction%
