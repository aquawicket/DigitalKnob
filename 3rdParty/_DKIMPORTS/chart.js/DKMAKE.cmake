# https://github.com/chartjs/Chart.js
# https://www.chartjs.org/
#
# https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js
# https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js

DKIMPORT(https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js)

### VERSION ###
#DKSET(CHART.JS_VERSION 2.9.4)
#DKSET(CHART.JS_NAME chart.min-${CHART.JS_VERSION})
#DKSET(CHART.JS_DL https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js)
#DKSET(CHART.JS ${3RDPARTY}/${CHART.JS_NAME})
#DKINSTALL(${CHART.JS_DL} chart.js ${CHART.JS})


### INSTALL ###
## if(${CHARTJS_MAJOR} GREATER_EQUAL 3)
## DKINSTALL(https://cdn.jsdelivr.net/npm/chart.js@${CHARTJS_MAJOR}.${CHARTJS_MINOR}.${CHARTJS_BUILD}/dist/chart.min.js Chart.js ${CHARTJS})
## else()
	#DKINSTALL(${CHART.JS_DL} chart.js ${CHART.JS})
## endif()
