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

dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKChart ############
dk_depend(moment)
dk_depend(chart.js)

if(MOMENT)
	dk_copy(${MOMENT}/ ${DKCPP_PLUGINS_DIR}/DKChart/)
	dk_rename(${DKCPP_PLUGINS_DIR}/DKChart/moment.js ${DKCPP_PLUGINS_DIR}/DKChart/moment.min.js OVERWRITE)
endif()
if(CHART.JS)
	dk_copy(${CHART.JS}/ ${DKCPP_PLUGINS_DIR}/DKChart/)
	dk_rename(${DKCPP_PLUGINS_DIR}/DKChart/chart.js-Chart.min.js ${DKCPP_PLUGINS_DIR}/DKChart/chart.min.js OVERWRITE)
endif()


dk_assets(DKChart)
