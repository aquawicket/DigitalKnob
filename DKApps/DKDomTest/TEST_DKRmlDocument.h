#pragma once
#ifndef TEST_DKRmlDocument_H
#define TEST_DKRmlDocument_H

#include "DKRmlDocument/DKRmlDocument.h"


class TEST_DKRmlDocument : public DKObjectT<TEST_DKRmlDocument>
{
public:
	DKRmlDocument dkRmlDocument;
	
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKRmlDocument.h //////\n");
		
		printRmlDocumentProperties(dkRmlDocument);
		return true;
	}
	
	static void printRmlDocumentProperties(DKRmlDocument& dkRmlDocument){
		DKDEBUGFUNC(dkRmlDocument);
		
		TEST_Document::printDocumentProperties(dynamic_cast<DKDocument&>(dkRmlDocument));	//TODO: try to remove the need for dynamic_cast
	}
};
REGISTER_OBJECT(TEST_DKRmlDocument, true);


#endif //TEST_DKRmlDocument_H