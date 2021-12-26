# https://guide.macports.org/#installing.macports
# https://github.com/macports/macports-base
# https://github.com/macports/macports-base/releases
#
# https://github.com/macports/macports-base/releases/download/v2.7.1/MacPorts-2.7.1-11-BigSur.pkg

### VERSION ###
DKSET(MACPORTS_VERSION 2.7.1-11-BigSur)
DKSET(MACPORTS_NAME MacPorts-${MACPORTS_VERSION}.pkg)
DKSET(MACPORTS_DL https://github.com/macports/macports-base/releases/download/v2.7.1/${MACPORTS_NAME})

if(NOT EXISTS ${DKDOWNLOAD}/${MACPORTS_NAME})
	DOWNLOAD(${MACPORTS_DL} ${DKDOWNLOAD}/${MACPORTS_NAME})
	DKSET(QUEUE_BUILD ON)
	MAC_DKQCOMMAND(${DKDOWNLOAD}/${MACPORTS_NAME})
endif()