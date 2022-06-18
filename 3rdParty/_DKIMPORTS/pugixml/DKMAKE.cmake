# https://github.com/zeux/pugixml


#dk_import(https://github.com/zeux/pugixml.git)
dk_import(https://github.com/zeux/pugixml/releases/download/v1.6/pugixml-1.6.zip PATCH)



if(ANDROID)
	DKDEFINE(PUGIXML_NO_EXCEPTIONS)
endif()
