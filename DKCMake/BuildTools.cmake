CMAKE_MINIMUM_REQUIRED(VERSION 3.4)
CMAKE_POLICY(SET CMP0054 NEW)
SET(CMAKE_SOURCE_DIR C:/Users/aquawicket/digitalknob/DK)
SET(DIGITALKNOB ${CMAKE_SOURCE_DIR})
INCLUDE(${DIGITALKNOB}/DKCMake/FUNCTIONS.cmake)
INCLUDE(${DIGITALKNOB}/DKCMake/OPTIONS.cmake)
DKSET(DKCMAKE ${DIGITALKNOB}/DKCMake)
DKSET(DKPLUGINS ${DIGITALKNOB}/DKPlugins)
DKSET(3RDPARTY ${DIGITALKNOB}/3rdParty)
DKSET(DKIMPORTS ${3RDPARTY}/_DKIMPORTS)
DKSET(DKDOWNLOAD ${DIGITALKNOB}/Download)
DKSET(DKWEB http://127.0.0.1)




# run the DKDEPNDS for BuildTools
INCLUDE(${DIGITALKNOB}/DKPlugins/BuildTools/DKCMake.txt)

MESSAGE("\n")
MESSAGE("**********************************")
MESSAGE("*** BUILD TOOLS (sorted) ***")
MESSAGE("**********************************\n")
FOREACH(plugin ${DKPLUGS})
	MESSAGE("${plugin}")	
ENDFOREACH()


SET(ANDROID_NDK ${3RDPARTY}/android-ndk-r21e)
ANDROID_DEBUG_LIB(${ANDROID_NDK}/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a/libc++_static.a)
ANDROID_RELEASE_LIB(${ANDROID_NDK}/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a/libc++_static.a)
FOREACH(plugin ${DKPLUGS})
	DKSET(QUEUE_BUILD OFF)
	MESSAGE("\n")
	MESSAGE("***************************************")
	MESSAGE("**** Processing ${plugin}...")
	MESSAGE("***************************************\n")
	
	#################### 3rdParty libs #####################
	##Strip any sublibrary named in the plugin
	STRING(FIND "${plugin}" " " _indexa)
	IF(${_indexa} GREATER -1)
		MATH(EXPR _indexa "${_indexa}+1")
		STRING(SUBSTRING ${plugin} ${_indexa} -1 arg2)
		MATH(EXPR _indexa "${_indexa}-1")
		STRING(SUBSTRING ${plugin} 0 ${_indexa} plugin)
		DKENABLE(${arg2})
	ENDIF()
	
	DKSETPATHTOPLUGIN(${plugin})
	IF(NOT PATHTOPLUGIN)
		RETURN()
	ENDIF()

	INCLUDE(${PATHTOPLUGIN}/DKCMake.txt)
ENDFOREACH()