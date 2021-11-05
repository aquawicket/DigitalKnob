# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win64.zip
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-i386_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm_linux.tar.xz
# https://github.com/upx/upx/releases/download/v3.96/upx-3.96-dos.zip


### VERSION ###
DKSET(UPX_MAJOR 3)
DKSET(UPX_MINOR 96)
DKSET(UPX_VERSION ${UPX_MAJOR}.${UPX_MINOR})
DKSET(UPX_NAME upx-${UPX_VERSION})
WIN32_DKSET(UPX_DL https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_NAME}-win32.zip)
WIN64_DKSET(UPX_DL https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_NAME}-win64.zip)
LINUX_DKSET(UPX_DL https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_NAME}-i386_linux.zip)
RASPBERRY(https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_NAME}-arm_linux.tar.xz
DKSET(UPX ${3RDPARTY}/${UPX_NAME}_${OS})
WIN32_DKSET(UPX_EXE ${UPX}/upx.exe)
WIN64_DKSET(UPX_EXE ${UPX}/upx.exe)


### INSTALL ###
DKINSTALL(${UPX_DL} upx ${UPX}_${OS})
