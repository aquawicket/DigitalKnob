@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	::######### kill cmake.exe process #########
	::# %dk_call% dk_killProcess cmake.exe

	::######### kill cmake-gui.exe process #########
	::# %dk_call% dk_killProcess cmake-gui.exe
	
	%dk_call% dk_import APP

	if /i "%Host_Os%" equ "Windows" ( 
		%dk_call% dk_set CMAKE_EXE "%PLUGIN.Install.Path%/bin/cmake.exe"
	) else ( 
		%dk_call% dk_set CMAKE_EXE "%PLUGIN.Install.Path%/bin/cmake"
	)	
	%dk_call% dk_assertPath "%CMAKE_EXE%"
	%dk_call% dk_firewallAllow 			"CMake" "%CMAKE_EXE%"

	if EXIST "%CMAKE_EXE%" (%dk_call% dk_success "cmake install complete") else (%dk_call% dk_error "cmake install failed")
	
	:: Add cmake to git_bash (symlink)
	::%dk_call% dk_validate BASH_EXE "%dk_call% dk_depend git"
	::%BASH_EXE% -c "ln ${HOME}/DigitalKnob/DKTools/%CMAKE_FOLDER%/bin/cmake /usr/bin/cmake"
	::%BASH_EXE% -c "ln -s ${HOME}/DigitalKnob/DKTools/%CMAKE_FOLDER%/share/cmake-3.29 /usr/share/cmake-3.29"
%endfunction%
