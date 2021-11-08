# https://guide.macports.org/#installing.macports
# https://github.com/macports/macports-base
# https://github.com/macports/macports-base/releases
#
# https://github.com/macports/macports-base/releases/download/v2.7.1/MacPorts-2.7.1-11-BigSur.pkg

### VERSION ###
DKSET(MACPORTS_VERSION 2.7.1-11-BigSur)
DKSET(MACPORTS_NAME MacPorts-${MACPORTS_VERSION}.pkg)

if(NOT EXISTS ${DKDOWNLOAD}/${MACPORTS_NAME})
	DOWNLOAD(${MACPORTS_DL} ${DKDOWNLOAD}/${MACPORTS_NAME})
	MAC_COMMAND(${DKDOWNLOAD}/${MACPORTS_NAME})
endif()