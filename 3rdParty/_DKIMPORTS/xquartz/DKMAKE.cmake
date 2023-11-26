# https://www.xquartz.org/
# https://www.xquartz.org/releases/index.html
# https://github.com/XQuartz/XQuartz/releases/download/XQuartz-2.8.1/XQuartz-2.8.1.dmg

if(NOT MAC)
	dk_undepend(xquartz)
	dk_return()
endif()

dk_depend(homebrew)


### INSTALL ###
#if(NOT EXISTS ${XQUARTZ})
	dk_command(brew install --cask xquartz)
	dk_include(/opt/X11/include)
#endif()

# Other install methods
# sudo port -v install xorg-server
# or
# sudo port -v install xorg
# or
# brew install --cask xquartz

# Build fill library method
#dk_set(XQUARTZ_VERSION 2.8.1)
#dk_set(XQUARTZ_NAME XQuartz-${XQUARTZ_VERSION})
#dk_set(XQUARTZ_DL https://github.com/XQuartz/XQuartz/releases/download/${XQUARTZ_NAME}/${XQUARTZ_NAME}.dmg)
#dk_set(XQUARTZ FIXME)

### INSTALL ###
#IF(NOT EXISTS ${XQUARTZ})
#	dk_download(${XQUARTZ_DL} ${DKDOWNLOAD}/${XQUARTZ_NAME}.dmg)
#	dk_set(QUEUE_BUILD ON)
#	MAC_dk_queueCommand(${DKDOWNLOAD}/${XQUARTZ_NAME}.dmg)
#ENDIF()
