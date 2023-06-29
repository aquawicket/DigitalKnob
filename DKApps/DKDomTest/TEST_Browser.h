#pragma once
#ifndef TEST_Browser_H
#define TEST_Browser_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_Browser //: public DKObjectT<TEST_Browser>
{
public:
	static DKSdlWindow* 	window;
	DKRmlInterface* 		dkRmlInterfaceA;
	DKRmlEventListener* 	dkRmlEventListenerA;
	static DKRmlLocation*	location;
	static DKRmlDocument*	document;
	
	TEST_Browser(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Browser.h //////");
		
		window = 			new DKSdlWindow();
		dkRmlInterfaceA = 		new DKRmlInterface(window);
		dkRmlEventListenerA = 	new DKRmlEventListener();
		location = 		new DKRmlLocation(dkRmlInterfaceA, dkRmlEventListenerA);
		location->href("DKWebTest/index.html");
		document = 		DKRmlDocument::instance(dkRmlInterfaceA, dkRmlEventListenerA);
		document->addEventListener("load", &TEST_Browser::onLoad);
		
		DKEvent load_event("load", "");
		document->dispatchEvent(load_event);
	}
	
	~TEST_Browser(){
		delete window;
		delete dkRmlInterfaceA;
		delete dkRmlEventListenerA;
		delete location;
		delete document;
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
					item->style()->setProperty("color", "rgb(0,0,255)");
					item->style()->setProperty("text-decoration", "underline");
					item->addEventListener("click", &TEST_Browser::onHyperlink);
				}
			}
		}
	}
	
	static void onHyperlink(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("onHyperlink()");
		DKElement* target = dynamic_cast<DKElement*>(&event.target());
		DOMString value = target->getAttribute("href");
		TEST_Browser::location->href(value);
	}
};
//REGISTER_OBJECT(TEST_Browser, true);

DKSdlWindow* 	TEST_Browser::window;
DKRmlLocation*	TEST_Browser::location;
DKRmlDocument*	TEST_Browser::document;


#endif //TEST_Browser_H