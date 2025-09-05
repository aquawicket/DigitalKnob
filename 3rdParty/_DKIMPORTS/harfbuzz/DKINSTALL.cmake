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


############ harfbuzz ############
# https://github.com/harfbuzz/harfbuzz.git

dk_depend(freetype)
dk_depend(python3)

### IMPORT ###
dk_import()

### LINK ###
dk_include			(${harfbuzz}/src							HARFBUZZ_INCLUDE_DIR)
if(MSVC AND Windows)
	dk_libDebug		(${harfbuzz_Debug_Dir}/harfbuzz.lib			HARFBUZZ_DEBUG_LIBRARY		HARFBUZZ_LIBRARY)
	dk_libRelease	(${harfbuzz_Release_Dir}/harfbuzz.lib		HARFBUZZ_RELEASE_LIBRARY	HARFBUZZ_LIBRARY)
else()
	dk_libDebug		(${harfbuzz_Config_Dir}/libharfbuzz.a		HARFBUZZ_DEBUG_LIBRARY		HARFBUZZ_LIBRARY)
	dk_libRelease	(${harfbuzz_Config_Dir}/libharfbuzz.a		HARFBUZZ_RELEASE_LIBRARY	HARFBUZZ_LIBRARY)
endif()


### GENERATE ###
dk_configure(${harfbuzz} 
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
	${freetype_CMAKE}
	${python3_CMAKE})

### 3RDPARTY LINK ###
dk_set(harfbuzz_CMAKE -DHARFBUZZ_INCLUDE_DIR=${HARFBUZZ_INCLUDE_DIR} -DHARFBUZZ_LIBRARY=${HARFBUZZ_LIBRARY})

### COMPILE ###
dk_build()

