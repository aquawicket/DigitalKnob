#ifdef USE_DKDuktape
#pragma once
#ifndef DKRocketJS_H
#define DKRocketJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////
class DKRocketJS : public DKObjectT<DKRocketJS>
{
public:
	bool Init();

	static int LoadUrl(duk_context* ctx);
	static int Reload(duk_context* ctx);
	static int ToggleDebugger(duk_context* ctx);

	//events
	static int addEventListener(duk_context* ctx);
	static int removeEventListener(duk_context* ctx);
	
	//window
	static int innerHeight(duk_context* ctx);
	static int innerWidth(duk_context* ctx);
	static int name(duk_context* ctx);

	//location
	static int href(duk_context* ctx);

	//document
	static int createElement(duk_context* ctx);
	static int getElementById(duk_context* ctx);
	static int getElementsByClassName(duk_context* ctx);
	static int getElementsByTagName(duk_context* ctx);

	//element
	static int appendChild(duk_context* ctx);
	static int getAttribute(duk_context* ctx);
	static int hasAttribute(duk_context* ctx);
	static int innerHTML(duk_context* ctx);
	static int parentNode(duk_context* ctx);
	static int removeChild(duk_context* ctx);
	static int setAttribute(duk_context* ctx);
	static int setInnerHTML(duk_context* ctx);
	static int clientWidth(duk_context* ctx);
	static int clientHeight(duk_context* ctx);
	static int clientTop(duk_context* ctx);
	static int clientLeft(duk_context* ctx);
	static int childNodes(duk_context* ctx);

	//XMLHttpRequest
	static int send(duk_context* ctx);
	
	//style
	static int setProperty(duk_context* ctx);
	static int getPropertyValue(duk_context* ctx);
	
	static Rocket::Core::Element* getElementByAddress(const DKString& address);
	static bool GetElements(Rocket::Core::Element* parent, Rocket::Core::ElementList& elements);
};

REGISTER_OBJECT(DKRocketJS, true)

#endif //DKRocketJS_H
#endif //USE_DKDuktape