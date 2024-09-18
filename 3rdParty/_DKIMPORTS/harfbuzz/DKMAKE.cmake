include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/harfbuzz/harfbuzz.git


dk_depend(freetype)
dk_printVar(FREETYPE_CMAKE)
dk_depend(python3)


### IMPORT ###
#dk_import(https://github.com/harfbuzz/harfbuzz.git BRANCH main)
dk_import(https://github.com/harfbuzz/harfbuzz/archive/refs/heads/main.zip)
dk_printVar(plugin)


### LINK ###
dk_include				(${HARFBUZZ_DIR}/src						HARFBUZZ_INCLUDE_DIR)
if(MSVC)
	WIN_dk_libDebug		(${HARFBUZZ_DEBUG_DIR}/harfbuzz.lib			HARFBUZZ_DEBUG_LIBRARY)
	WIN_dk_libRelease	(${HARFBUZZ_RELEASE_DIR}/harfbuzz.lib		HARFBUZZ_RELEASE_LIBRARY)
else()
	dk_libDebug			(${HARFBUZZ_CONFIG_DIR}/libharfbuzz.a		HARFBUZZ_DEBUG_LIBRARY)
	dk_libRelease		(${HARFBUZZ_CONFIG_DIR}/libharfbuzz.a		HARFBUZZ_RELEASE_LIBRARY)
endif()


### GENERATE ###
dk_configure(${HARFBUZZ_DIR} 
	-DHB_BUILD_SUBSET=ON			# "Build harfbuzz-subset" ON
	-DHB_BUILD_UTILS=OFF			# "Build harfbuzz utils, needs cairo, freetype, and glib properly be installed" OFF
	-DHB_HAVE_CAIRO=OFF 			# "Enable cairo interop helpers" OFF
	-DHB_HAVE_CORETEXT=ON 			# "Enable CoreText shaper backend on macOS" ON
	-DHB_HAVE_DIRECTWRITE=OFF		# "Enable DirectWrite shaper backend on Windows" OFF
	-DHB_HAVE_FREETYPE=${FREETYPE} 	# "Enable freetype interop helpers" OFF
	-DHB_HAVE_GDI=OFF				# "Enable GDI integration helpers on Windows" OFF
	-DHB_HAVE_GLIB=OFF				# "Enable glib unicode functions" OFF
	-DHB_HAVE_GOBJECT=OFF			# "Enable GObject Bindings" OFF
	-DHB_HAVE_GRAPHITE2=OFF 		# "Enable Graphite2 complementary shaper" OFF
	-DHB_HAVE_ICU=OFF				# "Enable icu unicode functions" OFF
	-DHB_HAVE_INTROSPECTION=OFF		# "Enable building introspection (.gir/.typelib) files" OFF
	-DHB_HAVE_UNISCRIBE=OFF 		# "Enable Uniscribe shaper backend on Windows" OFF
	${FREETYPE_CMAKE}
	${PYTHON3_CMAKE})


### 3RDPARTY LINK ###
DEBUG_dk_set	(HARFBUZZ_CMAKE -DHARFBUZZ_INCLUDE_DIR=${HARFBUZZ_INCLUDE_DIR} -DHARFBUZZ_LIBRARY=${HARFBUZZ_DEBUG_LIBRARY})
RELEASE_dk_set	(HARFBUZZ_CMAKE -DHARFBUZZ_INCLUDE_DIR=${HARFBUZZ_INCLUDE_DIR} -DHARFBUZZ_LIBRARY=${HARFBUZZ_RELEASE_LIBRARY})


### COMPILE ###
dk_build(${HARFBUZZ_DIR})

