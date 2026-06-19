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


rem ############################################################################
rem # dk_evalDKJavascript()
rem #
rem #		https://stackoverflow.com/q/51262326
rem #
:dk_evalDKJavascript
%setlocal%

	set "code=%~1"
	
	rem Method 1 - mshta.exe javascript:
	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
	set DKCOMMAND=%mshta.exe:/=\% "javascript:%code%" 	
	for /f "usebackq delims=" %%a in (`%DKCOMMAND%`) do (
		@echo %%a
		set "dk_evalDKJavascript=%%a"
	)
	
	rem https://stackoverflow.com/q/51262326
	rem %DKCOMMAND% | for /f "delims=" %%a in ('%findstr.exe% "^"') do @echo %%a


	rem Method 2 - cscriopt.exe w/ temporary file
rem	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
rem	echo %code% > "%DKCACHE_DIR%/dk_evalJavascript_TEMP.js"
rem	%dk_call% dk_validate cscript.exe %dk_call% dk_findFile cscript.exe
rem	set DKCOMMAND=%cscript.exe:/=\% //D //E:javascript //H:CScript //I //NoLogo //X "%DKCACHE_DIR%/dk_evalJavascript_TEMP.js"
rem	for /f "delims=" %%a in ('%DKCOMMAND%') do (
rem		@echo %%a
rem		set "dk_evalDKJavascript=%%a"
rem	)


	:return
	endlocal & (
		set "dk_evalDKJavascript=%dk_evalDKJavascript%"
	)
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 
	%dk_call% dk_evalDKJavascript "new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write('Hello World');close();"
	%dk_call% dk_debug "dk_evalDKJavascript = '%dk_evalDKJavascript%'"
%endfunction%

