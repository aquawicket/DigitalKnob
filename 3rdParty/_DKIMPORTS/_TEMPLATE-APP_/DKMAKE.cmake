#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
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
#dk_set(APP "${ProgramFiles_x86}/${APP_NAME}")
#dk_set(APP_EXE "${APP}/app.exe")

### INSTALL ###
#IF(NOT EXISTS "${APP_EXE}")
#	MESSAGE(STATUS "Installing ${APP_NAME}")
#	dk_download(${APP_DL} ${DKDOWNLOAD_DIR}/${APP_NAME})
#	dk_command(${DKDOWNLOAD_DIR}/${APP_NAME})
#ENDIF()


dk_import("http://www.app.com/downloads/app-1.0.exe")
