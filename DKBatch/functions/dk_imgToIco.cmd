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


rem ####################################################################
rem # dk_imgToIco(<imgFile>, <icoFile>)
rem #
rem #
:dk_imgToIco
%setlocal%

    set "imgFile=%~1"
	set "imgFile=%imgFile:/=\%"
    set "icoFile=%~2"
	set "icoFile=%icoFile:/=\%"
    set "OVERWRITE=%~3"
   
    if NOT defined OVERWRITE if EXIST "%icoFile%" (%dk_call% dk_warning "%icoFile% already exists" && %return%)
	if EXIST "%icoFile%" (%dk_call% dk_delete "%icoFile%")

	%dk_call% dk_callDKPowershell dk_imgToIco "%imgFile% %icoFile%"
   
    if NOT EXIST "%icoFile%" (%dk_call% dk_fatal "icoFile:'%icoFile%' NOT FOUND")
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	set "imgFile=%USERPROFILE:\=/%/Digital Knob/Development/DKCpp/apps/DKCore/icons/icon.png"
	set "icoFile=%USERPROFILE:\=/%/Digital Knob/Development/DKCpp/apps/DKCore/icons/icon.ico"
	%dk_call% dk_imgToIco "%imgFile%" "%icoFile%"
%endfunction%
