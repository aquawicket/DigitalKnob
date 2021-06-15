### VERSION ###
DKSET(UPX_MAJOR_VERSION 3)
DKSET(UPX_MINOR_VERSION 96)


## OTHERS
## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm64_linux.tar.xz
## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm_linux.tar.xz
## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-dos.zip

IF(LINUX_32)
	## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz
	DKSET(UPX_VERSION upx-${UPX_MAJOR_VERSION}.${UPX_MINOR_VERSION}-i386_linux)
	DKSET(UPX_FOLDER upx-i386_linux)
ENDIF()
IF(LINUX_64)
	## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz
	DKSET(UPX_VERSION upx-${UPX_MAJOR_VERSION}.${UPX_MINOR_VERSION}-amd64_linux)
	DKSET(UPX_FOLDER upx-amd64_linux)
ENDIF()
IF(WIN_32)
	## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip
	DKSET(UPX_VERSION upx-${UPX_MAJOR_VERSION}.${UPX_MINOR_VERSION}-win32)
	DKSET(UPX_FOLDER upx-win32)
ENDIF()
IF(WIN_64)
	## https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win64.zip
	DKSET(UPX_VERSION upx-${UPX_MAJOR_VERSION}.${UPX_MINOR_VERSION}-win64)
	DKSET(UPX_FOLDER upx-win64)
ENDIF()



### INSTALL ###
IF(NOT EXISTS ${3RDPARTY}/${UPX_VERSION})	
	DKINSTALL(https://github.com/upx/upx/releases/download/v${UPX_MAJOR_VERSION}.${UPX_MINOR_VERSION}/${UPX_VERSION}.zip ${UPX_FOLDER} ${UPX_VERSION})
ENDIF()
DKSET(UPX ${3RDPARTY}/UPX_VERSION)