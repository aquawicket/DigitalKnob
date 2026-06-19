@rem shebang
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
rem # generate()
rem #
rem #
:generate
 rem %setlocal%

	set "CMAKE_ARGS="
	
	rem ###### DKBATCH_TOOLCHAIN ######
	%dk_call% dk_set DKBATCH_TOOLCHAIN %DKBATCH_DIR%/toolchains/%Target_Tuple%_toolchain.cmd
 	if NOT EXIST "%DKBATCH_TOOLCHAIN%" (
		%dk_call% dk_notice "%DKBATCH_TOOLCHAIN% NOT found. skipping..."
		%dk_call% dk_unset CMAKE_GENERATOR
		exit /b 0
	)
	%dk_call% "%DKBATCH_TOOLCHAIN:/=\%" || (
		%dk_call% dk_notice "%Target_Tuple% invalid. skipping..."
		exit /b 0
	)

	%dk_call% dk_title "Generating %Target_App% - %Target_Tuple% - %Target_Type%"
rem	%dk_call% dk_echo
rem	%dk_call% dk_echo "##################################################################"
rem	%dk_call% dk_echo "	  Generating %Target_App% - %Target_Tuple% - %Target_Type%"
rem	%dk_call% dk_echo "##################################################################"
rem	%dk_call% dk_echo
	
	rem ############ Target_App_Dir ############
	%dk_call% dk_validate DKCPP_APPS_DIR %dk_call% dk_DKBRANCH_DIR
	set "Target_App_Dir=%DKCPP_APPS_DIR%/%Target_App%"
	
	rem ############ Target_Tuple_Dir ############
	set "Target_Tuple_Dir=%Target_App_Dir%/%Target_Tuple%"
	%dk_call% dk_mkdir "%Target_Tuple_Dir%"
	
	rem ############ Get CMakeLists.txt file #############
	if NOT EXIST "%Target_App_Dir%/CMakeLists.txt" (
		%dk_call% dk_copy "%DKCPP_PLUGINS_DIR%/_DKIMPORT/_CMakeLists.txt_" "%Target_App_Dir%/CMakeLists.txt" OVERWRITE
	)
	
	rem ############ set cmake Variables ###########
	%dk_call% dk_validate DKCMAKE_DIR %dk_call% dk_DKBRANCH_DIR
	rem set "CMAKE_SOURCE_DIR=%DKCMAKE_DIR%"
	set "CMAKE_SOURCE_DIR=%Target_App_Dir%"

	rem ############ Create CMAKE_ARGS array ############
	set "Target_Level=RebuildAll"
	set "Target_Link=Static"

	rem if /i "%Target_Type%"		equ "Debug"			(%dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON)
	rem if /i "%Target_Type%"		equ "Release"		(%dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON)
	rem if /i "%Target_Type%"		equ "All"			(%dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON) && (%dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON)
	rem if /i "%Target_Level%"	equ "Build"			(%dk_call% dk_appendArgs CMAKE_ARGS -DBUILD=ON)
	rem if /i "%Target_Level%"	equ "Rebuild"		(%dk_call% dk_appendArgs CMAKE_ARGS -DREBUILD=ON)
	rem if /i "%Target_Level%"	equ "RebuildAll"	(%dk_call% dk_appendArgs CMAKE_ARGS -DREBUILDALL=ON)
	rem if /i "%Target_Link%"		equ "Static"		(%dk_call% dk_appendArgs CMAKE_ARGS -DSTATIC=ON)
	rem if /i "%Target_Link%"		equ "Shared"		(%dk_call% dk_appendArgs CMAKE_ARGS -DSHARED=OFF)
	
	if /i "%Target_Type%"	equ "Debug"			(%dk_call% dk_set Debug 1)
	if /i "%Target_Type%"	equ "Release"		(%dk_call% dk_set Release 1)
	if /i "%Target_Type%"	equ "All"			(%dk_call% dk_set Debug 1) && (%dk_call% dk_set Release 1)
	if /i "%Target_Level%"	equ "Build"			(%dk_call% dk_set Build 1)
	if /i "%Target_Level%"	equ "Rebuild"		(%dk_call% dk_set Rebuild 1)
	if /i "%Target_Level%"	equ "RebuildAll"	(%dk_call% dk_set RebuildAll 1)
	if /i "%Target_Link%"	equ "Static"		(%dk_call% dk_set Static 1)
	if /i "%Target_Link%"	equ "Shared"		(%dk_call% dk_set Shared 1)
	

	rem ############ DKCMAKE_FUNCTIONS_DIR_ ############
	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ %dk_call% dk_DKBRANCH_DIR
	rem %dk_call% dk_appendArgs CMAKE_ARGS -DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%

	rem ############ CMake Options ############
	%dk_call% dk_appendArgs CMAKE_ARGS -DCMAKE_VERBOSE_MAKEFILE=1
	rem %dk_call% dk_appendArgs CMAKE_ARGS -DCMAKE_COLOR_DIAGNOSTICS=ON
	%dk_call% dk_appendArgs CMAKE_ARGS -Wdev
	rem %dk_call% dk_appendArgs CMAKE_ARGS -Werror=dev
	%dk_call% dk_appendArgs CMAKE_ARGS -Wdeprecated
	rem %dk_call% dk_appendArgs CMAKE_ARGS -Werror=deprecated
	rem %dk_call% dk_appendArgs CMAKE_ARGS --graphviz=graphviz.txt
	rem %dk_call% dk_appendArgs CMAKE_ARGS --system-information system_information.txt
	%dk_call% dk_appendArgs CMAKE_ARGS --debug-trycompile
	rem %dk_call% dk_appendArgs CMAKE_ARGS --debug-output
	rem %dk_call% dk_appendArgs CMAKE_ARGS --trace
	rem %dk_call% dk_appendArgs CMAKE_ARGS --trace-expand
	rem %dk_call% dk_appendArgs CMAKE_ARGS --warn-uninitialized
	rem %dk_call% dk_appendArgs CMAKE_ARGS --warn-unused-vars
	rem %dk_call% dk_appendArgs CMAKE_ARGS --check-system-vars

	rem ############ CMAKE_SOURCE_DIR ############
	%dk_call% dk_assertVar CMAKE_SOURCE_DIR
	%dk_call% dk_appendArgs CMAKE_ARGS -S="%CMAKE_SOURCE_DIR%"

	rem ############ CMAKE_BINARY_DIR ############
	if NOT defined MULTI_CONFIG	(set "SINGLE_CONFIG=1")
	if defined MULTI_CONFIG		(set "CMAKE_BINARY_DIR=%Target_Tuple_Dir%")
	if defined SINGLE_CONFIG	(set "CMAKE_BINARY_DIR=%Target_Tuple_Dir%/%Target_Type%")
	%dk_call% dk_assertVar CMAKE_BINARY_DIR
	%dk_call% dk_appendArgs CMAKE_ARGS -B="%CMAKE_BINARY_DIR%"
	
	rem ############ CMAKE_GENERATOR ############
	%dk_call% dk_assertVar CMAKE_GENERATOR
	%dk_call% dk_prependArgs CMAKE_ARGS -G %CMAKE_GENERATOR%

	rem ############ Linux_x86_64 (WSL) ############
	if /i "%Target_Os%" equ "Linux"	(set "wsl.exe=wsl")
rem  ###### WSL CMake Fix ######
rem  if defined WSLENV; then
rem		%dk_call% dk_chdir "$DKCMAKE_DIR"
rem		set -- "$@" "."
rem	fi
	rem if defined wsl.exe (
	rem	%dk_call% dk_replaceAll "!CMAKE_ARGS!" "C:" "/mnt/c" WSL_CMAKE_ARGS
	rem )
	if defined wsl.exe (%dk_call% dk_replaceAll "!DKSCRIPT_DIR!" "C:" "/mnt/c" DKSCRIPT_DIR)
	if defined wsl.exe (%wsl.exe% sh -c "export UPDATE=1 && export Target_App=%Target_App% && export Target_Tuple=%Target_Tuple% && export Target_Type=%Target_Type% && %DKSCRIPT_DIR:\=/%/DKBuilder.sh && exit $(true)")
	if defined wsl.exe (%return%)

	rem ###### CMake Configure ######
	%dk_call% dk_validate DKIMPORTS_DIR  %dk_call% dk_DKIMPORTS_DIR

	rem ###### Delete Cmake Cache files ######
	%dk_call% dk_clearCmakeCache "%CMAKE_BINARY_DIR%"	
	
	rem ########### cmake Command ###################
	echo cmake.exe %CMAKE_ARGS%
	%dk_call% cmake.exe %CMAKE_ARGS% && (
		%dk_call% dk_success "CMake Generation Successful"
	) || (
		%dk_call% dk_error "CMake Generation Failed"
	)
	rem ############################################
	
	

	rem ###### IMPORT VARIABLES ######
	%dk_call% dk_loadCache
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% generate
%endfunction%
