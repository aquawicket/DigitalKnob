#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libx11-dev ############
# https://www.gnu.org/software/libiconv/
# https://savannah.gnu.org/projects/libiconv
# https://stackoverflow.com/a/57734435/688352
# https://cmake.org/cmake/help/latest/module/FindIconv.html
#

dk_load(dk_builder)

### IMPORT ###
#dk_import(https://ftp.gnu.org/gnu/libiconv/libiconv-1.14.tar.gz PATCH)
dk_import(http://ftp.vim.org/ftp/gnu/libiconv/libiconv-1.14.tar.gz PATCH)



### LINK ###
dk_include				(${LIBICONV_DIR})
dk_include				(${LIBICONV_DIR}/include 				LIBICONV_INCLUDE_DIR)
dk_include				(${LIBICONV_CONFIG_DIR})
if(DEBUG)
	dk_include			(${LIBICONV_DEBUG_DIR})
endif()
if(RELEASE)
	dk_include			(${LIBICONV_RELEASE_DIR})
endif()

# libcharset
if(MSVC)
	if(WIN)
		dk_libDebug		(${LIBICONV_DEBUG_DIR}/charset.lib		LIBICONV_CHARSET_LIBRARY_DEBUG)
		dk_libRelease	(${LIBICONV_RELEASE_DIR}/charset.lib	LIBICONV_CHARSET_LIBRARY_RELEASE)
	endif()
else()
	dk_libDebug			(${LIBICONV_DEBUG_DIR}/libcharset.a		LIBICONV_CHARSET_LIBRARY_DEBUG)
	dk_libRelease		(${LIBICONV_RELEASE_DIR}/libcharset.a	LIBICONV_CHARSET_LIBRARY_RELEASE)
endif()

#libiconv
if(MSVC)
	if(WIN)
		dk_libDebug		(${LIBICONV_DEBUG_DIR}/iconv.lib		LIBICONV_LIBRARY_DEBUG)
		dk_libRelease	(${LIBICONV_RELEASE_DIR}/iconv.lib		LIBICONV_LIBRARY_RELEASE)
	endif()
else()
	dk_libDebug			(${LIBICONV_DEBUG_DIR}/libiconv.a		LIBICONV_LIBRARY_DEBUG)
	dk_libRelease		(${LIBICONV_RELEASE_DIR}/libiconv.a		LIBICONV_LIBRARY_RELEASE)
endif()

if(DEBUG)
	dk_set(Iconv_LIBRARY "${LIBICONV_LIBRARY_DEBUG}")
elseif(RELEASE)
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
	if(DEBUG)
		dk_set(LIBICONV_CMAKE
			#-DLIBICONV_PATH=${LIBICONV}
			#-DICONV_DIR=${LIBICONV}
			#-DICONV_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
			#-DICONV_LIBRARIES="${LIBICONV_CHARSET_LIBRARY_DEBUG};${LIBICONV_LIBRARY_DEBUG};${LIBICONV_CHARSET_LIBRARY_RELEASE};${LIBICONV_LIBRARY_RELEASE}"
			-DIconv_INCLUDE_DIRS=${LIBICONV_INCLUDE_DIR}
			-DIconv_LIBRARIES=${LIBICONV_CHARSET_LIBRARY_DEBUG};${Iconv_LIBRARY}
			-DIconv_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
			-DIconv_LIBRARY=${Iconv_LIBRARY})
	endif()
	if(RELEASE)
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
dk_configure(${LIBICONV_DIR})


### COMPILE ###
dk_build(${LIBICONV_DIR} iconv)
