#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ upx ############
# https://github.com/upx/upx
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-amd64_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-arm64_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-armeb_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-arm_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-dos.zip
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-i386_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-mipsel_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-mips_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-powerpc64le_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-powerpc_linux.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-src.tar.xz
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-win32.zip
# https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-win64.zip



#dk_validate(Target_Config  "dk_Target_Config()")
dk_validate(Target_Tuple "dk_Target_Tuple()")

#if(Android OR IOS OR Iossim OR Mac)
#	dk_disable(upx)
#	dk_return()
#endif()

if(Windows_X86)	
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-win32.zip)
elseif(Windows_X86_64)	
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-win64.zip)
elseif(Linux_X86)
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-i386_linux.tar.xz)
elseif(Linux_X86_64)
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-amd64_linux.tar.xz)
elseif(Raspberry)
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-arm_linux.tar.xz)
#elseif(DOS)
#	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-dos.zip)
endif()


if(Windows)
	dk_set(UPX_EXE "${UPX}/upx.exe")
endif()

dk_assertPath(UPX_EXE)
