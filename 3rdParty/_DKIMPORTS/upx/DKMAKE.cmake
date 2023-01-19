# https://github.com/upx/upx
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win64.zip
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-i386_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-dos.zip

if(ANDROID OR IOS OR IOSSIM OR MAC)
	dk_return()
endif()

WIN32_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip)
WIN64_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win64.zip)
LINUX32_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-i386_linux.tar.xz)
LINUX64_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz)
RASPBERRY_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm_linux.tar.xz)
#DOS_dk_import(https://github.com/upx/upx/releases/download/v3.96/upx-3.96-dos.zip)
WIN_dk_set(UPX_EXE ${UPX}/upx.exe)
