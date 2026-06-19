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
rem %setlocal%
	
	rem ######### kill cmake.exe process #########
	rem # %dk_call% dk_killProcess cmake.exe

	rem ######### kill cmake-gui.exe process #########
	rem # %dk_call% dk_killProcess cmake-gui.exe
	
	%dk_call% dk_import

	%dk_call% dk_validate Host_Os %dk_call% dk_Host_Os
	if /i "%Host_Os%" equ "Windows" ( 
		set "cmake.exe=%cmake%/bin/cmake.exe"
	) else ( 
		set "cmake.exe=%cmake%/bin/cmake"
	)	
	rem %dk_call% dk_assertPath "%cmake.exe%"
	%dk_call% dk_firewallAllow "%cmake.exe%"

	if EXIST "%cmake.exe%" (%dk_call% dk_success "cmake install complete") else (%dk_call% dk_error "cmake install failed")
	
	rem Add cmake to git_bash (symlink)
	rem %dk_call% dk_validate bash_exe %dk_call% dk_depend git
	rem %bash_exe% -c "ln ${HOME}/Digital Knob/DKTools/%cmake_Install_Folder%/bin/cmake /usr/bin/cmake"
	rem %bash_exe% -c "ln -s ${HOME}/Digital Knob/DKTools/%cmake_Install_Folder%/share/cmake-3.29 /usr/share/cmake-3.29"
%endfunction%
