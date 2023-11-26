# https://github.com/mikke89/RmlUi.git
# https://github.com/aquawicket/RmlUi.git


### DEPEND ###
dk_depend(freetype)

# BUILD_SAMPLES
dk_depend(glew)
#dk_depend(lua)
dk_depend(sdl)
dk_depend(sdl_image)
#dk_depend(sfml)


### IMPORT ###
dk_import(https://github.com/mikke89/RmlUi.git)

# ANDROID FIX
if(ANDROID)
	dkFileReplace(${RMLUI}/CMakeLists.txt "target_compile_features" "#target_compile_features")
endif()


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
	UNIX_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlCore.a)
	UNIX_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlCore.a)
	WIN_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/RmlCore.lib)
	WIN_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/RmlCore.lib)
endif()

if(rmlui_RmlDebugger)
	dk_define				(HAVE_rmlui_debugger)
	UNIX_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
	UNIX_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
	WIN_dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/RmlDebugger.lib)
	WIN_dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/RmlDebugger.lib)
endif()


### GENERATE ###
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} "-DCMAKE_CXX_FLAGS=-DRMLUI_STATIC_LIB -DCHOBO_FLAT_MAP_NO_THROW -std=c++1z" ${RMLUI}) #-DDISABLE_RTTI_AND_EXCEPTIONS=ON -DRMLUI_USE_CUSTOM_RTTI
EMSCRIPTEN_dk_queueCommand	(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
IOSSIM_dk_queueCommand		(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
IOS_dk_queueCommand			(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
MAC_dk_queueCommand			(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})
WIN_dk_queueCommand			(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=/DRMLUI_STATIC_LIB /I${RMLUI}/Include" -DBUILD_SAMPLES=ON -DBUILD_TESTING=OFF -DENABLE_SVG_PLUGIN=OFF -DENABLE_LOTTIE_PLUGIN=OFF -DBUILD_LUA_BINDINGS=OFF ${FREETYPE_CMAKE} ${GLEW_CMAKE} ${LUA_CMAKE} ${SDL_CMAKE} ${SDL_IMAGE_CMAKE} ${SFML_CMAKE} ${RMLUI})


### COMPILE ###
if(rmlui_RmlCore)
	dk_build(${RMLUI} RmlCore)
endif()

if(rmlui_RmlDebugger)
	dk_build(${RMLUI} RmlDebugger)
endif()
