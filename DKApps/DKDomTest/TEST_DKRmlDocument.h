#pragma once
#ifndef TEST_DKRmlDocument_H
#define TEST_DKRmlDocument_H

#include "DKRmlDocument/DKRmlDocument.h"


class TEST_DKRmlDocument //: public DKObjectT<TEST_DKRmlDocument>
{
public:
	static DKRmlDocument* dkRmlDocument;
	//std::unique_ptr<DKRmlDocument> dkRmlDocument;
	
	TEST_DKRmlDocument() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlDocument.h //////");
		
		dkRmlDocument = new DKRmlDocument(TEST_DKRmlInterface::dkRmlInterface);
		//dkRmlDocument = std::make_unique<DKRmlDocument>(TEST_DKRmlInterface::dkRmlInterface);
		
		DKElement* body = dkRmlDocument->getElementById("body");
		if(body){
			DKINFO("body is valid \n");
		}
		else{
			DKINFO("body is invalid \n");
		}
		
		DOMString tagName = body->tagName();
		DKINFO("tagName = "+tagName+"\n");
		
		//DKElement* _getElementsByTagName = dkRmlDocument->getElementsByTagName("a");
		//DKINFO("_getElementsByTagName = "+_getElementsByTagName+"\n");
		
		printRmlDocumentProperties(*dkRmlDocument);
	}
	
	~TEST_DKRmlDocument() {
		delete dkRmlDocument;
	}
	
	static void printRmlDocumentProperties(DKRmlDocument& dkRmlDocument){
		DKDEBUGFUNC(dkRmlDocument);
		
		TEST_Document::printDocumentProperties(dynamic_cast<DKDocument&>(dkRmlDocument));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlDocument, true);

DKRmlDocument* TEST_DKRmlDocument::dkRmlDocument;

#endif //TEST_DKRmlDocument_H