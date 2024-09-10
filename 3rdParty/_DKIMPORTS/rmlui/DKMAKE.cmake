include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/mikke89/RmlUi.git
# https://github.com/aquawicket/RmlUi.git


#################### NOTE ###########################################################################################
#  To get the samples to compile with a SDL Renderer backend, I needed to add a few things to 
#  cmake gui to get everything to compile.
#
#  CMAKE_C_STANDARD_LIBRARIES
#  -lshlwapi -lCfgmgr32 -lSetupapi -lwinmm
#
#  CMAKE_EXE_LINKER_FLAGS 
#  C:/Users/aquawicket/digitalknob/Development/3rdParty/sdl-release-2.26.1/win_x86_64_clang/Debug/libSDL2maind.a
#  C:/Users/aquawicket/digitalknob/Development/3rdParty/sdl-release-2.26.1/win_x86_64_clang/Debug/libSDL2d.a
#
# freetype also needed a folder moved up one heirarchy level
# 
# -DSDL2_DIR=${SDL}/${triple}/Debug
######################################################################################################################## 
 
 
 
### rmlui dependencies ###
dk_depend(freetype)
dk_depend(glfw)
dk_depend(harfbuzz)
#dk_depend(lua)
#dk_depend(luajit)
dk_depend(lunasvg)
dk_depend(rlottie)

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

### IMPORT ###
#dk_import(https://github.com/mikke89/RmlUi.git)
dk_import(https://github.com/mikke89/RmlUi/archive/refs/heads/master.zip)


### PATCH ###
dk_gitApplyPatch(${RMLUI} ${DKIMPORTS_DIR}/rmlui/termux.patch)
dk_gitApplyPatch(${RMLUI} ${DKIMPORTS_DIR}/rmlui/termux2.patch)
dk_gitApplyPatch(${RMLUI} ${DKIMPORTS_DIR}/rmlui/termux3.patch)


# Version fix #
#dk_fileReplace(${RMLUI}/CMakeLists.txt "list(APPEND CORE_PRIVATE_DEFS RMLUI_VERSION" "#list(APPEND CORE_PRIVATE_DEFS RMLUI_VERSION")

# ANDROID FIX
if(ANDROID)
#	dk_fileReplace(${RMLUI}/CMakeLists.txt "target_compile_features" "#target_compile_features")
endif()


### LINK ###
dk_define(RMLUI_STATIC_LIB)
#ANDROID_dk_define(CHOBO_FLAT_MAP_NO_THROW)
#ANDROID_dk_define(RMLUI_USE_CUSTOM_RTTI)

dk_include		(${RMLUI}/Include	RML_INCLUDE_DIR)
dk_include		(${RMLUI}/Source 	RML_INCLUDE_DIR2)

dk_addTarget	(rmlui core)
dk_addTarget	(rmlui debugger)
dk_addTarget	(rmlui shell)
dk_addTarget	(rmlui treeview)
dk_addTarget	(rmlui invaders)

if(rmlui_core OR rmlui_all)
	if(MSVC)
		WIN_dk_libDebug		(${RMLUI}/${triple}/${DEBUG_DIR}/Source/Core/librmlui.lib)
		WIN_dk_libRelease	(${RMLUI}/${triple}/${RELEASE_DIR}/Source/Core/librmlui.lib)
	else()
		dk_libDebug			(${RMLUI}/${triple}/${DEBUG_DIR}/Source/Core/librmlui.a)
		dk_libRelease		(${RMLUI}/${triple}/${RELEASE_DIR}/Source/Core/librmlui.a)
	endif()
endif()

if(rmlui_debugger OR rmlui_all)
	dk_define				(HAVE_rmlui_RmlDebugger)
	dk_define				(HAVE_rmlui_debugger)
	if(MSVC)
		WIN_dk_libRelease	(${RMLUI}/${triple}/${RELEASE_DIR}/Source/Debugger/librmlui_debugger.lib)
		WIN_dk_libDebug		(${RMLUI}/${triple}/${DEBUG_DIR}/Source/Debugger/librmlui_debugger.lib)
	else()
		dk_libDebug			(${RMLUI}/${triple}/${DEBUG_DIR}/Source/Debugger/librmlui_debugger.a)
        dk_libRelease		(${RMLUI}/${triple}/${RELEASE_DIR}/Source/Debugger/librmlui_debugger.a)
	endif()
endif()

if(rmlui_shell OR rmlui_all)
	dk_define				(HAVE_rmlui_shell)
	if(MSVC)
		WIN_dk_libDebug		(${RMLUI}/${triple}/${DEBUG_DIR}/Samples/shell/librmlui_shell.lib)
		WIN_dk_libRelease	(${RMLUI}/${triple}/${RELEASE_DIR}/Samples/shell/librmlui_shell.lib)
	else()
		dk_libDebug			(${RMLUI}/${triple}/${DEBUG_DIR}/Samples/shell/librmlui_shell.a)
		dk_libRelease		(${RMLUI}/${triple}/${RELEASE_DIR}/Samples/shell/librmlui_shell.a)
	endif()
endif()

if(rmlui_treeview OR rmlui_all)
	dk_define				(HAVE_rmlui_treeview)
	WIN_dk_libDebug			(${RMLUI}/${triple}/${DEBUG_DIR}/rmlui_sample_tree_view.exe)
	WIN_dk_libRelease		(${RMLUI}/${triple}/${RELEASE_DIR}/rmlui_sample_tree_view.exe)
	UNIX_dk_libDebug		(${RMLUI}/${triple}/${DEBUG_DIR}/rmlui_sample_tree_view)
	UNIX_dk_libRelease		(${RMLUI}/${triple}/${RELEASE_DIR}/rmlui_sample_tree_view)
endif()

if(rmlui_invaders OR rmlui_all)
	dk_define				(HAVE_rmlui_invaders)
	WIN_dk_libDebug			(${RMLUI}/${triple}/${DEBUG_DIR}/rmlui_sample_invaders.exe)
	WIN_dk_libRelease		(${RMLUI}/${triple}/${RELEASE_DIR}/rmlui_sample_invaders.exe)
	UNIX_dk_libDebug		(${RMLUI}/${triple}/${DEBUG_DIR}/rmlui_sample_invaders)
	UNIX_dk_libRelease		(${RMLUI}/${triple}/${RELEASE_DIR}/rmlui_sample_invaders)
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
	dk_build(${RMLUI})
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
