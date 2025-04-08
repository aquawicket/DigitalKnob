#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


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
