### DKScreenRecorder ###
CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
INCLUDE(C:/digitalknob/DKCMake/FUNCTIONS.cmake)
INCLUDE(C:/digitalknob/DKCMake/OPTIONS.cmake)
PROJECT(DKScreenRecorder)
INCLUDE_DIRECTORIES(C:/digitalknob/3rdParty/boost_1_66_0)
INCLUDE_DIRECTORIES(C:/digitalknob/DKPlugins)
INCLUDE_DIRECTORIES(C:/digitalknob/DKPlugins/DKDuktape)
INCLUDE_DIRECTORIES(C:/digitalknob/3rdParty/duktape-1.5.0/src)
INCLUDE_DIRECTORIES(C:/digitalknob/3rdParty/zlib-1.2.11)
INCLUDE_DIRECTORIES(C:/digitalknob/3rdParty/zlib-1.2.11/win32)
INCLUDE_DIRECTORIES(C:/digitalknob/3rdParty/xz-5.2.0/src/liblzma/api)
INCLUDE_DIRECTORIES(C:/digitalknob/3rdParty/bzip2-1.0.6)
INCLUDE_DIRECTORIES(C:/digitalknob/3rdParty/libarchive-master/libarchive)
ADD_DEFINITIONS(-DUSE_Boost_System)
ADD_DEFINITIONS(-DUSE_Boost_Filesystem)
ADD_DEFINITIONS(-DUSE_DK)
ADD_DEFINITIONS(-DDUK_F_VBCC)
ADD_DEFINITIONS(-DUSE_DKDuktape)
ADD_DEFINITIONS(-DLZMA_API_STATIC)
ADD_DEFINITIONS(-DLIBARCHIVE_STATIC)
ADD_DEFINITIONS(-DUSE_DKArchive)
ADD_DEFINITIONS(-DUSE_DKAssets)
ADD_DEFINITIONS(-DUSE_DKFile)
LINK_DIRECTORIES(C:/digitalknob/3rdParty/boost_1_66_0/win32/lib)

FILE(GLOB DK_SRC 
	   C:/digitalknob/DKPlugins/DKScreenRecorder/*.h
    C:/digitalknob/DKPlugins/DKScreenRecorder/*.c
    C:/digitalknob/DKPlugins/DKScreenRecorder/*.cpp
    C:/digitalknob/DKPlugins/DKScreenRecorder/*.rc
)
ADD_LIBRARY(DKScreenRecorder STATIC ${DK_SRC})
TARGET_COMPILE_OPTIONS(DKScreenRecorder PRIVATE /W3 /nologo /Zm500 /EHsc /GR /D_WIN32_WINNT=0x0600 /D_USING_V110_SDK71_ $<$<CONFIG:Debug>:/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MT /O2 /Ob2 /DNDEBUG>)
IF(WIN32)
    SET_TARGET_PROPERTIES(DKScreenRecorder PROPERTIES LINKER_LANGUAGE CPP)
ENDIF()
