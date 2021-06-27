## https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip

### VERSION ###
DKSET(MSINTTYPES_VERSION r26)
DKSET(MSINTTYPES_NAME msinttypes-${MSINTTYPES_VERSION})
DKSET(MSINTTYPES ${3RDPARTY}/${MSINTTYPES_NAME})


### INSTALL ###
DKINSTALL(https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/${MSINTTYPES_NAME}.zip msinttypes ${MSINTTYPES_NAME})