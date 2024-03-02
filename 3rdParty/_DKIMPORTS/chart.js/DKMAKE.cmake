# https://github.com/chartjs/Chart.js
# https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js
# https://www.chartjs.org/
# https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js

dk_import(https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js)


#dk_set(CHART.JS_VERSION 2.9.4)
#dk_set(CHART.JS_FOLDER chart.min-${CHART.JS_VERSION})
#dk_set(CHART.JS_DL https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js)
#dk_set(CHART.JS ${DK3RDPARTY_DIR}/${CHART.JS_FOLDER})
#dk_import(${CHART.JS_DL} ${CHART.JS})


## if(${CHARTJS_MAJOR} GREATER_EQUAL 3)
## dk_import(https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js ${CHARTJS})
## else()
	#dk_import(${CHART.JS_DL} ${CHART.JS})
## endif()
