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


rem #################################################################################
rem dk_registrySetKey() <reg_path> <key> <type> <value>
rem 
:dk_registrySetKey
%setlocal%

    if "%~1" neq "" (set "_reg_path_=%~1")	else 	(%dk_call% dk_error "dk_registrySetKey: _reg_path_ is invalid" & %return%)
    if "%~2" neq "" (set "_key_=/v %~2")	else	(set "_key_=/ve")
    if "%~3" neq "" (set "_type_=/t %~3")	else 	(set "_type_=")
    if "%~4" neq "" (set "_value_=%~4")		else	(set "_value_=")

	%dk_call% dk_validate reg.exe %dk_call% dk_findFile reg.exe
	
    set command="%reg.exe:/=\%" ADD "%_reg_path_:/=\%" %_key_% %_type_% /d "%_value_%" /f
	echo command = %command%
	%command%
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
rem 	### Fix 15 file minimum context menu issue ###
	%dk_call% dk_registrySetKey "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" "MultipleInvokePromptMinimum" "REG_DWORD" 50
	 
rem    %dk_call% dk_set NOTEPAD_EXE "%SystemRoot:\=/%/notepad.exe"
rem    %dk_call% dk_registrySetKey "HKCR/*/shell/Edit with Notepad" "Icon" "REG_SZ" "\"%NOTEPAD_EXE:/=\%\""
rem    %dk_call% dk_registrySetKey "HKCR/*/shell/Edit with Notepad/command" "" "" "\"%NOTEPAD_EXE:/=\%\" \"%%%%%%%%1\""
	
	rem %dk_call% dk_registrySetKey
%endfunction%
