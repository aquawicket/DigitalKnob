# https://github.com/zeux/pugixml


#DKIMPORT(https://github.com/zeux/pugixml)
#DKIMPORT(https://github.com/zeux/pugixml/archive/363ebdde91214e456943822ddf422860af8bb54d.zip)
DKIMPORT(https://github.com/zeux/pugixml/releases/download/v1.6/pugixml-1.6.zip PATCH)
#DKSET(PUGIXML_VERSION 1.6)
#DKSET(PUGIXML_DL https://github.com/zeux/pugixml/releases/download/v1.6/pugixml-1.6.zip)
#DKSET(PUGIXML_NAME pugixml-${PUGIXML_VERSION})
#DKSET(PUGIXML ${3RDPARTY}/${PUGIXML_NAME})
#DKINSTALL(${PUGIXML_DL} pugixml ${PUGIXML})


if(ANDROID)
	DKDEFINE(PUGIXML_NO_EXCEPTIONS)
endif()
