include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/
# https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip
# https://gitlab.com/libtiff/libtiff.git
# https://cmake.org/cmake/help/latest/module/FindTIFF.html


### DEPEND ###
dk_depend(libjpeg-turbo)
#dk_depend(libwebp) ERROR: circular reference
dk_depend(xz)
dk_depend(zlib)
dk_depend(zstd)

#-- Could NOT find Deflate (missing: Deflate_LIBRARY Deflate_INCLUDE_DIR)
#-- Could NOT find JBIG (missing: JBIG_LIBRARY JBIG_INCLUDE_DIR)
#-- Could NOT find LERC (missing: LERC_LIBRARY LERC_INCLUDE_DIR)
#-- Could NOT find GLUT (missing: GLUT_glut_LIBRARY)


### IMPORT ###
#dk_import(https://gitlab.com/libtiff/libtiff.git)
dk_import(https://gitlab.com/libtiff/libtiff/-/archive/master/libtiff-master.zip)


### LINK ###
dk_include					(${TIFF_DIR}/libtiff									TIFF_INCLUDE_DIR)
dk_include					(${TIFF_CONFIG_DIR}/libtiff								TIFF_INCLUDE_DIRS)
DEBUG_dk_include			(${TIFF_CONFIG_DIR}/libtiff/${DEBUG_DIR}				TIFF_INCLUDE_DIRS)
RELEASE_dk_include			(${TIFF_CONFIG_DIR}/libtiff/${RELEASE_DIR}				TIFF_INCLUDE_DIRS)
if(MULTI_CONFIG)
	if(MSVC)
		WIN_dk_libDebug		(${TIFF_CONFIG_DIR}/libtiff/${DEBUG_DIR}/tiffd.lib		TIFF_LIBRARY_DEBUG)
		WIN_dk_libRelease	(${TIFF_CONFIG_DIR}/libtiff/${RELEASE_DIR}/tiff.lib		TIFF_LIBRARY_RELEASE)
	else()
		dk_libDebug			(${TIFF_CONFIG_DIR}/libtiff/${DEBUG_DIR}/libtiff.a		TIFF_LIBRARY_DEBUG)
		dk_libRelease		(${TIFF_CONFIG_DIR}/libtiff/${RELEASE_DIR}/libtiff.a	TIFF_LIBRARY_RELEASE)
	endif()
else()	
		dk_libDebug			(${TIFF_CONFIG_DIR}/libtiff/libtiff.a					TIFF_LIBRARY_DEBUG)
		dk_libRelease		(${TIFF_CONFIG_DIR}/libtiff/libtiff.a					TIFF_LIBRARY_RELEASE)
endif()
dk_set						(TIFF_LIBRARIES 										"${TIFF_LIBRARY_DEBUG};${TIFF_LIBRARY_RELEASE}")



### 3RDPARTY LINK ###
# https://cmake.org/cmake/help/latest/module/FindTIFF.html
dk_set(TIFF_CMAKE
	-DTIFF_INCLUDE_DIR=${TIFF_INCLUDE_DIR}
	-DTIFF_INCLUDE_DIRS=${TIFF_INCLUDE_DIRS}
	-DTIFF_LIBRARY_DEBUG=${TIFF_LIBRARY_DEBUG}
	-DTIFF_LIBRARY_RELEASE=${TIFF_LIBRARY_RELEASE}
	-DTIFF_LIBRARIES=${TIFF_LIBRARIES}
	"-DCMAKE_EXE_LINKER_FLAGS=${TIFF_LIBRARIES}")	
if(MSVC)
	WIN_dk_append(TIFF_CMAKE
		"-DCMAKE_C_FLAGS=/I${TIFF_INCLUDE_DIR} /I${TIFF_INCLUDE_DIRS}"
		"-DCMAKE_CXX_FLAGS=/I${TIFF_INCLUDE_DIR} /I${TIFF_INCLUDE_DIRS}")
else()	
	dk_append(TIFF_CMAKE
		"-DCMAKE_C_FLAGS=-I${TIFF_INCLUDE_DIR} -I${TIFF_INCLUDE_DIRS}"
		"-DCMAKE_CXX_FLAGS=-I${TIFF_INCLUDE_DIR} -I${TIFF_INCLUDE_DIRS}")
endif()




### GENERATE ###
dk_configure(${TIFF_DIR}
	-Dtiff-tools=OFF				# "build TIFF tools" ON
	-Dtiff-tools-unsupported=OFF	# "build unsupported TIFF tools" OFF
	-Dtiff-tests=OFF				# "build TIFF tests" ON
	-Dtiff-contrib=OFF				# "build TIFF contrib" ON
	-Dtiff-docs=OFF					# "build TIFF documentation" ON
	-Dtiff-deprecated=OFF			# "build TIFF deprecated features" OFF
	-Dtiff-install=OFF				# "install TIFF targets" ${TIFF_INSTALL_DEFAULT}
	${LIBJPEG_TURBO_CMAKE} 
	${XZ_CMAKE}
	${ZLIB_CMAKE}
	${ZSTD_CMAKE})


### COMPILE ###
dk_build(${TIFF_DIR} tiff)
