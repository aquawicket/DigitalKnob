DKDEPEND(DKCef)

DKSET(QUEUE_BUILD ON)
DKEXECUTABLE(DKCefChild)


IF(WIN_32)
	IF(DEBUG)
		DKCOPY(${DKPLUGINS}/DKCefChild/${OS}/${DEBUG_DIR}/cefchild.exe ${DKPROJECT}/assets/DKCef/win32Debug TRUE)
	ENDIF()
	IF(RELEASE)
		DKCOPY(${DKPLUGINS}/DKCefChild/${OS}/${RELEASE_DIR}/cefchild.exe ${DKPROJECT}/assets/DKCef/win32Release TRUE)
	ENDIF()
ENDIF()

IF(WIN_64)
	IF(DEBUG)
		DKCOPY(${DKPLUGINS}/DKCefChild/${OS}/${DEBUG_DIR}/cefchild.exe ${DKPROJECT}/assets/DKCef/win64Debug TRUE)
	ENDIF()
	IF(RELEASE)
		DKCOPY(${DKPLUGINS}/DKCefChild/${OS}/${RELEASE_DIR}/cefchild.exe ${DKPROJECT}/assets/DKCef/win64Release TRUE)
	ENDIF()
ENDIF()

IF(MAC_64)
	if(DEBUG)
		DKCOPY(${DKPLUGINS}/DKCefChild/${OS}/${DEBUG_DIR}/cefchild.app "${DKPROJECT}/assets/DKCef/mac64Debug/${AppName} Helper.app" TRUE)
		#DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${AppName}.app/Contents/Frameworks/cefchild.app/Contents/MacOS/cefchild "${DKPROJECT}/${OS}/${DEBUG_DIR}/${AppName}.app/Contents/Frameworks/cefchild.app/Contents/MacOS/${AppName} Helper")
		#DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${AppName}.app/Contents/Frameworks/cefchild.app "${DKPROJECT}/${OS}/${DEBUG_DIR}/${AppName}.app/Contents/Frameworks/${AppName} Helper.app")
	endif()
	if(RELEASE)
		DKCOPY(${DKPLUGINS}/DKCefChild/${OS}/${RELEASE_DIR}/cefchild.app "${DKPROJECT}/assets/DKCef/mac64Release/${AppName} Helper.app" TRUE)
		#DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${AppName}.app/Contents/Frameworks/cefchild.app/Contents/MacOS/cefchild "${DKPROJECT}/${OS}/${RELEASE_DIR}/${AppName}.app/Contents/Frameworks/cefchild.app/Contents/MacOS/${AppName} Helper")
		#DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${AppName}.app/Contents/Frameworks/cefchild.app "${DKPROJECT}/${OS}/${RELEASE_DIR}/${AppName}.app/Contents/Frameworks/${AppName} Helper.app")
	endif()
	#MAC_COMMAND(install_name_tool -change "@executable_path/Chromium Embedded Framework" "@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework" "${DKPROJECT}/${OS}/${DEBUG_DIR}/${AppName}.app/Contents/Frameworks/${AppName} Helper.app/Contents/MacOS/${AppName} Helper")
	
	#FIXME - command does not work because app does not exist yet
	#MAC_COMMAND(install_name_tool -change "@executable_path/Chromium Embedded Framework" "@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework" "${DKPROJECT}/${OS}/${DEBUG_DIR}/${AppName}.app/Contents/MacOS/${AppName}")
ENDIF()

IF(LINUX)
	DKREMOVE(${DKPROJECT}/assets/DKCef/cefchild)
	IF(DEBUG)
		DKCOPY(${DKPLUGINS}/DKCefChild/${OS}/${DEBUG_DIR}/cefchild ${DKPROJECT}/assets/DKCef TRUE)
	ENDIF()
	IF(RELEASE)
		DKCOPY(${DKPLUGINS}/DKCefChild/${OS}/${RELEASE_DIR}/cefchild ${DKPROJECT}/assets/DKCef TRUE)
	ENDIF()
ENDIF()




## cefchild win
IF(WIN)
	DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${CEF}) \n")
	DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}) \n")
	#DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}/DKCef) \n")
	
	#if(DEBUG)
		DKAPPEND_CMAKE("FIND_LIBRARY(libcefD libcef.lib ${CEF}/${DEBUG_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcefD}) \n")
	
		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperD libcef_dll_wrapper.lib ${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcef_dll_wrapperD}) \n")
		
		#DKAPPEND_CMAKE("FIND_LIBRARY(libcef_sandboxD cef_sandbox.lib ${CEF}/${DEBUG_DIR}) \n")
		#DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcef_sandboxD}) \n")
	#endif()
	#if(RELEASE)
		DKAPPEND_CMAKE("FIND_LIBRARY(libcefR libcef.lib ${CEF}/${RELEASE_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcefR}) \n")
	
		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperR libcef_dll_wrapper.lib ${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcef_dll_wrapperR}) \n")
		
		##DKAPPEND_CMAKE("FIND_LIBRARY(libcef_sandboxR cef_sandbox.lib ${CEF}/${RELEASE_DIR}) \n")
		#DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcef_sandboxR}) \n")
	#endif()
	
	DKAPPEND_CMAKE("FILE(GLOB cefchild_SRC ${DKPLUGINS}/DKCefChild/*.cpp ${DKPLUGINS}/DKCefChild/*.manifest) \n")	
	if(WIN_32)
		DKAPPEND_CMAKE("ADD_EXECUTABLE(cefchild WIN32 \${cefchild_SRC}) \n")
	endif()
	if(WIN_64)
		DKAPPEND_CMAKE("ADD_EXECUTABLE(cefchild WIN64 \${cefchild_SRC}) \n")
	endif()
	DKAPPEND_CMAKE("TARGET_LINK_LIBRARIES(cefchild \${CEF_DEBUG_LIBS} \${CEF_RELEASE_LIBS} dbghelp.lib version.lib winmm.lib ws2_32.lib psapi.lib) \n")
	DKAPPEND_CMAKE("SET_TARGET_PROPERTIES(cefchild PROPERTIES LINK_FLAGS_DEBUG \"/MANIFESTUAC:NO /SUBSYSTEM:CONSOLE /SAFESEH:NO\" LINK_FLAGS_RELEASE \"/INCREMENTAL:NO /OPT:NOREF /MANIFESTUAC:NO /SUBSYSTEM:CONSOLE /FORCE /SAFESEH:NO\") \n")
ENDIF()


## cefchild win64
#if(WIN_64)
#	DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${CEF}) \n")
#	DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}) \n")
#	#DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}/DKCef) \n")
#
#	#if(DEBUG)
#		DKAPPEND_CMAKE("FIND_LIBRARY(libcefD libcef.lib ${CEF}/${DEBUG_DIR}) \n")
#		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcefD}) \n")
#		
#		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperD libcef_dll_wrapper.lib ${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}) \n")
#		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcef_dll_wrapperD}) \n")
#	
#		#DKAPPEND_CMAKE("FIND_LIBRARY(libcef_sandboxD cef_sandbox.lib ${CEF}/${DEBUG_DIR}) \n")
#		#DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcef_sandboxD}) \n")
#	#endif()
#	#if(RELEASE)
#		DKAPPEND_CMAKE("FIND_LIBRARY(libcefR libcef.lib ${CEF}/${RELEASE_DIR}) \n")
#		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcefR}) \n")
#
#		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperR libcef_dll_wrapper.lib ${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}) \n")
#		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcef_dll_wrapperR}) \n")
#	
#		#DKAPPEND_CMAKE("FIND_LIBRARY(libcef_sandboxD cef_sandbox.lib ${CEF}/${DEBUG_DIR}) \n")
#		#DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcef_sandboxD}) \n")
#	#endif()
#	
#	DKAPPEND_CMAKE("FILE(GLOB cefchild_SRC ${DKPLUGINS}/DKCefChild/*.cpp ${DKPLUGINS}/DKCefChild/*.manifest) \n")
#	DKAPPEND_CMAKE("ADD_EXECUTABLE(cefchild WIN64 \${cefchild_SRC}) \n")
#	DKAPPEND_CMAKE("TARGET_LINK_LIBRARIES(cefchild \${CEF_DEBUG_LIBS} \${CEF_RELEASE_LIBS} dbghelp.lib version.lib winmm.lib ws2_32.lib psapi.lib) \n")
#	DKAPPEND_CMAKE("SET_TARGET_PROPERTIES(cefchild PROPERTIES LINK_FLAGS_DEBUG \"/MANIFESTUAC:NO /SUBSYSTEM:CONSOLE /SAFESEH:NO\" LINK_FLAGS_RELEASE \"/INCREMENTAL:NO /OPT:NOREF /MANIFESTUAC:NO /SUBSYSTEM:CONSOLE /FORCE /SAFESEH:NO\") \n")
#endif()


## cefchild mac
IF(MAC)
	DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${CEF}) \n")
	DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}) \n")
	#DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}/DKCef) \n")
	
	#if(DEBUG)
		#DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \"${CEF}/${DEBUG_DIR}/Chromium Embedded Framework.framework\") \n")
		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperD libcef_dll_wrapper.a ${CEF}/${OS}/libcef_dll_wrapper/${DEBUG_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcef_dll_wrapperD}) \n")
		
		#DKAPPEND_CMAKE("FIND_LIBRARY(AK AppKit)\n")
		#DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS ${AK}) \n")
	#endif()
	#if(RELEASE)
		#DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \"${CEF}/${RELEASE_DIR}/Chromium Embedded Framework.framework\") \n")
		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperR libcef_dll_wrapper.a ${CEF}/${OS}/libcef_dll_wrapper/${RELEASE_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcef_dll_wrapperR}) \n")
		
		#DKAPPEND_CMAKE("FIND_LIBRARY(AK AppKit)\n")
		#DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS ${AK}) \n")
	#endif()
	
	DKAPPEND_CMAKE("FILE(GLOB cefchild_SRC ${DKPLUGINS}/DKCefChild/*.cpp) \n")
	if(MAC_32)
		DKAPPEND_CMAKE("SET(CMAKE_OSX_ARCHITECTURES \"i386\") \n")
	endif()
	if(MAC_64)
		DKAPPEND_CMAKE("SET(CMAKE_OSX_ARCHITECTURES \"x86_64\") \n")
	endif()
	DKAPPEND_CMAKE("ADD_EXECUTABLE(cefchild MACOSX_BUNDLE \${cefchild_SRC}) \n")
	DKAPPEND_CMAKE("TARGET_LINK_LIBRARIES(cefchild \${CEF_DEBUG_LIBS} \${CEF_RELEASE_LIBS}) \n")
ENDIF()


## cefchild linux
IF(LINUX)
		DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${CEF}) \n")
		DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}) \n")
		#DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}/DKCef) \n")
	IF(DEBUG)
		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperD libcef_dll_wrapper.a ${CEF}/${OS}/${DEBUG_DIR}/libcef_dll_wrapper) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcef_dll_wrapperD}) \n")
		
		DKAPPEND_CMAKE("FIND_LIBRARY(libcefD libcef.so ${CEF}/${DEBUG_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcefD}) \n")
		
		DKAPPEND_CMAKE("FILE(GLOB cefchild_SRC ${DKPLUGINS}/DKCefChild/*.cpp) \n")
		DKAPPEND_CMAKE("ADD_EXECUTABLE(cefchild \${cefchild_SRC}) \n")
		DKAPPEND_CMAKE("TARGET_LINK_LIBRARIES(cefchild  \${CEF_DEBUG_LIBS}) \n")
	ENDIF()
	IF(RELEASE)
		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperR libcef_dll_wrapper.a ${CEF}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcef_dll_wrapperR}) \n")
		
		DKAPPEND_CMAKE("FIND_LIBRARY(libcefR libcef.so ${CEF}/${RELEASE_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcefR}) \n")
		
		DKAPPEND_CMAKE("FILE(GLOB cefchild_SRC ${DKPLUGINS}/DKCefChild/*.cpp) \n")
		DKAPPEND_CMAKE("ADD_EXECUTABLE(cefchild \${cefchild_SRC}) \n")
		DKAPPEND_CMAKE("TARGET_LINK_LIBRARIES(cefchild  \${CEF_RELEASE_LIBS}) \n")
	ENDIF()
ENDIF()

## cefchild raspberry
IF(RASPBERRY)
		DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${CEF}) \n")
		DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}) \n")
		#DKAPPEND_CMAKE("INCLUDE_DIRECTORIES(${DKPLUGINS}/DKCef) \n")
	IF(DEBUG)
		DKAPPEND_CMAKE("FIND_LIBRARY(libcefD libcef.so ${CEF}/${DEBUG_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcef_dll_wrapperD}) \n")
		
		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperD libcef_dll_wrapper.a ${CEF}/${OS}/${DEBUG_DIR}/libcef_dll_wrapper) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_DEBUG_LIBS debug \${libcefD}) \n")
		
		DKAPPEND_CMAKE("FILE(GLOB cefchild_SRC ${DKPLUGINS}/DKCefChild/*.cpp) \n")
		DKAPPEND_CMAKE("ADD_EXECUTABLE(cefchild \${cefchild_SRC}) \n")
		DKAPPEND_CMAKE("TARGET_LINK_LIBRARIES(cefchild  \${CEF_DEBUG_LIBS}) \n")
	ENDIF()
	IF(RELEASE)
		DKAPPEND_CMAKE("FIND_LIBRARY(libcefR libcef.so ${CEF}/${RELEASE_DIR}) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcef_dll_wrapperR}) \n")
		
		DKAPPEND_CMAKE("FIND_LIBRARY(libcef_dll_wrapperR libcef_dll_wrapper.a ${CEF}/${OS}/${RELEASE_DIR}/libcef_dll_wrapper) \n")
		DKAPPEND_CMAKE("LIST(APPEND CEF_RELEASE_LIBS optimized \${libcefR}) \n")
		
		DKAPPEND_CMAKE("FILE(GLOB cefchild_SRC ${DKPLUGINS}/DKCefChild/*.cpp) \n")
		DKAPPEND_CMAKE("ADD_EXECUTABLE(cefchild \${cefchild_SRC}) \n")
		DKAPPEND_CMAKE("TARGET_LINK_LIBRARIES(cefchild  \${CEF_RELEASE_LIBS}) \n")
	ENDIF()
ENDIF()
