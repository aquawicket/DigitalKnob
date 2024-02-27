#if(NOT WIN AND NOT LINUX)
#	return()
#endif()

if(HAVE_DKCef)
	dk_depend(DKCef)
endif()
dk_generateCmake(DKHook)
dk_assets(DKHook)

## add hoodll.dll to CMakeLists.txt on windows
if(WIN)
	dk_appendCmake("\n\n")
	dk_appendCmake("FILE(GLOB hookdll_SRC \n")
	dk_appendCmake("	${DKPLUGINS}/DKHook/hookdll/*.* \n")
	dk_appendCmake(") \n")
	dk_appendCmake("ADD_LIBRARY(hookdll SHARED \${hookdll_SRC}) \n")
	dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib\") \n")
	dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES DEFINE_SYMBOL \"DKHook\") \n")
	dk_appendCmake("SET_TARGET_PROPERTIES(hookdll PROPERTIES LINKER_LANGUAGE CPP) \n")
endif()

# FIXME - these should be post built operations. hookdll.dll will not exist yet
WIN_X86_dk_copy(${DKPLUGINS}/DKHook/win_x86/Release/hookdll.dll ${DKPROJECT}/assets/DKHook OVERWRITE)
WIN_X86_64_dk_copy(${DKPLUGINS}/DKHook/win_x86_64/Release/hookdll.dll ${DKPROJECT}/assets/DKHook OVERWRITE)
