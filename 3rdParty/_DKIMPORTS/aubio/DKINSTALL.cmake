#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############### aubio ###############
# https://aubio.org/manual/latest/installing.html
# https://github.com/aubio/aubio.git
# https://github.com/aubio/aubio/archive/5461304a598952ffdca78f90cef5b6c82475ec4a.zip


dk_validate(python "dk_depend(python)")

dk_import()

dk_include			("${aubio}/src"						AUBIO_INCLUDE)

if(Windows AND MSVC)
	dk_libDebug		("${aubio_Debug_Dir}/aubio.lib"		AUBIO_LIBRARY_DEBUG 	AUBIO_LIBRARY)
	dk_libRelease	("${aubio_Release_Dir}/aubio.lib"	AUBIO_LIBRARY_RELEASE	AUBIO_LIBRARY)
else()
	dk_libDebug		("${aubio_Debug_Dir}/libaubio.a"	AUBIO_LIBRARY_DEBUG 	AUBIO_LIBRARY)
	dk_libRelease	("${aubio_Release_Dir}/libaubio.a"	AUBIO_LIBRARY_RELEASE	AUBIO_LIBRARY)
endif()

dk_chdir			("${aubio_Build_Dir}")
dk_configure		(make configure -C "${aubio}")
#dk_build			(${aubio})
#dk_exec(./waf configure)
#dk_exec(./waf build)
#dk_exec(${sudo_exe} ./waf install)