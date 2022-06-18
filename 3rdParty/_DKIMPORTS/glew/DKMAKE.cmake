# http://glew.sourceforge.net

if(IOS OR IOSSIM OR ANDROID)
	return()
endif()


#DKGITCLONE(https://github.com/nigels-com/glew.git)

dk_import(https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip)

#dk_set(GLEW_VERSION 2.2.0)
#dk_set(GLEW_NAME glew-${GLEW_VERSION})
#dk_set(GLEW_DL https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip)
#dk_set(GLEW ${3RDPARTY}/${GLEW_NAME})
#dk_install(${GLEW_DL} glew ${GLEW})



dk_copy(${GLEW}/build/cmake ${GLEW}/${OS}/CMakeFiles/Export/lib/cmake/glew TRUE)


### LINK ###
dk_define(GLEW_STATIC)
dk_include(${GLEW}/include)
WIN_DEBUG_DKLIB(${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib)
WIN_RELEASE_DKLIB(${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib)
#WIN_DEBUG_SHARED_LIB(${GLEW}/${OS}/bin/${DEBUG_DIR}/glew32d.lib)
#WIN_RELEASE_SHARED_LIB(${GLEW}/${OS}/bin/${RELEASE_DIR}/glew32.lib)
MAC_DEBUG_DKLIB(${GLEW}/${OS}/lib/${DEBUG_DIR}/libGLEWd.a)
MAC_RELEASE_DKLIB(${GLEW}/${OS}/lib/${RELEASE_DIR}/libGLEW.a)
IOSSIM_DEBUG_DKLIB(${GLEW}/${OS}/lib/${DEBUG_DIR}/libGLEWd.a)
IOSSIM_RELEASE_DKLIB(${GLEW}/${OS}/lib/${RELEASE_DIR}/libGLEW.a)
LINUX_DEBUG_DKLIB(${GLEW}/${OS}/${DEBUG_DIR}/lib/libGLEWd.a)
LINUX_RELEASE_DKLIB(${GLEW}/${OS}/${RELEASE_DIR}/lib/libGLEW.a)
RASPBERRY_DEBUG_DKLIB(${GLEW}/${OS}/${DEBUG_DIR}/lib/libGLEWd.a)
RASPBERRY_RELEASE_DKLIB(${GLEW}/${OS}//${RELEASE_DIR}/lib/libGLEW.a)


### INJECT ###
#dk_set(GLEW_WIN32 
#	-DGLEW_USE_STATIC_LIB=ON
#	-DGLEW_DIR=${GLEW}/${OS}/CMakeFiles/Export/lib/cmake/glew
#	-DGLEW_LIBRARY=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32.lib
#	-DGLEW_INCLUDE_DIR=${GLEW}/include
#	-DGLEW_SHARED_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib
#	-DGLEW_SHARED_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib
#	-DGLEW_STATIC_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/glew32d.lib
#	-DGLEW_STATIC_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/glew32.lib
#	-DGLEW_LIBRARIES=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib ${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib)
	
	

##You need to link to other Windows libraries if you use GLFW as static library - gdi32.lib and user32.lib. Either add them in project properties for linker â€œAdditional Dependenciesâ€? setting. Or put #pragma comment (lib, "gdi32.lib") in your .c/.cpp source.

# -DGLEW_STATIC=ON -DGLEW_USE_STATIC_LIBS=ON

### COMPILE ###
dk_setPath(${GLEW}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
WIN_VS(${GLEW_NAME} glew.sln glew_s)
#dk_copy(${GLEW}/${OS}/lib/${DEBUG_DIR} ${GLEW}/${OS}/CMakeFiles/Export/lib/ TRUE)
#dk_copy(${GLEW}/${OS}/lib/${RELEASE_DIR} ${GLEW}/${OS}/CMakeFiles/Export/lib/ TRUE)
#dk_copy(${GLEW}/${OS}/bin/${DEBUG_DIR} ${GLEW}/${OS}/CMakeFiles/Export/bin/ TRUE)
#dk_copy(${GLEW}/${OS}/bin/${RELEASE_DIR} ${GLEW}/${OS}/CMakeFiles/Export/bin/ TRUE)


MAC_dk_queueCommand(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
MAC_XCODE(${GLEW_NAME} glew_s)


IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
IOSSIM_XCODE(${GLEW_NAME} glew_s)


LINUX_dk_queueCommand(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
LINUX_dk_queueCommand(make glew_s)


RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
RASPBERRY_dk_queueCommand(make glew_s)
