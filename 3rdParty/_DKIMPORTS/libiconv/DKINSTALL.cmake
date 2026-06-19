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


############ libiconv ############
# https://www.gnu.org/software/libiconv/
# https://savannah.gnu.org/projects/libiconv
# https://stackoverflow.com/a/57734435/688352
# https://cmake.org/cmake/help/latest/module/FindIconv.html
# http://ftp.vim.org/ftp/gnu/libiconv/libiconv-1.14.tar.gz
# https://ftp.gnu.org/gnu/libiconv/libiconv-1.14.tar.gz

dk_import()

dk_include			(${libiconv})															# config.h
dk_include			(${libiconv}/include 					Iconv_INCLUDE_DIR)
dk_include			(${libiconv_Config_Dir})
dk_include			(${libiconv_Build_Dir})


# libcharset
if(Windows AND MSVC)
	dk_libDebug		(${libiconv_Debug_Dir}/charset.lib		Iconv_CHARSET_LIBRARY_DEBUG 	Iconv_CHARSET_LIBRARY)
	dk_libRelease	(${libiconv_Release_Dir}/charset.lib	Iconv_CHARSET_LIBRARY_RELEASE	Iconv_CHARSET_LIBRARY)
else()
	dk_libDebug		(${libiconv_Debug_Dir}/libcharset.a		Iconv_CHARSET_LIBRARY_DEBUG		Iconv_CHARSET_LIBRARY)
	dk_libRelease	(${libiconv_Release_Dir}/libcharset.a	Iconv_CHARSET_LIBRARY_RELEASE	Iconv_CHARSET_LIBRARY)
endif()

#libiconv
if(Windows AND MSVC)
	dk_libDebug		(${libiconv_Debug_Dir}/iconv.lib		Iconv_LIBRARY_DEBUG				Iconv_LIBRARY)
	dk_libRelease	(${libiconv_Release_Dir}/iconv.lib		Iconv_LIBRARY_RELEASE			Iconv_LIBRARY)
else()
	dk_libDebug		(${libiconv_Debug_Dir}/libiconv.a		Iconv_LIBRARY_DEBUG				Iconv_LIBRARY)
	dk_libRelease	(${libiconv_Release_Dir}/libiconv.a		Iconv_LIBRARY_RELEASE			Iconv_LIBRARY)
endif()

if(MULTI_CONFIG)
	dk_set(libiconv_CMAKE
		-DIconv_INCLUDE_DIR=${Iconv_INCLUDE_DIR}
		-DIconv_INCLUDE_DIRS=${Iconv_INCLUDE_DIRS}
		-DIconv_LIBRARY=${Iconv_LIBRARY}
		-DIconv_LIBRARIES="${Iconv_CHARSET_LIBRARY_DEBUG};${Iconv_LIBRARY_DEBUG};${Iconv_CHARSET_LIBRARY_RELEASE};${Iconv_LIBRARY_RELEASE}"
		-DICONV_INCLUDE_DIR=${Iconv_INCLUDE_DIR})
else()
	dk_set(libiconv_CMAKE
		-DIconv_INCLUDE_DIR=${Iconv_INCLUDE_DIR}
		-DIconv_INCLUDE_DIRS=${Iconv_INCLUDE_DIRS}
		-DIconv_LIBRARY=${Iconv_LIBRARY}
		-DIconv_LIBRARIES=${Iconv_LIBRARY}
		-DICONV_INCLUDE_DIR=${Iconv_INCLUDE_DIR})
endif()

dk_configure()

dk_build(${libiconv} iconv)
