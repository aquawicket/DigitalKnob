#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKMySql ############
#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

dk_depend(DKAssets)
dk_depend(DKCurl)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


dk_generateCmake(DKMySql)
dk_assets(DKMySql)

#DKENABLE(mysql) ##MySql library
if(mysql)
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	SET(PATH_MYSQL_WIN32 ${DK3RDPARTY_DIR}/mysql-5.6.16-win32)
	SET(PATH_MYSQL_WIN64 ${DK3RDPARTY_DIR}/mysql-5.6.16-winx64)
	SET(PATH_MYSQL_MAC ${DK3RDPARTY_DIR}/mysql-5.6.16-osx10.7-x86_64)
	SET(PATH_MYSQL_LINUX ${DK3RDPARTY_DIR}/libmysqlclient-dev_5.5.40-1_amd64)
	dk_include(${PATH_MYSQL}/include)
	dk_include(${PATH_MYSQL}/include/mysql)
	WIN_dk_libDebug(${PATH_MYSQL}/lib/debug/mysqlclient.lib)
	WIN_dk_libRelease(${PATH_MYSQL}/lib/mysqlclient.lib)
	APPLE_dk_libDebug(${PATH_MYSQL}/lib/libmysqlclient.a)
	APPLE_dk_libRelease(${PATH_MYSQL}/lib/libmysqlclient.a)
	LINUX_dk_libDebug(${PATH_MYSQL}/lib/x86_64-linux-gnu/libmysqlclient.a)
	LINUX_dk_libRelease(${PATH_MYSQL}/lib/x86_64-linux-gnu/libmysqlclient.a)
endif(mysql)
