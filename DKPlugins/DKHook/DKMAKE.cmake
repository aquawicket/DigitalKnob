#if(NOT WIN AND NOT LINUX)
#	return()
#endif()

IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()
dk_generateCmake(DKHook)
dk_assets(DKHook)

## hookdll windows
IF(WIN)
	dk_appendCmake("\n\n")
	dk_appendCmake("FILE(GLOB hookdll_SRC \n")
	dk_appendCmake("	${DKPLUGINS}/DKHook/hookdll/*.cpp \n")
	dk_appendCmake(") \n")
	dk_appendCmake("ADD_LIBRARY(hookdll SHARED \${hookdll_SRC}) \n")
	dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib\") \n")
	dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES DEFINE_SYMBOL \"DKHook\") \n")
	dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES LINKER_LANGUAGE CPP) \n")
ENDIF()

#IF(WIN_32)
	WIN32_dk_copy(${DKPLUGINS}/DKHook/win32/Release/hookdll.dll ${DKPROJECT}/assets/DKHook OVERWRITE)
#ENDIF()

#IF(WIN_64)
	WIN64_dk_copy(${DKPLUGINS}/DKHook/win64/Release/hookdll.dll ${DKPROJECT}/assets/DKHook OVERWRITE)
#ENDIF()
