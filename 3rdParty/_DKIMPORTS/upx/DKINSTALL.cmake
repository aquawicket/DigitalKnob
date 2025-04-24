#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


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



#dk_load(dk_builder)
dk_validate(target_triple "dk_target_triple()")

#if(ANDROID OR IOS OR IOSSIM OR MAC)
#	dk_undepend(upx)
#	dk_return()
#endif()

if(WIN_X86)	
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-win32.zip)
elseif(WIN_X86_64)	
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-win64.zip)
elseif(LINUX_X86)
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-i386_linux.tar.xz)
elseif(LINUX_X86_64)
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-amd64_linux.tar.xz)
elseif(RASPBERRY)
	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-arm_linux.tar.xz)
#elseif(DOS)
#	dk_import(https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-dos.zip)
endif()


if(WIN)
	dk_set(UPX_EXE "${UPX}/upx.exe")
endif()

dk_assertPath(UPX_EXE)
