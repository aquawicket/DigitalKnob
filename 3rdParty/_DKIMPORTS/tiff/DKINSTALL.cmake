#!/usr/bin/cmake -P
return()
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


############ tiff ############
# https://gitlab.com/libtiff/libtiff
# http://www.simplesystems.org/libtiff/
# https://download.osgeo.org/libtiff/
# https://gitlab.com/libtiff/libtiff/-/archive/v4.2.0/libtiff-v4.2.0.zip
# https://gitlab.com/libtiff/libtiff.git
# https://cmake.org/cmake/help/latest/module/FindTIFF.html
#dk_validate(Target_Config  "dk_Target_Config()")

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
#dk_import(${tiff_Import})
dk_import()


### LINK ###
dk_include					(${tiff}/libtiff										TIFF_INCLUDE_DIR)
dk_include					(${TIFF_Config_Dir}/libtiff								TIFF_INCLUDE_DIRS)
#Debug_dk_include			(${TIFF_Config_Dir}/libtiff/${Debug_Dir}				TIFF_INCLUDE_DIRS)
#Release_dk_include			(${TIFF_Config_Dir}/libtiff/${Release_Dir}				TIFF_INCLUDE_DIRS)
if(MULTI_CONFIG)
	if(MSVC)
		dk_libDebug			(${TIFF_Config_Dir}/libtiff/${Debug_Dir}/tiffd.lib		TIFF_LIBRARY_DEBUG)
		dk_libRelease		(${TIFF_Config_Dir}/libtiff/${Release_Dir}/tiff.lib		TIFF_LIBRARY_RELEASE)
	else()
		dk_libDebug			(${TIFF_Config_Dir}/libtiff/${Debug_Dir}/libtiff.a		TIFF_LIBRARY_DEBUG)
		dk_libRelease		(${TIFF_Config_Dir}/libtiff/${Release_Dir}/libtiff.a	TIFF_LIBRARY_RELEASE)
	endif()
else()	
		dk_libDebug			(${TIFF_Config_Dir}/libtiff/libtiff.a					TIFF_LIBRARY_DEBUG)
		dk_libRelease		(${TIFF_Config_Dir}/libtiff/libtiff.a					TIFF_LIBRARY_RELEASE)
endif()
dk_set						(TIFF_LIBRARIES 										"${TIFF_LIBRARY_DEBUG};${TIFF_LIBRARY_RELEASE}")

### 3RDPARTY LINK ###
# https://cmake.org/cmake/help/latest/module/FindTIFF.html
dk_set(tiff_CMAKE
	-DTIFF_INCLUDE_DIR=${TIFF_INCLUDE_DIR}
	-DTIFF_INCLUDE_DIRS=${TIFF_INCLUDE_DIRS}
	-DTIFF_LIBRARY_DEBUG=${TIFF_LIBRARY_DEBUG}
	-DTIFF_LIBRARY_RELEASE=${TIFF_LIBRARY_RELEASE}
	-DTIFF_LIBRARIES=${TIFF_LIBRARIES}
	"-DCMAKE_EXE_LINKER_FLAGS=${TIFF_LIBRARIES}")	
if(MSVC)
	dk_append(tiff_CMAKE
		"-DCMAKE_C_FLAGS=/I${TIFF_INCLUDE_DIR} /I${TIFF_INCLUDE_DIRS}"
		"-DCMAKE_CXX_FLAGS=/I${TIFF_INCLUDE_DIR} /I${TIFF_INCLUDE_DIRS}")
else()	
	dk_append(tiff_CMAKE
		"-DCMAKE_C_FLAGS=-I${TIFF_INCLUDE_DIR} -I${TIFF_INCLUDE_DIRS}"
		"-DCMAKE_CXX_FLAGS=-I${TIFF_INCLUDE_DIR} -I${TIFF_INCLUDE_DIRS}")
endif()

### GENERATE ###
dk_configure(${tiff}
	-Dtiff-tools=OFF				# "build TIFF tools" ON
	-Dtiff-tools-unsupported=OFF	# "build unsupported TIFF tools" OFF
	-Dtiff-tests=OFF				# "build TIFF tests" ON
	-Dtiff-contrib=OFF				# "build TIFF contrib" ON
	-Dtiff-docs=OFF					# "build TIFF documentation" ON
	-Dtiff-deprecated=OFF			# "build TIFF deprecated features" OFF
	-Dtiff-install=OFF				# "install TIFF targets" ${TIFF_INSTALL_DEFAULT}
	${libjpeg-turbo_CMAKE} 
	${xz_CMAKE}
	${zlib_CMAKE}
	${zstd_CMAKE})

### COMPILE ###
dk_build(${tiff})# tiff)
