if(NOT WIN_HOST)
	return()
endif()
## https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip

### VERSION ###
#dk_set(MSINTTYPES_VERSION r26)
#dk_set(MSINTTYPES_FOLDER msinttypes-${MSINTTYPES_VERSION})
#dk_set(MSINTTYPES_DL https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip)
#dk_set(MSINTTYPES ${3RDPARTY}/${MSINTTYPES_FOLDER})


### INSTALL ###
dk_import(https://raw.githubusercontent.com/SummersEpsilon/msinttypes/master/msinttypes-r26.zip)
