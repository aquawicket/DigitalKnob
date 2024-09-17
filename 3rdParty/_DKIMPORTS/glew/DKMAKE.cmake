include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
#dk_import(https://github.com/nigels-com/glew.git)
dk_import(https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip)
dk_copy(${GLEW}/build/cmake ${GLEW}/${triple}/CMakeFiles/Export/lib/cmake/glew OVERWRITE)


### LINK ###
dk_define				(GLEW_STATIC)
dk_include				(${GLEW}/include									GLEW_INCLUDE_DIR)
if(MSVC)
	WIN_dk_libDebug		(${GLEW}/${triple}/lib/${DEBUG_DIR}/libglew32d.lib		GLEW_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${GLEW}/${triple}/lib/${RELEASE_DIR}/libglew32.lib		GLEW_LIBRARY_RELEASE)
elseif(APPLE)
	APPLE_dk_libDebug	(${GLEW}/${triple}/lib/${DEBUG_DIR}/libGLEWd.a			GLEW_LIBRARY_DEBUG)
	APPLE_dk_libRelease	(${GLEW}/${triple}/lib/${RELEASE_DIR}/libGLEW.a			GLEW_LIBRARY_RELEASE)
else()
	dk_libDebug			(${GLEW}/${triple}/${DEBUG_DIR}/lib/libGLEWd.a			GLEW_LIBRARY_DEBUG)
	dk_libRelease		(${GLEW}/${triple}/${RELEASE_DIR}/lib/libGLEW.a			GLEW_LIBRARY_RELEASE)
endif()



### 3RDPARTY LINK ###
# dk_set(GLEW_CMAKE
#	-DGLEW_USE_STATIC_LIB=ON
#	-DGLEW_DIR=${GLEW}/${triple}/CMakeFiles/Export/lib/cmake/glew
#	-DGLEW_LIBRARY=${GLEW_LIBRARY_DEBUG}
#	-DGLEW_INCLUDE_DIR=${GLEW_INCLUDE_DIR}
#	-DGLEW_SHARED_LIBRARY_DEBUG=${GLEW}/${triple}/lib/${DEBUG_DIR}/libglew32d.lib
#	-DGLEW_SHARED_LIBRARY_RELEASE=${GLEW}/${triple}/lib/${RELEASE_DIR}/libglew32.lib
#	-DGLEW_STATIC_LIBRARY_DEBUG=${GLEW}/${triple}/lib/${DEBUG_DIR}/glew32d.lib
#	-DGLEW_STATIC_LIBRARY_RELEASE=${GLEW}/${triple}/lib/${RELEASE_DIR}/glew32.lib
#	-DGLEW_LIBRARIES=${GLEW_LIBRARY_DEBUG} ${GLEW_LIBRARY_RELEASE})
if(MSVC)
	WIN_dk_set	(GLEW_CMAKE "-DCMAKE_C_FLAGS=/I${GLEW}/include /DGLEW_STATIC" "-DCMAKE_CXX_FLAGS=/I${GLEW_INCLUDE_DIR} /DGLEW_STATIC" -DGLEW_INCLUDE_DIR=${GLEW_INCLUDE_DIR} -DGLEW_LIBRARY=${GLEW_LIBRARY_DEBUG})
else()
	dk_set		(GLEW_CMAKE "-DCMAKE_C_FLAGS=-I${GLEW}/include -DGLEW_STATIC" "-DCMAKE_CXX_FLAGS=-I${GLEW_INCLUDE_DIR} -DGLEW_STATIC" -DGLEW_INCLUDE_DIR=${GLEW_INCLUDE_DIR})
endif()


	
### GENERATE ###
dk_configure(${GLEW_DIR}/build/cmake)
#dk_copy(${GLEW}/${triple}/lib/${DEBUG_DIR} ${GLEW}/${triple}/CMakeFiles/Export/lib/ OVERWRITE)
#dk_copy(${GLEW}/${triple}/lib/${RELEASE_DIR} ${GLEW}/${triple}/CMakeFiles/Export/lib/ OVERWRITE)
#dk_copy(${GLEW}/${triple}/bin/${DEBUG_DIR} ${GLEW}/${triple}/CMakeFiles/Export/bin/ OVERWRITE)
#dk_copy(${GLEW}/${triple}/bin/${RELEASE_DIR} ${GLEW}/${triple}/CMakeFiles/Export/bin/ OVERWRITE)


### COMPILE ###
dk_build(${GLEW_DIR} glew_s)
