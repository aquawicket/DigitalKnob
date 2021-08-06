## https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip

### VERSION ###
DKSET(MSINTTYPES_VERSION r26)
DKSET(MSINTTYPES_NAME msinttypes-${MSINTTYPES_VERSION})
DKSET(MSINTTYPES_DL https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/${MSINTTYPES_NAME}.zip)
DKSET(MSINTTYPES ${3RDPARTY}/${MSINTTYPES_NAME})


### INSTALL ###
DKINSTALL(${MSINTTYPES_DL} msinttypes ${MSINTTYPES})