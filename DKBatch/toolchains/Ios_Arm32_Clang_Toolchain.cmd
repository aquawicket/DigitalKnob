@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

message("############################################################################")
message("#################### Ios_Arm32_Clang_Toolchain.cmake #######################")
message("############################################################################")

if(NOT Mac_Host)
	dk_exit()
endif()

dk_depend(xcode)
dk_depend(make)
	
set(CMAKE_TOOLCHAIN_FILE			${IOS_TOOLCHAIN_FILE})
dk_append(CMAKE_C_FLAGS				-DIOS -DIOS_ARM32 -std=c17 -x objective-c)
dk_append(CMAKE_CXX_FLAGS			-DIOS -DIOS_ARM32 -std=c++17 -x objective-c++)
#dk_append(DKCONFIGURE_FLAGS		--host arm-apple-${IOS_DARWIN})
#dk_append(DKCONFIGURE_CFLAGS		-arch arm -DIOS -DIOS_ARM32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
#dk_append(DKCONFIGURE_CXXFLAGS		-arch arm -DIOS -DIOS_ARM32 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT})
dk_append(DKCMAKE_FLAGS				-DSDK_VERSION=${IOS_SDK} -DDEPLOYMENT_TARGET=${IOS_MIN_SDK} -DPLATFORM=OS -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=arm)
#dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)