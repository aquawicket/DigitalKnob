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
rem # ___NEW_BATCH_FUNCTION___()
rem #
rem #
:___NEW_BATCH_FUNCTION___
%setlocal%

	rem ### name the new function
	%dk_call% dk_inputBox
	if "%dk_inputBox%" equ "" (%return%)
	
	set "FUNCTION=%dk_inputBox%"
	set "FUNCTION_FILE=%DKBATCH_FUNCTIONS_DIR_%%FUNCTION:.cmd=%.cmd"
	
	if EXIST "%FUNCTION_FILE%" (
		%dk_call% dk_notice "%FUNCTION_FILE% already exists"
		goto :edit_textfile
	)
	
	setlocal disableDelayedExpansion
	>"%FUNCTION_FILE%" (
		echo.@rem shebang
        echo.@echo off^&rem ###### DK.cmd #########################################################################################################################
        echo.if not defined DKINIT_cmd (
        echo.    setlocal enableDelayedExpansion
        echo.    if NOT EXIST "%%DK.cmd%%" (set "DK.cmd=%%USERPROFILE%%\Digital Knob\Development\DKBatch\functions\DK.cmd"^)
        echo.    if NOT EXIST "!DK.cmd!" (for /F "delims=" %%%%G IN ('dir /b/s/a:-d "%%USERPROFILE%%\DK.cmd"'^) do (set "DK.cmd=%%%%~fG"^)^)
        echo.    if NOT EXIST "!DK.cmd!" (
        echo.           "%%SystemRoot%%\System32\curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd^)
        echo.    call "!DK.cmd:/=\!" "%%%%~0" %%%%*
        echo.    exit /b %%errorlevel%%
        echo.^)
        echo.rem #################################################################################################################################################
		echo.
		echo.
		echo.rem ############################################################################
		echo.rem # %dk_inputBox%(^)
		echo.rem #
		echo.rem #
		echo.:%dk_inputBox%
		echo.%%setlocal%%
		echo.
		echo.	::insert function code here::
		echo.
		echo.%%endfunction%%
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
		echo.:DKTEST
		echo.%%setlocal%%
		echo.
		echo.	%%dk_call%% %dk_inputBox%
		echo.
		echo.%%endfunction%%
		echo.
	)
	endlocal
	
	:edit_textfile
	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp_exe
	"%notepadpp_exe%" "%FUNCTION_FILE%"
%endfunction%


















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% ___NEW_BATCH_FUNCTION___
%endfunction%
