# https://www.xquartz.org/
#
# https://github.com/XQuartz/XQuartz/releases/download/XQuartz-2.8.1/XQuartz-2.8.1.dmg

DKSET(XQUARTZ_VERSION 2.8.1)
DKSET(XQUARTZ_NAME XQuartz-${XQUARTZ_VERSION})
DKSET(XQUARTZ_DL https://github.com/XQuartz/XQuartz/releases/download/${XQUARTZ_NAME}/${XQUARTZ_NAME}.dmg)
DKSET(XQUARTZ FIXME)

### INSTALL ###
IF(NOT EXISTS ${XQUARTZ})
	DOWNLOAD(${XQUARTZ_DL} ${DKDOWNLOAD}/${XQUARTZ_NAME}.dmg)
	DKSET(QUEUE_BUILD ON)
	MAC_COMMAND(${DKDOWNLOAD}/${XQUARTZ_NAME}.dmg)
ENDIF()