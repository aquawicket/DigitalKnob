# https://github.com/mikke89/RmlUi.git
# https://github.com/aquawicket/RmlUi.git


### rmlui dependencies ###
dk_depend(freetype)
dk_depend(harfbuzz)
#dk_depend(lua)
#dk_depend(luajit)
dk_depend(lunasvg)
dk_depend(rlottie)

# rmlui sample dependencies
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(pthread)
dk_depend(sdl)
dk_depend(sdl_image)
dk_depend(setupapi.lib)
dk_depend(sfml)
dk_depend(tiff)
dk_depend(version.lib)
dk_depend(winmm.lib)
dk_depend(xz)
dk_depend(zlib)
dk_depend(zstd)



set(rmlui_all 0)
set(rmlui_RmlCore 1)
set(rmlui_RmlDebugger 1)
set(rmlui_shell 1)
set(rmlui_treeview 1)
set(rmlui_customlog 1)
set(rmlui_drag 1)
set(rmlui_loaddocument 1)
set(rmlui_transform 1)
set(rmlui_bitmapfont 1)
set(rmlui_animation 1)
set(rmlui_benchmark 1)
set(rmlui_demo 1)
set(rmlui_databinding 1)
set(rmlui_effects 1)
set(rmlui_lottie 1)
set(rmlui_harfbuzzshaping 1)
set(rmlui_tutorial_template 1)
set(rmlui_tutorial_drag 1)
set(rmlui_invaders 1)
set(rmlui_UnitTests 1)
set(rmlui_VisualTests 1)
set(rmlui_Benchmarks 1)

### IMPORT ###
dk_import(https://github.com/mikke89/RmlUi.git)

# Version fix #
dk_fileReplace(${RMLUI_MASTER}/CMakeLists.txt "list(APPEND CORE_PRIVATE_DEFS RMLUI_VERSION" "#list(APPEND CORE_PRIVATE_DEFS RMLUI_VERSION")

# ANDROID FIX
if(ANDROID)
	dk_fileReplace(${RMLUI_MASTER}/CMakeLists.txt "target_compile_features" "#target_compile_features")
endif()


### LINK ###
dk_define(RMLUI_STATIC_LIB)
ANDROID_dk_define(CHOBO_FLAT_MAP_NO_THROW)
ANDROID_dk_define(RMLUI_USE_CUSTOM_RTTI)

dk_include		(${RMLUI_MASTER}/Include			RML_INCLUDE_DIR)
dk_include		(${RMLUI_MASTER}/Source)

dk_addTarget	(rmlui RmlCore)
dk_addTarget	(rmlui RmlDebugger)
dk_addTarget	(rmlui shell)
dk_addTarget	(rmlui treeview)
dk_addTarget	(rmlui invaders)

if(rmlui_RmlCore)
	if(MSVC)
		WIN_dk_libDebug		(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/RmlCore.lib)
		WIN_dk_libRelease	(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/RmlCore.lib)
	else()
		dk_libDebug			(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/libRmlCore.a)
		dk_libRelease		(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/libRmlCore.a)
	endif()
endif()

if(rmlui_RmlDebugger)
	dk_define				(HAVE_rmlui_RmlDebugger)
	if(MSVC)
		WIN_dk_libRelease	(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/RmlDebugger.lib)
		WIN_dk_libDebug		(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/RmlDebugger.lib)
	else()
		dk_libDebug			(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/libRmlDebugger.a)
		dk_libRelease		(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/libRmlDebugger.a)
	endif()
endif()

if(rmlui_shell)
	dk_define				(HAVE_rmlui_shell)
	if(MSVC)
		WIN_dk_libRelease	(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/shell.lib)
		WIN_dk_libDebug		(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/shell.lib)
	else()
		dk_libDebug			(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/libshell.a)
		dk_libRelease		(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/libshell.a)
	endif()
endif()

if(rmlui_treeview)
	dk_define				(HAVE_rmlui_treeview)
	WIN_dk_libDebug			(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/treeview.exe)
	WIN_dk_libRelease		(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/treeview.exe)
	UNIX_dk_libDebug		(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/treeview)
	UNIX_dk_libRelease		(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/treeview)
endif()

if(rmlui_invaders)
	dk_define				(HAVE_rmlui_invaders)
	WIN_dk_libDebug			(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/invaders.exe)
	WIN_dk_libRelease		(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/invaders.exe)
	UNIX_dk_libDebug		(${RMLUI_MASTER}/${OS}/${DEBUG_DIR}/invaders)
	UNIX_dk_libRelease		(${RMLUI_MASTER}/${OS}/${RELEASE_DIR}/invaders)
endif()

### GENERATE ###
if(MSVC)
	WIN_dk_configure(${RMLUI_MASTER}
		"-DCMAKE_CXX_FLAGS=/DRMLUI_STATIC_LIB /I${RML_INCLUDE_DIR}"
		-DBUILD_FRAMEWORK=OFF 					# "Build Framework bundle for OSX" OFF
		-DBUILD_LUA_BINDINGS_FOR_LUAJIT=OFF 	# "Build Lua bindings using luajit" OFF
		-DBUILD_LUA_BINDINGS=${LUA}	 			# "Build Lua bindings" OFF
		-DBUILD_SAMPLES=ON 						# "Build samples" OFF
		-DBUILD_SHARED_LIBS=OFF					# "Build shared (dynamic) libraries" ON
		-DBUILD_TESTING=ON 						#  OFF
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
		-RMLUI_LUA_AS_CXX=OFF					# "Lua library was compiled with a C++ compiler" OFF
		-DRMLUI_TRACY_CONFIGURATION=OFF			# "Enable a separate Tracy configuration type for multi-config generators such as Visual Studio, otherwise enable Tracy in all configurations." ON
		-DRMLUI_TRACY_MEMORY_PROFILING=OFF		# "Overload global operator new/delete to track memory allocations in Tracy." ON
		-DRMLUI_TRACY_PROFILING=OFF				# "Enable profiling with Tracy. Source files can be placed in Dependencies/tracy." OFF
		-DRMLUI_VK_DEBUG=OFF					# "Enable debugging mode for Vulkan renderer." OFF
		"-DSAMPLES_BACKEND=SDL_SDLrenderer"		# "Backend platform and renderer used for the samples." "auto" 
		-DWARNINGS_AS_ERRORS=OFF				# "Treat compiler warnings as errors." OFF
		${FREETYPE_CMAKE} 
		${HARFBUZZ_CMAKE}
		${LIBJPEG_TURBO_CMAKE}
		${LIBPNG_CMAKE}
		#${LUA_CMAKE}
		#${LUAJIT_CMAKE}
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
		${ZSTD_CMAKE})
	
	ANDROID_dk_configure(${RMLUI_MASTER}
		"-DCMAKE_CXX_FLAGS=-DRMLUI_STATIC_LIB -DCHOBO_FLAT_MAP_NO_THROW -std=c++1z"
		-DBUILD_FRAMEWORK=OFF 					# "Build Framework bundle for OSX" OFF
		-DBUILD_LUA_BINDINGS_FOR_LUAJIT=OFF 	# "Build Lua bindings using luajit" OFF
		-DBUILD_LUA_BINDINGS=${LUA}	 			# "Build Lua bindings" OFF
		-DBUILD_SAMPLES=ON 						# "Build samples" OFF
		-DBUILD_SHARED_LIBS=OFF					# "Build shared (dynamic) libraries" ON
		-DBUILD_TESTING=ON 					    #  OFF
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
		"-DSAMPLES_BACKEND=SDL_SDLrenderer"		# "Backend platform and renderer used for the samples." "auto" 
		-DWARNINGS_AS_ERRORS=OFF				# "Treat compiler warnings as errors." OFF
		${FREETYPE_CMAKE} 
		${HARFBUZZ_CMAKE}
		${LIBJPEG_TURBO_CMAKE}
		${LIBPNG_CMAKE}
		#${LUA_CMAKE}
		#${LUAJIT_CMAKE}
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
		${ZSTD_CMAKE})
else()									
	
	# https://stackoverflow.com/a/37038641/688352
	# The first line of the configure below "-DCMAKE_EXE_LINKER_FLAGS=-lWinmm -lsetupapi -lversion"  provides the linker 
	# libraries for the executable rmlui samples. Most of the time, we don't compile test apps and executables in
	# other libraries that require their own linkage. This is just an example of how to deal with those missing link time libs.
	# In Fact, If you look in Genererate.cmake, you'll see how the collection of link time library's are provided to the DK app.
	# So all in all, That list of needed targetd already exists by the time we get here.

	#string(APPEND SampleDependencies "-DCMAKE_EXE_LINKER_FLAGS=")
	#string(APPEND SampleDependencies " -lpthread")
	#string(APPEND SampleDependencies " -lsetupapi")
	#string(APPEND SampleDependencies " -lversion")
	#string(APPEND SampleDependencies " -lWinmm")
	#string(APPEND SampleDependencies " -L${LIBJPEG_TURBO}/${OS}/${DEBUG_DIR} -lturbojpeg")
	#string(APPEND SampleDependencies " -L${LIBPNG}/${OS}/${DEBUG_DIR} -lpng16d")
	#string(APPEND SampleDependencies " -L${TIFF}/${OS}/${DEBUG_DIR}/libtiff -ltiff")
	#string(APPEND SampleDependencies " -L${XZ}/${OS}/${DEBUG_DIR} -llzma")
	#string(APPEND SampleDependencies " -L${ZLIB}/${OS}/${DEBUG_DIR} -lzlibstatic")
	#string(APPEND SampleDependencies " -L${ZSTD}/${OS}/${DEBUG_DIR}/lib -lzstd")
	
	dk_configure(${RMLUI_MASTER}
		"-DSAMPLES_BACKEND=SDL_SDLrenderer"			# "Backend platform and renderer used for the samples." "auto" 
		#-DBUILD_FRAMEWORK=OFF 						# "Build Framework bundle for OSX" OFF
		#-DBUILD_LUA_BINDINGS=${LUAJIT}	 			# "Build Lua bindings" OFF
		#-DBUILD_LUA_BINDINGS_FOR_LUAJIT=${LUAJIT} 	# "Build Lua bindings using luajit" OFF
		-DBUILD_SAMPLES=ON 							# "Build samples" OFF
		-DBUILD_SHARED_LIBS=OFF						# "Build shared (dynamic) libraries" ON
		-DBUILD_TESTING=ON 							#  OFF
		-DBUILD_UNIVERSAL_BINARIES=OFF 				# "Build universal binaries for all architectures supported" ON
		#-DCUSTOM_CONFIGURATION=OFF					# "Customize RmlUi configuration files for overriding the default configuration and types." OFF
		#-DDISABLE_RTTI_AND_EXCEPTIONS=OFF			# "Build with rtti and exceptions disabled." OFF
		-DENABLE_HARFBUZZ=${HARFBUZZ}				# "Enable HarfBuzz for text-shaping sample. Requires the HarfBuzz library." OFF
		-DENABLE_LOTTIE_PLUGIN=${RLOTTIE} 			# "Enable plugin for Lottie animations. Requires the rlottie library." OFF
		-DENABLE_PRECOMPILED_HEADERS=OFF			# "Enable precompiled headers" ON
		#-DENABLE_SVG_PLUGIN=${LUNASVG}				# "Enable plugin for SVG images. Requires the lunasvg library." OFF
		#-DMATRIX_ROW_MAJOR=OFF 					# "Use row-major matrices. Column-major matrices are used by default." OFF
		#-DNO_FONT_INTERFACE_DEFAULT=OFF			# "Do not include the default font engine in the build. Allows building without the FreeType dependency, but a custom font engine must be created and set." OFF
		#-DNO_THIRDPARTY_CONTAINERS=OFF				# "Only use standard library containers." OFF
		-DRMLUI_TRACY_CONFIGURATION=OFF				# "Enable a separate Tracy configuration type for multi-config generators such as Visual Studio, otherwise enable Tracy in all configurations." ON
		-DRMLUI_TRACY_MEMORY_PROFILING=OFF			# "Overload global operator new/delete to track memory allocations in Tracy." ON
		#-DRMLUI_TRACY_PROFILING=OFF				# "Enable profiling with Tracy. Source files can be placed in Dependencies/tracy." OFF
		#-DRMLUI_VK_DEBUG=OFF						# "Enable debugging mode for Vulkan renderer." OFF
		#-DWARNINGS_AS_ERRORS=OFF					# "Treat compiler warnings as errors." OFF
		${FREETYPE_CMAKE} 
		${HARFBUZZ_CMAKE}
		${LIBJPEG_TURBO_CMAKE}
		${LIBPNG_CMAKE}
		#${LUA_CMAKE}
		#${LUAJIT_CMAKE}
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
		${ZSTD_CMAKE})
endif()


### COMPILE ###
if(rmlui_all)
	dk_build(${RMLUI_MASTER})
else()
	if(rmlui_RmlCore)
		dk_build(${RMLUI_MASTER} RmlCore)
	endif()

	if(rmlui_RmlDebugger)
		dk_build(${RMLUI_MASTER} RmlDebugger)
	endif()
	
	if(rmlui_shell)
		dk_build(${RMLUI_MASTER} shell)
	endif()
	
	if(rmlui_treeview)
		dk_build(${RMLUI_MASTER} treeview)
	endif()
	
	if(rmlui_invaders)
		dk_build(${RMLUI_MASTER} invaders)
	endif()
endif()
