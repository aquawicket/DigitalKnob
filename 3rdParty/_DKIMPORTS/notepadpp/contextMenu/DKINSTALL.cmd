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
rem # DKINSTALL()
rem #
:DKINSTALL
%setlocal%

	rem ############ Try local notepad++.exe in DKTools first #############
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	if NOT EXIST "%notepadpp_exe%" (%dk_call% dk_findFile "notepad++.exe" "%DKTOOLS_DIR%" "notepadpp_exe")

	if NOT EXIST "%notepadpp_exe%" (%dk_call% dk_findFile "notepad++.exe" "%ProgramFiles%" "notepadpp_exe")

	rem ############ Install Notepad++ ############
	rem %dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	rem %dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp

rem 	if NOT EXIST "%notepadpp_exe%" (
rem 		%dk_call% dk_error "could NOT find notepad++.exe.  is it installed?"
rem 		%return%
rem 	)


rem %dk_call% dk_installContextMenu "Edit with Notepad++" "%notepadpp_exe%" "%notepadpp_exe:/=\%" "%%1"
  "reg.exe" ADD "HKCR\AllFilesystemObjects\shell\Edit with Notepad++" /v Icon /t REG_SZ /d "%notepadpp_exe:/=\%" /f
  "reg.exe" ADD "HKCR\AllFilesystemObjects\shell\Edit with Notepad++\command" /ve /d "\"%notepadpp_exe:/=\%\" \"%%1\"" /f
%endfunction%

