# http://www.app.com
#
# http://www.app.com/downloads/app-1.0.exe

### DEPENDS ###
#DKDEPEND(depend_name)

### VERSION ###
DKSET(APP_VERSION 1.0)
DKSET(APP_NAME "app-${APP_VERSION}.exe")
DKSET(APP_DL https://app.com/app.exe)
DKSET(APP "C:/Program Files (x86)/${APP_NAME}")
DKSET(APP_EXE "${APP}/app.exe")

### INSTALL ###
IF(NOT EXISTS "${APP_EXE}")
	MESSAGE(STATUS "Installing ${APP_NAME}")
	DOWNLOAD(${APP_DL} ${DKDOWNLOAD}/${APP_NAME})
	DKCOMMAND(${DKDOWNLOAD}/${APP_NAME})
ENDIF()
