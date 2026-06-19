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
rem # __LINE__(frame)
rem #
:__LINE__
%setlocal%

    if "%_FRAME_%" equ "" (set "_FRAME_=%~1")
	if "%_FRAME_%" equ "" (set "_FRAME_=0")
    rem set /a _FRAME_+=1
	rem %dk_call% dk_return "%BATCH_LINENO[%_FRAME_%]%"
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem prepareLineNumbers
	set "JREPL=%DKBATCH_DIR%/3rdParty/JREPL.BAT"
	if NOT EXIST %JREPL% %dk_call% dk_error "__LINE__ requires JREPL.BAT"
    >nul 2>nul (
		call %JREPL% "(\x25#=\x25)\d*(\x25=#\x25)" "$1+ln+$2" /j /f "%~f0" /o "%~f0.new"
		fc /b "%~f0" "%~f0.new" && del "%~f0.new" || move /y "%~f0.new" "%~f0"
    )

    echo line %#=%41%=#%
    echo line %#=%42%=#%

    for %%G in ( 1 2 3) DO (
       echo Within loop iteration %%G: line %#=%45%=#%
       echo Within loop iteration %%G: line %#=%46%=#%
    )
%endfunction%
