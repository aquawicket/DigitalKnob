@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

message("############################################################################")
message("###################### Ios_X86_Clang_Toolchain.cmake #######################")
message("############################################################################")

if(NOT Mac_Host)
	dk_exit()
endif()

dk_depend(xcode)
dk_depend(make)
	
dk_set(CMAKE_TOOLCHAIN_FILE			${IOS_TOOLCHAIN_FILE})
dk_append(CMAKE_C_FLAGS				-DIOS -DIOS -DIOS_X86 -std=c17 -x objective-c)
dk_append(CMAKE_CXX_FLAGS			-DIOS -DIOS -DIOS_X86 -std=c++17 -x objective-c++)
dk_append(DKCONFIGURE_FLAGS			--host i686-apple-${IOS_DARWIN})
dk_append(DKCONFIGURE_CFLAGS		-arch i686 -DIOS -DIOS -DIOS_X86 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
dk_append(DKCONFIGURE_CXXFLAGS		-arch i686 -DIOS -DIOS -DIOS_X86 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
dk_append(DKCMAKE_FLAGS				-DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=OS -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=i686)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)
	