# https://guide.macports.org/#installing.macports
# https://github.com/macports/macports-base
# https://github.com/macports/macports-base/releases
#
# https://github.com/macports/macports-base/releases/download/v2.7.1/MacPorts-2.7.1-11-BigSur.pkg

### VERSION ###
dk_set(MACPORTS_VERSION 2.7.1-11-BigSur)
dk_set(MACPORTS_NAME MacPorts-${MACPORTS_VERSION}.pkg)
dk_set(MACPORTS_DL https://github.com/macports/macports-base/releases/download/v2.7.1/${MACPORTS_NAME})

if(NOT EXISTS ${DKDOWNLOAD_DIR}/${MACPORTS_NAME})
	dk_download(${MACPORTS_DL} ${DKDOWNLOAD_DIR}/${MACPORTS_NAME})
		
	MAC_dk_command(chmod +x ${DKDOWNLOAD_DIR}/${MACPORTS_NAME})
	dk_set(QUEUE_BUILD ON)
	#MAC_dk_queueCommand(${DKDOWNLOAD_DIR}/${MACPORTS_NAME}) #FIXME
endif()