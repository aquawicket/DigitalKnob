dk_depend(DKAssets)
dk_depend(DKCurl)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()


dk_generateCmake(DKMySql)
dk_assets(DKMySql)

#DKENABLE(mysql) ##MySql library
IF(mysql)
	SET(PATH_MYSQL_WIN32 ${3RDPARTY}/mysql-5.6.16-win32)
	SET(PATH_MYSQL_WIN64 ${3RDPARTY}/mysql-5.6.16-winx64)
	SET(PATH_MYSQL_MAC ${3RDPARTY}/mysql-5.6.16-osx10.7-x86_64)
	SET(PATH_MYSQL_LINUX ${3RDPARTY}/libmysqlclient-dev_5.5.40-1_amd64)
	dk_include(${PATH_MYSQL}/include)
	dk_include(${PATH_MYSQL}/include/mysql)
	WIN_dk_libDebug(${PATH_MYSQL}/lib/debug/mysqlclient.lib)
	WIN_dk_libRelease(${PATH_MYSQL}/lib/mysqlclient.lib)
	APPLE_dk_libDebug(${PATH_MYSQL}/lib/libmysqlclient.a)
	APPLE_dk_libRelease(${PATH_MYSQL}/lib/libmysqlclient.a)
	LINUX_dk_libDebug(${PATH_MYSQL}/lib/x86_64-linux-gnu/libmysqlclient.a)
	LINUX_dk_libRelease(${PATH_MYSQL}/lib/x86_64-linux-gnu/libmysqlclient.a)
ENDIF(mysql)
