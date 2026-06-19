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


rem ############ cmake ############
rem # https://cmake.org
rem # https://github.com/Kitware/CMake
rem # https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
rem # https://developer.android.com/studio/projects/configure-cmake
rem # https://discourse.cmake.org/t/cmake-silent-install-with-options-help/1475/2
rem # https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line 	# How to get latest version on ubuntu
rem # https://github.com/Kitware/CMake/releases
rem #
:DKINSTALL
%setlocal%
	
	rem ######### kill cmake.exe process #########
	rem # %dk_call% dk_killProcess cmake.exe

	rem ######### kill cmake-gui.exe process #########
	rem # %dk_call% dk_killProcess cmake-gui.exe
	
	set "cmake.exe=%cmake.exe:cmake.exe%=%"
	
	%dk_start% "!cmake.exe:/=\!" --version 1>nul 2>nul && (
		goto:return) || (
			%dk_call% dk_import
			%dk_call% dk_validate Host_Os %dk_call% dk_Host_Os
			if /i "!Host_Os!" equ "Windows" ( 
				set "cmake.exe=!cmake.exe!/bin/cmake.exe"
			) else ( 
				set "cmake.exe=!cmake.exe!/bin/cmake"
			)	
		)

	%dk_start% "!cmake.exe:/=\!" --version 1>nul 2>nul && (
		goto:return) || (
			if exist "!cmake.exe!" (
				%dk_call% dk_error "cmake.exe:'%cmake.exe%' FAILED"
			) else (
				%dk_call% dk_error "cmake.exe:'%cmake.exe%' NOT FOUND"
			)
			%endfunction%
		)
	
	:return
	%dk_call% dk_firewallAllow "%cmake.exe%"
	endlocal & (
		set "cmake.exe=%cmake.exe%"
	)
	rem %dk_call% dk_cacheVariable cmake.exe
	rem %dk_call% dk_debug "cmake.exe = %cmake.exe%"
%endfunction%


	rem Add cmake to git_bash (symlink)
	rem %dk_call% dk_validate bash_exe %dk_call% dk_depend git
	rem %bash_exe% -c "ln ${HOME}/Digital Knob/DKTools/%cmake_Install_Folder%/bin/cmake /usr/bin/cmake"
	rem %bash_exe% -c "ln -s ${HOME}/Digital Knob/DKTools/%cmake_Install_Folder%/share/cmake-3.29 /usr/share/cmake-3.29"
	
	
rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo.
	echo ####### Test dk_depend cmake.exe ######
	set "cmake.exe="
	%dk_call% dk_validate cmake.exe  %dk_call% dk_depend cmake.exe
	%dk_call% dk_debug "cmake.exe = %cmake.exe%"
	%dk_start% "%cmake.exe:/=\%" --version
	pause
	
	echo.
	echo ###### Test %%dk_call%% cmake.exe ######
	set "cmake.exe="
	%dk_call% cmake.exe --version
	pause
%endfunction%
