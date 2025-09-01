#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKPhp ############
#dk_depend(php_binary)
#dk_copy(${PHP_BINARY}/php.exe ${DKCPP_PLUGINS_DIR}/DKPhp/php.exe OVERWRITE)
#dk_copy(${PHP_BINARY}/php8ts.dll ${DKCPP_PLUGINS_DIR}/DKPhp/php8ts.dll OVERWRITE)

dk_depend(php-src)
dk_copy(${PHP_SRC}/php.exe ${DKCPP_PLUGINS_DIR}/DKPhp/php.exe OVERWRITE)
dk_copy(${PHP_SRC}/php8ts.dll ${DKCPP_PLUGINS_DIR}/DKPhp/php8ts.dll OVERWRITE)

dk_assets(DKPhp)