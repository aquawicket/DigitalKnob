@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_generate()
::#
::#
:dk_generate
 ::%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_title "Generating %Target_App% - %Target_Tuple% - %Target_Type%"
	%dk_call% dk_echo
	%dk_call% dk_echo "##################################################################"
	%dk_call% dk_echo "	  Generating %Target_App% - %Target_Tuple% - %Target_Type%"
	%dk_call% dk_echo "##################################################################"
	%dk_call% dk_echo

	::###### DKBATCH_TOOLCHAIN ######
	%dk_call% dk_set DKBATCH_TOOLCHAIN %DKBATCH_DIR%/toolchains/%Target_Tuple%_Toolchain.cmd
 	%dk_call% dk_assertPath %DKBATCH_TOOLCHAIN%
	call "%DKBATCH_TOOLCHAIN:/=\%"

	if not defined CMAKE_GENERATOR (
		%dk_call% dk_notice "CMAKE_GENERATOR invalid for %Target_Tuple%. skipping..."
		exit /b 0
	)
	
	
	::############ Host_Os ############
	%dk_call% dk_validate Host_Os "%dk_call% dk_Host_Os"
	%dk_call% dk_assertVar Host_Os
	
	::############ Target_Path ############
	%dk_call% dk_validate DKCPP_APPS_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "Target_Path=%DKCPP_APPS_DIR%/%Target_App%"
	
	::############ Create Debug / Release Folder ############
	if not exist "%Target_Path%/%Target_Tuple%" (%dk_call% dk_mkdir "%Target_Path%\%Target_Tuple%")
	
	::############ set CMAKE Variables ###########
	%dk_call% dk_validate DKCMAKE_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "CMAKE_SOURCE_DIR=%DKCMAKE_DIR%"
	set "CMAKE_TARGET_PATH=%TARGET_PATH%"

	::############ Create CMAKE_ARGS array ############
	set "Target_Level=RebuildAll"
	set "DKLINK=Static"

	set "CMAKE_ARGS="
	if /i "%Target_Type%"  equ "Debug"		(%dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON)
	if /i "%Target_Type%"  equ "Release"	(%dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON)
	if /i "%Target_Type%"  equ "All"		(%dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON) && (%dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON)
	if /i "%Target_Level%" equ "Build"		(%dk_call% dk_appendArgs CMAKE_ARGS -DBUILD=ON)
	if /i "%Target_Level%" equ "Rebuild"	(%dk_call% dk_appendArgs CMAKE_ARGS -DREBUILD=ON)
	if /i "%Target_Level%" equ "RebuildAll"	(%dk_call% dk_appendArgs CMAKE_ARGS -DREBUILDALL=ON)
	if /i "%DKLINK%" 	   equ "Static"		(%dk_call% dk_appendArgs CMAKE_ARGS -DSTATIC=ON)
	if /i "%DKLINK%"       equ "Shared"		(%dk_call% dk_appendArgs CMAKE_ARGS -DSHARED=OFF)
	::if "%Target_Tuple%==emscripten" 		(%dk_call% dk_appendArgs CMAKE_ARGS -DEMSCRIPTEN=ON)

	::############ DKCMAKE_FUNCTIONS_DIR_ ############
	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ "%dk_call% dk_DKBRANCH_DIR"
	set "DKCMAKE_FUNCTIONS_DIR_=!DKCMAKE_FUNCTIONS_DIR_:\=/!"   
	%dk_call% dk_appendArgs CMAKE_ARGS -DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%

	::############ CMake Options ############
	%dk_call% dk_appendArgs CMAKE_ARGS -DCMAKE_VERBOSE_MAKEFILE=1
	::%dk_call% dk_appendArgs CMAKE_ARGS -DCMAKE_COLOR_DIAGNOSTICS=ON
	%dk_call% dk_appendArgs CMAKE_ARGS -Wdev
	::%dk_call% dk_appendArgs CMAKE_ARGS -Werror=dev
	%dk_call% dk_appendArgs CMAKE_ARGS -Wdeprecated
	::%dk_call% dk_appendArgs CMAKE_ARGS -Werror=deprecated
	::%dk_call% dk_appendArgs CMAKE_ARGS --graphviz=graphviz.txt
	::%dk_call% dk_appendArgs CMAKE_ARGS --system-information system_information.txt
	%dk_call% dk_appendArgs CMAKE_ARGS --debug-trycompile
	::%dk_call% dk_appendArgs CMAKE_ARGS --debug-output
	::%dk_call% dk_appendArgs CMAKE_ARGS --trace
	::%dk_call% dk_appendArgs CMAKE_ARGS --trace-expand
	::%dk_call% dk_appendArgs CMAKE_ARGS --warn-uninitialized
	::%dk_call% dk_appendArgs CMAKE_ARGS --warn-unused-vars
	::%dk_call% dk_appendArgs CMAKE_ARGS --check-system-vars

	if not defined MULTI_CONFIG		(set "SINGLE_CONFIG=1")

	if /i "%Target_Os%" equ "Linux"	(set "WSL_EXE=wsl")

	%dk_call% dk_appendArgs CMAKE_ARGS -S="%CMAKE_SOURCE_DIR%"

	if defined MULTI_CONFIG			(set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%Target_Tuple%")
	if defined SINGLE_CONFIG		(set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%Target_Tuple%/%Target_Type%")
	
	%dk_call% dk_assertVar CMAKE_BINARY_DIR
	%dk_call% dk_appendArgs CMAKE_ARGS -B="%CMAKE_BINARY_DIR%"
	
	%dk_call% dk_assertVar CMAKE_GENERATOR
	%dk_call% dk_prependArgs CMAKE_ARGS -G %CMAKE_GENERATOR%

::  ###### WSL CMake Fix ######
::  if defined WSLENV; then 
::		%dk_call% dk_chdir "$DKCMAKE_DIR"
::		set -- "$@" "."
::	fi
	::if defined WSL_EXE (
	::	%dk_call% dk_replaceAll "!CMAKE_ARGS!" "C:" "/mnt/c" WSL_CMAKE_ARGS
	::)

	::###### Linux_x86_64 (WSL) ######
	if defined WSL_EXE (%dk_call% dk_replaceAll "!DKSCRIPT_DIR!" "C:" "/mnt/c" DKSCRIPT_DIR)
	if defined WSL_EXE (%WSL_EXE% sh -c "export UPDATE=1 && export Target_App=%Target_App% && export Target_Tuple=%Target_Tuple% && export Target_Type=%Target_Type% && %DKSCRIPT_DIR:\=/%/DKBuilder.sh && exit $(true)")
	if defined WSL_EXE (%return%)

	::###### CMake Configure ######
	%dk_call% dk_validate DKIMPORTS_DIR  "%dk_call% dk_DKIMPORTS_DIR"
	if not defined CMAKE_EXE (call "%DKIMPORTS_DIR%/cmake/DKINSTALL.cmd")

	::###### Delete Cmake Cache files ######
	%dk_call% dk_clearCmakeCache "%CMAKE_BINARY_DIR%"

	::########### CMAKE Command ###################
	echo "%CMAKE_EXE%" %CMAKE_ARGS%
	%dk_call% "%CMAKE_EXE%" %CMAKE_ARGS% && (
		%dk_call% dk_success "CMake Generation Successful"
	) || (
		%dk_call% dk_error "CMake Generation Failed"
	)
	::############################################

	::###### IMPORT VARIABLES ######
	%dk_call% dk_importVars
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_generate
%endfunction%
