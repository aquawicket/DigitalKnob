# https://github.com/chartjs/Chart.js
# https://www.chartjs.org/
#
# https://github.com/chartjs/Chart.js/releases/download/v2.9.3/Chart.min.js
# https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js

### VERSION ###
DKSET(CHARTJS_MAJOR 2)
DKSET(CHARTJS_MINOR 9)
DKSET(CHARTJS_BUILD 3)
DKSET(CHARTJS_VERSION ${CHARTJS_MAJOR}.${CHARTJS_MINOR}.${CHARTJS_BUILD})
DKSET(CHARTJS_NAME chart.min-${CHARTJS_VERSION})
DKSET(CHARTJS_DL https://github.com/chartjs/Chart.js/releases/download/v${CHARTJS_VERSION}/Chart.min.js)
DKSET(CHARTJS ${3RDPARTY}/${CHARTJS_NAME})

## https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js

### INSTALL ###
## if(${CHARTJS_MAJOR} GREATER_EQUAL 3)
## DKINSTALL(https://cdn.jsdelivr.net/npm/chart.js@${CHARTJS_MAJOR}.${CHARTJS_MINOR}.${CHARTJS_BUILD}/dist/chart.min.js Chart.js ${CHARTJS})
## else()
DKINSTALL(${CHARTJS_DL} chart.js ${CHARTJS})
## endif()
