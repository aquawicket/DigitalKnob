# https://github.com/zeux/pugixml


#DKIMPORT(https://github.com/zeux/pugixml.git)
DKIMPORT(https://github.com/zeux/pugixml/releases/download/v1.6/pugixml-1.6.zip PATCH)



if(ANDROID)
	DKDEFINE(PUGIXML_NO_EXCEPTIONS)
endif()
