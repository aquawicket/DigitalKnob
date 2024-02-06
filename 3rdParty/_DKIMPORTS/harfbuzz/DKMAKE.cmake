# https://github.com/harfbuzz/harfbuzz.git


### IMPORT ###
dk_import(https://github.com/harfbuzz/harfbuzz.git BRANCH main)


### LINK ###
dk_include		(${HARFBUZZ}/include								HARFBUZZ_INCLUDE_DIR)
dk_libDebug		(${HARFBUZZ}/${OS}/${DEBUG_DIR}/libharfbuzz.a		HARFBUZZ_DEBUG_LIBRARY)
dk_libRelease	(${HARFBUZZ}/${OS}/${RELEASE_DIR}/libharfbuzz.a		HARFBUZZ_RELEASE_LIBRARY)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} 
		-DHB_HAVE_CAIRO=OFF 		# "Enable cairo interop helpers" OFF
		-DHB_HAVE_FREETYPE=OFF 		# "Enable freetype interop helpers" OFF
		-DHB_HAVE_GRAPHITE2=OFF 	# "Enable Graphite2 complementary shaper" OFF
		-DHB_HAVE_GLIB=OFF			# "Enable glib unicode functions" OFF
		-DHB_HAVE_ICU=OFF			# "Enable icu unicode functions" OFF
		-DHB_HAVE_CORETEXT=ON 		# "Enable CoreText shaper backend on macOS" ON
		-DHB_HAVE_UNISCRIBE=OFF 	# "Enable Uniscribe shaper backend on Windows" OFF
		-DHB_HAVE_GDI=OFF			# "Enable GDI integration helpers on Windows" OFF
		-DHB_HAVE_DIRECTWRITE=OFF	# "Enable DirectWrite shaper backend on Windows" OFF
		-DHB_BUILD_UTILS=OFF		# "Build harfbuzz utils, needs cairo, freetype, and glib properly be installed" OFF
		-DHB_BUILD_SUBSET=ON		# "Build harfbuzz-subset" ON
		-DHB_HAVE_GOBJECT=OFF		# "Enable GObject Bindings" OFF
		-DHB_HAVE_INTROSPECTION=OFF	# "Enable building introspection (.gir/.typelib) files" OFF
		${HARFBUZZ})


### 3RDPARTY LINK ###
DEBUG_dk_set	(HARFBUZZ_CMAKE -DHARFBUZZ_INCLUDE_DIR=${HARFBUZZ_INCLUDE_DIR} -DHARFBUZZ_LIBRARY=${HARFBUZZ_DEBUG_LIBRARY})
RELEASE_dk_set	(HARFBUZZ_CMAKE -DHARFBUZZ_INCLUDE_DIR=${HARFBUZZ_INCLUDE_DIR} -DHARFBUZZ_LIBRARY=${HARFBUZZ_RELEASE_LIBRARY})


### COMPILE ###
dk_build(${HARFBUZZ})

