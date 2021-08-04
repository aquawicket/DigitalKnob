if(DK_OPTIONS_INCLUDED)
  return()
endif()
set(DK_OPTIONS_INCLUDED true)

if(COMMAND cmake_policy)
	CMAKE_POLICY(SET CMP0003 NEW) ##https://cmake.org/cmake/help/latest/policy/CMP0003.html
endif(COMMAND cmake_policy)

###########################################################################
## Get variables for Build Type
###########################################################################
option(DEBUG "Build Debug Output" OFF)
option(RELEASE "Build Release Output" OFF)
if(NOT DEBUG)
if(NOT RELEASE)
	message(FATAL_ERROR "Please select Debug or Release mode")
endif()
endif()

###########################################################################
## Get variables for Build Level
###########################################################################
option(BUILD "Simpily build the app or library" OFF)
option(REBUILD "Rebuild the app" OFF)
option(REBUILDALL "Rebuild the app and all dependencies" OFF)
if(NOT BUILD)
if(NOT REBUILD)
if(NOT REBUILDALL)
	message(FATAL_ERROR "Please select Build, Rebuild, or Rebuild All")
endif()
endif()
endif()


###########################################################################
## Get variables for Library Build Type (STATIC or SHARED)
###########################################################################
option(STATIC "Build Static Libraries and Plugins" OFF)
option(SHARED "Build SHARED Libraries and Plugins" OFF)
if(NOT STATIC)
if(NOT SHARED)
	DKSET(STATIC ON)
	##message(FATAL_ERROR "Please select STATIC or SHARED build.")
endif()
endif()	



#########################################################################
## Set variables for paths
###############################################################
get_filename_component(DIGITALKNOB ${CMAKE_SOURCE_DIR} ABSOLUTE)
#DKSETENV("DIGITALKNOB" ${DIGITALKNOB})
DKSET(DKCMAKE ${DIGITALKNOB}/DKCMake)
DKSET(DKPLUGINS ${DIGITALKNOB}/DKPlugins)
DKSET(3RDPARTY ${DIGITALKNOB}/3rdParty)
DKSET(DKIMPORTS ${3RDPARTY}/_DKIMPORTS)
DKSET(DKDOWNLOAD ${DIGITALKNOB}/Download)
DKSET(DKWEB http://127.0.0.1)



########### Determine the OS we are building for ####################
# Windows 32
string(FIND "${CMAKE_BINARY_DIR}" "/win32" index)
if(${index} GREATER -1)
	message(STATUS "Creating Windows x32 Project Files")
	string(REPLACE "/win32" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(WIN_32 ON)
	DKSET(WIN ON)
	DKSET(OS win32)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DWIN32)
	add_definitions(-D_WINDOWS)
endif()

# Windows 64
string(FIND "${CMAKE_BINARY_DIR}" "/win64" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating Windows x64 Project Files ***")
	string(REPLACE "/win64" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(WIN_64 ON)
	DKSET(WIN ON)
	DKSET(OS win64)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DWIN32)
	add_definitions(-DWIN64)
	add_definitions(-D_WINDOWS)
endif()

# MacOs 32
string(FIND "${CMAKE_BINARY_DIR}" "/mac32" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating Mac x32 Project Files ***")
	string(REPLACE "/mac32" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(MAC_32 ON)
	DKSET(MAC ON)
	DKSET(OS mac32)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DMAC32)
	add_definitions(-DMAC)
	include_directories(/usr/X11/include)
endif()

# MacOs 64
string(FIND "${CMAKE_BINARY_DIR}" "/mac64" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating Mac x64 Project Files ***")
	string(REPLACE "/mac64" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(MAC_64 ON)	
	DKSET(MAC ON)
	DKSET(OS mac64)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DMAC64)
	add_definitions(-DMAC)
	include_directories(/usr/X11/include)
endif()

# Linux 32
string(FIND "${CMAKE_BINARY_DIR}" "/linux32" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating Linux x32 Project Files ***")
	string(REPLACE "/linux32" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(LINUX_32 ON)
	DKSET(LINUX ON)
	DKSET(OS linux32)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_C_FLAGS "-m32")
	DKSET(CMAKE_CXX_FLAGS "-m32")
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DLINUX32)
	add_definitions(-DLINUX)
	include_directories(/usr/X11/include)
endif()

# Linux 64
string(FIND "${CMAKE_BINARY_DIR}" "/linux64" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating Linux x64 Project Files ***")
	string(REPLACE "/linux64" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(LINUX_64 ON)
	DKSET(LINUX ON)
	DKSET(OS linux64)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_C_FLAGS "-m64")
	DKSET(CMAKE_CXX_FLAGS "-m64")
	DKSET(OpenGL_GL_PREFERENCE "GLVND")
	#DKSET(CMAKE_SKIP_RPATH ON)
	set(CMAKE_SKIP_BUILD_RPATH  FALSE)
	set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) 
	set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/")
	set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
	list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/" isSystemDir)
	if("${isSystemDir}" STREQUAL "-1")
		set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/")
	endif("${isSystemDir}" STREQUAL "-1")
	add_definitions(-DLINUX64)
	add_definitions(-DLINUX)
	include_directories(/usr/X11/include)
endif()

# iOS 32
string(FIND "${CMAKE_BINARY_DIR}" "/ios32" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating iOS x32 Project Files ***")
	string(REPLACE "/ios32" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(IOS_32 ON)
	DKSET(IOS ON)
	DKSET(OS ios32)
	DKSET(DEBUG_DIR Debug-iphoneos)
	DKSET(RELEASE_DIR Release-iphoneos)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DIOS32)
	add_definitions(-DIOS)
	include_directories(/usr/X11/include)
	list(APPEND App_SRC ${PATH_PLUGINS}/DK/DKiPhone.mm)
endif()

# iOS 64
string(FIND "${CMAKE_BINARY_DIR}" "/ios64" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating iOS x64 Project Files ***")
	string(REPLACE "/ios64" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(IOS_64 ON)
	DKSET(IOS ON)
	DKSET(OS ios64)
	DKSET(DEBUG_DIR Debug-iphoneos)
	DKSET(RELEASE_DIR Release-iphoneos)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DIOS64)
	add_definitions(-DIOS)
	include_directories(/usr/X11/include)
	list(APPEND App_SRC ${PATH_PLUGINS}/DK/DKiPhone.mm)
endif()

# iOS Simulator 32
string(FIND "${CMAKE_BINARY_DIR}" "/iossim32" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating iOS-Simulator x32 Project Files ***")
	string(REPLACE "/iossim32" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(IOSSIM_32 ON)
	DKSET(IOSSIM ON)
	DKSET(OS iossim32)
	DKSET(DEBUG_DIR Debug-iphonesimulator)
	DKSET(RELEASE_DIR Release-iphonesimulator)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DIOS32)
	add_definitions(-DIOS)
	add_definitions(-DIOSSIM32)
	add_definitions(-DIOSSIM)
	include_directories(/usr/X11/include)
	list(APPEND App_SRC ${PATH_PLUGINS}/DK/DKiPhone.mm)
	DKSET(CMAKE_OSX_SYSROOT iphoneos)
endif()

# iOS Simulator 64
string(FIND "${CMAKE_BINARY_DIR}" "/iossim64" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating iOS-Simulator x64 Project Files ***")
	string(REPLACE "/iossim64" "" DKPROJECT ${CMAKE_BINARY_DIR})
	set(IOSSIM_64 ON)
	DKSET(IOSSIM ON)
	DKSET(OS iossim64)
	DKSET(DEBUG_DIR Debug-iphonesimulator)
	DKSET(RELEASE_DIR Release-iphonesimulator)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DIOS64)
	add_definitions(-DIOS)
	add_definitions(-DIOSSIM64)
	add_definitions(-DIOSSIM)
	include_directories(/usr/X11/include)
	list(APPEND App_SRC ${PATH_PLUGINS}/DK/DKiPhone.mm)
	DKSET(CMAKE_OSX_SYSROOT iphoneos)
	#DKSET(FLAGS -DIOSSIM)
endif()

# Raspberry Pi 32
string(FIND "${CMAKE_BINARY_DIR}" "/raspberry32" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating RASPBERRY x32 Project Files ***")
	string(REPLACE "/raspberry32" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(RASPBERRY_32 ON)
	DKSET(RASPBERRY ON)
	DKSET(OS raspberry32)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_C_FLAGS "-m32")
	DKSET(CMAKE_CXX_FLAGS "-m32")
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DRASPBERRY32)
	add_definitions(-DRASPBERRY)
	add_definitions(-DLINUX32) #FIXME - not all Raspberry OS's are Linux
	add_definitions(-DLINUX) #FIXME
	include_directories(/usr/X11/include)
endif()

# Raspberry Pi 64
string(FIND "${CMAKE_BINARY_DIR}" "/raspberry64" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating Raspberry x64 Project Files ***")
	string(REPLACE "/raspberry64" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(RASPBERRY_64 ON)
	DKSET(RASPBERRY ON)
	DKSET(OS raspberry64)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_C_FLAGS "-m64")
	DKSET(CMAKE_CXX_FLAGS "-m64")
	#DKSET(CMAKE_SKIP_RPATH ON)
	set(CMAKE_SKIP_BUILD_RPATH  FALSE)
	set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) 
	set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/")
	set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
	list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/" isSystemDir)
	if("${isSystemDir}" STREQUAL "-1")
		set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/")
	endif("${isSystemDir}" STREQUAL "-1")
	add_definitions(-DRASPBERRY64)
	add_definitions(-DRASPBERRY)
	add_definitions(-DLINUX64) #FIXME - not all Raspberry OS's are Linux
	add_definitions(-DLINUX) #FIXME
	include_directories(/usr/X11/include)
endif()

# Android 32
string(FIND "${CMAKE_BINARY_DIR}" "/android32" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating Android x32 Project Files ***")
	string(REPLACE "/android32" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(ANDROID_32 ON)
	DKSET(ANDROID ON)
	DKSET(OS android32)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DANDROID32)
	add_definitions(-DANDROID)
endif()

# Android 64
string(FIND "${CMAKE_BINARY_DIR}" "/android64" index)
if(${index} GREATER -1)
	message(STATUS "*** Creating Android x64 Project Files ***")
	string(REPLACE "/android64" "" DKPROJECT ${CMAKE_BINARY_DIR})
	DKSET(ANDROID_64 ON)
	DKSET(ANDROID ON)
	DKSET(OS android64)
	DKSET(DEBUG_DIR Debug)
	DKSET(RELEASE_DIR Release)
	DKSET(CMAKE_SKIP_RPATH ON)
	add_definitions(-DANDROID64)
	add_definitions(-DANDROID)
endif()

## we use /Debug and /Release folders for Linux, Android and Raspberry
## If we are calling cmake from one of those folders, remove them and let DEBUG and RELEASE flags deal with that later.
string(REPLACE "/Debug" "" DKPROJECT ${DKPROJECT})
string(REPLACE "/Release" "" DKPROJECT ${DKPROJECT})

if(NOT OS)
	message(STATUS "EXAMPLE: digitalknob/DKApps/MyApp/win32")
	message(FATAL_ERROR "The binary directory must contain an os folder. Valid folders are win32, win64, mac32, mac64, linux32, linux64, ios32, ios64, iossim32, iossim64, raspberry32, raspberry64, android32, android64")
	#DKREMOVE(${CMAKE_BINARY_DIR})
endif()



###########################################################################
## Set variables for Generator
###########################################################################
##### Microsoft Visual Studio 2019 #####
if(CMAKE_GENERATOR STREQUAL "Visual Studio 16 2019")
	DKSET(CMAKE_COMMAND C:/Progra~2/CMake/bin/cmake.exe) #deprecated
	DKSET(CMAKE_EXE C:/Progra~2/CMake/bin/cmake.exe)
	if(WIN)
		##DKSET(CMAKE_CXX_FLAGS "/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /Yustdafx.h /Zm500 /D_WIN32_WINNT=0x0600") #precompiled headers
		DKSET(CMAKE_CXX_FLAGS "/W3 /nologo /GR /EHsc /Zm500 /D_WIN32_WINNT=0x0600 /D_USING_V110_SDK71_")
		
		#DKSET(CMAKE_C_FLAGS "/DWIN32 /D_WINDOWS /W3 /std:c11 /nologo /GR /EHsc /Zm500 /D_WIN32_WINNT=0x0600 /D_USING_V110_SDK71_")
		#DKSET(CMAKE_CXX_FLAGS "/DWIN32 /D_WINDOWS /W3 /std:c11 /std:c++17 /nologo /GR /EHsc /Zm500 /D_WIN32_WINNT=0x0600 /D_USING_V110_SDK71_")
		if(STATIC)
			DKSET(CMAKE_CXX_FLAGS_DEBUG "/MTd /Od /Ob0 /Zi /RTC1")
			DKSET(CMAKE_CXX_FLAGS_RELEASE "/MT /O2 /Ob2")
			
			#DKSET(CMAKE_C_FLAGS_DEBUG "/MTd /Od /Ob0 /Zi /RTC1 /D_ITERATOR_DEBUG_LEVEL=2 /DDEBUG /D_DEBUG")
			#DKSET(CMAKE_C_FLAGS_RELEASE "/MT /O2 /Ob2 /D_ITERATOR_DEBUG_LEVEL=0 /DNDEBUG")
			#DKSET(CMAKE_CXX_FLAGS_DEBUG "/MTd /Od /Ob0 /Zi /RTC1 /D_ITERATOR_DEBUG_LEVEL=2 /DDEBUG /D_DEBUG")
			#DKSET(CMAKE_CXX_FLAGS_RELEASE "/MT /O2 /Ob2 /D_ITERATOR_DEBUG_LEVEL=0 /DNDEBUG")
		elseif(SHARED)
			#DKSET(CMAKE_CXX_FLAGS_DEBUG "/MDd /Od /Ob0 /Zi /RTC1 /D_ITERATOR_DEBUG_LEVEL=2")
			#DKSET(CMAKE_CXX_FLAGS_RELEASE "/MD /O2 /Ob2 /D_ITERATOR_DEBUG_LEVEL=0")	
		endif()
		DKSET(FLAGS "/W3 /nologo /Zm500 /EHsc /GR /D_WIN32_WINNT=0x0600 /D_USING_V110_SDK71_ /Zc:__cplusplus $<$<CONFIG:Debug>:/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MT /O2 /Ob2 /DNDEBUG>")
		
		#DKSET(FLAGS "/DWIN32 /D_WINDOWS /W3 /std:c++17 /nologo /GR /EHsc /Zm500 /D_WIN32_WINNT=0x0600 /D_USING_V110_SDK71_ /Zc:__cplusplus
		#$<$<CONFIG:Debug>:/MTd /Od /Ob0 /Zi /RTC1 /D_ITERATOR_DEBUG_LEVEL=2 /DDEBUG /D_DEBUG>
		#$<$<CONFIG:Release>:/MT /O2 /Ob2 /D_ITERATOR_DEBUG_LEVEL=0 /DNDEBUG>")
	endif()
	if(ANDROID)
		## https://stackoverflow.com/a/38057807/688352
		if(STATIC)
			#DKSET(CMAKE_CXX_FLAGS_DEBUG "-frtti -fexceptions")
			#DKSET(CMAKE_CXX_FLAGS_RELEASE "-frtti -fexceptions")
		endif()
		if(SHARED)
			#TODO
		endif()
	endif()
endif()

##### Microsoft Visual Studio 2019 Win64 #####
if(CMAKE_GENERATOR STREQUAL "Visual Studio 16 2019 Win64")
	DKSET(CMAKE_COMMAND C:/Progra~2/CMake/bin/cmake.exe) #deprecated
	DKSET(CMAKE_EXE C:/Progra~2/CMake/bin/cmake.exe)
	##DKSET(CMAKE_CXX_FLAGS "/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /Yustdafx.h /Zm500 /D_WIN32_WINNT=0x0600") #precompiled headers
	DKSET(CMAKE_CXX_FLAGS "/DWIN32 /DWIN64 /D_WINDOWS /W3 /nologo /GR /EHsc /Zm500 /D_WIN32_WINNT=0x0600")
	DKSET(CMAKE_CXX_FLAGS_DEBUG "/MTd /Od /Ob0 /Zi /RTC1")
	DKSET(CMAKE_CXX_FLAGS_RELEASE "/MT /O2 /Ob2")
	DKSET(FLAGS "/DWIN64 /W3 /nologo /Zm500 /EHsc /GR /D_WIN32_WINNT=0x0600 /Zc:__cplusplus $<$<CONFIG:Debug>:/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MT /O2 /Ob2 /DNDEBUG>")
endif()

##### Apple Xcode #####
if(CMAKE_GENERATOR STREQUAL "Xcode")
	DKSET(CMAKE_CXX_FLAGS "-x objective-c++")
endif()

##### Unix Makefiles #####
if(CMAKE_GENERATOR STREQUAL "Unix Makefiles")
	DKSET(CMAKE_C_FLAGS "-fPIC")
	DKSET(CMAKE_CXX_FLAGS "-fPIC")
endif()

if(DEBUG)
	DKSET(CMAKE_BUILD_TYPE DEBUG)
	add_definitions(-DDEBUG)
	add_definitions(-D_DEBUG)
endif()
if(RELEASE)
	DKSET(CMAKE_BUILD_TYPE RELEASE)
	add_definitions(-DNDEBUG)
endif(RELEASE)





## NOTE: These defines should be done as per needed in DKMAKE.cmake files
option(OPENGL2 "Set the OpenGL Version" OFF)
if(OPENGL2)
	add_definitions(-DOPENGL2)
	add_definitions(-DUSE_SHADERS)
endif()


option(DKCEF "Use Chromium Embeded Framework" OFF)
if(DKCEF)
	add_definitions(-DUSE_DKCef)
endif()