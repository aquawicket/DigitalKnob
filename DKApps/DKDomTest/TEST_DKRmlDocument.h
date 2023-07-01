#pragma once
#ifndef TEST_DKRmlDocument_H
#define TEST_DKRmlDocument_H

#include "DKRmlDocument/DKRmlDocument.h"
#include "DKRmlCSSStyleDeclaration/DKRmlCSSStyleDeclaration.h"


class TEST_DKRmlDocument //: public DKObjectT<TEST_DKRmlDocument>
{
public:
	static DKRmlDocument* _dkRmlDocument;
	//std::unique_ptr<DKRmlDocument> _dkSdlWindow;
	
	TEST_DKRmlDocument() {
		//DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlDocument.h //////");
		
		_dkSdlWindow = DKRmlDocument::instance(TEST_DKRmlInterface::_dkRmlInterface, TEST_DKRmlEventListener::_dkRmlEventListener);
		//_dkSdlWindow = std::make_unique<DKRmlDocument>(TEST_DKRmlInterface::dkRmlInterface);
		
		//////////// TESTS ////////////
		// readonly attribute Element? documentElement;
		DKElement* document = _dkSdlWindow->documentElement();
		console.log("document->tagName() = "+document->tagName());
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		DKHTMLCollection* elements = _dkSdlWindow->getElementsByTagName("a");
		if(!elements)
			console.error("elements invalid!");
		
		// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
		DKElement* div = _dkSdlWindow->createElement("div");
		console.log("div->tagName() = "+div->tagName());
		
		// Element? getElementById(DOMString elementId);
		DKElement* body = _dkSdlWindow->getElementById("body");
		console.log("body->tagName() = "+body->tagName());
		///////////////////////////////
		
		
		_dkSdlWindow->addEventListener("load", &TEST_DKRmlDocument::onLoad);
		DKEvent load_event("load", "");
		_dkSdlWindow->dispatchEvent(load_event);

		printRmlDocumentProperties(*_dkSdlWindow);
	}
	
	~TEST_DKRmlDocument() {
		delete _dkSdlWindow;
	}
	
	static void onLoad(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("onLoad()");
		
		//////////// Post processing <a href></a> hyperlinks ////////////
		DKHTMLCollection* aElements = _dkSdlWindow->getElementsByTagName("a");
		if(!aElements){
			console.error("aElements invalid!");
		}
		else{
			//console.log("aElement->length() = "+toString(aElements->length()));
			for(unsigned int i=0; i<aElements->length(); ++i){
				DKElement* item = aElements->item(i);
				if (!item)
					console.error("aElements->item(" + toString(i) + ") invalid!");
				if (item->hasAttribute("href")) {
					item->style()->setProperty("color", "rgb(0,0,255)");
					item->style()->setProperty("text-decoration", "underline");
					item->addEventListener("click", &TEST_DKRmlDocument::onHyperlink);
				}
			}
		}
	}
	
	static void onHyperlink(DKEvent& event){
		DKDEBUGFUNC(event);
		//console.log("onHyperlink()");
		DKElement* target = dynamic_cast<DKElement*>(&event.target());
		DOMString value = target->getAttribute("href");
		TEST_DKRmlLocation::_dkRmlLocation->href(value);
	}
	
	static void printRmlDocumentProperties(DKRmlDocument& dkRmlDocument){
		DKDEBUGFUNC(dkRmlDocument);
		
		console.log("dkRmlDocument = "				+toString(dkRmlDocument));
		
		TEST_Document::printDocumentProperties(dkRmlDocument);
	}
};
//REGISTER_OBJECT(TEST_DKRmlDocument, true);

DKRmlDocument* TEST_DKRmlDocument::_dkRmlDocument;

#endif //TEST_DKRmlDocument_H