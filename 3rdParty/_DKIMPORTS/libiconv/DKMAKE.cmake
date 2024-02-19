# https://www.gnu.org/software/libiconv/
# https://savannah.gnu.org/projects/libiconv
# https://stackoverflow.com/a/57734435/688352
# https://cmake.org/cmake/help/latest/module/FindIconv.html

### IMPORT ###
#dk_import(https://ftp.gnu.org/gnu/libiconv/libiconv-1.14.tar.gz PATCH)
dk_import(http://ftp.vim.org/ftp/gnu/libiconv/libiconv-1.14.tar.gz PATCH)



### LINK ###
dk_include				(${LIBICONV})
dk_include				(${LIBICONV}/include 							LIBICONV_INCLUDE_DIR)
dk_include				(${LIBICONV}/${OS})
dk_include				(${LIBICONV}/${OS}/${RELEASE_DIR})
ANDROID_dk_include		(${LIBICONV}/${OS}/$(BUILD_TYPE)/jni)

# libcharset
if(MSVC)
	WIN_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/charset.lib		LIBICONV_CHARSET_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${LIBICONV}/${OS}/${RELEASE_DIR}/charset.lib	LIBICONV_CHARSET_LIBRARY_RELEASE)
else()
	dk_libDebug			(${LIBICONV}/${OS}/${DEBUG_DIR}/libcharset.a	LIBICONV_CHARSET_LIBRARY_DEBUG)
	dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libcharset.a	LIBICONV_CHARSET_LIBRARY_RELEASE)
endif()

#libiconv
if(MSVC)
	WIN_dk_libDebug		(${LIBICONV}/${OS}/${DEBUG_DIR}/iconv.lib		LIBICONV_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${LIBICONV}/${OS}/${RELEASE_DIR}/iconv.lib		LIBICONV_LIBRARY_RELEASE)
else()
	dk_libDebug			(${LIBICONV}/${OS}/${DEBUG_DIR}/libiconv.a		LIBICONV_LIBRARY_DEBUG)
	dk_libRelease		(${LIBICONV}/${OS}/${RELEASE_DIR}/libiconv.a	LIBICONV_LIBRARY_RELEASE)
endif()

if(DEBUG)
	list(APPEND LIBICONV_LIBRARIES ${LIBICONV_CHARSET_LIBRARY_DEBUG})
	list(APPEND LIBICONV_LIBRARIES ${LIBICONV_LIBRARY_DEBUG})
endif()
if(RELEASE)
	list(APPEND LIBICONV_LIBRARIES ${LIBICONV_CHARSET_LIBRARY_RELEASE})
	list(APPEND LIBICONV_LIBRARIES ${LIBICONV_LIBRARY_RELEASE})
endif()



### 3RDPARTY LINK ###
if(MULTI_CONFIG)
	dk_set(LIBICONV_CMAKE 
		-DLIBICONV_PATH=${LIBICONV} 
		-DICONV_DIR=${LIBICONV}
		-DICONV_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
		-DICONV_LIBRARIES=${LIBICONV_LIBRARIES}
		-DIconv_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
		-DIconv_LIBRARY=${LIBICONV_LIBRARY_RELEASE}
		-DIconv_LIBRARIES=${LIBICONV_LIBRARIES})
else()
	DEBUG_dk_set(LIBICONV_CMAKE 
		-DLIBICONV_PATH=${LIBICONV} 
		-DICONV_DIR=${LIBICONV}
		-DICONV_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
		-DICONV_LIBRARIES=${LIBICONV_LIBRARIES}
		-DIconv_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
		-DIconv_LIBRARY=${LIBICONV_LIBRARY_DEBUG}
		-DIconv_LIBRARIES=${LIBICONV_LIBRARIES})
	
	RELEASE_dk_set(LIBICONV_CMAKE 
		-DLIBICONV_PATH=${LIBICONV} 
		-DICONV_DIR=${LIBICONV}
		-DICONV_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
		-DICONV_LIBRARIES=${LIBICONV_LIBRARIES}
		-DIconv_INCLUDE_DIR=${LIBICONV_INCLUDE_DIR}
		-DIconv_LIBRARY=${LIBICONV_LIBRARY_RELEASE}
		-DIconv_LIBRARIES=${LIBICONV_LIBRARIES})
endif()


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${LIBICONV})


### COMPILE ###
dk_build(${LIBICONV} iconv)
