## http://glew.sourceforge.net/

### VERSION ###
DKSET(GLEW_VERSION 2.2.0)
DKSET(GLEW ${3RDPARTY}/glew-${GLEW_VERSION})


### INSTALL ###
# https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip
DKINSTALL(https://versaweb.dl.sourceforge.net/project/glew/glew/${GLEW_VERSION}/glew-${GLEW_VERSION}.zip glew glew-${GLEW_VERSION})
DKCOPY(${GLEW}/build/cmake ${GLEW}/${OS}/CMakeFiles/Export/lib/cmake/glew TRUE)


### LINK ###
#DKDEFINE(GLEW_USE_STATIC_LIBS)
#DKDEFINE(GLEW_STATIC)
DKINCLUDE(${GLEW}/include)
WIN_DEBUG_LIB(${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib)
WIN_RELEASE_LIB(${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib)
##WIN_DEBUG_SHARED_LIB(${GLEW}/${OS}/bin/${DEBUG_DIR}/glew32d.lib)
##WIN_RELEASE_SHARED_LIB(${GLEW}/${OS}/bin/${RELEASE_DIR}/glew32.lib)


### INJECT ###
DKSET(GLEW_WIN32 
	-DGLEW_USE_STATIC_LIB=ON
	-DGLEW_DIR=${GLEW}/${OS}/CMakeFiles/Export/lib/cmake/glew
	-DGLEW_LIBRARY=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32.lib
	-DGLEW_INCLUDE_DIR=${GLEW}
	-DGLEW_STATIC_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib
	-DGLEW_STATIC_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib
	-DGLEW_SHARED_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/glew32d.lib
	-DGLEW_SHARED_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/glew32.lib
	-DGLEW_LIBRARIES=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib ${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib)
	
	

##You need to link to other Windows libraries if you use GLFW as static library - gdi32.lib and user32.lib. Either add them in project properties for linker â€œAdditional Dependenciesâ€? setting. Or put #pragma comment (lib, "gdi32.lib") in your .c/.cpp source.

# -DGLEW_STATIC=ON -DGLEW_USE_STATIC_LIBS=ON

### COMPILE ###
WIN_PATH(${GLEW}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${GLEW}/build/cmake)
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${GLEW}/build/cmake)
WIN_VS_DEBUG(glew-${GLEW_VERSION} glew.sln glew)
WIN_VS_RELEASE(glew-${GLEW_VERSION} glew.sln glew)
WIN_VS_DEBUG(glew-${GLEW_VERSION} glew.sln glew_s)
WIN_VS_RELEASE(glew-${GLEW_VERSION} glew.sln glew_s)
DKCOPY(${GLEW}/${OS}/lib/${DEBUG_DIR} ${GLEW}/${OS}/CMakeFiles/Export/lib/ TRUE)
DKCOPY(${GLEW}/${OS}/lib/${RELEASE_DIR} ${GLEW}/${OS}/CMakeFiles/Export/lib/ TRUE)
DKCOPY(${GLEW}/${OS}/bin/${DEBUG_DIR} ${GLEW}/${OS}/CMakeFiles/Export/bin/ TRUE)
DKCOPY(${GLEW}/${OS}/bin/${RELEASE_DIR} ${GLEW}/${OS}/CMakeFiles/Export/bin/ TRUE)
