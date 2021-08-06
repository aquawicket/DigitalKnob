### VERSION ###
DKSET(CHARTJS_MAJOR 2)
DKSET(CHARTJS_MINOR 9)
DKSET(CHARTJS_BUILD 4)
DKSET(CHARTJS_VERSION Chart.js-${CHARTJS_MAJOR}.${CHARTJS_MINOR}.${CHARTJS_BUILD})
DKSET(CHARTJS ${3RDPARTY}/${CHARTJS_VERSION})

## https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js

### INSTALL ###
## if(${CHARTJS_MAJOR} GREATER_EQUAL 3)
## DKINSTALL(https://cdn.jsdelivr.net/npm/chart.js@${CHARTJS_MAJOR}.${CHARTJS_MINOR}.${CHARTJS_BUILD}/dist/chart.min.js Chart.js ${CHARTJS})
## else()
DKINSTALL(https://cdn.jsdelivr.net/npm/chart.js@${CHARTJS_MAJOR}.${CHARTJS_MINOR}.${CHARTJS_BUILD}/dist/Chart.min.js Chart.js ${CHARTJS})
## endif()
