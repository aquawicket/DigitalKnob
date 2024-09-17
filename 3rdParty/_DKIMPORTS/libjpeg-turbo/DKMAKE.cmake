include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/libjpeg-turbo/libjpeg-turbo
# https://libjpeg-turbo.org/
# For ANDROID - https://github.com/DeviceFarmer/android-libjpeg-turbo
# https://sourceforge.net/projects/libjpeg-turbo/files/2.1.1/libjpeg-turbo-2.1.1.tar.gz/download


### IMPORT ###
#dk_import(https://github.com/libjpeg-turbo/libjpeg-turbo.git BRANCH main)
dk_import(https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/heads/main.zip)


#dk_validate(MULTI_CONFIG "dk_getMULTI_CONFIG()")
### LINK ###
dk_include			(${LIBJPEG_TURBO}													LIBJPEG_TURBO_INCLUDE_DIR)
dk_include			(${LIBJPEG_TURBO}/${CONFIG_PATH}										LIBJPEG_TURBO_INCLUDE_DIR2)
dk_include			(${LIBJPEG_TURBO}/src												LIBJPEG_TURBO_INCLUDE_DIR3)
ANDROID_dk_include	(${LIBJPEG_TURBO}/${triple}/$(BUILD_TYPE)/jni)

if(WIN AND MSVC)
	dk_libDebug		(${LIBJPEG_TURBO}/${triple}/${DEBUG_DIR}/turbojpeg-static.lib		LIBJPEG_TURBO_LIBRARY_DEBUG)
	dk_libRelease	(${LIBJPEG_TURBO}/${triple}/${RELEASE_DIR}/turbojpeg-static.lib		LIBJPEG_TURBO_LIBRARY_RELEASE)
else()
	dk_libDebug		(${LIBJPEG_TURBO}/${triple}/${DEBUG_DIR}/libturbojpeg.a				LIBJPEG_TURBO_LIBRARY_DEBUG)
	dk_libRelease	(${LIBJPEG_TURBO}/${triple}/${RELEASE_DIR}/libturbojpeg.a			LIBJPEG_TURBO_LIBRARY_RELEASE)
endif()



### 3RDPARTY LINK ###
dk_append(LIBJPEG_TURBO_CMAKE
	#-DLIBJPEG_INCLUDE_DIR=${LIBJPEG_TURBO}
	-DJPEG_INCLUDE_DIR=${LIBJPEG_TURBO_INCLUDE_DIR} 
	-DJPEG_INCLUDE_DIR2=${LIBJPEG_TURBO_INCLUDE_DIR2}
	-DJPEG_LIBRARY_DEBUG=${LIBJPEG_TURBO_LIBRARY_DEBUG}
	-DJPEG_LIBRARY_RELEASE=${LIBJPEG_TURBO_LIBRARY_RELEASE})
if(WIN AND MSVC)
	dk_append(LIBJPEG_TURBO_CMAKE 
		"-DCMAKE_C_FLAGS=/I${LIBJPEG_TURBO_INCLUDE_DIR} /I${LIBJPEG_TURBO_INCLUDE_DIR2} /I${LIBJPEG_TURBO_INCLUDE_DIR3}"
		"-DCMAKE_CXX_FLAGS=/I${LIBJPEG_TURBO_INCLUDE_DIR} /I${LIBJPEG_TURBO_INCLUDE_DIR2} /I${LIBJPEG_TURBO_INCLUDE_DIR3}")
else()
	dk_append(LIBJPEG_TURBO_CMAKE
		-DENABLE_SHARED=0
		"-DCMAKE_C_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR} -I${LIBJPEG_TURBO_INCLUDE_DIR2} -I${LIBJPEG_TURBO_INCLUDE_DIR3}"
		"-DCMAKE_CXX_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR} -I${LIBJPEG_TURBO_INCLUDE_DIR2} -I${LIBJPEG_TURBO_INCLUDE_DIR3}")
	DEBUG_dk_append(LIBJPEG_TURBO_CMAKE
		#-DLIBJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_DEBUG} 
		-DJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_DEBUG}
		"-DCMAKE_EXE_LINKER_FLAGS=${LIBJPEG_TURBO_LIBRARY_DEBUG}")
	RELEASE_dk_append(LIBJPEG_TURBO_CMAKE
		#-DLIBJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_RELEASE} 
		-DJPEG_LIBRARY=${LIBJPEG_TURBO_LIBRARY_RELEASE}
		"-DCMAKE_EXE_LINKER_FLAGS=${LIBJPEG_TURBO_LIBRARY_RELEASE}")
endif()








### GENERATE ##
dk_configure(${LIBJPEG_TURBO} -DWITH_SIMD=OFF "-DCMAKE_C_FLAGS=-I${LIBJPEG_TURBO_INCLUDE_DIR2}")


#if(EXISTS "${LIBJPEG_TURBO_INCLUDE_DIR2}/jconfig.h")
#	dk_copy("${LIBJPEG_TURBO_INCLUDE_DIR2}/jconfig.h" "${LIBJPEG_TURBO}/jconfig.h" OVERWRITE)
#endif()


### COMPILE ###
dk_build(${LIBJPEG_TURBO} turbojpeg-static)



