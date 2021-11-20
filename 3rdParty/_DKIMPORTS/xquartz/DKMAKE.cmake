# https://www.xquartz.org/
# https://www.xquartz.org/releases/index.html
#
# https://github.com/XQuartz/XQuartz/releases/download/XQuartz-2.8.1/XQuartz-2.8.1.dmg
if(MAC)
	DKDEPEND(homebrew)
endif()


### INSTALL ###
#if(NOT EXISTS ${XQUARTZ})
if(CMAKE_HOST_MAC)
		DKCOMMAND("brew install cmake")
endif()
#endif()

# Other install methods
# sudo port -v install xorg-server
# or
# sudo port -v install xorg
# or
# brew install --cask xquartz

# Build fill library method
#DKSET(XQUARTZ_VERSION 2.8.1)
#DKSET(XQUARTZ_NAME XQuartz-${XQUARTZ_VERSION})
#DKSET(XQUARTZ_DL https://github.com/XQuartz/XQuartz/releases/download/${XQUARTZ_NAME}/${XQUARTZ_NAME}.dmg)
#DKSET(XQUARTZ FIXME)

### INSTALL ###
#IF(NOT EXISTS ${XQUARTZ})
#	DOWNLOAD(${XQUARTZ_DL} ${DKDOWNLOAD}/${XQUARTZ_NAME}.dmg)
#	DKSET(QUEUE_BUILD ON)
#	MAC_COMMAND(${DKDOWNLOAD}/${XQUARTZ_NAME}.dmg)
#ENDIF()