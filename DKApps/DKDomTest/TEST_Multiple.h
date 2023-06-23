#pragma once
#ifndef TEST_Multiple_H
#define TEST_Multiple_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_Multiple //: public DKObjectT<TEST_Multiple>
{
public:
	DKSdlWindow* 			dkSdlWindowA;
	DKRmlInterface* 		dkRmlInterfaceA;
	DKRmlEventListener* 	dkRmlEventListenerA;
	static DKRmlLocation*	dkRmlLocationA;
	static DKRmlDocument*	dkRmlDocumentA;
	
	//DKSdlWindow* 			dkSdlWindowB;
	//DKRmlInterface* 		dkRmlInterfaceB;
	//DKRmlEventListener* 	dkRmlEventListenerB;
	//DKRmlLocation*		dkRmlLocationB;
	//DKRmlDocument*		dkRmlDocumentB;

	TEST_Multiple(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Multiple.h //////");
		
		dkSdlWindowA = 			new DKSdlWindow();
		dkRmlInterfaceA = 		new DKRmlInterface(dkSdlWindowA);
		dkRmlEventListenerA = 	new DKRmlEventListener();
		dkRmlLocationA = 		new DKRmlLocation(dkRmlInterfaceA, dkRmlEventListenerA);
		dkRmlLocationA->href("DKWebTest/index.html");
		dkRmlDocumentA = 		new DKRmlDocument(dkRmlInterfaceA, dkRmlEventListenerA);
		dkRmlDocumentA->addEventListener("load", &TEST_Multiple::onLoad);
		DKEvent load_event("load", "");
		dkRmlDocumentA->dispatchEvent(load_event);
		
		//dkSdlWindowB = 		new DKSdlWindow();
		//dkRmlInterfaceB = 	new DKRmlInterface(dkSdlWindowB);
		//dkRmlEventListenerB = new DKRmlEventListener();
		//dkRmlLocationB = 		new DKRmlLocation(dkRmlInterfaceB, dkRmlEventListenerB);
		//dkRmlLocationB->href("DKWebTest/index.html");
		//dkRmlDocumentB = 		new DKRmlDocument(dkRmlInterfaceB, dkRmlEventListenerB);
	}
	
	~TEST_Multiple(){
		delete dkSdlWindowA;
		delete dkRmlInterfaceA;
		delete dkRmlEventListenerA;
		delete dkRmlLocationA;
		delete dkRmlDocumentA;
		
		//delete dkSdlWindowB;
		//delete dkRmlInterfaceB;
		//delete dkRmlEventListenerB;
		//delete dkRmlLocationB;
		//delete dkRmlDocumentB;
	}
	
	static void onLoad(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("onLoad()");
		
		//////////// Post processing <a href></a> hyperlinks ////////////
		DKDocument* document = dynamic_cast<DKDocument*>(&event.target());
		DKHTMLCollection* aElements = document->getElementsByTagName("a");
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
					item->style().setProperty("color", "rgb(0,0,255)");
					item->style().setProperty("text-decoration", "underline");
					item->addEventListener("click", &TEST_Multiple::onHyperlink);
				}
			}
		}
	}
	
	static void onHyperlink(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("onHyperlink()");
		DKElement* target = dynamic_cast<DKElement*>(&event.target());
		DOMString value = target->getAttribute("href");
		TEST_Multiple::dkRmlLocationA->href(value);
	}
};
//REGISTER_OBJECT(TEST_Multiple, true);

DKRmlLocation*	TEST_Multiple::dkRmlLocationA;
DKRmlDocument*	TEST_Multiple::dkRmlDocumentA;

#endif //TEST_Multiple_H