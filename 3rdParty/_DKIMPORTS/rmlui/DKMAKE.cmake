# https://github.com/mikke89/RmlUi.git
# https://github.com/aquawicket/RmlUi.git


### DEPEND ###
dk_depend(freetype)
dk_depend(harfbuzz)
dk_depend(lua)
dk_depend(lunasvg)
dk_depend(rlottie)

# BUILD_SAMPLES
set(RMLUI_BUILD_SAMPLES OFF)
if(RMLUI_BUILD_SAMPLES)
	dk_depend(glew)
	dk_depend(sdl)
	dk_depend(sdl_image)
	dk_depend(sfml)
endif()


### IMPORT ###
dk_import(https://github.com/mikke89/RmlUi.git)

# Version fix #
dkFileReplace(${RMLUI}/CMakeLists.txt "list(APPEND CORE_PRIVATE_DEFS RMLUI_VERSION" "#list(APPEND CORE_PRIVATE_DEFS RMLUI_VERSION")

# ANDROID FIX
if(ANDROID)
	dkFileReplace(${RMLUI}/CMakeLists.txt "target_compile_features" "#target_compile_features")
endif()


### LINK ###
dk_define(RMLUI_STATIC_LIB)
ANDROID_dk_define(CHOBO_FLAT_MAP_NO_THROW)
ANDROID_dk_define(RMLUI_USE_CUSTOM_RTTI)

dk_include		(${RMLUI}/Include					RML_INCLUDE_DIR)
dk_include		(${RMLUI}/Source)

dk_addTarget	(rmlui RmlCore)
dk_addTarget	(rmlui RmlDebugger)

if(rmlui_RmlCore)
	if(MSVC)
		WIN_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/RmlCore.lib)
		WIN_dk_libRelease	(${RMLUI}/${OS}/${RELEASE_DIR}/RmlCore.lib)
	else()
		dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlCore.a)
		dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlCore.a)
	endif()
endif()

if(rmlui_RmlDebugger)
	dk_define			(HAVE_rmlui_debugger)
	if(MSVC)
		WIN_dk_libRelease	(${RMLUI}/${OS}/${RELEASE_DIR}/RmlDebugger.lib)
		WIN_dk_libDebug		(${RMLUI}/${OS}/${DEBUG_DIR}/RmlDebugger.lib)
	else()
		dk_libDebug			(${RMLUI}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
		dk_libRelease		(${RMLUI}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
	endif()
endif()

### GENERATE ###
if(MSVC)
	WIN_dk_queueCommand(${DKCMAKE_BUILD}
		"-DCMAKE_CXX_FLAGS=/DRMLUI_STATIC_LIB /I${RML_INCLUDE_DIR}"
		-DBUILD_FRAMEWORK=OFF 					# "Build Framework bundle for OSX" OFF
		-DBUILD_LUA_BINDINGS_FOR_LUAJIT=OFF 	# "Build Lua bindings using luajit" OFF
		-DBUILD_LUA_BINDINGS=${LUA}	 			# "Build Lua bindings" OFF
		-DBUILD_SAMPLES=OFF 					# "Build samples" OFF
		-DBUILD_SHARED_LIBS=OFF					# "Build shared (dynamic) libraries" ON
		-DBUILD_TESTING=OFF 					#  OFF
		-DBUILD_UNIVERSAL_BINARIES=OFF 			# "Build universal binaries for all architectures supported" ON
		-DCUSTOM_CONFIGURATION=OFF				# "Customize RmlUi configuration files for overriding the default configuration and types." OFF
		-DDISABLE_RTTI_AND_EXCEPTIONS=OFF		# "Build with rtti and exceptions disabled." OFF
		-DENABLE_HARFBUZZ=${HARFBUZZ}			# "Enable HarfBuzz for text-shaping sample. Requires the HarfBuzz library." OFF
		-DENABLE_LOTTIE_PLUGIN=${RLOTTIE} 		# "Enable plugin for Lottie animations. Requires the rlottie library." OFF
		-DENABLE_PRECOMPILED_HEADERS=ON			# "Enable precompiled headers" ON
		-DENABLE_SVG_PLUGIN=${LUNASVG_CMAKE}	# "Enable plugin for SVG images. Requires the lunasvg library." OFF
		-DMATRIX_ROW_MAJOR=OFF 					# "Use row-major matrices. Column-major matrices are used by default." OFF
		-DNO_FONT_INTERFACE_DEFAULT=OFF			# "Do not include the default font engine in the build. Allows building without the FreeType dependency, but a custom font engine must be created and set." OFF
		-DNO_THIRDPARTY_CONTAINERS=OFF			# "Only use standard library containers." OFF
		-DRMLUI_TRACY_CONFIGURATION=OFF			# "Enable a separate Tracy configuration type for multi-config generators such as Visual Studio, otherwise enable Tracy in all configurations." ON
		-DRMLUI_TRACY_MEMORY_PROFILING=OFF		# "Overload global operator new/delete to track memory allocations in Tracy." ON
		-DRMLUI_TRACY_PROFILING=OFF				# "Enable profiling with Tracy. Source files can be placed in Dependencies/tracy." OFF
		-DRMLUI_VK_DEBUG=OFF					# "Enable debugging mode for Vulkan renderer." OFF
		-DWARNINGS_AS_ERRORS=OFF				# "Treat compiler warnings as errors." OFF
		${FREETYPE_CMAKE} 
		${GLEW_CMAKE}
		${HARFBUZZ_CMAKE}
		${LUA_CMAKE}
		${LUNASVG_CMAKE}
		${SDL_CMAKE} 
		${SDL_IMAGE_CMAKE} 
		${SFML_CMAKE} 
		${RMLUI})
	
	ANDROID_dk_queueCommand(${DKCMAKE_BUILD} 
		"-DCMAKE_CXX_FLAGS=-DRMLUI_STATIC_LIB -DCHOBO_FLAT_MAP_NO_THROW -std=c++1z"
		-DBUILD_FRAMEWORK=OFF 					# "Build Framework bundle for OSX" OFF
		-DBUILD_LUA_BINDINGS_FOR_LUAJIT=OFF 	# "Build Lua bindings using luajit" OFF
		-DBUILD_LUA_BINDINGS=${LUA}	 			# "Build Lua bindings" OFF
		-DBUILD_SAMPLES=OFF 					# "Build samples" OFF
		-DBUILD_SHARED_LIBS=OFF					# "Build shared (dynamic) libraries" ON
		-DBUILD_TESTING=OFF 					#  OFF
		-DBUILD_UNIVERSAL_BINARIES=OFF 			# "Build universal binaries for all architectures supported" ON
		-DCUSTOM_CONFIGURATION=OFF				# "Customize RmlUi configuration files for overriding the default configuration and types." OFF
		-DDISABLE_RTTI_AND_EXCEPTIONS=OFF		# "Build with rtti and exceptions disabled." OFF
		-DENABLE_HARFBUZZ=${HARFBUZZ}			# "Enable HarfBuzz for text-shaping sample. Requires the HarfBuzz library." OFF
		-DENABLE_LOTTIE_PLUGIN=${RLOTTIE} 		# "Enable plugin for Lottie animations. Requires the rlottie library." OFF
		-DENABLE_PRECOMPILED_HEADERS=ON			# "Enable precompiled headers" ON
		-DENABLE_SVG_PLUGIN=${LUNASVG_CMAKE}	# "Enable plugin for SVG images. Requires the lunasvg library." OFF
		-DMATRIX_ROW_MAJOR=OFF 					# "Use row-major matrices. Column-major matrices are used by default." OFF
		-DNO_FONT_INTERFACE_DEFAULT=OFF			# "Do not include the default font engine in the build. Allows building without the FreeType dependency, but a custom font engine must be created and set." OFF
		-DNO_THIRDPARTY_CONTAINERS=OFF			# "Only use standard library containers." OFF
		-DRMLUI_TRACY_CONFIGURATION=OFF			# "Enable a separate Tracy configuration type for multi-config generators such as Visual Studio, otherwise enable Tracy in all configurations." ON
		-DRMLUI_TRACY_MEMORY_PROFILING=OFF		# "Overload global operator new/delete to track memory allocations in Tracy." ON
		-DRMLUI_TRACY_PROFILING=OFF				# "Enable profiling with Tracy. Source files can be placed in Dependencies/tracy." OFF
		-DRMLUI_VK_DEBUG=OFF					# "Enable debugging mode for Vulkan renderer." OFF
		-DWARNINGS_AS_ERRORS=OFF				# "Treat compiler warnings as errors." OFF
		${FREETYPE_CMAKE} 
		${GLEW_CMAKE}
		${HARFBUZZ_CMAKE}
		${LUA_CMAKE}
		${LUNASVG_CMAKE}
		${SDL_CMAKE} 
		${SDL_IMAGE_CMAKE} 
		${SFML_CMAKE} 
		${RMLUI}) 
else()
	dk_debug(LUA_CMAKE)
	dk_queueCommand(${DKCMAKE_BUILD} 
		-DBUILD_FRAMEWORK=OFF 					# "Build Framework bundle for OSX" OFF
		-DBUILD_LUA_BINDINGS_FOR_LUAJIT=OFF 	# "Build Lua bindings using luajit" OFF
		-DBUILD_LUA_BINDINGS=${LUA}	 			# "Build Lua bindings" OFF
		-DBUILD_SAMPLES=OFF 					# "Build samples" OFF
		-DBUILD_SHARED_LIBS=OFF					# "Build shared (dynamic) libraries" ON
		-DBUILD_TESTING=OFF 					#  OFF
		-DBUILD_UNIVERSAL_BINARIES=OFF 			# "Build universal binaries for all architectures supported" ON
		-DCUSTOM_CONFIGURATION=OFF				# "Customize RmlUi configuration files for overriding the default configuration and types." OFF
		-DDISABLE_RTTI_AND_EXCEPTIONS=OFF		# "Build with rtti and exceptions disabled." OFF
		-DENABLE_HARFBUZZ=${HARFBUZZ}			# "Enable HarfBuzz for text-shaping sample. Requires the HarfBuzz library." OFF
		-DENABLE_LOTTIE_PLUGIN=${RLOTTIE} 		# "Enable plugin for Lottie animations. Requires the rlottie library." OFF
		-DENABLE_PRECOMPILED_HEADERS=OFF		# "Enable precompiled headers" ON
		-DENABLE_SVG_PLUGIN=${LUNASVG}			# "Enable plugin for SVG images. Requires the lunasvg library." OFF
		-DMATRIX_ROW_MAJOR=OFF 					# "Use row-major matrices. Column-major matrices are used by default." OFF
		-DNO_FONT_INTERFACE_DEFAULT=OFF			# "Do not include the default font engine in the build. Allows building without the FreeType dependency, but a custom font engine must be created and set." OFF
		-DNO_THIRDPARTY_CONTAINERS=OFF			# "Only use standard library containers." OFF
		-DRMLUI_TRACY_CONFIGURATION=OFF			# "Enable a separate Tracy configuration type for multi-config generators such as Visual Studio, otherwise enable Tracy in all configurations." ON
		-DRMLUI_TRACY_MEMORY_PROFILING=OFF		# "Overload global operator new/delete to track memory allocations in Tracy." ON
		-DRMLUI_TRACY_PROFILING=OFF				# "Enable profiling with Tracy. Source files can be placed in Dependencies/tracy." OFF
		-DRMLUI_VK_DEBUG=OFF					# "Enable debugging mode for Vulkan renderer." OFF
		-DWARNINGS_AS_ERRORS=OFF				# "Treat compiler warnings as errors." OFF
		${FREETYPE_CMAKE} 
		${GLEW_CMAKE}
		${HARFBUZZ_CMAKE}
		${LUA_CMAKE}
		${LUNASVG_CMAKE}
		${RLOTTIE_CMAKE}
		${SDL_CMAKE} 
		${SDL_IMAGE_CMAKE} 
		${SFML_CMAKE} 
		${RMLUI})
endif()



### COMPILE ###
if(rmlui_RmlCore)
	dk_build(${RMLUI} RmlCore)
endif()

if(rmlui_RmlDebugger)
	dk_build(${RMLUI} RmlDebugger)
endif()
