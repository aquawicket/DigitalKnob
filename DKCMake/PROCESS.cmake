INCLUDE(DKCMake/FUNCTIONS.cmake)
INCLUDE(DKCMake/OPTIONS.cmake)

MESSAGE("##########################")
MESSAGE("#####   VARIABLES    #####")
MESSAGE("##########################")
MESSAGE("DKPROJECT: ${DKPROJECT}")
MESSAGE("DKPLUGINS: ${DKPLUGINS}")
MESSAGE("3RDPARTY: ${3RDPARTY}")
MESSAGE("OS: ${OS}")
MESSAGE("DEBUG: ${DEBUG}")
MESSAGE("RELEASE: ${RELEASE}")
MESSAGE("BUILD: ${BUILD}")
MESSAGE("REBUILD: ${REBUILD}")
MESSAGE("REBUILDALL: ${REBUILDALL}")
MESSAGE("LIB_TYPE: ${LIB_TYPE}")
MESSAGE("OPENGL2: ${OPENGL2}")
MESSAGE("DKCEF: ${DKCEF}")
MESSAGE("WIN: ${WIN}")
MESSAGE("WIN_32: ${WIN_32}")
MESSAGE("WIN_64: ${WIN_64}")
MESSAGE("MAC: ${MAC}")
MESSAGE("MAC_32: ${MAC_32}")
MESSAGE("MAC_64: ${MAC_64}")
MESSAGE("IOS: ${IOS}")
MESSAGE("IOS_32: ${IOS_32}")
MESSAGE("IOS_64: ${IOS_64}")
MESSAGE("IOSSIM: ${IOSSIM}")
MESSAGE("IOSSIM_32: ${IOSSIM_32}")
MESSAGE("IOSSIM_64: ${IOSSIM_64}")
MESSAGE("LINUX: ${LINUX}")
MESSAGE("LINUX_32: ${LINUX_32}")
MESSAGE("LINUX_64: ${LINUX_64}")
MESSAGE("ANDROID: ${ANDROID}")
MESSAGE("ANDROID_32: ${ANDROID_32}")
MESSAGE("ANDROID_64: ${ANDROID_64}")
MESSAGE("RASPBERRY: ${RASPBERRY}")
MESSAGE("RASPBERRY_32: ${RASPBERRY_32}")
MESSAGE("RASPBERRY_64: ${RASPBERRY_64}")


MESSAGE("\n")
MESSAGE("**********************************************")
MESSAGE("**************  DigitalKnob  *****************")
MESSAGE("**********************************************\n")

############################################################################################
############################   ADD EXECUTABLE  #############################################
############################################################################################
### Set the project name to the App folder name
GET_FILENAME_COMPONENT(AppName ${DKPROJECT} NAME)
STRING(REPLACE " " "_" AppName ${AppName})

SET(CMAKE_CXX_STANDARD 14)

PROJECT(${AppName})


#### EXTRA VARIABLES ###############
DKSET(DKAPP ON)



##################################################
##### Scan the DKPlugins and build the lists #####
##################################################
# run the DKDEPNDS for the apps DKCMake.txt file
INCLUDE(${DKPROJECT}/DKCMake.txt)

MESSAGE("\n")
MESSAGE("**********************************")
MESSAGE("*** ENABLED DKPLUGINS (sorted) ***")
MESSAGE("**********************************\n")
FOREACH(plugin ${DKPLUGS})
	MESSAGE("${plugin}")	
ENDFOREACH()

#DKDEPEND(DK) 

DKSET(DKDEFINES "")
DKSET(DKINCLUDES "")
DKSET(DKLIBRARIES "")
ANDROID_DEBUG_LIB(${3RDPARTY}/android-ndk-r10d/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi-v7a/libgnustl_static.a)
ANDROID_RELEASE_LIB(${3RDPARTY}/android-ndk-r10d/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi-v7a/libgnustl_static.a)
FOREACH(plugin ${DKPLUGS})
	DKSET(QUEUE_BUILD OFF)
	DKSET(LIBLIST "") ## used for double checking
	DKSET(CMAKE_FILE "")
	DKSET(ANDROID_LIBMK "")
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
	
	####################### DKPlugins #######################
	STRING(FIND "${DKCPPPLUGS}" "${plugin}" _index)
	IF(${_index} GREATER -1)
		DKENABLE(${plugin})
		WIN_DEBUG_LIB(${PATHTOPLUGIN}/${OS}/Debug/${plugin}.lib)
		WIN_RELEASE_LIB(${PATHTOPLUGIN}/${OS}/Release/${plugin}.lib)
		APPLE_DEBUG_LIB(${PATHTOPLUGIN}/${OS}/${DEBUG}/lib${plugin}.a)
		APPLE_RELEASE_LIB(${PATHTOPLUGIN}/${OS}/${RELEASE}/lib${plugin}.a)
		LINUX_DEBUG_LIB(${PATHTOPLUGIN}/${OS}/Debug/lib${plugin}.a)
		LINUX_RELEASE_LIB(${PATHTOPLUGIN}/${OS}/Release/lib${plugin}.a)
		ANDROID_DEBUG_LIB(${PATHTOPLUGIN}/${OS}/Debug/obj/local/armeabi-v7a/lib${plugin}.a)
		ANDROID_RELEASE_LIB(${PATHTOPLUGIN}/${OS}/Release/obj/local/armeabi-v7a/lib${plugin}.a)
		RASPBERRY_DEBUG_LIB(${PATHTOPLUGIN}/${OS}/Debug/lib${plugin}.a)
		RASPBERRY_RELEASE_LIB(${PATHTOPLUGIN}/${OS}/Release/lib${plugin}.a)
		IF(REBUILD OR REBUILDALL)
			DKSET(QUEUE_BUILD ON)
		ENDIF()
	ENDIF()
	
	IF(QUEUE_BUILD AND CMAKE_FILE)
		IF(REBUILDALL)
			DKREMOVE(${PATHTOPLUGIN}/CMakeLists.txt)
			FOREACH(the_lib ${LIBLIST})
				MESSAGE("Removing ${the_lib}")
				DKREMOVE(${the_lib})
			ENDFOREACH()
		ENDIF()
		IF(NOT EXISTS ${PATHTOPLUGIN}/CMakeLists.txt)
			MESSAGE("Creating CMakeLists.txt file for ${plugin}....")
			FILE(WRITE ${PATHTOPLUGIN}/CMakeLists.txt ${CMAKE_FILE})
		ENDIF()
		
		IF(WIN_32)
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/win32)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 -DWIN_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${PATHTOPLUGIN})
			IF(DEBUG)
				WIN32_COMMAND(${VC_EXE} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
			ENDIF()
			IF(RELEASE)
				WIN32_COMMAND(${VC_EXE} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
			ENDIF()
		ENDIF()
		IF(WIN_64)
			MESSAGE("WINDOWS 64")
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/win64)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 -DWIN_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${PATHTOPLUGIN})
			IF(DEBUG)
				WIN64_COMMAND(${VC_EXE} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
			ENDIF()
			IF(RELEASE)
				WIN64_COMMAND(${VC_EXE} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
			ENDIF()
		ENDIF()
		IF(MAC_32)
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/mac32)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			MAC32_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DMAC_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DCMAKE_OSX_ARCHITECTURES=\"x86_64\" ${PATHTOPLUGIN})
			IF(DEBUG)
				MAC32_COMMAND(xcodebuild -configuration Debug build)
			ENDIF()
			IF(RELEASE)
				MAC32_COMMAND(xcodebuild -configuration Release build)
			ENDIF()
		ENDIF()
		IF(MAC_64)
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/mac64)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			MAC64_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DMAC_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DCMAKE_OSX_ARCHITECTURES=\"x86_64\" ${PATHTOPLUGIN})
			IF(DEBUG)
				MAC64_COMMAND(xcodebuild -configuration Debug build)
			ENDIF()
			IF(RELEASE)
				MAC64_COMMAND(xcodebuild -configuration Release build)
			ENDIF()
		ENDIF()
		IF(IOS_32)
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/ios32)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			IOS32_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DIOS_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS ${PATHTOPLUGIN})
			IF(DEBUG)
				IOS32_COMMAND(xcodebuild -configuration Debug build -sdk iphoneos11.2)
			ENDIF()
			IF(RELEASE)
				IOS32_COMMAND(xcodebuild -configuration Release build -sdk iphoneos11.2)
			ENDIF()
		ENDIF()
		IF(IOS_64)
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/ios64)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			IOS64_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DIOS_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS ${PATHTOPLUGIN})
			IF(DEBUG)
				IOS64_COMMAND(xcodebuild -configuration Debug build)
			ENDIF()
			IF(RELEASE)
				IOS64_COMMAND(xcodebuild -configuration Release build)
			ENDIF()
		ENDIF()
		IF(IOSSIM_32)
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/iossim32)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			IOSSIM32_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DIOSSIM_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR ${PATHTOPLUGIN})
			IF(DEBUG)
				IOSSIM32_COMMAND(xcodebuild -configuration Debug build -sdk iphonesimulator11.2)
			ENDIF()
			IF(RELEASE)
				IOSSIM32_COMMAND(xcodebuild -configuration Release build -sdk iphonesimulator11.2)
			ENDIF()
		ENDIF()
		IF(IOSSIM_64)
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/iossim64)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			IOSSIM64_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DIOSSIM_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR64 ${PATHTOPLUGIN})
			IF(DEBUG)
				IOSSIM64_COMMAND(xcodebuild -configuration Debug build -sdk iphonesimulator11.2)
			ENDIF()
			IF(RELEASE)
				IOSSIM64_COMMAND(xcodebuild -configuration Release build -sdk iphonesimulator11.2)
			ENDIF()
		ENDIF()
		IF(LINUX_32)
			FILE(MAKE_DIRECTORY ${PATHTOPLUGIN}/${OS})
			IF(DEBUG)
				DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Debug)
				FILE(MAKE_DIRECTORY ${CURRENT_DIR})
				LINUX32_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DLINUX_32=ON -DREBUILD=ON -DDEBUG=ON ${PATHTOPLUGIN})
				LINUX32_COMMAND(make)
			ENDIF()
			IF(RELEASE)
				DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Release)
				FILE(MAKE_DIRECTORY ${CURRENT_DIR})
				LINUX32_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DLINUX_32=ON -DREBUILD=ON -DRELEASE=ON ${PATHTOPLUGIN})
				LINUX32_COMMAND(make)
			ENDIF()
		ENDIF()
		IF(LINUX_64)
			FILE(MAKE_DIRECTORY ${PATHTOPLUGIN}/${OS})
			IF(DEBUG)
				DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Debug)
				FILE(MAKE_DIRECTORY ${CURRENT_DIR})
				LINUX64_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DLINUX_64=ON -DREBUILD=ON -DDEBUG=ON ${PATHTOPLUGIN})
				LINUX64_COMMAND(make)
			ENDIF()
			IF(RELEASE)
				DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Release)
				FILE(MAKE_DIRECTORY ${CURRENT_DIR})
				LINUX64_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DLINUX_64=ON -DREBUILD=ON -DRELEASE=ON ${PATHTOPLUGIN})
				LINUX64_COMMAND(make)
			ENDIF()
		ENDIF()
		IF(RASPBERRY_32)
			FILE(MAKE_DIRECTORY ${PATHTOPLUGIN}/${OS})
			IF(DEBUG)
				DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Debug)
				FILE(MAKE_DIRECTORY ${CURRENT_DIR})
				RASPBERRY32_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DRASPBERRY_32=ON -DLINUX_32=ON -DREBUILD=ON -DDEBUG=ON ${PATHTOPLUGIN})
				RASPBERRY32_COMMAND(make)
			ENDIF()
			IF(RELEASE)
				DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Release)
				FILE(MAKE_DIRECTORY ${CURRENT_DIR})
				RASPBERRY32_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DRASPBERRY_32=ON -DLINUX_32=ON -DREBUILD=ON -DRELEASE=ON ${PATHTOPLUGIN})
				RASPBERRY32_COMMAND(make)
			ENDIF()
		ENDIF()
		IF(RASPBERRY_64)
			FILE(MAKE_DIRECTORY ${PATHTOPLUGIN}/${OS})
			IF(DEBUG)
				DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Debug)
				FILE(MAKE_DIRECTORY ${CURRENT_DIR})
				RASPBERRY64_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DRASPBERRY_64=ON -DLINUX_64=ON -DREBUILD=ON -DDEBUG=ON ${PATHTOPLUGIN})
				RASPBERRY64_COMMAND(make)
			ENDIF()
			IF(RELEASE)
				DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Release)
				FILE(MAKE_DIRECTORY ${CURRENT_DIR})
				RASPBERRY64_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DRASPBERRY_64=ON -DLINUX_64=ON -DREBUILD=ON -DRELEASE=ON ${PATHTOPLUGIN})
				RASPBERRY64_COMMAND(make)
			ENDIF()
		ENDIF()
		
		INCLUDE(${PATHTOPLUGIN}/DKCMake.txt) ##run it again to copy any .exe and .dll files. 
	ENDIF()
	
	##NOTE - can this work inside the IF()/END() group above?..  please test
	IF(ANDROID_LIBMK)
		DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS})
		FILE(MAKE_DIRECTORY ${CURRENT_DIR})
		IF(DEBUG)
			MESSAGE("Creating DEBUG Application.mk file for ${plugin}....")
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Debug)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			FILE(MAKE_DIRECTORY ${CURRENT_DIR}/jni)
			
			DKSET(APPMK_FILE "APP_PLATFORM := android-15 \n")
			DKSET(APPMK_FILE ${APPMK_FILE} "APP_ABI      := armeabi-v7a \n")
			DKSET(APPMK_FILE ${APPMK_FILE} "APP_STL      := gnustl_static \n")
			DKSET(APPMK_FILE ${APPMK_FILE} "APP_OPTIM    := debug \n")
			DKSET(APPMK_FILE ${APPMK_FILE} "APP_CPPFLAGS := -fexceptions -frtti\n")
			FILE(WRITE ${CURRENT_DIR}/jni/Application.mk ${APPMK_FILE})
			
			MESSAGE("Creating DEBUG Android.mk file for ${plugin}....")
			DKSET(ANDROID_LIBMK ${ANDROID_LIBMK} ${DKDEFINES})
			DKSET(ANDROID_LIBMK ${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${DKPLUGINS}\n")
			DKSET(ANDROID_LIBMK ${ANDROID_LIBMK} ${DKINCLUDES})
			DKSET(ANDROID_LIBMK ${ANDROID_LIBMK} "include $(BUILD_STATIC_LIBRARY) \n\n")
			FILE(WRITE ${CURRENT_DIR}/jni/Android.mk ${ANDROID_LIBMK})
			IF(NOT UNIX)
				EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd NDK_DEBUG=1 WORKING_DIRECTORY ${CURRENT_DIR})
				##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r10d/ndk-build.cmd NDK_DEBUG=1 WORKING_DIRECTORY ${CURRENT_DIR})
			ENDIF()
			IF(UNIX)
				EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build NDK_DEBUG=1 WORKING_DIRECTORY ${CURRENT_DIR})
				##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r16b/ndk-build NDK_DEBUG=1 WORKING_DIRECTORY ${CURRENT_DIR})
			ENDIF()
		ENDIF()
		IF(RELEASE)
			MESSAGE("Creating RELEASE Application.mk file for ${plugin}....")
			DKSET(CURRENT_DIR ${PATHTOPLUGIN}/${OS}/Release)
			FILE(MAKE_DIRECTORY ${CURRENT_DIR})
			FILE(MAKE_DIRECTORY ${CURRENT_DIR}/jni)
			
			DKSET(APPMK_FILE "APP_PLATFORM := android-15 \n")
			DKSET(APPMK_FILE ${APPMK_FILE} "APP_ABI      := armeabi-v7a \n")
			DKSET(APPMK_FILE ${APPMK_FILE} "APP_STL      := gnustl_static \n")
			DKSET(APPMK_FILE ${APPMK_FILE} "APP_OPTIM    := release \n")
			DKSET(APPMK_FILE ${APPMK_FILE} "APP_CPPFLAGS := -fexceptions -frtti\n")
			FILE(WRITE ${CURRENT_DIR}/jni/Application.mk ${APPMK_FILE})
			
			MESSAGE("Creating RELEASE Android.mk file for ${plugin}....")
			DKSET(ANDROID_LIBMK ${ANDROID_LIBMK} ${DKDEFINES})
			DKSET(ANDROID_LIBMK ${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${DKPLUGINS}\n")
			DKSET(ANDROID_LIBMK ${ANDROID_LIBMK} ${DKINCLUDES})
			DKSET(ANDROID_LIBMK ${ANDROID_LIBMK} "include $(BUILD_STATIC_LIBRARY) \n\n")
			FILE(WRITE ${CURRENT_DIR}/jni/Android.mk ${ANDROID_LIBMK})
			IF(NOT UNIX)
				EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd NDK_DEBUG=0 WORKING_DIRECTORY ${CURRENT_DIR})
				##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r10d/ndk-build.cmd NDK_DEBUG=0 WORKING_DIRECTORY ${CURRENT_DIR})
			ENDIF()
			IF(UNIX)
				EXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build NDK_DEBUG=0 WORKING_DIRECTORY ${CURRENT_DIR})
				##EXECUTE_PROCESS(COMMAND ${3RDPARTY}/android-ndk-r16b/ndk-build NDK_DEBUG=0 WORKING_DIRECTORY ${CURRENT_DIR})
			ENDIF()
		ENDIF()
	ENDIF()
	
	## double check that the missing libs were built
	FOREACH(the_lib ${LIBLIST})
		IF(NOT EXISTS ${the_lib})
			MESSAGE(FATAL_ERROR "\n\n\n********************************************\nFAILED to find: ${the_lib} \n********************************************")
			MESSAGE(FATAL_ERROR " ")
		ENDIF()
	ENDFOREACH()
	DKSET(CMAKE_FILE "") ##Linux cache file fix
ENDFOREACH()

## Create the DKPlugins.h header file
IF(PLUGINS_FILE)
STRING(REPLACE "#include \"DKWindow.h\"" "" PLUGINS_FILE ${PLUGINS_FILE})
STRING(REPLACE "\\n" "\n" PLUGINS_FILE ${PLUGINS_FILE})
FILE(WRITE ${DKPROJECT}/DKPlugins.h ${PLUGINS_FILE})
ENDIF()
	



MESSAGE("\n")
MESSAGE("***************************************")
MESSAGE("********** Creating ${AppName} **********")
MESSAGE("***************************************\n")

############################################################
###  TODO: Prep the app data files and assets 
############################################################

#copy digitalknob/DKPlugins/_DKIMPORT/CMakeLists.txt to app path.
MESSAGE("Copying DKPlugins/_DKIMPORT/ to App...")

## copy recursivly without overwrite
DKCOPY(${DKPLUGINS}/_DKIMPORT ${DKPROJECT} FALSE)

### Include all source files from the app folder
FILE(GLOB App_SRC 
	${DKPROJECT}/*.h
	${DKPROJECT}/*.c
	${DKPROJECT}/*.cpp
	${DKPROJECT}/*.rc
	${DKPROJECT}/icons/windows/*.rc)


#IF(USE_OPENGL2)
#	DKSET(EXECUTABLE_OUTPUT_PATH ${DKPROJECT}/${OS}-GL2)
#ELSE()
#	DKSET(EXECUTABLE_OUTPUT_PATH ${DKPROJECT}/${OS})
#ENDIF()

ADD_DEFINITIONS(-DDKAPP) #TODO - phase this out
INCLUDE_DIRECTORIES(${DKPROJECT})

##########
IF(WIN_32)
	MESSAGE("\n")
	MESSAGE("#### LIBRARIES #####")
	MESSAGE("${RELEASE_LIBS}")
	MESSAGE("\n")
	
	# copy the icon
	DKCOPY(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE)
	
	# backup files not going in the package
	DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	DKCOPY(${DKPROJECT}/assets/DKCef/win32Debug ${DKPROJECT}/Backup/DKCef/win32Debug TRUE)
	DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
	DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
	# remove files before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
	DKREMOVE(${DKPROJECT}/assets/DKCef/win32Debug)
	DKREMOVE(${DKPROJECT}/assets/cef.log)
	DKREMOVE(${DKPROJECT}/assets/log.txt)
	
	DKZIP(${DKPROJECT}/assets) #zip the assets
	
	DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ TRUE) #put everything back from backup
	DKREMOVE(${DKPROJECT}/Backup)
	
	LIST(APPEND WIN_LIBS 
		kernel32.lib
		user32.lib
		gdi32.lib
		winspool.lib
		shell32.lib
		ole32.lib
		oleaut32.lib
		uuid.lib
		comdlg32.lib
		advapi32.lib
		odbc32.lib
		odbccp32.lib
		opengl32.lib
		DbgHelp.lib
	)

	ADD_DEFINITIONS(-D_USING_V110_SDK71_)
	ADD_EXECUTABLE(${AppName} WIN32 ${App_SRC})
	TARGET_LINK_LIBRARIES(${AppName} ${DEBUG_LIBS} ${RELEASE_LIBS} ${WIN_LIBS})
	##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
	
	LIST(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
	LIST(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
	LIST(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
	LIST(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	LIST(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)
	STRING(REPLACE ";" " " DEBUG_FLAGS "${DEBUG_LINK_FLAGS}")
	
	##LIST(APPEND RELEASE_LINK_FLAGS /FORCE) ## MySQL lib needs /FORCE due to zlib redefinitions
	LIST(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
	LIST(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
	LIST(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
	LIST(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
	LIST(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
	LIST(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	LIST(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
	STRING(REPLACE ";" " " RELEASE_FLAGS "${RELEASE_LINK_FLAGS}")
	
	SET_TARGET_PROPERTIES(${AppName} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
ENDIF(WIN_32)
	
##########
IF(WIN_64)
	MESSAGE("\n")
	MESSAGE("#### LIBRARIES #####")
	MESSAGE("${RELEASE_LIBS}")
	MESSAGE("\n")
	
	# copy the icon
	DKCOPY(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE)
	
	# backup files not going in the package
	DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	DKCOPY(${DKPROJECT}/assets/DKCef/win64Debug ${DKPROJECT}/Backup/DKCef/win64Debug TRUE)
	DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
	DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
	# remove files before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
	DKREMOVE(${DKPROJECT}/assets/DKCef/win64Debug)
	DKREMOVE(${DKPROJECT}/assets/cef.log)
	DKREMOVE(${DKPROJECT}/assets/log.txt)
	
	DKZIP(${DKPROJECT}/assets) #zip the assets
	
	DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ TRUE) #put everything back from backup
	DKREMOVE(${DKPROJECT}/Backup)
	
	LIST(APPEND WIN_LIBS 
		kernel32.lib
		user32.lib
		gdi32.lib
		winspool.lib
		shell32.lib
		ole32.lib
		oleaut32.lib
		uuid.lib
		comdlg32.lib
		advapi32.lib
		odbc32.lib
		odbccp32.lib
		opengl32.lib
		DbgHelp.lib
	)
	
	ADD_EXECUTABLE(${AppName}_64 WIN32 ${App_SRC})
	TARGET_LINK_LIBRARIES(${AppName}_64 ${DEBUG_LIBS} ${RELEASE_LIBS} ${WIN_LIBS})
	##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
	
	LIST(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
	LIST(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
	LIST(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
	LIST(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	LIST(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)
	STRING(REPLACE ";" " " DEBUG_FLAGS "${DEBUG_LINK_FLAGS}")
	
	##LIST(APPEND RELEASE_LINK_FLAGS /FORCE) ## MySQL lib needs /FORCE due to zlib redefinitions
	LIST(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
	LIST(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
	LIST(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
	LIST(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
	LIST(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
	LIST(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	LIST(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
	STRING(REPLACE ";" " " RELEASE_FLAGS "${RELEASE_LINK_FLAGS}")
	
	SET_TARGET_PROPERTIES(${AppName}_64 PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
ENDIF(WIN_64)

#######
IF(MAC)
	MESSAGE("\n")
	MESSAGE("#### LIBRARIES #####")
	MESSAGE("${RELEASE_LIBS}")
	MESSAGE("\n")
	
	## copy assets
	IF(DEBUG)
		DKREMOVE(${DKPROJECT}/assets/USER)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/Debug/${AppName}.app/Contents/Resources)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/Debug/${AppName}.app/Contents/Resources TRUE)
		DKCOPY(${DKPROJECT}/icons/mac/logo.icns ${DKPROJECT}/${OS}/Debug/${AppName}.app/Contents/Resources/logo.icns TRUE)
	ENDIF()
	IF(RELEASE)
		DKREMOVE(${DKPROJECT}/assets/USER)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/Release/${AppName}.app/Contents/Resources)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/Release/${AppName}.app/Contents/Resources TRUE)
		DKCOPY(${DKPROJECT}/icons/mac/logo.icns ${DKPROJECT}/${OS}/Release/${AppName}.app/Contents/Resources/logo.icns TRUE)
	ENDIF()
	
	FIND_LIBRARY(CF CoreFoundation)
	FIND_LIBRARY(CO Cocoa)
	FIND_LIBRARY(CB Carbon)
	FIND_LIBRARY(AT AudioToolbox)
	FIND_LIBRARY(AU AudioUnit)
	FIND_LIBRARY(CA CoreAudio)
	FIND_LIBRARY(CV CoreVideo)
	FIND_LIBRARY(IO IOKit)
	FIND_LIBRARY(GL OpenGL)
	FIND_LIBRARY(FF ForceFeedback)
	FIND_LIBRARY(AK AppKit)
	
	LIST(APPEND DEBUG_LIBS ${CF} ${CO} ${CB} ${AT} ${AU} ${CV} ${CA} ${IO} ${GL} ${FF} ${AK})
	LIST(APPEND RELEASE_LIBS ${CF} ${CO} ${CB} ${AT} ${AU} ${CV} ${CA} ${IO} ${GL} ${FF} ${AK})
	
	SET(CMAKE_OSX_ARCHITECTURES "x86_64")
	ADD_EXECUTABLE(${AppName} MACOSX_BUNDLE ${App_SRC})
	TARGET_LINK_LIBRARIES(${AppName} ${DEBUG_LIBS} ${RELEASE_LIBS})
	
	DKUPDATE_INFO_PLIST(${AppName}) #this may need to be run at post build
ENDIF()

#######
IF(IOS)
	## copy assets
	DKREMOVE(${DKPROJECT}/assets/USER)
	IF(DEBUG)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/${DEBUG}/${AppName}.app/assets)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG}/${AppName}.app/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${DEBUG}/${AppName}.app TRUE)
	ENDIF()
	IF(RELEASE)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/${RELEASE}/${AppName}.app/assets)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE}/${AppName}.app/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${RELEASE}/${AppName}.app TRUE)
	ENDIF()

	### FrameWorks ###
	SET(IOS_FRAMEWORKS
		Foundation
		AudioToolbox
		CoreGraphics
	   	QuartzCore
		UIKit
	    OpenGLES
		ImageIO
		MobileCoreServices
	)
	
	LIST(APPEND App_SRC ${DKPLUGINS}/DK/DKiPhone.mm)
	
	FOREACH(FW ${IOS_FRAMEWORKS})
		SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
	ENDFOREACH()
	
	#LIST(APPEND DEBUG_LIBS ${CF} ${CO} ${CB} ${AT} ${AU} ${CA} ${IO} ${GL} ${FF})
	#LIST(APPEND RELEASE_LIBS ${CF} ${CO} ${CB} ${AT} ${AU} ${CA} ${IO} ${GL} ${FF})
	
	#SET(CMAKE_OSX_SYSROOT iphoneos)
	#SET(XCODE_ATTRIBUTE_SDKROOT iphoneos)
	#SET(CMAKE_OSK_ARCHITECTURES "$(ARCHS_STANDARD_32_BIT)")
	SET(CMAKE_CXX_FLAGS "-x objective-c++")
	#SET(CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT dwarf)
	#SET(MACOSX_BUNDLE_GUI_IDENTIFIER "com.digitalknob.\${PRODUCT_NAME:identifier}")
		
	### App ###
	#GET_TARGET_PROPERTY(MyExecutable_PATH ${AppName} LOCATION)
	ADD_EXECUTABLE(${AppName} MACOSX_BUNDLE ${App_SRC})
	TARGET_LINK_LIBRARIES(${AppName} ${DEBUG_LIBS} ${RELEASE_LIBS})
	
	DKUPDATE_INFO_PLIST(${AppName}) #this may need to be run at post build
ENDIF()

##########
IF(IOSSIM)
	## copy assets
	DKREMOVE(${DKPROJECT}/assets/USER)
	IF(DEBUG)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/${DEBUG}/${AppName}.app/assets)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG}/${AppName}.app/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${DEBUG}/${AppName}.app TRUE)
	ENDIF()
	IF(RELEASE)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/${RELEASE}/${AppName}.app/assets)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE}/${AppName}.app/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${RELEASE}/${AppName}.app TRUE)
	ENDIF()
	
	### FrameWorks ###
	SET(IOS_FRAMEWORKS
		Foundation
		AudioToolbox
		CoreGraphics
	   	QuartzCore
		UIKit
	    OpenGLES
		ImageIO
		MobileCoreServices
	)
	
	LIST(APPEND App_SRC ${DKPLUGINS}/DK/DKiPhone.mm)
	
	FOREACH(FW ${IOS_FRAMEWORKS})
		SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
	ENDFOREACH()
	
	##LIST(APPEND DEBUG_LIBS ${CF} ${CO} ${CB} ${AT} ${AU} ${CA} ${IO} ${GL} ${FF})
	##LIST(APPEND RELEASE_LIBS ${CF} ${CO} ${CB} ${AT} ${AU} ${CA} ${IO} ${GL} ${FF})
	
	##SET(CMAKE_OSX_SYSROOT iphoneos)
	##SET(XCODE_ATTRIBUTE_SDKROOT iphoneos)
	##SET(CMAKE_OSX_ARCHITECTURES "$(ARCHS_STANDARD_32_BIT)")
	SET(CMAKE_CXX_FLAGS "-x objective-c++")
    SET(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libstdc++")
	##SET(CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT dwarf)
	##SET(MACOSX_BUNDLE_GUI_IDENTIFIER "com.digitalknob.\${PRODUCT_NAME:identifier}")
	
	### App ###
	#GET_TARGET_PROPERTY(MyExecutable_PATH ${AppName} LOCATION)
	ADD_EXECUTABLE(${AppName} MACOSX_BUNDLE ${App_SRC})
	TARGET_LINK_LIBRARIES(${AppName} ${DEBUG_LIBS} ${RELEASE_LIBS})
	
	DKUPDATE_INFO_PLIST(${AppName}) #this may need to be run at post build
ENDIF()

#########
IF(LINUX)
IF(NOT RASPBERRY)
	### copy assets
	DKREMOVE(${DKPROJECT}/assets/USER)
	IF(DEBUG)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/Debug/${AppName}-Data)
		DKCOPY(${DKPROJECT}/assets ${DKPROJECT}/${OS}/Debug/${AppName}-Data TRUE)
	ENDIF()
	IF(RELEASE)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/Release/${AppName}-Data)
		DKCOPY(${DKPROJECT}/assets ${DKPROJECT}/${OS}/Release/${AppName}-Data TRUE)
	ENDIF()
		

	FIND_PACKAGE(OpenGL REQUIRED)
	INCLUDE_DIRECTORIES(${OpenGL_INCLUDE_DIRS})
	LINK_DIRECTORIES(${OpenGL_LIBRARY_DIRS})
	ADD_DEFINITIONS(${OpenGL_DEFINITIONS})
	IF(NOT OPENGL_FOUND)
    	MESSAGE(ERROR " OPENGL not found!")
	ENDIF()
	
	LIST(APPEND DEBUG_LIBS ${OPENGL_LIBRARIES})
	LIST(APPEND RELEASE_LIBS ${OPENGL_LIBRARIES})
	LIST(APPEND DEBUG_LIBS pthread)
	LIST(APPEND RELEASE_LIBS pthread)
	LIST(APPEND DEBUG_LIBS dl)
	LIST(APPEND RELEASE_LIBS dl)
	
	## For Raspberry Pi
	##LINK_DIRECTORIES(/opt/vc/lib)
	##LIST(APPEND DEBUG_LIBS bcm_host)
	##LIST(APPEND RELEASE_LIBS bcm_host)
	
	SET(CMAKE_CXX_FLAGS "-g -std=c++14 -no-pie")
	ADD_EXECUTABLE(${AppName} ${App_SRC})
	
	IF(DEBUG)
		ADD_DEFINITIONS(-DDEBUG)
		TARGET_LINK_LIBRARIES(${AppName} ${DEBUG_LIBS})
	ELSE()
		TARGET_LINK_LIBRARIES(${AppName} ${RELEASE_LIBS})
	ENDIF()
ENDIF()
ENDIF()

###########
IF(ANDROID)
	MESSAGE("\n")
	MESSAGE("#### LIBRARIES #####")
	MESSAGE("${DKLIBRARIES}")
	MESSAGE("\n")

	#copy android files from DKPlugins/_DKIMPORT
	DKREMOVE(${DKPROJECT}/android32/Debug/CMakeCache.txt)
	DKREMOVE(${DKPROJECT}/android32/Release/CMakeCache.txt)
	DKREMOVE(${DKPROJECT}/android64/Debug/CMakeCache.txt)
	DKREMOVE(${DKPROJECT}/android64/Release/CMakeCache.txt)
	
	#copy assets
	DKREMOVE(${DKPROJECT}/assets/USER)
	IF(DEBUG)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG}/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/android/ ${DKPROJECT}/${OS}/${DEBUG}/res TRUE)
	ENDIF()
	IF(RELEASE)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE}/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/android/ ${DKPROJECT}/${OS}/${RELEASE}/res TRUE)
	ENDIF()
	
	##TODO - split Debug and Release 
	
	#update app name
	DKUPDATE_ANDROID_NAME(${AppName})
	
	MESSAGE("Creating Android.mk file for ${AppName}....")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_PATH := $(call my-dir)\n")
	IF(SDL)
		MESSAGE("USING SDL FOR ANDROID")
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(CLEAR_VARS)\n")
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_MODULE := SDL2\n")
	IF(DEBUG)
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := ${SDL}/${OS}/${DEBUG}/obj/local/armeabi-v7a/libSDL2.so\n")
	ENDIF()
	IF(RELEASE)
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := ${SDL}/${OS}/${RELEASE}/obj/local/armeabi-v7a/libSDL2.so\n")
	ENDIF()
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(PREBUILT_SHARED_LIBRARY)\n")
	ENDIF()
	
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(CLEAR_VARS)\n")
	IF(DEBUG)
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "BUILD_TYPE := Debug\n\n")
	ENDIF()
	IF(RELEASE)
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "BUILD_TYPE := Release\n\n")
	ENDIF()
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_MODULE := DKAndroid\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "SRC_DIR := $(LOCAL_PATH)/../../..\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "DK_DIR := C:/digitalknob\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "NDKLIBDIR := ${ANDROID_NDK}/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi-v7a\n")
	##DKSET(ANDROID_APPMK ${ANDROID_APPMK} "NDKLIBDIR := ${3RDPARTY}/android-ndk-r10d/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi-v7a\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "DKPLUGINS := $(DK_DIR)/DKPlugins\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "3RDPARTY := $(DKPLUGINS)/3rdParty\n\n")

	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES := $(LOCAL_PATH)\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES += $(SRC_DIR)\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CFLAGS := -fno-short-enums -fpermissive -fuse-ld=bfd\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv1_CM -lz -landroid\n")
	#IF(OPENGL2)
	#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv2 -lz\n")
	#ELSE()
	#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv1_CM -lz\n")
	#ENDIF()
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "APP_SRC := $(wildcard $(SRC_DIR)/*.cpp)\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "APP_SRC += $(wildcard $(SRC_DIR)/*.c)\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := $(APP_SRC:$(LOCAL_PATH)/%=%)\n\n")

	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS := -DANDROID\n")
	IF(ANDROID_32)
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DANDROID32\n")
	ENDIF()
	IF(ANDROID_64)
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DANDROID64\n")
	ENDIF()
	#DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -D__ANDROID__\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DDKAPP\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "ifeq ($(BUILD_TYPE),Debug)\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_CPPFLAGS += -DDEBUG\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "else\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_CPPFLAGS += -DNDEBUG\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "endif\n")

	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LIBDIR := $(BUILD_TYPE)/obj/local/armeabi\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_ARM_NEON := true\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LIBDIR := $(BUILD_TYPE)/obj/local/armeabi-v7a\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "endif\n\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDFLAGS :=\n\n")
	
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} ${DKDEFINES})
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES += ${DKPLUGINS}\n")
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} ${DKINCLUDES})
	#LIST(REVERSE DKLIBRARIES)
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} ${DKLIBRARIES})
			
	IF(SDL)
		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SHARED_LIBRARIES := SDL2\n")
	ENDIF()
	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(BUILD_SHARED_LIBRARY)\n\n")
	
	IF(DEBUG)
		FILE(WRITE ${DKPROJECT}/${OS}/${DEBUG}/jni/Android.mk ${ANDROID_APPMK})
	ENDIF()
	IF(RELEASE)
		FILE(WRITE ${DKPROJECT}/${OS}/${RELEASE}/jni/Android.mk ${ANDROID_APPMK})
	ENDIF()
ENDIF()

#########
IF(RASPBERRY)
	### copy assets
	DKREMOVE(${DKPROJECT}/assets/USER)
	IF(DEBUG)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/Debug/${AppName}-Data)
		DKCOPY(${DKPROJECT}/assets ${DKPROJECT}/${OS}/Debug/${AppName}-Data TRUE)
	ENDIF()
	IF(RELEASE)
		FILE(MAKE_DIRECTORY ${DKPROJECT}/${OS}/Release/${AppName}-Data)
		DKCOPY(${DKPROJECT}/assets ${DKPROJECT}/${OS}/Release/${AppName}-Data TRUE)
	ENDIF()
	
	FIND_PACKAGE(OpenGL REQUIRED)
	INCLUDE_DIRECTORIES(${OpenGL_INCLUDE_DIRS})
	LINK_DIRECTORIES(${OpenGL_LIBRARY_DIRS})
	ADD_DEFINITIONS(${OpenGL_DEFINITIONS})
	IF(NOT OPENGL_FOUND)
    	    MESSAGE(ERROR " OPENGL not found!")
	ENDIF()
	
	LIST(APPEND DEBUG_LIBS ${OPENGL_LIBRARIES})
	LIST(APPEND RELEASE_LIBS ${OPENGL_LIBRARIES})
	LIST(APPEND DEBUG_LIBS pthread)
	LIST(APPEND RELEASE_LIBS pthread)
	LIST(APPEND DEBUG_LIBS dl)
	LIST(APPEND RELEASE_LIBS dl)
	
	## For Raspberry Pi
	LINK_DIRECTORIES(/opt/vc/lib)
	LIST(APPEND DEBUG_LIBS bcm_host)
	LIST(APPEND RELEASE_LIBS bcm_host)
	
	SET(CMAKE_CXX_FLAGS "-g -std=c++14 -no-pie")
	ADD_EXECUTABLE(${AppName} ${App_SRC})
	
	IF(DEBUG)
		ADD_DEFINITIONS(-DDEBUG)
		TARGET_LINK_LIBRARIES(${AppName} ${DEBUG_LIBS})
	ELSE()
		TARGET_LINK_LIBRARIES(${AppName} ${RELEASE_LIBS})
	ENDIF()
ENDIF()


MESSAGE("\n")
MESSAGE("***************************************")
MESSAGE("********** Finnished ${AppName} **********")
MESSAGE("***************************************\n")


#clean these cached variables
DKSET(DKDEFINES "")
DKSET(DKINCLUDES "")
DKSET(DKLIBRARIES "")
