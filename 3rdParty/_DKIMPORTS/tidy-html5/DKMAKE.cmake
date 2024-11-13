#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip)


### PATCH FILES ###
dk_fileReplace			(${TIDY_HTML5_DIR}/CMakeLists.txt "add_definitions \\( -DLIBTIDY_VERSION" 	"#add_definitions ( -DLIBTIDY_VERSION")
dk_fileReplace			(${TIDY_HTML5_DIR}/CMakeLists.txt "add_definitions \\( -DRELEASE_DATE"    	"#add_definitions ( -DRELEASE_DATE")

### LINK ###
if(EMSCRIPTEN)
	dk_define			(HAS_FUTIME=0)
endif()
dk_include				(${TIDY_HTML5_DIR})
dk_include				(${TIDY_HTML5_DIR}/include)
dk_include				(${TIDY_HTML5_CONFIG_DIR})

if(MSVC AND WIN)
	dk_libDebug			(${TIDY_HTML5_DEBUG_DIR}/tidy_staticd.lib)
	dk_libRelease		(${TIDY_HTML5_RELEASE_DIR}/tidy_static.lib)
elseif(MINGW AND WIN)
	dk_libDebug			(${TIDY_HTML5_DEBUG_DIR}/libtidy_static.a)
	dk_libRelease		(${TIDY_HTML5_RELEASE_DIR}/libtidy_static.a)
else()
	dk_libDebug			(${TIDY_HTML5_DEBUG_DIR}/libtidy.a)
	dk_libRelease		(${TIDY_HTML5_RELEASE_DIR}/libtidy.a)
endif()


### GENERATE ###
if(EMSCRIPTEN)
	dk_configure		(${TIDY_HTML5_DIR} -DBUILD_SHARED_LIB=OFF ${ZLIB_CMAKE} "-DCMAKE_C_FLAGS=-DHAS_FUTIME=0")
else()
	dk_configure		(${TIDY_HTML5_DIR} -DBUILD_SHARED_LIB=OFF ${ZLIB_CMAKE})
endif()


### COMPILE ###
dk_build				(${TIDY_HTML5_DIR} tidy-static)
