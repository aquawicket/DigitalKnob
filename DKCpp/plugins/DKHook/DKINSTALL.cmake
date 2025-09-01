#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKHook ############

#if(NOT Windows AND NOT Linux)
#	dk_return()
#endif()

if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


############ DKHook ############
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()



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
if(EXISTS ${DKCPP_PLUGINS_DIR}/DKHook/Windows_X86_Msvc/Release/hookdll.dll)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKHook/Windows_X86_Msvc/Release/hookdll.dll ${Target_App_Dir}/assets/DKHook OVERWRITE)
endif()
if(EXISTS ${DKCPP_PLUGINS_DIR}/DKHook/Windows_X86_64_Msvc/Release/hookdll.dll)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKHook/Windows_X86_64_Msvc/Release/hookdll.dll ${Target_App_Dir}/assets/DKHook OVERWRITE)
endif()
