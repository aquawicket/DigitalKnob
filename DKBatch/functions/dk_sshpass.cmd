@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	%endfuncion%
	exit /b %errorlevel%
)
%endfuncion%
rem #################################################################################################################################################

rem ################################################################################
rem # dk_sshpass()
rem #
rem #
:dk_sshpass
%setlocal%
	rem echo :dk_sshpass %*
	set "SSH_PASS=Triad2393!!"
	set "sshpass.exe=C:\Users\Administrator\Digital Knob\DKTools\sshpass.exe"
	rem echo sshpass.exe = %sshpass.exe%


	rem "%git.exe%" -C "C:\Users\Administrator\Digital Knob\Development" push
	rem echo "%sshpass.exe%" -e "%git.exe%" -C "C:\Users\Administrator\Digital Knob\Development" push
	echo %dk_start% "%sshpass.exe%" -v -e %*
	%dk_start% "%sshpass.exe%" -v -k -P="u108565871@access912915170.webspace-data.io's password:" -e %*
	
	%dk_call% git.exe -C "%Local_Repo%" status
%endfuncion%
exit /b %errorlevel%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ######### Local Repository ########
	set "Branch=Development"
	set "Local_Repo=%USERPROFILE:\=/%/Digital Knob/%Branch%"
	set "git.exe=C:\Users\Administrator\Digital Knob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe"
	set "commit_msg=git commit %date% %time%"
	echo commit message: '%commit_msg%'

	rem ### Commit local repository
	%dk_call% git.exe -C "%Local_Repo%" commit -a -m "%commit_msg%"
	call :dk_sshpass """%git.exe%""" -C """C:\Users\Administrator\Digital Knob\Development""" push
	
%endfuncion%
exit /b %errorlevel%