@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	if NOT DEFINED DK.cmd (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	call "%%DK.cmd:/=\%%" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # dk_depend(plugin)
rem #
rem #   Run the DKINSTALL.cmd file for the given 'plugin'
rem #  '3rdParty/_IMPORTS/'plugin'/DKINSTALL.cmd'
rem #
:dk_depend
%setlocal%
	
	if "!DISABLE_%~1!" equ "1" (
		%dk_call% dk_notice "%~1 is Disabled"
		%return%
	)
		
	set "CURRENT_PLUGIN=%~1"
	%dk_call% dk_debug "CURRENT_PLUGIN = %CURRENT_PLUGIN%"
	
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	
	set "DKINSTALL_cmd=%DKIMPORTS_DIR%/%CURRENT_PLUGIN%/DKINSTALL.cmd"
	if NOT EXIST "%DKINSTALL_cmd%" (
		rem call set "DKHTTP_DKINSTALL_cmd=%%DKINSTALL_cmd:%DIGITALKNOB_DIR%=%DKHTTP_DIGITALKNOB_DIR%%%"
		%dk_call% dk_assertVar DKHTTP_DIGITALKNOB_DIR
		set "DKHTTP_DKINSTALL_cmd=!DKINSTALL_cmd:%DIGITALKNOB_DIR%=%DKHTTP_DIGITALKNOB_DIR%!"
		%dk_call% dk_download "!DKHTTP_DKINSTALL_cmd!" "%DKINSTALL_cmd%"
	)
	
	%dk_call% dk_allButFirstArgs %*	
	endlocal & (
		set "CURRENT_PLUGIN=%CURRENT_PLUGIN%"
		rem %dk_call% "%DKINSTALL_cmd%" %dk_allButFirstArgs%
		echo call "%DKINSTALL_cmd:/=\%" %dk_allButFirstArgs%
		call "%DKINSTALL_cmd:/=\%" %dk_allButFirstArgs%
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "git="
	%dk_call% dk_validate git %dk_call% dk_depend git
	%dk_call% dk_debug "git.exe = %git.exe%"
	"%git.exe:/=\%" --version

	set "bash_exe="
	%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe GIT
	%dk_call% dk_debug "bash_exe = %bash_exe%"
	"%bash_exe:/=\%" --version
	
	set "bash_exe="
	%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe MSYS2
	%dk_call% dk_debug "bash_exe = %bash_exe%"
	"%bash_exe:/=\%" --version
%endfunction%

