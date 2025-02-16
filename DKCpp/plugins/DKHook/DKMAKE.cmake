#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKHook ############

#if(NOT WIN AND NOT LINUX)
#	dk_return()
#endif()

if(HAVE_DKCef)
	dk_depend(DKCef)
endif()
dk_generateCmake(DKHook)
dk_assets(DKHook)

## add hoodll.dll to CMakeLists.txt on windows
dk_appendCmake("\n\n")
dk_appendCmake("FILE(GLOB hookdll_SRC \n")
dk_appendCmake("	${DKCPP_PLUGINS_DIR}/DKHook/hookdll/*.* \n")
dk_appendCmake(") \n")
dk_appendCmake("ADD_LIBRARY(hookdll SHARED \${hookdll_SRC}) \n")
if(MSVC)
	dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib\") \n")
endif()
dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES DEFINE_SYMBOL \"DKHook\") \n")
dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES LINKER_LANGUAGE CPP) \n")


# FIXME - these should be post built operations. hookdll.dll will not exist yet
if(EXISTS ${DKCPP_PLUGINS_DIR}/DKHook/win_x86_msvc/Release/hookdll.dll)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKHook/win_x86_msvc/Release/hookdll.dll ${DK_Project_Dir}/assets/DKHook OVERWRITE)
endif()
if(EXISTS ${DKCPP_PLUGINS_DIR}/DKHook/win_x86_64_msvc/Release/hookdll.dll)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKHook/win_x86_64_msvc/Release/hookdll.dll ${DK_Project_Dir}/assets/DKHook OVERWRITE)
endif()
