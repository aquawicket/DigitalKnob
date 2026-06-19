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


rem ############ reg_exe ############
rem #
:DKINSTALL
%setlocal%
 	
rem	%dk_call% dk_import
	
	"!reg_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (set "reg_exe=%SystemRoot:\=/%/System32/reg.exe")
	echo reg_exe = %reg_exe%
	"!reg_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (set "reg_exe=%DKTOOLS_DIR%/reg/reg.exe")
	"!reg_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (%dk_call% dk_findFile reg.exe)
rem	"!reg_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (
rem		%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
rem		set "reg_exe=%DKTOOLS_DIR%/reg/reg.exe"
rem		if NOT EXIST "%reg_exe%" (
rem			%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
rem			"C:\Windows\System32\reg.exe" --show-error --remote-time --location --remove-on-error --create-dirs --output "!DKDOWNLOAD_DIR!/reg" "https://cosmo.zip/pub/cosmos/bin/reg"
rem			%dk_call% dk_mkdir "%DKTOOLS_DIR%/reg"
rem			%dk_call% dk_copy "!DKDOWNLOAD_DIR!/reg" "%reg_exe%"
rem		)
rem	)
	"!reg_exe:/=\!" --version 1>nul 2>nul && (goto:return) || (
		%dk_call% dk_error "reg_exe:'!reg_exe!' FAILED"
	)
	
	 
	rem set reg_exe=%dk_start% "%DKTOOLS_DIR:/=\%\reg\reg"
	rem %dk_start% "%reg_exe:/=\%" --version
	
	:return
rem	%dk_call% dk_firewallAllow "%reg_exe%"
	endlocal & (
		set "reg_exe=%reg_exe%"
	)	
%endfunction%









rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "reg_exe="
	%dk_call% dk_validate reg_exe %dk_call% dk_depend reg_exe
	%dk_call% dk_debug "reg_exe = %reg_exe%"
%endfunction%