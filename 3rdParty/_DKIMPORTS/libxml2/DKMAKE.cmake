#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libxml2 ############
# https://gitlab.gnome.org/GNOME/libxml2
# https://github.com/GNOME/libxml2
# http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz
# https://github.com/GNOME/libxml2/archive/refs/tags/v2.9.8.zip
# https://fuchsia.googlesource.com/third_party/libxml2/

dk_load(dk_builder)

### DEPEND ###
dk_depend(libiconv)
dk_depend(python3)
dk_depend(xz)
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/GNOME/libxml2/archive/refs/tags/v2.12.5.tar.gz)

if(NOT EXISTS ${LIBXML2}/configure)
	dk_depend(autoconf)
	dk_depend(automake)
	dk_depend(libtool)
endif()

### LINK ###
dk_define				(LIBXML_STATIC)
dk_include				(${LIBXML2_DIR})
dk_include				(${LIBXML2_DIR}/include 				LIBXML2_INCLUDE_DIR)

if(MULTI_CONFIG)
	dk_include			(${LIBXML2_CONFIG_DIR}					LIBXML2_INCLUDE_DIR2)
else()
	if(DEBUG)
		dk_include    	(${LIBXML2_DEBUG_DIR}					LIBXML2_INCLUDE_DIR2)
	endif()
	if(RELEASE)
		dk_include 		(${LIBXML2_RELEASE_DIR}					LIBXML2_INCLUDE_DIR2)
	endif()
endif()

if(MSVC)
	if(WIN)
		dk_libDebug		(${LIBXML2_DEBUG_DIR}/libxml2sd.lib		LIBXML2_LIBRARY_DEBUG)
		dk_libRelease	(${LIBXML2_RELEASE_DIR}/libxml2s.lib	LIBXML2_LIBRARY_RELEASE)
	endif()
else()
	dk_libDebug			(${LIBXML2_DEBUG_DIR}/libxml2.a			LIBXML2_LIBRARY_DEBUG)
	dk_libRelease		(${LIBXML2_RELEASE_DIR}/libxml2.a		LIBXML2_LIBRARY_RELEASE)
endif()

if(DEBUG)
	set(LIBXML2_LIBRARY		${LIBXML2_LIBRARY_DEBUG})
endif()
if(RELEASE)
	set(LIBXML2_LIBRARY		${LIBXML2_LIBRARY_RELEASE})
endif()

### CMAKE 3RDPARTY LINK ###
dk_set(LIBXML2_CMAKE 
	-DLIBXML2_INCLUDE_DIR=${LIBXML2_INCLUDE_DIR}
	-DLIBXML2_LIBRARY=${LIBXML2_LIBRARY} 
	"-DLIBXML2_INCLUDE_DIRS=${LIBXML2_INCLUDE_DIR} ${LIBXML2_INCLUDE_DIR2}" 
	-DLIBXML2_LIBRARIES=${LIBXML2_LIBRARY} 
	"-DCMAKE_C_FLAGS=-DLIBXML_STATIC -I${LIBXML2_INCLUDE_DIR} -I${LIBXML2_INCLUDE_DIR2}" 
	"-DCMAKE_CXX_FLAGS=-DLIBXML_STATIC -I${LIBXML2_INCLUDE_DIR} -I${LIBXML2_INCLUDE_DIR2}")

### GENERATE ###
#if(NOT EXISTS ${LIBXML2}/configure)
#	dk_queueCommand(../../autogen.sh)
	#--with-c14n             Canonical XML 1.0 support (on)
	#--with-catalog          XML Catalogs support (on)
	#--with-debug            debugging module and shell (on)
	#--with-history          history support for shell (off)
	#--with-readline[=DIR]   use readline in DIR (for shell history)
	#--with-html             HTML parser (on)
	#--with-http             HTTP support (on)
	#--with-iconv[=DIR]      iconv support (on)
	#--with-icu              ICU support (off)
	#--with-iso8859x         ISO-8859-X support if no iconv (on)
	#--with-lzma[=DIR]       use liblzma in DIR (on)
	#--with-mem-debug        memory debugging module (off)
	#--with-modules          dynamic modules support (on)
	#--with-output           serialization support (on)
	#--with-pattern          xmlPattern selection interface (on)
	#--with-push             push parser interfaces (on)
	#--with-python           Python bindings (on)
	#--with-reader           xmlReader parsing interface (on)
	#--with-regexps          regular expressions support (on)
	#--with-run-debug        runtime debugging module (off)
	#--with-sax1             older SAX1 interface (on)
	#--with-schemas          XML Schemas 1.0 and RELAX NG support (on)
	#--with-schematron       Schematron support (on)
	#--with-threads          multithreading support (on)
	#--with-thread-alloc     per-thread malloc hooks (off)
	#--with-tree             DOM like tree manipulation APIs (on)
	#--with-valid            DTD validation support (on)
	#--with-writer           xmlWriter serialization interface (on)
	#--with-xinclude         XInclude 1.0 support (on)
	#--with-xpath            XPath 1.0 support (on)
	#--with-xptr             XPointer support (on)
	#--with-zlib[=DIR]       use libz in DIR (on)
	#--with-minimum          build a minimally sized library (off)
	#--with-legacy           maximum ABI compatibility (off)
#endif()

#ANDROID_dk_configure(${LIBXML2} 
#	"-DCMAKE_C_FLAGS=-DLIBXML_STATIC -DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2_INCLUDE_DIR2}" 
#	${LIBICONV_CMAKE} 
#	${PYTHON_CMAKE} 
#	${XZ_CMAKE} 
#	${ZLIB_CMAKE})

##APPLE_dk_queueCommand(${DKCONFIGURE_BUILD})
#APPLE_dk_configure(${LIBXML2} 
#	"-DCMAKE_C_FLAGS=-DLIBXML_STATIC -I${LIBXML2_INCLUDE_DIR2}" 
#	${LIBICONV_CMAKE} 
#	${PYTHON_CMAKE} 
#	${XZ_CMAKE} 
#	${ZLIB_CMAKE})

##EMSCRIPTEN_dk_queueCommand(${DKCONFIGURE_BUILD})
#E#MSCRIPTEN_dk_configure(${LIBXML2} 
#	"-DCMAKE_C_FLAGS=-DLIBXML_STATIC -DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2_INCLUDE_DIR2}" 
#	${LIBICONV_CMAKE} 
#	${XZ_CMAKE} 
#	${ZLIB_CMAKE})

##LINUX_dk_queueCommand(${DKCONFIGURE_BUILD} --with-python=no)
#LINUX_dk_configure(${LIBXML2} 
#	-DLIBXML2_WITH_PYTHON=OFF 
#	"-DCMAKE_C_FLAGS=-DLIBXML_STATIC -DHAVE_ERRNO_H -I${LIBXML2_INCLUDE_DIR2}" 
#	${LIBICONV_CMAKE} 
#	${XZ_CMAKE} 
#	${ZLIB_CMAKE})

##RASPBERRY_dk_queueCommand(${DKCONFIGURE_BUILD})
#RASPBERRY_dk_configure(${LIBXML2}
#	"-DCMAKE_C_FLAGS=-DLIBXML_STATIC -DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2_INCLUDE_DIR2}" 
#	${LIBICONV_CMAKE} 
#	${XZ_CMAKE} 
#	${ZLIB_CMAKE})

#WIN_dk_queueCommand(${DKCONFIGURE_BUILD})
dk_configure(${LIBXML2} 
	-DLIBXML2_WITH_C14N=ON					# Add the Canonicalization support ON
	-DLIBXML2_WITH_CATALOG=ON				# Add the Catalog support ON
	-DLIBXML2_WITH_DEBUG=ON					# Add the debugging module ON
	-DLIBXML2_WITH_FTP=OFF					# Add the FTP support OFF
	-DLIBXML2_WITH_HTML=ON					# Add the HTML support ON
	-DLIBXML2_WITH_HTTP=ON					# Add the HTTP support ON
	-DLIBXML2_WITH_ICONV=${LIBICONV}		# Add ICONV support ON
	-DLIBXML2_WITH_ICU=OFF					# Add ICU support OFF
	-DLIBXML2_WITH_LEGACY=OFF				# Add deprecated APIs for compatibility OFF
	-DLIBXML2_WITH_LZMA=${XZ}				# Use liblzma ON
	-DLIBXML2_WITH_MEM_DEBUG=OFF			# Add the memory debugging module OFF
	-DLIBXML2_WITH_MODULES=OFF				# Add the dynamic modules support ON
	-DLIBXML2_WITH_OUTPUT=ON				# Add the serialization support ON
	-DLIBXML2_WITH_PATTERN=ON				# Add the xmlPattern selection interface ON
	-DLIBXML2_WITH_PROGRAMS=OFF				# Build programs ON
	-DLIBXML2_WITH_PUSH=ON					# Add the PUSH parser interfaces ON
	-DLIBXML2_WITH_PYTHON=OFF #${PYTHON}	# Build Python bindings ON
	-DLIBXML2_WITH_READER=ON				# Add the xmlReader parsing interface ON
	-DLIBXML2_WITH_REGEXPS=ON				# Add Regular Expressions support ON
	-DLIBXML2_WITH_SAX1=ON					# Add the older SAX1 interface ON
	-DLIBXML2_WITH_SCHEMAS=ON				# Add Relax-NG and Schemas support ON
	-DLIBXML2_WITH_SCHEMATRON=ON			# Add Schematron support ON
	-DLIBXML2_WITH_TESTS=OFF				# Build tests ON
	-DLIBXML2_WITH_THREADS=ON				# Add multithread support ON
	-DLIBXML2_WITH_THREAD_ALLOC=OFF			# Add per-thread memory OFF
	-DLIBXML2_WITH_TLS=OFF					# Enable thread-local storage OFF
	-DLIBXML2_WITH_TREE=ON					# Add the DOM like tree manipulation APIs ON
	-DLIBXML2_WITH_VALID=ON					# Add the DTD validation support ON
	-DLIBXML2_WITH_WRITER=ON				# Add the xmlWriter saving interface ON
	-DLIBXML2_WITH_XINCLUDE=ON				# Add the XInclude support ON
	-DLIBXML2_WITH_XPATH=ON					# Add the XPATH support ON
	-DLIBXML2_WITH_XPTR=ON					# Add the XPointer support ON
	-DLIBXML2_WITH_XPTR_LOCS=OFF			# Add support for XPointer locations OFF
	-DLIBXML2_WITH_ZLIB=${ZLIB}				# Use libz ON
	${LIBICONV_CMAKE} 
	${PYTHON3_CMAKE}
	${XZ_CMAKE} 
	${ZLIB_CMAKE})

### COMPILE ###
dk_build(${LIBXML2} LibXml2)
