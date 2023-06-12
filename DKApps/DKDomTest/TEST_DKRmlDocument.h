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
		
		//////////// TESTS ////////////
		// readonly attribute Element? documentElement;
		DKElement* document = dkRmlDocument->documentElement();
		DKINFO("document->tagName() = "+document->tagName()+"\n");
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		DKHTMLCollection* elements = dkRmlDocument->getElementsByTagName("a");
		if(!elements)
			DKERROR("elements invalid! \n");
		
		// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
		DKElement* div = dkRmlDocument->createElement("div");
		DKINFO("div->tagName() = "+div->tagName()+"\n");
		
		// Element? getElementById(DOMString elementId);
		DKElement* body = dkRmlDocument->getElementById("body");
		DKINFO("body->tagName() = "+body->tagName()+"\n");
		///////////////////////////////

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