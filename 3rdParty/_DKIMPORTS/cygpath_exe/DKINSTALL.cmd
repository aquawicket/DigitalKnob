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
	
	if exist "%cygpath_exe%" (
		%return%
	)
	
	rem ###### git ######
	%dk_call% dk_validate git %dk_call% dk_depend git
	set "git_cygpath_exe=!git!/usr/bin/cygpath.exe"
	set "cygpath_exe=!git_cygpath_exe!"
		
	rem %dk_call% dk_assertPath cygpath_exe
	
	:return
	endlocal & (
        set "git_cygpath_exe=%git_cygpath_exe%"
		set "cygpath_exe=%cygpath_exe%"
	)
	rem %dk_call% dk_debug "cygpath_exe = %cygpath_exe%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_unset cygpath_exe
	%dk_call% dk_validate cygpath_exe %dk_call% dk_depend cygpath_exe
	%dk_call% dk_debug "cygpath_exe = %cygpath_exe%"
	"%cygpath_exe:/=\%" --version
	
	%dk_call% dk_unset cygpath_exe
	%dk_call% dk_validate cygpath_exe %dk_call% dk_depend cygpath_exe
	%dk_call% dk_debug "cygpath_exe = %cygpath_exe%"
	"%cygpath_exe:/=\%" --version
%endfunction%
