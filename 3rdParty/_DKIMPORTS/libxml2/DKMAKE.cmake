# https://github.com/GNOME/libxml2
# http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz
# https://github.com/GNOME/libxml2/archive/refs/tags/v2.9.8.zip


### DEPEND ###
dk_depend(libiconv)
dk_depend(python)
dk_depend(xz)
dk_depend(zlib)


### IMPORT ###
#dk_import(https://github.com/GNOME/libxml2.git TAG f2ad86fa600885429a6083aaf6926c7e2e5b24d6 PATCH)
dk_import(https://github.com/GNOME/libxml2.git)


### LINK ###
dk_define	(LIBXML_STATIC)
dk_include	(${LIBXML2}/include LIBXML2_INCLUDE_DIR)
dk_include	(${LIBXML2})
dk_include	(${LIBXML2}/${OS})

if(MSVC)
	WIN_dk_libDebug		(${LIBXML2}/${OS}/${DEBUG_DIR}/libxml2sd.lib)
	WIN_dk_libRelease	(${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2s.lib)
	#dk_set				(LIBXML2_LIBRARIES ${LIBXML2}/${OS}/${DEBUG_DIR}/xml2.lib;${LIBXML2}/${OS}/${RELEASE_DIR}/xml2.lib)
else()
	dk_libDebug			(${LIBXML2}/${OS}/${DEBUG_DIR}/libxml2.a)
	dk_libRelease		(${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a)
	#dk_set				(LIBXML2_LIBRARIES ${LIBXML2}/${OS}/${DEBUG_DIR}/libxml2.a;${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a)
endif()



### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set	(LIBXML2_CMAKE -DLIBXML2_INCLUDE_DIR=${LIBXML2}/include -DLIBXML2_LIBRARY=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2s.lib -DLIBXML2_LIBRARIES=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2s.lib)
else()
	dk_set		(LIBXML2_CMAKE -DLIBXML2_INCLUDE_DIR=${LIBXML2}/include -DLIBXML2_LIBRARY=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a -DLIBXML2_LIBRARIES=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a)
endif()



### GENERATE ###
ANDROID_dk_queueCommand				(${DKCONFIGURE_BUILD})
ANDROID_dk_queueCommand				(${DKCMAKE_BUILD} "-DANDROID_COMPILER_FLAGS=-I${LIBXML2}/${OS}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

APPLE_dk_queueCommand				(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBXML2}/${OS}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

#EMSCRIPTEN_dk_queueCommand			(${DKCONFIGURE_BUILD})
EMSCRIPTEN_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${DEBUG_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
EMSCRIPTEN_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${RELEASE_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

LINUX_dk_queueCommand				(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${DEBUG_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
LINUX_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${RELEASE_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

RASPBERRY_dk_queueCommand			(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${DEBUG_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
RASPBERRY_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${RELEASE_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

if(MSYS)
	dkFileReplace("${LIBXML2}/CMakeLists.txt" "list(APPEND LIBXML2_SRCS win32/libxml2.rc)" " ") # skip windres.exe (broken) 
	WIN_DEBUG_dk_queueMsys2			(${DKCMAKE_BUILD} -DBUILD_SHARED_LIBS=OFF "-DCMAKE_C_FLAGS=-I${LIBXML2}/${OS}/${DEBUG_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
	WIN_RELEASE_dk_queueMsys2		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBXML2}/${OS}/${RELEASE_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
endif()

if(MSVC)
	WIN_dk_queueCommand(
		${DKCMAKE_BUILD} 
		-DBUILD_SHARED_LIBS=		OFF				#Build shared libraries	
		-DLIBXML2_WITH_C14N=		ON				#Add the Canonicalization support
		-DLIBXML2_WITH_CATALOG=		ON				#Add the Catalog support
		-DLIBXML2_WITH_DEBUG=		ON				#Add the debugging module
		-DLIBXML2_WITH_FTP=			OFF				#Add the FTP support
		-DLIBXML2_WITH_HTML=		ON				#Add the HTML support
		-DLIBXML2_WITH_HTTP=		ON				#Add the HTTP support
		-DLIBXML2_WITH_ICONV=		${LIBICONV}		#Add ICONV support
		-DLIBXML2_WITH_ICU=			OFF				#Add ICU support
		-DLIBXML2_WITH_LEGACY=		OFF				#Add deprecated APIs for compatibility
		-DLIBXML2_WITH_LZMA=		${XZ}			#Use liblzma
		-DLIBXML2_WITH_MEM_DEBUG=	OFF				#Add the memory debugging module
		-DLIBXML2_WITH_MODULES=		ON				#Add the dynamic modules support
		-DLIBXML2_WITH_OUTPUT=		ON				#Add the serialization support
		-DLIBXML2_WITH_PATTERN=		ON				#Add the xmlPattern selection interface
		-DLIBXML2_WITH_PROGRAMS=	ON				#Build programs
		-DLIBXML2_WITH_PUSH=		ON				#Add the PUSH parser interfaces
		-DLIBXML2_WITH_PYTHON=		${PYTHON}		#Build Python bindings
		-DLIBXML2_WITH_READER=		ON				#Add the xmlReader parsing interface
		-DLIBXML2_WITH_REGEXPS=		ON				#Add Regular Expressions support
		-DLIBXML2_WITH_SAX1=		ON				#Add the older SAX1 interface
		-DLIBXML2_WITH_SCHEMAS=		ON				#Add Relax-NG and Schemas support
		-DLIBXML2_WITH_SCHEMATRON=	ON				#Add Schematron support
		-DLIBXML2_WITH_TESTS=		ON				#Build tests
		-DLIBXML2_WITH_THREADS=		ON				#Add multithread support
		-DLIBXML2_WITH_THREAD_ALLOC=OFF				#Add per-thread memory
		-DLIBXML2_WITH_TLS=			OFF				#Enable thread-local storage
		-DLIBXML2_WITH_TREE=		ON				#Add the DOM like tree manipulation APIs
		-DLIBXML2_WITH_VALID=		ON				#Add the DTD validation support
		-DLIBXML2_WITH_WRITER=		ON				#Add the xmlWriter saving interface
		-DLIBXML2_WITH_XINCLUDE=	ON				#Add the XInclude support
		-DLIBXML2_WITH_XPATH=		ON				#Add the XPATH support
		-DLIBXML2_WITH_XPTR=		ON				#Add the XPointer support
		-DLIBXML2_WITH_XPTR_LOCS=	OFF				#Add support for XPointer locations
		-DLIBXML2_WITH_ZLIB=		${ZLIB}			#Use libz
		-DPython_EXECUTABLE=${PYTHON_APP}
		${LIBICONV_CMAKE} 
		${XZ_CMAKE} 
		${ZLIB_CMAKE} 
		${LIBXML2})
endif()



### COMPILE ###
dk_build(${LIBXML2} LibXml2)
