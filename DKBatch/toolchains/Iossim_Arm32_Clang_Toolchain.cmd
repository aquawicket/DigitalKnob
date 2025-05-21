if not defined Mac_Host (
	exit /b 1
)
%dk_call% dk_echo "##########################################################################"
%dk_call% dk_echo "#################### Iosdim_Arm32_Clang_Toolchain.cmd ####################"
%dk_call% dk_echo "##########################################################################"

%dk_call% dk_set  MULTI_CONFIG		1
%dk_call% dk_set  CMAKE_GENERATOR	"Xcode"




::%dk_call% dk_depend xcode
::%dk_call% dk_depend make
rem  %dk_call% dk_set CMAKE_TOOLCHAIN_FILE		"%IOS_TOOLCHAIN_FILE%"
rem  %dk_call% dk_append CMAKE_C_FLAGS			-DIOS -DIOS_ARM32 -std=c17 -x objective-c
rem  %dk_call% dk_append CMAKE_CXX_FLAGS		-DIOS -DIOS_ARM32 -std=c++17 -x objective-c++
rem  %dk_call% dk_append DKCONFIGURE_FLAGS		--host arm-apple-%IOS_DARWIN%
rem  %dk_call% dk_append DKCONFIGURE_CFLAGS		-arch arm -DIOS -DIOS_ARM32 -mios-version-min=%IOS_MIN_SDK% -isysroot %IOS_SYSROOT%
rem  %dk_call% dk_append DKCONFIGURE_CXXFLAGS	-arch arm -DIOS -DIOS_ARM32 -mios-version-min=%IOS_MIN_SDK% -isysroot %IOS_SYSROOT%
rem  %dk_call% dk_append DKCMAKE_FLAGS			-DSDK_VERSION=%IOS_SDK% -DDEPLOYMENT_TARGET=%IOS_MIN_SDK% -DPLATFORM=OS -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=arm)
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS	-static  &rem  -s)