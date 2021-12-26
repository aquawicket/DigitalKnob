if(IOS OR IOSSIM OR ANDROID)
	return()
endif()

# http://glew.sourceforge.net/
#
# https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip

### VERSION ###
DKSET(GLEW_VERSION 2.2.0)
DKSET(GLEW_NAME glew-${GLEW_VERSION})
DKSET(GLEW_DL https://github.com/nigels-com/glew/releases/download/${GLEW_NAME}/${GLEW_NAME}.zip)
DKSET(GLEW ${3RDPARTY}/${GLEW_NAME})


### INSTALL ###
DKINSTALL(${GLEW_DL} glew ${GLEW})
DKCOPY(${GLEW}/build/cmake ${GLEW}/${OS}/CMakeFiles/Export/lib/cmake/glew TRUE)


### LINK ###
DKDEFINE(GLEW_STATIC)
DKINCLUDE(${GLEW}/include)
WIN_DEBUG_LIB(${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib)
WIN_RELEASE_LIB(${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib)
#WIN_DEBUG_SHARED_LIB(${GLEW}/${OS}/bin/${DEBUG_DIR}/glew32d.lib)
#WIN_RELEASE_SHARED_LIB(${GLEW}/${OS}/bin/${RELEASE_DIR}/glew32.lib)
MAC_DEBUG_LIB(${GLEW}/${OS}/lib/${DEBUG_DIR}/libGLEWd.a)
MAC_RELEASE_LIB(${GLEW}/${OS}/lib/${RELEASE_DIR}/libGLEW.a)
IOSSIM_DEBUG_LIB(${GLEW}/${OS}/lib/${DEBUG_DIR}/libGLEWd.a)
IOSSIM_RELEASE_LIB(${GLEW}/${OS}/lib/${RELEASE_DIR}/libGLEW.a)
LINUX_DEBUG_LIB(${GLEW}/${OS}/${DEBUG_DIR}/lib/libGLEWd.a)
LINUX_RELEASE_LIB(${GLEW}/${OS}/${RELEASE_DIR}/lib/libGLEW.a)
RASPBERRY_DEBUG_LIB(${GLEW}/${OS}/${DEBUG_DIR}/lib/libGLEWd.a)
RASPBERRY_RELEASE_LIB(${GLEW}/${OS}//${RELEASE_DIR}/lib/libGLEW.a)


### INJECT ###
#DKSET(GLEW_WIN32 
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
WIN_PATH(${GLEW}/${OS})
WIN32_DKQCOMMAND(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
WIN64_DKQCOMMAND(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
#WIN_VS_DEBUG(${GLEW_NAME} glew.sln glew)
#WIN_VS_RELEASE(${GLEW_NAME} glew.sln glew)
WIN_VS_DEBUG(${GLEW_NAME} glew.sln glew_s)
WIN_VS_RELEASE(${GLEW_NAME} glew.sln glew_s)
#DKCOPY(${GLEW}/${OS}/lib/${DEBUG_DIR} ${GLEW}/${OS}/CMakeFiles/Export/lib/ TRUE)
#DKCOPY(${GLEW}/${OS}/lib/${RELEASE_DIR} ${GLEW}/${OS}/CMakeFiles/Export/lib/ TRUE)
#DKCOPY(${GLEW}/${OS}/bin/${DEBUG_DIR} ${GLEW}/${OS}/CMakeFiles/Export/bin/ TRUE)
#DKCOPY(${GLEW}/${OS}/bin/${RELEASE_DIR} ${GLEW}/${OS}/CMakeFiles/Export/bin/ TRUE)


MAC_PATH(${GLEW}/${OS})
MAC64_DKQCOMMAND(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
MAC_XCODE(${GLEW_NAME} glew_s)

IOSSIM_PATH(${GLEW}/${OS})
IOSSIM64_DKQCOMMAND(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
IOSSIM_XCODE(${GLEW_NAME} glew_s)


LINUX_DEBUG_DKSETPATH(${GLEW}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_DKQCOMMAND(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
LINUX_DEBUG_DKQCOMMAND(make glew_s)
LINUX_RELEASE_DKSETPATH(${GLEW}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_DKQCOMMAND(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
LINUX_RELEASE_DKQCOMMAND(make glew_s)


RASPBERRY_DEBUG_DKSETPATH(${GLEW}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_DKQCOMMAND(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
RASPBERRY_DEBUG_DKQCOMMAND(make glew_s)
RASPBERRY_RELEASE_DKSETPATH(${GLEW}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_DKQCOMMAND(${DKCMAKE_BUILD} ${GLEW}/build/cmake)
RASPBERRY_RELEASE_DKQCOMMAND(make glew_s)