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


############ chart.js ############
# https://github.com/chartjs/Chart.js
# https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js
# https://www.chartjs.org/
# https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js

dk_import()


#dk_set(chart.js_VERSION 2.9.4)
#dk_set(chart.js_FOLDER chart.min-${chart.js_VERSION})
#dk_set(chart.js_DL https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js)
#dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
#dk_set(chart.js ${DK3RDPARTY_DIR}/${chart.js_FOLDER})
#dk_import(${chart.js_DL} ${chart.js})


## if(${CHARTJS_MAJOR} GREATER_EQUAL 3)
## dk_import(https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js ${CHARTJS})
## else()
	#dk_import(${chart.js_DL} ${chart.js})
## endif()
