### VERSION ###
DKSET(UPX_MAJOR 3)
DKSET(UPX_MINOR 96)

## OTHERS
## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm64_linux.tar.xz
## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm_linux.tar.xz
## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-dos.zip

IF(LINUX_32)
	## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz
	DKSET(UPX_VERSION upx-${UPX_MAJOR}.${UPX_MINOR}-i386_linux)
ENDIF()
IF(LINUX_64)
	## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz
	DKSET(UPX_VERSION upx-${UPX_MAJOR}.${UPX_MINOR}-amd64_linux)
ENDIF()
IF(WIN_32)
	## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip
	DKSET(UPX_VERSION upx-${UPX_MAJOR}.${UPX_MINOR}-win32)
ENDIF()
IF(WIN_64)
	## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win64.zip
	DKSET(UPX_VERSION upx-${UPX_MAJOR}.${UPX_MINOR}-win64)
ENDIF()
DKSET(UPX ${3RDPARTY}/UPX_VERSION)


### INSTALL ###
IF(NOT EXISTS ${3RDPARTY}/${UPX_VERSION})	
	DKINSTALL(https://github.com/upx/upx/releases/download/v${UPX_MAJOR}.${UPX_MINOR}/${UPX_VERSION}.zip upx ${UPX})
ENDIF()
