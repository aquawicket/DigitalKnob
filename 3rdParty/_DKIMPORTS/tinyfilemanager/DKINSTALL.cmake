#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ tinyfilemanager ############
# https://github.com/prasathmani/tinyfilemanager/archive/dd2e22781badf48b041643c5b2e428dd7965405f.zip

dk_import()

#dk_fileReplace("${tinyfilemanager}/tinyfilemanager.php" "\'Tiny File Manager\')" "\'aquawicket.com\')")
#dk_fileReplace("${tinyfilemanager}/tinyfilemanager.php" "\'admin\' => \'$2y$10$/K.hjNr84lLNDt8fTXjoI.DBp6PpeyoJ.mGwrrLuCZfAwfSAGqhOW\', //admin@123" "\'aquawicket\' => \'$2y$10$UuW/awzwq0gjgXSjy4jGuO6ySEAZmhmO5kPDA75/arpag8EiV3q0G\'")
#dk_fileReplace("${tinyfilemanager}/tinyfilemanager.php" "\'user\' => \'$2y$10$Fg6Dz8oH9fPoZ2jJan5tZuv6Z4Kp7avtQ9bDfrdRntXtPeiMAZyGO\' //12345" "")
#dk_fileReplace("${tinyfilemanager}/tinyfilemanager.php" "highlightjs_style = \'vs\'" "highlightjs_style = \'ir-black\'")
#dk_fileReplace("${tinyfilemanager}/tinyfilemanager.php" ": 'light'"  ": 'dark'")
#dk_fileReplace("${tinyfilemanager}/tinyfilemanager.php" "isset(\$cfg->data[\'show_hidden\']) ? \$cfg->data[\'show_hidden\'] : " "")
#dk_fileReplace("${tinyfilemanager}/tinyfilemanager.php" "isset(\$cfg->data[\'theme\']) ? \$cfg->data[\'theme\'] : " "")