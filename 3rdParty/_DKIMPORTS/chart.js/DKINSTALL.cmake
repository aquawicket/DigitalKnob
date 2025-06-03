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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/chartjs/Chart.js
# https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js
# https://www.chartjs.org/
# https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js

dk_import(https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js)


#dk_set(CHART.JS_VERSION 2.9.4)
#dk_set(CHART.JS_FOLDER chart.min-${CHART.JS_VERSION})
#dk_set(CHART.JS_DL https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js)
#dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
#dk_set(CHART.JS $ENV{DK3RDPARTY_DIR}/${CHART.JS_FOLDER})
#dk_import(${CHART.JS_DL} ${CHART.JS})


## if(${CHARTJS_MAJOR} GREATER_EQUAL 3)
## dk_import(https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js ${CHARTJS})
## else()
	#dk_import(${CHART.JS_DL} ${CHART.JS})
## endif()
