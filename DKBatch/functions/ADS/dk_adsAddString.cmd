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
rem # ADS::dk_adsAddString(filePath, string, label)
rem #
rem #
:dk_adsAddString
%setlocal%

	set "filePath=%~1"
	set "filePath=%filePath:/=\%"
	
	set "string=%~2"
	
	set "label=%~3"
	set "label=%label::=%"
	
	if not exist "%filePath%" (
		echo. > "%filePath%"
	)

	echo  "%string%" > "%filePath%:%label%"
%endfunction%















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_selectFile
	%dk_call% ADS::dk_adsAddString "%dk_selectFile%" "Test string" string1
%endfunction%

