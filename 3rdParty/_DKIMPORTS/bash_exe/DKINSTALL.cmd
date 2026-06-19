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
	
	if not defined bash_exe_DEFAULT (
		set "bash_exe_DEFAULT=git"
	)
	
	if exist "%bash_exe%" (
		if /i "%bash_env%" equ "%~1" (
			%return%
		)
	)
	
	set "bash_env=%~1"
	if "%bash_env%" equ "" (set "bash_env=%bash_exe_DEFAULT%")
	
	rem ###### git ######
	if /i "%bash_env%" equ "git" (
		%dk_call% dk_validate git %dk_call% dk_depend git
		set "git_bash_exe=!git!/bin/bash.exe"
		set "git_bash_icon=!git!/git-bash.exe"
		set "git_cygpath_exe=!git!/usr/bin/cygpath.exe"
		set "bash_exe=!git_bash_exe!"
		set "bash_icon=!git_bash_icon!"
		set "cygpath_exe=!git_cygpath_exe!"
	)
		
	rem ###### msys2 ######
	if /i "%bash_env%" equ "msys2" (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		set "msys2_bash_exe=!msys2!/usr/bin/bash.exe"
		set "msys2_bash_icon=!msys2!/msys2.exe"
		set "bash_exe=!msys2_bash_exe!"
		set "bash_icon=!msys2_bash_icon!"
	)
	
	rem ###### wsl ######
	if /i "%bash_env%" equ "wsl" (
		%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe
		set "wsl_bash_exe=%SystemRoot%/System32/bash.exe"
		set "wsl_bash_icon=!wsl.exe!"
		set "bash_exe=!wsl_bash_exe!"
		set "bash_icon=!wsl_bash_icon!"
	)

	%dk_call% dk_assertPath bash_exe
	%dk_call% dk_assertPath bash_icon
	
	:return
	endlocal & (
		set "bash_env=%bash_env%"
		set "bash_exe=%bash_exe%"
		set "bash_icon=%bash_icon%"
		set "cygpath_exe=%cygpath_exe%"
		set "git_bash_exe=%git_bash_exe%"
		set "git_bash_icon=%git_bash_icon%"
		set "git_cygpath_exe=%git_cygpath_exe%"
		set "msys2_bash_exe=%msys2_bash_exe%"
		set "msys2_bash_icon=%msys2_bash_icon%"
		set "wsl_bash_exe=%wsl_bash_exe%"
		set "wsl_bash_icon=%wsl_bash_icon%"
	)
	rem %dk_call% dk_debug "bash_exe = %bash_exe%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_unset bash_exe
	%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe git
	%dk_call% dk_debug "bash_exe = %bash_exe%"
	"%bash_exe:/=\%" --version
	
	%dk_call% dk_unset bash_exe
	%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe msys2
	%dk_call% dk_debug "bash_exe = %bash_exe%"
	"%bash_exe:/=\%" --version
	
	%dk_call% dk_unset bash_exe
	%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe wsl
	%dk_call% dk_debug "bash_exe = %bash_exe%"
	"%bash_exe:/=\%" --version
%endfunction%
