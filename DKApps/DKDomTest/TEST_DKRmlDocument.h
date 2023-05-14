#pragma once
#ifndef TEST_DKRmlDocument_H
#define TEST_DKRmlDocument_H

#include "DKRmlDocument/DKRmlDocument.h"


class TEST_DKRmlDocument : public DKObjectT<TEST_DKRmlDocument>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKRmlDocument.h ////// \n");
		
		DKRmlDocument rmldocument;
		printRmlDocumentProperties(rmldocument);
		return true;
	}
	
	static void printRmlDocumentProperties(DKRmlDocument& rmldocument){
		DKDEBUGFUNC(rmldocument);
		DKTODO();
	}

};
REGISTER_OBJECT(TEST_DKRmlDocument, true);


#endif //TEST_DKRmlDocument_H