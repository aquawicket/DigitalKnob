#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKPhp ############
#dk_depend(php_binary)
#dk_copy(${PHP_BINARY}/php.exe ${DKCPP_PLUGINS_DIR}/DKPhp/php.exe OVERWRITE)
#dk_copy(${PHP_BINARY}/php8ts.dll ${DKCPP_PLUGINS_DIR}/DKPhp/php8ts.dll OVERWRITE)

dk_depend(php-src)
dk_copy(${PHP_SRC}/php.exe ${DKCPP_PLUGINS_DIR}/DKPhp/php.exe OVERWRITE)
dk_copy(${PHP_SRC}/php8ts.dll ${DKCPP_PLUGINS_DIR}/DKPhp/php8ts.dll OVERWRITE)

dk_assets(DKPhp)