# https://github.com/upx/upx
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win64.zip
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-i386_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-dos.zip
if(ANDROID OR IOS OR IOSSIM OR MAC)
	return()
endif()


WIN32_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip)
WIN64_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win64.zip)
LINUX32_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-i386_linux.tar.xz)
LINUX64_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz)
RASPBERRY_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm_linux.tar.xz)
#DOS_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-dos.zip)

#dk_set(UPX_VERSION 3.96)
#dk_set(UPX_NAME upx-${UPX_VERSION})
#WIN32_dk_set(UPX_DL https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_NAME}-win32.zip)
#WIN64_dk_set(UPX_DL https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_NAME}-win64.zip)
#LINUX32_dk_set(UPX_DL https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_NAME}-i386_linux.zip)
#LINUX64_dk_set(UPX_DL https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz)
#RASPBERRY_dk_set(UPX_DL https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_NAME}-arm_linux.tar.xz)
#dk_set(UPX ${3RDPARTY}/${UPX_NAME})
#DKINSTALL(${UPX_DL} upx ${UPX})


WIN_dk_set(UPX_EXE ${UPX}/upx.exe)
