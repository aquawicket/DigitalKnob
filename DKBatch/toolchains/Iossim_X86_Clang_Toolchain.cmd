::@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::######################################################################################################################################################

if not defined Mac_Host (
	set "CMAKE_GENERATOR="
	exit /b 0
)

%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "#################### Iossim_X86_Clang_Toolchain.cmd ######################"
%dk_call% dk_echo "############################################################################"

%dk_call% dk_depend xcode
%dk_call% dk_depend make
	
%dk_call% dk_set CMAKE_TOOLCHAIN_FILE			"%IOS_TOOLCHAIN_FILE%"
rem  %dk_call% dk_append CMAKE_C_FLAGS			-DIOS -DIOSSIM -DIOSSIM_X86 -std=c17 -x objective-c
rem  %dk_call% dk_append CMAKE_CXX_FLAGS		-DIOS -DIOSSIM -DIOSSIM_X86 -std=c++17 -x objective-c++
rem  %dk_call% dk_append DKCONFIGURE_FLAGS		--host i686-apple-%IOS_DARWIN%
rem  %dk_call% dk_append DKCONFIGURE_CFLAGS		-arch i686 -DIOS -DIOSSIM -DIOSSIM_X86 -mios-version-min=%IOS_MIN_SDK% -isysroot %IOSSIM_SYSROOT%
rem  %dk_call% dk_append DKCONFIGURE_CXXFLAGS	-arch i686 -DIOS -DIOSSIM -DIOSSIM_X86 -mios-version-min=%IOS_MIN_SDK% -isysroot %IOSSIM_SYSROOT%
rem  %dk_call% dk_append DKCMAKE_FLAGS			-DSDK_VERSION=%IOS_SDK% -DDEPLOYMENT_TARGET=%IOS_MIN_SDK% -DPLATFORM=SIMULATOR -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES=i686)
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS	-static  &rem  -s)
	