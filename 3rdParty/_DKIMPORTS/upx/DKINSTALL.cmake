#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
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


dk_import()

if(Android_Arm32_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Android_Arm64_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Android_X86_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Android_X86_64_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Dos_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Linux_Arm32_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Linux_Arm64_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Linux_X86_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Linux_X86_64_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Mac_X86_64_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Raspberry_Host)
	dk_set(upx_exe "${upx}/TODO")
elseif(Windows_X86_Host)
	dk_set(upx_exe "${upx}/upx.exe")
elseif(Windows_X86_64_Host)
	dk_set(upx_exe "${upx}/upx.exe")	
endif()

dk_assertPath(upx_exe)
