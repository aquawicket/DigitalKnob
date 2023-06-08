#pragma once
#ifndef TEST_DKRmlDocument_H
#define TEST_DKRmlDocument_H

#include "DKRmlDocument/DKRmlDocument.h"
#include "TEST_DKSdlWindow.h"


class TEST_DKRmlDocument //: public DKObjectT<TEST_DKRmlDocument>
{
public:
	//DKRmlDocument dkRmlDocument;					// goes out of scope
	static DKRmlDocument* dkRmlDocument;			// dangling pointer
	//std::unique_ptr<DKRmlDocument> dkRmlDocument;
	
	TEST_DKRmlDocument(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlDocument.h //////");
		
		//dkRmlDocument = new DKRmlDocument(TEST_DKSdlWindow::Get()->dkSdlWindow);
		dkRmlDocument = new DKRmlDocument(TEST_DKSdlWindow::dkSdlWindow);
		//dkRmlDocument = std::make_unique<DKRmlDocument>(TEST_DKSdlWindow::dkSdlWindow);	
		
		printRmlDocumentProperties(*dkRmlDocument);
	}
	
	static void printRmlDocumentProperties(DKRmlDocument& dkRmlDocument){
		DKDEBUGFUNC(dkRmlDocument);
		
		TEST_Document::printDocumentProperties(dynamic_cast<DKDocument&>(dkRmlDocument));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlDocument, true);

DKRmlDocument* TEST_DKRmlDocument::dkRmlDocument;

#endif //TEST_DKRmlDocument_H