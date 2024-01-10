# https://github.com/libjpeg-turbo/libjpeg-turbo
# https://libjpeg-turbo.org/
# For ANDROID - https://github.com/DeviceFarmer/android-libjpeg-turbo
# https://sourceforge.net/projects/libjpeg-turbo/files/2.1.1/libjpeg-turbo-2.1.1.tar.gz/download


### IMPORT ###
#dk_import(https://sourceforge.net/projects/libjpeg-turbo/files/2.1.1/libjpeg-turbo-2.1.1.tar.gz ${3RDPARTY}/libjpeg-turbo-2.1.1)
dk_import(https://github.com/libjpeg-turbo/libjpeg-turbo.git BRANCH main)


### LINK ###
dk_include					(${LIBJPEG-TURBO})
dk_include					(${LIBJPEG-TURBO}/${OS})
dk_include					(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR})
dk_include					(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR})
ANDROID_dk_include			(${LIBJPEG-TURBO}/${OS}/$(BUILD_TYPE)/jni)
if(MSVC)
	ANDROID_dk_libDebug		(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
	ANDROID_dk_libRelease	(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
	WIN_dk_libDebug			(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/turbojpeg-static.lib)
	WIN_dk_libRelease		(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/turbojpeg-static.lib)
elseif(APPLE)
	dk_libDebug				(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
	dk_libRelease			(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
else()
	dk_libDebug				(${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a)
	dk_libRelease			(${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
endif()

### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set				(LIBJPEG-TURBO_CMAKE "-DCMAKE_C_FLAGS=/I${LIBJPEG-TURBO}/${OS}" "-DCMAKE_CXX_FLAGS=/I${LIBJPEG-TURBO}/${OS}" -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_LIBRARY_RELEASE=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/turbojpeg-static.lib)
	ANDROID_dk_set			(LIBJPEG-TURBO_CMAKE "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}" "-DCMAKE_CXX_FLAGS=-I${LIBJPEG-TURBO}/${OS}" -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS} -DJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a -DLIBJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DLIBJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
elseif(APPLE)
	APPLE_dk_set			(LIBJPEG-TURBO_CMAKE "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}" "-DCMAKE_CXX_FLAGS=-I${LIBJPEG-TURBO}/${OS}" -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS} -DJPEG_LIBRARY_RELEASE=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a -DLIBJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DLIBJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
else()
	DEBUG_dk_set			(LIBJPEG-TURBO_CMAKE "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}/Debug" "-DCMAKE_CXX_FLAGS=-I${LIBJPEG-TURBO}/${OS}/Debug" -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR} -DJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/libturbojpeg.a -DLIBJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DLIBJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
	RELEASE_dk_set			(LIBJPEG-TURBO_CMAKE "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}/Release" "-DCMAKE_CXX_FLAGS=-I${LIBJPEG-TURBO}/${OS}/Release" -DJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DJPEG_INCLUDE_DIR2=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR} -DJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a -DLIBJPEG_INCLUDE_DIR=${LIBJPEG-TURBO} -DLIBJPEG_LIBRARY=${LIBJPEG-TURBO}/${OS}/${RELEASE_DIR}/libturbojpeg.a)
endif()


### GENERATE ##
dk_queueCommand(${DKCMAKE_BUILD} -DWITH_SIMD=OFF ${LIBJPEG-TURBO})


### COMPILE ###
dk_build(${LIBJPEG-TURBO} turbojpeg-static)
