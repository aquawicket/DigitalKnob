# https://github.com/glennrp/libpng
# http://www.libpng.org/pub/png/libpng.html


### DEPEND ###
EMSCRIPTEN_dk_depend(m)
dk_depend(zlib)


### IMPORT ###
if(MAC)
	dk_import(https://github.com/glennrp/libpng.git)
else()
	dk_import(https://github.com/glennrp/libpng/archive/refs/tags/v1.6.35.zip PATCH)
	dk_set(LIBPNG_MAJOR 1)
	dk_set(LIBPNG_MINOR 6)
	dk_set(LIBPNG_BUILD 35)
endif()


### LINK ###
dk_define					(PNG_STATIC)
dk_include					(${LIBPNG}  																	PNG_INCLUDE_DIR)
dk_include					(${LIBPNG}/${OS})
dk_include					(${LIBPNG}/${OS}/${RELEASE_DIR})
ANDROID_dk_include			(${LIBPNG}/${OS}/$(BUILD_TYPE)/jni)
if(MSVC)
	ANDROID_dk_libDebug		(${LIBPNG}/${OS}/${DEBUG_DIR}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}d.a			PNG_LIBRARY_DEBUG)
	ANDROID_dk_libRelease	(${LIBPNG}/${OS}/${RELEASE_DIR}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}.a			PNG_LIBRARY_RELEASE)
	WIN_dk_libDebug			(${LIBPNG}/${OS}/${DEBUG_DIR}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}_staticd.lib	PNG_LIBRARY_DEBUG)
	WIN_dk_libRelease		(${LIBPNG}/${OS}/${RELEASE_DIR}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}_static.lib	PNG_LIBRARY_RELEASE)
elseif(APPLE)
	dk_libDebug				(${LIBPNG}/${OS}/${DEBUG_DIR}/libpng16d.a										PNG_LIBRARY_DEBUG)
	dk_libRelease			(${LIBPNG}/${OS}/${RELEASE_DIR}/libpng16d.a										PNG_LIBRARY_RELEASE)
else()
	dk_libDebug				(${LIBPNG}/${OS}/${DEBUG_DIR}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}d.a			PNG_LIBRARY_DEBUG)
	dk_libRelease			(${LIBPNG}/${OS}/${RELEASE_DIR}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}.a			PNG_LIBRARY_RELEASE)
endif()


### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set					(LIBPNG_CMAKE "-DCMAKE_C_FLAGS=/I${LIBPNG} /I${LIBPNG}/${OS}" "-DCMAKE_CXX_FLAGS=/I${LIBPNG} /I${LIBPNG}/${OS}" -DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR} -DPNG_PNG_INCLUDE_DIR=${LIBPNG}/${OS} -DPNG_INCLUDE_DIR2=${LIBPNG}/${OS} -DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} -DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
	ANDROID_dk_set				(LIBPNG_CMAKE "-DCMAKE_C_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}" "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}" -DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR} -DPNG_PNG_INCLUDE_DIR=${LIBPNG}/${OS} -DPNG_INCLUDE_DIR2=${LIBPNG}/${OS} -DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} -DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
elseif(APPLE)
	APPLE_dk_set				(LIBPNG_CMAKE "-DCMAKE_C_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}" "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}" -DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR} -DPNG_INCLUDE_DIR2=${LIBPNG}/${OS} -DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} -DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
elseif(RASPBERRY)
	RASPBERRY_DEBUG_dk_set		(LIBPNG_CMAKE "-DCMAKE_C_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}/${DEBUG_DIR}" -DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR} -DPNG_INCLUDE_DIR2=${LIBPNG}/${OS} -DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} -DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
	RASPBERRY_RELEASE_dk_set	(LIBPNG_CMAKE "-DCMAKE_C_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}/${RELEASE_DIR}" -DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR} -DPNG_INCLUDE_DIR2=${LIBPNG}/${OS} -DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} -DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
else()
	DEBUG_dk_set				(LIBPNG_CMAKE 
		"-DCMAKE_C_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}/${DEBUG_DIR}"
		"-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}/${DEBUG_DIR}"
		-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR}
		-DPNG_INCLUDE_DIR2=${LIBPNG}/${OS}/${DEBUG_DIR}
		-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG}
		-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE}
		#"-DCMAKE_EXE_LINKER_FLAGS=-L${LIBPNG}/${OS}/${DEBUG_DIR} -lpng16d"
		"-DCMAKE_EXE_LINKER_FLAGS=${PNG_LIBRARY_DEBUG}")
	RELEASE_dk_set				(LIBPNG_CMAKE "-DCMAKE_C_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS=-I${LIBPNG} -I${LIBPNG}/${OS}/${RELEASE_DIR}" -DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR} -DPNG_INCLUDE_DIR2=${LIBPNG}/${OS}/${RELEASE_DIR} -DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} -DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
endif()



### GENERATE ###
dk_configure(${LIBPNG}
	-DPNG_BUILD_ZLIB=OFF 			# "Custom zlib Location, otherwise find_package is used" OFF
	-DPNG_STATIC=ON					# "Build shared lib" ON
	-DPNG_SHARED=OFF				# "Build static lib" ON
	-DPNG_TESTS=OFF 				# "Build libpng tests" ON
	-DPNG_FRAMEWORK=OFF				# "Build OS X framework" OFF
	-DPNG_DEBUG=OFF    				# "Build with debug output" OFF
	-DPNGARG=OFF       				# "Disable ANSI-C prototypes" OFF
	-DPNG_HARDWARE_OPTIMIZATIONS=ON	# "Enable Hardware Optimizations" ON
	#-DPNG_PREFIX="" 				# "Prefix to add to the API function names"
	#-DDFA_XTRA=""					# "File containing extra configuration settings"
	-Dld-version-script=ON			# "Enable linker version script" ON
	-DSKIP_INSTALL_LIBRARIES=ON 
	-DSKIP_INSTALL_ALL=ON
	${ZLIB_CMAKE})  



### COMPILE ###
dk_build(${LIBPNG} png_static)

