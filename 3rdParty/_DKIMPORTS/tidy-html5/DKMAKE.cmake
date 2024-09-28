#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/htacg/tidy-html5.git


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
#dk_import(https://github.com/htacg/tidy-html5.git)
dk_import(https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip)


dk_fileReplace			(${TIDY_HTML5_DIR}/CMakeLists.txt "add_definitions ( -DLIBTIDY_VERSION" "#add_definitions ( -DLIBTIDY_VERSION")
dk_fileReplace			(${TIDY_HTML5_DIR}/CMakeLists.txt "add_definitions ( -DRELEASE_DATE" "#add_definitions ( -DRELEASE_DATE")

### LINK ###
EMSCRIPTEN_dk_define	(HAS_FUTIME=0)
dk_include				(${TIDY_HTML5_DIR})
dk_include				(${TIDY_HTML5_DIR}/include)
dk_include				(${TIDY_HTML5_CONFIG_DIR})

if(MSVC)
	WIN_dk_libDebug		(${TIDY_HTML5_DEBUG_DIR}/tidy_staticd.lib)
	WIN_dk_libRelease	(${TIDY_HTML5_RELEASE_DIR}/tidy_static.lib)
elseif(MINGW)
	WIN_dk_libDebug		(${TIDY_HTML5_DEBUG_DIR}/libtidy_static.a)
	WIN_dk_libRelease	(${TIDY_HTML5_RELEASE_DIR}/libtidy_static.a)
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
