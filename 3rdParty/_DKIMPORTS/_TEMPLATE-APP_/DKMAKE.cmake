# to use this template, remove these lines
dk_undepend(_TEMPLATE-APP_)
dk_return()
#########################################


# http://www.app.com
# http://www.app.com/downloads/app-1.0.exe


### DEPENDS ###
#dk_depend(depend_name)


### VERSION ###
#dk_set(APP_VERSION 1.0)
#dk_set(APP_NAME "app-${APP_VERSION}.exe")
#dk_set(APP_DL https://app.com/app.exe)
#dk_set(APP "C:/Program Files (x86)/${APP_NAME}")
#dk_set(APP_EXE "${APP}/app.exe")

### INSTALL ###
#IF(NOT EXISTS "${APP_EXE}")
#	MESSAGE(STATUS "Installing ${APP_NAME}")
#	dk_download(${APP_DL} ${DKDOWNLOAD}/${APP_NAME})
#	dk_command(${DKDOWNLOAD}/${APP_NAME})
#ENDIF()


dk_import("http://www.app.com/downloads/app-1.0.exe")
