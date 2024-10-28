#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKChart ############
dk_depend(moment)
dk_depend(chart.js)

if(MOMENT)
	dk_copy(${MOMENT}/ ${DKPLUGINS_DIR}/DKChart/)
	dk_rename(${DKPLUGINS_DIR}/DKChart/moment.js ${DKPLUGINS_DIR}/DKChart/moment.min.js OVERWRITE)
endif()
if(CHART.JS)
	dk_copy(${CHART.JS}/ ${DKPLUGINS_DIR}/DKChart/)
	dk_rename(${DKPLUGINS_DIR}/DKChart/chart.js-Chart.min.js ${DKPLUGINS_DIR}/DKChart/chart.min.js OVERWRITE)
endif()
dk_assets(DKChart)
