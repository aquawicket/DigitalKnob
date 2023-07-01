#pragma once
#ifndef TEST_Browser_H
#define TEST_Browser_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_Browser //: public DKObjectT<TEST_Browser>
{
public:
	static DKSdlWindow* 	window;
	DKRmlInterface* 		dkRmlInterface;
	DKRmlEventListener* 	dkRmlEventListener;
	static DKRmlLocation*	location;
	static DKRmlDocument*	document;
	
	TEST_Browser(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Browser.h //////");
		
		//////////// Setup ////////////
		console.log("/// DKSdlWindow /////////////////");
		window = 				new DKSdlWindow();
		console.log(" ");
		
		console.log("/// DKRmlInterface //////////////");
		dkRmlInterface = 		new DKRmlInterface(window);
		console.log(" ");
		
		console.log("/// DKRmlEventListener //////////");
		dkRmlEventListener = 	new DKRmlEventListener();
		console.log(" ");
		
		console.log("/// DKRmlLocation ///////////////");
		location = 				new DKRmlLocation(dkRmlInterface, dkRmlEventListener);
		console.log(" ");
		
		console.log("/// DKRmlDocument ///////////////");
		document = 				DKRmlDocument::instance(dkRmlInterface, dkRmlEventListener);
		console.log(" ");
		///////////////////////////////
		
		
		location->href("DKWebTest/index.html");
		document->addEventListener("load", &TEST_Browser::onLoad);
		DKEvent load_event("load", "");
		document->dispatchEvent(&load_event);
		
		
		console.log("/// DKRmlElement ////////////////");
		DKElement* div = document->createElement("div");
		console.log(" ");
	}
	
	~TEST_Browser(){
		delete window;
		delete dkRmlInterface;
		delete dkRmlEventListener;
		delete location;
		delete document;
	}
	
	static void onLoad(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("onLoad()");
		
		//////////// Post processing <a href></a> hyperlinks ////////////
		if(!document)
			console.error("document invalid!");
		
		DKHTMLCollection* aElements = document->getElementsByTagName("a");
		if(!aElements)
			console.error("aElements invalid!");
		
		for(unsigned int i=0; i<aElements->length(); ++i){
			DKElement* item = aElements->item(i);
			if (!item)
				console.error("aElements->item("+toString(i)+") invalid!");
			
			if (item->hasAttribute("href")) {
				if(!item->style())
					console.error("item->style() invalid!");
				
				item->style()->setProperty("color", "rgb(0,0,255)");
				item->style()->setProperty("text-decoration", "underline");
				item->addEventListener("click", &TEST_Browser::onHyperlink);
			}
		}
	}
	
	static void onHyperlink(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("onHyperlink()");
		DKElement* target = dynamic_cast<DKElement*>(event->target());
		DOMString value = target->getAttribute("href");
		TEST_Browser::location->href(value);
	}
};
//REGISTER_OBJECT(TEST_Browser, true);

DKSdlWindow* 	TEST_Browser::window;
DKRmlLocation*	TEST_Browser::location;
DKRmlDocument*	TEST_Browser::document;


#endif //TEST_Browser_H