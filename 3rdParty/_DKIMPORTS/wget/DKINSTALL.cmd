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


::############ wget ############
::# https://www.gnu.org/software/wget
::# https://cosmo.zip/pub/cosmos/bin/wget
::#
:DKINSTALL
%setlocal%
	
	%dk_start% "!wget_exe:/=\!" --version && (goto:return) || (
		%dk_call% dk_validate DKTOOLS_DIR 	%dk_call% dk_DKTOOLS_DIR
		set "wget_exe=!DKTOOLS_DIR!/cosmos/wget"
		if NOT EXIST "!wget_exe!" (
			%dk_call% dk_import INSTALL_PATH "!DKTOOLS_DIR!/cosmos"
			%dk_call% dk_copy "!wget_Download!" "!wget_exe!"
		)
	)

	%dk_start% "!wget_exe:/=\!" --version && (goto:return) || (
		if exist !wget_exe! (
			%dk_call% dk_error "wget_exe:'!wget_exe!' failed"
		) else (
			%dk_call% dk_error "wget_exe:'!wget_exe!' NOT FOUND"
		)
		%endfunction%
	)
	
	:return
	%dk_call% dk_firewallAllow wget "%wget_exe%"	
	endlocal & (
		set "wget=%wget%"
		set "wget_exe=%wget_exe%"
	)
	
	%dk_call% dk_debug "wget = %wget%"
	%dk_call% dk_debug "wget_exe = %wget_exe%"
%endfunction%


:DKTEST
	call :DKINSTALL
%endfuncton%
