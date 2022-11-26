# https://github.com/mikke89/RmlUi.git
# https://github.com/aquawicket/RmlUi.git


### DEPEND ###
dk_depend(freetype)
dk_depend(glew)
dk_depend(lua)
dk_depend(sdl)
dk_depend(sdl_image)
dk_depend(sfml)


### IMPORT ###
#dk_import(https://github.com/aquawicket/RmlUi.git PATCH)
#dk_import(https://github.com/aquawicket/RmlUi.git BRANCH RCSS_attribute_selector_support PATCH)
dk_import(https://github.com/mikke89/RmlUi.git)


### LINK ###
dk_define(RMLUI_STATIC_LIB)
ANDROID_dk_define(CHOBO_FLAT_MAP_NO_THROW)
ANDROID_dk_define(RMLUI_USE_CUSTOM_RTTI)
#if(IOS OR IOSSIM OR WIN)
	#dk_define(RMLUI_NO_THIRDPARTY_CONTAINERS)
#endif()
dk_include		(${RMLUI}/Include)
dk_include		(${RMLUI}/Source)

dk_addTarget	(rmlui RmlCore)
dk_addTarget	(rmlui RmlDebugger)

if(rmlui_RmlCore)
	WIN_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/RmlCore.lib)
	WIN_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/RmlCore.lib)
	MAC_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlCore.a)
	MAC_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlCore.a)
	IOS_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlCore.a)
	IOS_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlCore.a)
	IOSSIM_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlCore.a)
	IOSSIM_dk_libRelease	(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlCore.a)
	LINUX_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlCore.a)
	LINUX_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlCore.a)
	RASPBERRY_dk_libDebug	(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlCore.a)
	RASPBERRY_dk_libRelease	(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlCore.a)
	ANDROID_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlCore.a)
	ANDROID_dk_libRelease	(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlCore.a)
endif()

if(rmlui_RmlDebugger)
	dk_define				(HAVE_rmlui_debugger)
	WIN_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/RmlDebugger.lib)
	WIN_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/RmlDebugger.lib)
	WIN_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/RmlDebugger.lib)
	MAC_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
	MAC_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
	IOS_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
	IOS_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
	IOSSIM_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
	IOSSIM_dk_libRelease	(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
	LINUX_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
	LINUX_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
	RASPBERRY_dk_libDebug	(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
	RASPBERRY_dk_libRelease	(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
	ANDROID_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
	ANDROID_dk_libRelease	(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
endif()


### GENERATE ###

## RML minimal
WIN_dk_queueCommand			(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/DRMLUI_STATIC_LIB /I${RMLUI}/Include" -DBUILD_SAMPLES=OFF -DBUILD_TESTING=OFF -DENABLE_SVG_PLUGIN=OFF -DENABLE_LOTTIE_PLUGIN=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})

## RML + ALL Extras
# WIN32_dk_queueCommand(${DKCMAKE_BUILD} 
#"-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc -DRMLUI_STATIC_LIB -DGLEW_STATIC /I${RMLUI}/Include /I${SDL}/include /I${GLEW}/include" 
#-DBUILD_SAMPLES=ON -DBUILD_TESTING=ON -DENABLE_SVG_PLUGIN=OFF -DENABLE_LOTTIE_PLUGIN=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${SDLIMAGE_CMAKE} ${GLEW_CMAKE} ${SDL_CMAKE} ${SFML_CMAKE} 
#${RMLUI})

# WIN32_dk_queueCommand(${CMAKE_EXE} -G "Visual Studio 16 2019" -A Win32 "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc -DRMLUI_STATIC_LIB /I${3RDPARTY}/${RMLUI_FOLDER}/Include /I${SDL}/include /I${GLEW}/include" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -DBUILD_SHARED_LIBS=OFF -DBUILD_SAMPLES=ON ${FREETYPE_CMAKE} ${SDL2_CMAKE} -DSDL2_IMAGE_LIBRARY_TEMP=${SDLIMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.lib -DSDL2_IMAGE_INCLUDE_DIR=${SDLIMAGE} -DGLEW_DIR=${GLEW}/build/cmake -DGLEW_INCLUDE_DIR=${GLEW} -DGLEW_SHARED_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/libglew32d.lib -DGLEW_SHARED_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/libglew32.lib -DGLEW_STATIC_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/glew32d.lib -DGLEW_STATIC_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/glew32.lib -DCMAKE_PREFIX_PATH=${GLEW} -DSFML_INCLUDE_DIR=${SFML}/include -DSFML_MAIN_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-main-d.lib -DSFML_MAIN_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-main.lib -DSFML_SYSTEM_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s-d.lib -DSFML_SYSTEM_LIBRARY_RELEASE=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-system-s.lib -DSFML_WINDOW_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-window-s-d.lib -DSFML_WINDOW_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-window-s.lib -DSFML_GRAPHICS_LIBRARY_DEBUG=${SFML}/${OS}/lib/${DEBUG_DIR}/sfml-graphics-s-d.lib -DSFML_GRAPHICS_LIBRARY_RELEASE=${SFML}/${OS}/lib/${RELEASE_DIR}/sfml-graphics-s.lib ${RMLUI})

# WIN32_dk_queueCommand(${CMAKE_EXE} -G ${GENERATOR} -A Win32 "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /I${RMLUI}/Include /I${SDL}/include" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -DBUILD_SHARED_LIBS=OFF -DBUILD_SAMPLES=ON -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY=${FREETYPE}/${OS}/${RELEASE_DIR}/freetype.lib -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/freetype.lib -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/freetype.lib -DSDL2_INCLUDE_DIR=${SDL} -DSDL2_LIBRARY=${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib -DSDL2_LIBRARY_TEMP=${SDL}/${OS}/${RELEASE_DIR}/SDL2.lib -DSDL2_IMAGE_INCLUDE_DIR=${SDLIMAGE} -DSDL2_IMAGE_LIBRARY_TEMP=${SDLIMAGE}/${OS}/lib/${RELEASE_DIR}/SDL_image.lib -DGLEW_INCLUDE_DIR=${GLEW} -DGLEW_STATIC_LIBRARY_DEBUG=${GLEW}/${OS}/lib/${DEBUG_DIR}/glew32d.lib -DGLEW_STATIC_LIBRARY_RELEASE=${GLEW}/${OS}/lib/${RELEASE_DIR}/glew32.lib ${RMLUI})
# WIN_dk_visualStudio(${RMLUI_FOLDER})

## Test Building with Msys/Mingw
# WIN32_dk_queueCommand(${CMAKE_EXE} -G "MSYS Makefiles" -DCMAKE_MAKE_PROGRAM=${MSYS}/bin/make.exe -DENABLE_PRECOMPILED_HEADERS=OFF -DDISABLE_RTTI_AND_EXCEPTIONS=ON -DBUILD_SHARED_LIBS=OFF -DFREETYPE_INCLUDE_DIR_freetype2=${FREETYPE}/include -DFREETYPE_INCLUDE_DIR_ft2build=${FREETYPE}/include -DFREETYPE_LIBRARY_DEBUG=${FREETYPE}/${OS}/${DEBUG_DIR}/freetype.lib -DFREETYPE_LIBRARY_RELEASE=${FREETYPE}/${OS}/${RELEASE_DIR}/freetype.lib ${RMLUI})
# WIN32_BASH("#!/bin/bash
# cd /${RMLUI}/${OS}
# export PATH=/c/mingw32/bin:$PATH
# export PATH=/c/msys/bin:$PATH
# make
# exit")


MAC_dk_queueCommand			(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
IOS_dk_queueCommand			(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
IOSSIM_dk_queueCommand		(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} "-DCMAKE_CXX_FLAGS=-DRMLUI_STATIC_LIB -DCHOBO_FLAT_MAP_NO_THROW -DRMLUI_USE_CUSTOM_RTTI -std=c++1z" ${RMLUI}) #-DDISABLE_RTTI_AND_EXCEPTIONS=ON 


### COMPILE ###
if(rmlui_RmlCore)
	dk_build(${RMLUI_FOLDER} RmlCore)
endif()

if(rmlui_RmlDebugger)
	dk_build(${RMLUI_FOLDER} RmlDebugger)
endif()
