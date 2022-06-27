# https://github.com/chartjs/Chart.js
# https://www.chartjs.org/
#
# https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js
# https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js

dk_import(https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js)

### VERSION ###
#dk_set(CHART.JS_VERSION 2.9.4)
#dk_set(CHART.JS_NAME chart.min-${CHART.JS_VERSION})
#dk_set(CHART.JS_DL https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js)
#dk_set(CHART.JS ${3RDPARTY}/${CHART.JS_NAME})
#dk_install(${CHART.JS_DL} ${CHART.JS})


### INSTALL ###
## if(${CHARTJS_MAJOR} GREATER_EQUAL 3)
## dk_install(https://cdn.jsdelivr.net/npm/chart.js@${CHARTJS_MAJOR}.${CHARTJS_MINOR}.${CHARTJS_BUILD}/dist/chart.min.js ${CHARTJS})
## else()
	#dk_install(${CHART.JS_DL} ${CHART.JS})
## endif()
