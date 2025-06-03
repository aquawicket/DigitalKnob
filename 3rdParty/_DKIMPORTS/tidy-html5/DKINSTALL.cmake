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


dk_validate(Target_Config  "dk_Target_Config()")


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.zip)


### PATCH FILES ###
dk_fileReplace			("${TIDY_HTML5_DIR}/CMakeLists.txt" "add_definitions ( -DLIBTIDY_VERSION" 	"#add_definitions ( -DLIBTIDY_VERSION")
dk_fileReplace			("${TIDY_HTML5_DIR}/CMakeLists.txt" "add_definitions ( -DRELEASE_DATE"    	"#add_definitions ( -DRELEASE_DATE")

### LINK ###
if(Emscripten)
	dk_define			(HAS_FUTIME=0)
endif()
dk_include				(${TIDY_HTML5_DIR})
dk_include				(${TIDY_HTML5_DIR}/include)
dk_include				(${TIDY_HTML5_CONFIG_DIR})

if(MSVC AND Windows)
	dk_libDebug			(${TIDY_HTML5_DEBUG_DIR}/tidy_staticd.lib)
	dk_libRelease		(${TIDY_HTML5_RELEASE_DIR}/tidy_static.lib)
elseif(MINGW AND Windows)
	dk_libDebug			(${TIDY_HTML5_DEBUG_DIR}/libtidy_static.a)
	dk_libRelease		(${TIDY_HTML5_RELEASE_DIR}/libtidy_static.a)
else()
	dk_libDebug			(${TIDY_HTML5_DEBUG_DIR}/libtidy.a)
	dk_libRelease		(${TIDY_HTML5_RELEASE_DIR}/libtidy.a)
endif()


### GENERATE ###
if(Emscripten) 
	dk_configure		(${TIDY_HTML5_DIR} ${ZLIB_CMAKE} "-DCMAKE_C_FLAGS=-DHAS_FUTIME=0") # -DBUILD_SHARED_LIB=OFF 
else()
	dk_configure		(${TIDY_HTML5_DIR} ${ZLIB_CMAKE}) # -DBUILD_SHARED_LIB=OFF
endif()


### COMPILE ###
dk_build				(${TIDY_HTML5_DIR} tidy-static)
