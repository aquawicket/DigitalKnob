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


############ fmt ############
# https://github.com/fmtlib/fmt.git
# https://fmt.dev/latest/index.html
# https://github.com/fmtlib/fmt/archive/fade652ade6e9ba4b16e7484cbda5ee4c9178918.zip

#dk_depend(python3)

dk_import()

dk_define(FMT_HEADER_ONLY)
dk_include(${fmt}/include)

# if(MSVC)
#	dk_append(CMAKE_C_FLAGS /utf-8)				# moved to DKBuildFlags.cmake
#	dk_append(CMAKE_CXX_FLAGS /utf-8)			# moved to DKBuildFlags.cmake
#	dk_libDebug		(${fmt_Debug_Dir}/fmtd.lib)
#	dk_libRelease	(${fmt_Release_Dir}/fmt.lib)
# else()
#	dk_libDebug		(${fmt_Debug_Dir}/libfmtd.a)
#	dk_libRelease	(${fmt_Release_Dir}/libfmt.a)
# endif()

#dk_configure(${fmt} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE)

#dk_build()
