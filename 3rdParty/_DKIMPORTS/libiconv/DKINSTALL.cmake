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


############ libiconv ############
# https://www.gnu.org/software/libiconv/
# https://savannah.gnu.org/projects/libiconv
# https://stackoverflow.com/a/57734435/688352
# https://cmake.org/cmake/help/latest/module/FindIconv.html
#

dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
#dk_import(${libiconv_Import} PATCH)
dk_import()

### LINK ###
dk_include				(${LIBICONV})
dk_include				(${LIBICONV}/include 				LIBICONV_INCLUDE_DIR)
dk_include				(${LIBICONV_Config_Dir})
if(Debug)
	dk_include			(${LIBICONV_Debug_Dir})
endif()
if(Release)
	dk_include			(${LIBICONV_Release_Dir})
endif()

# libcharset
if(MSVC)
	if(Windows)
		dk_libDebug		(${LIBICONV_Debug_Dir}/charset.lib		LIBICONV_CHARSET_LIBRARY_DEBUG)
		dk_libRelease	(${LIBICONV_Release_Dir}/charset.lib	LIBICONV_CHARSET_LIBRARY_RELEASE)
	endif()
else()
	dk_libDebug			(${LIBICONV_Debug_Dir}/libcharset.a		LIBICONV_CHARSET_LIBRARY_DEBUG)
	dk_libRelease		(${LIBICONV_Release_Dir}/libcharset.a	LIBICONV_CHARSET_LIBRARY_RELEASE)
endif()

#libiconv
if(MSVC)
	if(Windows)
		dk_libDebug		(${LIBICONV_Debug_Dir}/iconv.lib		LIBICONV_LIBRARY_DEBUG)
		dk_libRelease	(${LIBICONV_Release_Dir}/iconv.lib		LIBICONV_LIBRARY_RELEASE)
	endif()
else()
	dk_libDebug			(${LIBICONV_Debug_Dir}/libiconv.a		LIBICONV_LIBRARY_DEBUG)
	dk_libRelease		(${LIBICONV_Release_Dir}/libiconv.a		LIBICONV_LIBRARY_RELEASE)
endif()

if(Debug)
	dk_set(Iconv_LIBRARY "${LIBICONV_LIBRARY_DEBUG}")
elseif(Release)
	dk_set(Iconv_LIBRARY "${LIBICONV_LIBRARY_RELEASE}")
endif()


### 3RDPARTY LINK ###
if(MULTI_CONFIG)
	dk_set(LIBICONV_CMAKE
		#-DLIBICONV_PATH=${LIBICONV}
		#-DICONV_DIR=${LIBICONV}
		#-DICONV_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
		#-DICONV_LIBRARIES="${LIBICONV_CHARSET_LIBRARY_DEBUG};${LIBICONV_LIBRARY_DEBUG}"
		-DIconv_INCLUDE_DIRS=${LIBICONV_INCLUDE_DIR}
		-DIconv_LIBRARIES="${LIBICONV_CHARSET_LIBRARY_DEBUG};${LIBICONV_LIBRARY_DEBUG};${LIBICONV_CHARSET_LIBRARY_RELEASE};${LIBICONV_LIBRARY_RELEASE}"
		-DIconv_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
		-DIconv_LIBRARY=${Iconv_LIBRARY})
else()
	if(Debug)
		dk_set(LIBICONV_CMAKE
			#-DLIBICONV_PATH=${LIBICONV}
			#-DICONV_DIR=${LIBICONV}
			#-DICONV_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
			#-DICONV_LIBRARIES="${LIBICONV_CHARSET_LIBRARY_DEBUG};${LIBICONV_LIBRARY_DEBUG};${LIBICONV_CHARSET_LIBRARY_RELEASE};${LIBICONV_LIBRARY_RELEASE}"
			-DIconv_INCLUDE_DIRS=${LIBICONV_INCLUDE_DIR}
			-DIconv_LIBRARIES="${LIBICONV_CHARSET_LIBRARY_DEBUG};${Iconv_LIBRARY}"
			-DIconv_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
			-DIconv_LIBRARY=${Iconv_LIBRARY})
	endif()
	if(Release)
		dk_set(LIBICONV_CMAKE 
			#-DLIBICONV_PATH=${LIBICONV}
			#-DICONV_DIR=${LIBICONV}
			#-DICONV_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
			#-DICONV_LIBRARIES="${LIBICONV_CHARSET_LIBRARY_RELEASE};${LIBICONV_LIBRARY_RELEASE}"
			-DIconv_INCLUDE_DIRS=${LIBICONV_INCLUDE_DIR}
			-DIconv_LIBRARIES="${LIBICONV_CHARSET_LIBRARY_RELEASE};${Iconv_LIBRARY}"
			-DIconv_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
			-DIconv_LIBRARY=${Iconv_LIBRARY})
	endif()
endif()



### GENERATE ###
dk_configure()


### COMPILE ###
dk_build(${LIBICONV} iconv)
