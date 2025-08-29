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


############ rmlui ############
# https://github.com/mikke89/RmlUi.git
# https://github.com/aquawicket/RmlUi.git
#dk_validate(Target_Config  "dk_Target_Config()")

#################### NOTE ###########################################################################################
#  To get the samples to compile with a SDL Renderer backend, I needed to add a few things to 
#  cmake gui to get everything to compile.
#
#  CMAKE_C_STANDARD_LIBRARIES
#      -lshlwapi -lCfgmgr32 -lSetupapi -lwinmm
#
#  CMAKE_EXE_LINKER_FLAGS 
#      C:/Users/aquawicket/DigitalKnob/Development/3rdParty/sdl-release-2.26.1/Windows_X86_64_Clang/Debug/libSDL2maind.a
#      C:/Users/aquawicket/DigitalKnob/Development/3rdParty/sdl-release-2.26.1/Windows_X86_64_Clang/Debug/libSDL2d.a
#
#  freetype also needed a folder moved up one heirarchy level
# 
#  -DSDL2_DIR=${SDL}/${Target_Tuple}/Debug
######################################################################################################################## 


### rmlui dependencies ###
dk_depend(freetype)
dk_depend(glfw)
dk_depend(harfbuzz)
#dk_depend(lua)
#dk_depend(luajit)
dk_depend(lunasvg)
dk_depend(rlottie)


set(rmlui_all 0)
set(rmlui_core 1)
set(rmlui_debugger 1)
set(rmlui_shell 0)
set(rmlui_treeview 0)
set(rmlui_customlog 0)
set(rmlui_drag 0)
set(rmlui_loaddocument 0)
set(rmlui_transform 0)
set(rmlui_bitmapfont 0)
set(rmlui_animation 0)
set(rmlui_benchmark 0)
set(rmlui_demo 0)
set(rmlui_databinding 0)
set(rmlui_effects 0)
set(rmlui_lottie 0)
set(rmlui_harfbuzzshaping 0)
set(rmlui_tutorial_template 0)
set(rmlui_tutorial_drag 0)
set(rmlui_invaders 0)
set(rmlui_UnitTests 0)
set(rmlui_VisualTests 0)
set(rmlui_Benchmarks 0)


# rmlui sample dependencies
set(RMLUI_SAMPLES OFF)
if(RMLUI_SAMPLES)
	dk_depend(cfgmgr32)
	dk_depend(imm32)
	dk_depend(libjpeg-turbo)
	dk_depend(libpng)
	dk_depend(pthread)
	dk_depend(sdl)
	dk_depend(sdl_image)
	dk_depend(setupapi)
	dk_depend(sfml)
	dk_depend(shlwapi)
	dk_depend(tiff)
	dk_depend(version)
	dk_depend(winmm)
	dk_depend(xz)
	dk_depend(zlib)
	dk_depend(zstd)
	set(RMLUI_BACKEND "-DRMLUI_BACKEND=${RMLUI_BACKEND}")
endif()


### IMPORT ###
#dk_import(${rmlui_Import})
dk_import()

### PATCH ###
dk_gitApplyPatch("${RMLUI}" "$ENV{DKIMPORTS_DIR}/rmlui/rmlui.patch")


### LINK ###
dk_define		(RMLUI_STATIC_LIB)
dk_include		(${RMLUI}/Include	RML_INCLUDE_DIR)
dk_include		(${RMLUI}/Source 	RML_INCLUDE_DIR2)

dk_addTarget	(rmlui core)
dk_addTarget	(rmlui debugger)
dk_addTarget	(rmlui shell)
dk_addTarget	(rmlui treeview)
dk_addTarget	(rmlui invaders)

if(rmlui_all OR rmlui_core)
	dk_define				(HAVE_rmlui_core)
	if(MSVC)
		dk_libDebug			(${RMLUI_Config_Dir}/Source/Core/${Debug_Dir}/rmlui.lib)
		dk_libRelease		(${RMLUI_Config_Dir}/Source/Core/${Release_Dir}/rmlui.lib)
	else()
		dk_libDebug			(${RMLUI_Debug_Dir}/Source/Core/librmlui.a)
		dk_libRelease		(${RMLUI_Release_Dir}/Source/Core/librmlui.a)
	endif()
endif()

if(rmlui_all OR rmlui_debugger)
	dk_define				(HAVE_rmlui_RmlDebugger)
	dk_define				(HAVE_rmlui_debugger)
	if(MSVC)
		dk_libDebug			(${RMLUI_Config_Dir}/Source/Debugger/${Debug_Dir}/rmlui_debugger.lib)
		dk_libRelease		(${RMLUI_Config_Dir}/Source/Debugger/${Release_Dir}/rmlui_debugger.lib)
	else()
		dk_libDebug			(${RMLUI_Debug_Dir}/Source/Debugger/librmlui_debugger.a)
        dk_libRelease		(${RMLUI_Release_Dir}/Source/Debugger/librmlui_debugger.a)
	endif()
endif()

if(rmlui_all OR rmlui_shell)
	dk_define				(HAVE_rmlui_shell)
	if(MSVC)
		dk_libDebug			(${RMLUI_Debug_Dir}/Samples/shell/librmlui_shell.lib)
		dk_libRelease		(${RMLUI_Release_Dir}/Samples/shell/librmlui_shell.lib)
	else()
		dk_libDebug			(${RMLUI_Debug_Dir}/Samples/shell/librmlui_shell.a)
		dk_libRelease		(${RMLUI_Release_Dir}/Samples/shell/librmlui_shell.a)
	endif()
endif()

if(rmlui_all OR rmlui_treeview)
	dk_define				(HAVE_rmlui_treeview)
	if(Windows)
		dk_libDebug			(${RMLUI_Debug_Dir}/rmlui_sample_tree_view.exe)
		dk_libRelease		(${RMLUI_Release_Dir}/rmlui_sample_tree_view.exe)
	endif()
	if(Unix)
		dk_libDebug			(${RMLUI_Debug_Dir}/rmlui_sample_tree_view)
		dk_libRelease		(${RMLUI_Release_Dir}/rmlui_sample_tree_view)
	endif()
endif()

if(rmlui_all OR rmlui_invaders)
	dk_define				(HAVE_rmlui_invaders)
	if(Windows)
		dk_libDebug			(${RMLUI_Debug_Dir}/rmlui_sample_invaders.exe)
		dk_libRelease		(${RMLUI_Release_Dir}/rmlui_sample_invaders.exe)
	endif()
	if(Unix)
		dk_libDebug			(${RMLUI_Debug_Dir}/rmlui_sample_invaders)
		dk_libRelease		(${RMLUI_Release_Dir}/rmlui_sample_invaders)
	endif()
endif()

### GENERATE ###								
dk_configure(
	${RMLUI}
	${RMLUI_BACKEND}
	-DRMLUI_SAMPLES=${RMLUI_SAMPLES}
	-DENABLE_PRECOMPILED_HEADERS=OFF		# "Enable precompiled headers" ON	
	#-DRMLUI_TRACY_CONFIGURATION=OFF		# "Enable a separate Tracy configuration type for multi-config generators such as Visual Studio, otherwise enable Tracy in all configurations."ON
	#-DRMLUI_TRACY_MEMORY_PROFILING=OFF		# "Overload global operator new/delete to track memory allocations in Tracy." ON
	${FREETYPE_CMAKE}
	#${GLFW_CMAKE}
	#${HARFBUZZ_CMAKE}
	${IMM32_CMAKE}
	${LIBJPEG_TURBO_CMAKE}
	${LIBPNG_CMAKE}
	${LUNASVG_CMAKE}
	${PTHREAD_CMAKE}
	${RLOTTIE_CMAKE}
	${SDL_CMAKE}
	${SDL_IMAGE_CMAKE}
	${SETUPAPI_CMAKE}
	${SFML_CMAKE}
	${TIFF_CMAKE}
	${VERSION_CMAKE}
	${WINMM_CMAKE}
	${XZ_CMAKE}
	${ZLIB_CMAKE}
	${ZSTD_CMAKE} 
	NO_HALT)

### COMPILE ###
if(rmlui_all)
	dk_build()
else()
	if(rmlui_core)
		dk_build(${RMLUI} rmlui_core)
	endif()
	if(rmlui_debugger)
		dk_build(${RMLUI} rmlui_debugger)
	endif()
	if(rmlui_shell)
		dk_build(${RMLUI} shell)
	endif()
	if(rmlui_treeview)
		dk_build(${RMLUI} treeview)
	endif()
	if(rmlui_invaders)
		dk_build(${RMLUI} invaders)
	endif()
endif()
