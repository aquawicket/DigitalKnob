# https://github.com/zeux/pugixml 
#
# https://github.com/zeux/pugixml/releases/download/v1.11.4/pugixml-1.11.4.zip

### VERSION ###
DKSET(PUGIXML_MAJOR 1)
DKSET(PUGIXML_MINOR 11)
DKSET(PUGIXML_BUILD 4)
DKSET(PUGIXML_VERSION ${PUGIXML_MAJOR}.${PUGIXML_MINOR}.${PUGIXML_BUILD})
DKSET(PUGIXML_NAME pugixml-${PUGIXML_VERSION})
DKSET(PUGIXML_DL https://github.com/zeux/pugixml/releases/download/v${PUGIXML_VERSION}/${PUGIXML_NAME}.zip)
DKSET(PUGIXML ${3RDPARTY}/${PUGIXML_NAME})


### INSTALL ###
DKDEFINE(PUGIXML_NO_EXCEPTIONS)
DKINSTALL(${PUGIXML_DL} pugixml ${PUGIXML})
