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


############ tidy-html5 ############
# https://github.com/htacg/tidy-html5.git

#dk_validate(Target_Config  "dk_Target_Config()")


### DEPEND ###
dk_depend(zlib)


### IMPORT ###
#dk_import(${tidy_html5_Import})
dk_import()


### PATCH FILES ###
dk_fileReplace			("${TIDY_HTML5}/CMakeLists.txt" "add_definitions ( -DLIBTIDY_VERSION" 	"#add_definitions ( -DLIBTIDY_VERSION")
dk_fileReplace			("${TIDY_HTML5}/CMakeLists.txt" "add_definitions ( -DRELEASE_DATE"    	"#add_definitions ( -DRELEASE_DATE")

### LINK ###
if(Emscripten)
	dk_define			(HAS_FUTIME=0)
endif()
dk_include				(${TIDY_HTML5})
dk_include				(${TIDY_HTML5}/include)
dk_include				(${TIDY_HTML5_Config_Dir})

if(MSVC AND Windows)
	dk_libDebug			(${TIDY_HTML5_Debug_Dir}/tidy_staticd.lib)
	dk_libRelease		(${TIDY_HTML5_Release_Dir}/tidy_static.lib)
elseif(Windows) # AND MINGW
	dk_libDebug			(${TIDY_HTML5_Debug_Dir}/libtidy_static.a)
	dk_libRelease		(${TIDY_HTML5_Release_Dir}/libtidy_static.a)
else()
	dk_libDebug			(${TIDY_HTML5_Debug_Dir}/libtidy.a)
	dk_libRelease		(${TIDY_HTML5_Release_Dir}/libtidy.a)
endif()


### GENERATE ###
if(Emscripten) 
	dk_configure		(${TIDY_HTML5} ${ZLIB_CMAKE} "-DCMAKE_C_FLAGS=-DHAS_FUTIME=0")
else()
	dk_configure		(${TIDY_HTML5} ${ZLIB_CMAKE})
endif()


### COMPILE ###
dk_build				(${TIDY_HTML5} tidy-static)
