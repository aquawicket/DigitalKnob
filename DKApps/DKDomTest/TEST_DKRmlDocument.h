#pragma once
#ifndef TEST_DKRmlDocument_H
#define TEST_DKRmlDocument_H

#include "DKSdlRmlDocument/DKSdlRmlDocument.h"

#include "DKRmlDocument/DKRmlDocument.h"
#include "TEST_DKSdlWindow.h"


class TEST_DKRmlDocument : public DKObjectT<TEST_DKRmlDocument>
{
public:
	DKRmlDocument* dkRmlDocument;
	
	DKSdlRmlDocument* dkSdlRmlDocument;
	
	bool Init(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlDocument.h //////");
		
		dkRmlDocument = new DKRmlDocument(*TEST_DKSdlWindow::Get()->dkSdlWindow);
		
		dkSdlRmlDocument = new DKSdlRmlDocument(TEST_DKSdlWindow::Get()->dkSdlWindow, dkRmlDocument);
		
		printRmlDocumentProperties(*dkRmlDocument);
		return true;
	}
	
	static void printRmlDocumentProperties(DKRmlDocument& dkRmlDocument){
		DKDEBUGFUNC(dkRmlDocument);
		
		TEST_Document::printDocumentProperties(dynamic_cast<DKDocument&>(dkRmlDocument));	//TODO: try to remove the need for dynamic_cast
	}
};
REGISTER_OBJECT(TEST_DKRmlDocument, true);


#endif //TEST_DKRmlDocument_H