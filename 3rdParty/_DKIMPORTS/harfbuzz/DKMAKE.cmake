#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ harfbuzz ############
# https://github.com/harfbuzz/harfbuzz.git

dk_load(dk_builder)

dk_depend(freetype)
dk_depend(python3)

### IMPORT ###
dk_import(https://github.com/harfbuzz/harfbuzz/archive/c1c0e82e.zip)

### LINK ###
dk_include			(${HARFBUZZ_DIR}/src						HARFBUZZ_INCLUDE_DIR)
if(MSVC AND WIN)
	dk_libDebug		(${HARFBUZZ_DEBUG_DIR}/harfbuzz.lib			HARFBUZZ_DEBUG_LIBRARY)
	dk_libRelease	(${HARFBUZZ_RELEASE_DIR}/harfbuzz.lib		HARFBUZZ_RELEASE_LIBRARY)
else()
	dk_libDebug		(${HARFBUZZ_CONFIG_DIR}/libharfbuzz.a		HARFBUZZ_DEBUG_LIBRARY)
	dk_libRelease	(${HARFBUZZ_CONFIG_DIR}/libharfbuzz.a		HARFBUZZ_RELEASE_LIBRARY)
endif()
if(DEBUG)
	dk_set			(HARFBUZZ_LIBRARY							${HARFBUZZ_DEBUG_LIBRARY})
endif()
if(RELEASE)
	dk_set			(HARFBUZZ_LIBRARY							${HARFBUZZ_RELEASE_LIBRARY})
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
dk_set(HARFBUZZ_CMAKE -DHARFBUZZ_INCLUDE_DIR=${HARFBUZZ_INCLUDE_DIR} -DHARFBUZZ_LIBRARY=${HARFBUZZ_LIBRARY})

### COMPILE ###
dk_build(${HARFBUZZ_DIR})

