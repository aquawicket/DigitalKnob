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


rem ##################################################################################
rem # dk_fileSearch(<base_path>, <file_pattern>, <search_depth>, optional:<rtn_var>)
rem #
rem #
rem #   Example:  %dk_call% dk_fileSearch "%USERPROFILE:\=/%/Digital Knob" "/bin/bash.exe" 7 bash_exe
:dk_fileSearch
%setlocal%
	set "base_path=%~1"
	set "base_path=%base_path:/=\%"
	set "file_pattern=%~2"
	set "file_pattern=%file_pattern:/=\%"
	set "search_depth=%~3"

	rem set file_pattern=%file_pattern:/=\%
	for %%a in (%file_pattern:\= %) do set filename=%%a
	set prefix=!file_pattern:%filename%=!

	echo searching '%base_path%' for '%file_pattern%'
	rem /s		- copy Subdirectories, but NOT empty ones.
	rem /fp		- include Full Pathname of files in the output.
	rem /l		- List only - don't copy, timestamp or delete any files.
	rem /lev:n 	- only copy the top n LEVels of the source directory tree.
	rem /nc		- No Class - don't log file classes.
	rem /ndl		- No Directory List - don't log directory names.
	rem /njh		- No Job Header.
	rem /njs		- No Job Summary.
	rem /ns		- No Size - don't log file sizes.
	echo.
	for /f "tokens=*" %%g in ('%systemroot:\=/%/system32/robocopy.exe "%base_path%" "null" "%filename%" /fp /l /lev:%search_depth% /nc /ndl /njh /njs /ns /s') do (
		set "string=%%g"
		if "!string:%file_pattern%=!" neq "!string!" (
			echo *** %%g
			set "dk_fileSearch=%%g"
		) else (
			echo %%g
		)
	)
	endlocal & (
		set "dk_fileSearch=%dk_fileSearch%"
		if "%~4" neq "" set "%4=%dk_fileSearch%"
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_fileSearch "%USERPROFILE%" "DKBatch/functions/DK.cmd" 9 DK_cmd
	%dk_call% dk_debug "DK_cmd = %DK_cmd%"
	
rem	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
rem	%dk_call% dk_fileSearch "%DKTOOLS_DIR%" "/usr/bin/bash.exe" 4 bash_exe
rem	%dk_call% dk_debug "bash_exe = %bash_exe%"
	
	
%endfunction%
