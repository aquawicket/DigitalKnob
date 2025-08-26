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

dk_validate(Target_Config  "dk_Target_Config()")

dk_depend(freetype)
dk_depend(python3)

### IMPORT ###
dk_import(${harfbuzz_Import})

### LINK ###
dk_include			(${HARFBUZZ}/src						HARFBUZZ_INCLUDE_DIR)
if(MSVC AND Windows)
	dk_libDebug		(${HARFBUZZ_Debug_Dir}/harfbuzz.lib			HARFBUZZ_DEBUG_LIBRARY)
	dk_libRelease	(${HARFBUZZ_Release_Dir}/harfbuzz.lib		HARFBUZZ_RELEASE_LIBRARY)
else()
	dk_libDebug		(${HARFBUZZ_Config_Dir}/libharfbuzz.a		HARFBUZZ_DEBUG_LIBRARY)
	dk_libRelease	(${HARFBUZZ_Config_Dir}/libharfbuzz.a		HARFBUZZ_RELEASE_LIBRARY)
endif()
if(Debug)
	dk_set			(HARFBUZZ_LIBRARY							${HARFBUZZ_DEBUG_LIBRARY})
endif()
if(Release)
	dk_set			(HARFBUZZ_LIBRARY							${HARFBUZZ_RELEASE_LIBRARY})
endif()

### GENERATE ###
dk_configure(${HARFBUZZ} 
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
dk_build()

