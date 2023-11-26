# https://github.com/nigels-com/glew.git
# http://glew.sourceforge.net
# https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip
if(IOS OR IOSSIM OR ANDROID)
	dk_undepend(glew)
	dk_return()
endif()

### DEPEND ###
dk_depend(libglu1-mesa-dev)


### IMPORT ###
dk_import(https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip)
#dk_import(https://github.com/nigels-com/glew.git)
dk_copy(${GLEW}/build/cmake ${GLEW}/${OS}/CMakeFiles/Export/lib/cmake/glew OVERWRITE)


### LINK ###
dk_define				(GLEW_STATIC)
dk_include				(${GLEW}/include)
ANDROID_dk_libDebug		(${GLEW}/${OS}/${DEBUG_DIR}/lib/libGLEWd.a)
ANDROID_dk_libRelease	(${GLEW}/${OS}/${RELEASE_DIR}/lib/libGLEW.a)
APPLE_dk_libDebug		(${GLEW}/${OS}/lib/${DEBUG_DIR}/libGLEWd.a)
APPLE_dk_libRelease		(${GLEW}/${OS}/lib/${RELEASE_DIR}/libGLEW.a)
EMSCRIPTEN_dk_libDebug	(${GLEW}/${OS}/${DEBUG_DIR}/lib/libGLEWd.a)
EMSCRIPTEN_dk_libRelease(${GLEW}/${OS}/${RELEASE_DIR}/lib/libGLEW.a)
LINUX_dk_libDebug		(${GLEW}/${OS}/${DEBUG_DIR}/lib/libGLEWd.a)
LINUX_dk_libRelease		(${GLEW}/${OS}/${RELEASE_DIR}/lib/libGLEW.a)
RASPBERRY_dk_libDebug	(${GLEW}/${OS}/${DEBUG_DIR}/lib/libGLEWd.a)
RASPBERRY_dk_libRelease	(${GLEW}/${OS}/${RELEASE_DIR}/lib/libGLEW.a)
WIN_dk_libDebug			(${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib)
WIN_dk_libRelease		(${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib)


### 3RDPARTY LINK ###
# dk_set(GLEW_CMAKE
#	-DGLEW_USE_STATIC_LIB=ON
#	-DGLEW_DIR=${GLEW}/${OS}/CMakeFiles/Export/lib/cmake/glew
#	-DGLEW_LIBRARY=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32.lib
#	-DGLEW_INCLUDE_DIR=${GLEW}/include
#	-DGLEW_SHARED_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib
#	-DGLEW_SHARED_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib
#	-DGLEW_STATIC_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/glew32d.lib
#	-DGLEW_STATIC_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/glew32.lib
#	-DGLEW_LIBRARIES=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib ${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib)
UNIX_dk_set	(GLEW_CMAKE "-DCMAKE_C_FLAGS=-I${GLEW}/include -DGLEW_STATIC" "-DCMAKE_CXX_FLAGS=-I${GLEW}/include -DGLEW_STATIC" -DGLEW_INCLUDE_DIR=${GLEW}/include)
WIN_dk_set	(GLEW_CMAKE "-DCMAKE_C_FLAGS=/I${GLEW}/include /DGLEW_STATIC" "-DCMAKE_CXX_FLAGS=/I${GLEW}/include /DGLEW_STATIC" -DGLEW_INCLUDE_DIR=${GLEW}/include -DGLEW_LIBRARY=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32.lib)
	
	
### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
#dk_copy(${GLEW}/${OS}/lib/${DEBUG_DIR} ${GLEW}/${OS}/CMakeFiles/Export/lib/ OVERWRITE)
#dk_copy(${GLEW}/${OS}/lib/${RELEASE_DIR} ${GLEW}/${OS}/CMakeFiles/Export/lib/ OVERWRITE)
#dk_copy(${GLEW}/${OS}/bin/${DEBUG_DIR} ${GLEW}/${OS}/CMakeFiles/Export/bin/ OVERWRITE)
#dk_copy(${GLEW}/${OS}/bin/${RELEASE_DIR} ${GLEW}/${OS}/CMakeFiles/Export/bin/ OVERWRITE)


### COMPILE ###
dk_build(${GLEW} glew_s)
