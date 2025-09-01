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

dk_depend(DKAssets)
dk_depend(DKCurl)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


############ DKMySql ############
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()



#DKENABLE(mysql) ##MySql library
if(mysql)
	dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
	SET(PATH_MYSQL_WIN32 $ENV{DK3RDPARTY_DIR}/mysql-5.6.16-win32)
	SET(PATH_MYSQL_WIN64 $ENV{DK3RDPARTY_DIR}/mysql-5.6.16-winx64)
	SET(PATH_MYSQL_MAC $ENV{DK3RDPARTY_DIR}/mysql-5.6.16-osx10.7-x86_64)
	SET(PATH_MYSQL_LINUX $ENV{DK3RDPARTY_DIR}/libmysqlclient-dev_5.5.40-1_amd64)
	dk_include(${PATH_MYSQL}/include)
	dk_include(${PATH_MYSQL}/include/mysql)
	Windows_dk_libDebug(${PATH_MYSQL}/lib/debug/mysqlclient.lib)
	Windows_dk_libRelease(${PATH_MYSQL}/lib/mysqlclient.lib)
	Apple_dk_libDebug(${PATH_MYSQL}/lib/libmysqlclient.a)
	Apple_dk_libRelease(${PATH_MYSQL}/lib/libmysqlclient.a)
	Linux_dk_libDebug(${PATH_MYSQL}/lib/x86_64-linux-gnu/libmysqlclient.a)
	Linux_dk_libRelease(${PATH_MYSQL}/lib/x86_64-linux-gnu/libmysqlclient.a)
endif(mysql)
