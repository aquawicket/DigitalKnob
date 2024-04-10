# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/
# https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip
# https://gitlab.com/libtiff/libtiff.git

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
dk_import(https://gitlab.com/libtiff/libtiff.git)


### LINK ###
dk_include					(${TIFF}/libtiff								TIFF_INCLUDE_DIR)
dk_include					(${TIFF}/${OS}/libtiff							TIFF_INCLUDE_DIR2)
DEBUG_dk_include			(${TIFF}/${OS}/libtiff/${DEBUG_DIR})
RELEASE_dk_include			(${TIFF}/${OS}/libtiff/${RELEASE_DIR})
if(MSVC)
	ANDROID_dk_libDebug		(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff.a	TIFF_LIBRARY_DEBUG)
	ANDROID_dk_libRelease	(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff.a	TIFF_LIBRARY_RELEASE)
	WIN_dk_libDebug			(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/tiffd.lib	TIFF_LIBRARY_DEBUG)
	WIN_dk_libRelease		(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/tiff.lib	TIFF_LIBRARY_RELEASE)
elseif(APPLE)
	dk_libDebug				(${TIFF}/${OS}/libtiff/${DEBUG_DIR}/libtiff.a	TIFF_LIBRARY_DEBUG)
	dk_libRelease			(${TIFF}/${OS}/libtiff/${RELEASE_DIR}/libtiff.a TIFF_LIBRARY_RELEASE)
else()
	dk_libDebug				(${TIFF}/${OS}/${DEBUG_DIR}/libtiff/libtiff.a	TIFF_LIBRARY_DEBUG)
	dk_libRelease			(${TIFF}/${OS}/${RELEASE_DIR}/libtiff/libtiff.a TIFF_LIBRARY_RELEASE)
endif()


#if(MINGW)
#	dk_fileReplace("${TIFF}/CMakeLists.txt" "add_subdirectory(tools)" " ") # skip windres.exe (broken)
#endif() 

### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set		(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF_INCLUDE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF_LIBRARY_DEBUG} -DTIFF_LIBRARY_RELEASE=${TIFF_LIBRARY_RELEASE} -DTIFF_INCLUDE_DIR2=${TIFF_INCLUDE_DIR2} "-DCMAKE_C_FLAGS=/I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=/I${TIFF}/${OS}/libtiff")
	ANDROID_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF_INCLUDE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF_LIBRARY_DEBUG} -DTIFF_LIBRARY_RELEASE=${TIFF_LIBRARY_RELEASE} -DTIFF_INCLUDE_DIR2=${TIFF_INCLUDE_DIR2} "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/libtiff")
elseif(APPLE)
	APPLE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF_INCLUDE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF_LIBRARY_DEBUG} -DTIFF_LIBRARY_RELEASE=${TIFF_LIBRARY_RELEASE} -DTIFF_INCLUDE_DIR2=${TIFF_INCLUDE_DIR2}  "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/libtiff")
else()
	DEBUG_dk_set	(TIFF_CMAKE
		-DTIFF_INCLUDE_DIR=${TIFF_INCLUDE_DIR}
		-DTIFF_LIBRARY_DEBUG=${TIFF_LIBRARY_DEBUG}
		-DTIFF_LIBRARY_RELEASE=${TIFF_LIBRARY_RELEASE}
		-DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${DEBUG_DIR}/libtiff
		"-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff"
		"-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${DEBUG_DIR}/libtiff"
		"-DCMAKE_EXE_LINKER_FLAGS=-L${TIFF}/${OS}/${DEBUG_DIR}/libtiff -ltiff")
	RELEASE_dk_set	(TIFF_CMAKE -DTIFF_INCLUDE_DIR=${TIFF_INCLUDE_DIR} -DTIFF_LIBRARY_DEBUG=${TIFF_LIBRARY_DEBUG} -DTIFF_LIBRARY_RELEASE=${TIFF_LIBRARY_RELEASE} -DTIFF_INCLUDE_DIR2=${TIFF}/${OS}/${RELEASE_DIR}/libtiff "-DCMAKE_C_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff" "-DCMAKE_CXX_FLAGS=-I${TIFF}/${OS}/${RELEASE_DIR}/libtiff")
endif()



### GENERATE ###
dk_configure(${TIFF}
	-DBUILD_SHARED_LIBS=OFF
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
dk_build(${TIFF} tiff)
