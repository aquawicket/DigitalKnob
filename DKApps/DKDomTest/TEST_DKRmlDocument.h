#pragma once
#ifndef TEST_DKRmlDocument_H
#define TEST_DKRmlDocument_H

#include "DKRmlDocument/DKRmlDocument.h"
#include "DKRmlCSSStyleDeclaration/DKRmlCSSStyleDeclaration.h"


class TEST_DKRmlDocument //: public DKObjectT<TEST_DKRmlDocument>
{
public:
	static DKRmlDocument* dkRmlDocument;
	//std::unique_ptr<DKRmlDocument> dkRmlDocument;
	
	TEST_DKRmlDocument() {
		//DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlDocument.h //////");
		
		dkRmlDocument = new DKRmlDocument(TEST_DKRmlInterface::dkRmlInterface);
		//dkRmlDocument = std::make_unique<DKRmlDocument>(TEST_DKRmlInterface::dkRmlInterface);
		
		//////////// TESTS ////////////
		// readonly attribute Element? documentElement;
		DKElement* document = dkRmlDocument->documentElement();
		console.log("document->tagName() = "+document->tagName());
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		DKHTMLCollection* elements = dkRmlDocument->getElementsByTagName("a");
		if(!elements)
			console.error("elements invalid!");
		
		// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
		DKElement* div = dkRmlDocument->createElement("div");
		console.log("div->tagName() = "+div->tagName());
		
		// Element? getElementById(DOMString elementId);
		DKElement* body = dkRmlDocument->getElementById("body");
		console.log("body->tagName() = "+body->tagName());
		///////////////////////////////
		
		
		//////////// Post processing <a hfer></a> hyperlinks ////////////
		DKHTMLCollection* aElements = dkRmlDocument->getElementsByTagName("a");
		if(!aElements){
			console.error("aElements invalid!");
		}
		else{
			console.log("aElement.length() = "+toString(aElements->length()));
			for(unsigned int i=0; i<aElements->length(); ++i){
				//console.log("aElement["+toString(i)+"]");
				//DKElement* item = aElements->item(i);
				if (!aElements->item(i))
					console.error("aElements->item("+toString(i)+") invalid!");
				DKElement& item = *aElements->item(i);
				//if(!item)
					//console.error("item invalid!");
				//if(item->hasAttribute("href")){
				if (item.hasAttribute("href")) {
					//console.log("item()->hasAttribute('href')");
					//item->style().setProperty("color", "rgb(0,0,255)");
					item.style().setProperty("color", "rgb(0,0,255)");
					item.style().setProperty("text-decoration", "underline");
					item.addEventListener("click", &TEST_DKRmlDocument::onHyperlink);
				}
			}
		}

		printRmlDocumentProperties(*dkRmlDocument);
	}
	
	~TEST_DKRmlDocument() {
		delete dkRmlDocument;
	}
	
	static void onHyperlink(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("onHyperlink()");
	}
	
	static void printRmlDocumentProperties(DKRmlDocument& dkRmlDocument){
		DKDEBUGFUNC(dkRmlDocument);
		
		TEST_Document::printDocumentProperties(dynamic_cast<DKDocument&>(dkRmlDocument));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlDocument, true);

DKRmlDocument* TEST_DKRmlDocument::dkRmlDocument;

#endif //TEST_DKRmlDocument_H