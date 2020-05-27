#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKDocument.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKDocument::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDocument_body", DKDocument::body);
	DKDuktape::AttachFunction("DKDocument_createElement", DKDocument::createElement);
	DKDuktape::AttachFunction("DKDocument_documentElement", DKDocument::documentElement);
	DKDuktape::AttachFunction("DKDocument_getElementById", DKDocument::getElementById);
	DKDuktape::AttachFunction("DKDocument_getElementsByTagName", DKDocument::getElementsByTagName);
	
	DKClass::DKCreate("DKRocket/DKDocument.js");
	return true;
}

//////////////////////////////////////
int DKDocument::body(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rocket::Core::ElementList elements;
	DKRocket::Get()->document->GetElementsByTagName(elements, "body");
	if(!elements[0]){
		DKERROR("DKDocument::body(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRocket::Get()->elementToAddress(elements[0]);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

///////////////////////////////////////////////
int DKDocument::createElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rocket::Core::Element* doc = DKRocket::Get()->document;
	//Rocket::Core::Element* element = doc->AppendChild(DKRocket::Get()->document->CreateElement(tag.c_str()), true);
	Rocket::Core::Element* element = DKRocket::Get()->document->CreateElement(tag.c_str());
	doc->AppendChild(element, true);
	if(!element){
		DKERROR("DKDocument::createElement(): element invalid\n");
		return false;
	}
	DKString elementAddress = DKRocket::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

/////////////////////////////////////////////////
int DKDocument::documentElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rocket::Core::Element* element = DKRocket::Get()->document;
	if(!element){
		DKERROR("DKDocument::documentElement(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRocket::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

////////////////////////////////////////////////
int DKDocument::getElementById(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->document->GetElementById(id.c_str());
	if(!element){
		//DKERROR("DKDocument::getElementById(): element invalid\n");
		duk_push_null(ctx);
		return true;
	}
	DKString elementAddress = DKRocket::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

//////////////////////////////////////////////////////
int DKDocument::getElementsByTagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rocket::Core::ElementList elements;
	DKRocket::Get()->document->GetElementsByTagName(elements, tag.c_str());
	if(elements.empty()){
		//DKERROR("DKDocument::getElementsByTagName(): element list invalid\n");
		duk_push_null(ctx);
		return true;
	}
	DKStringArray elementAddresses;
	for(unsigned int i = 0; i<elements.size(); i++){
		elementAddresses.push_back(DKRocket::Get()->elementToAddress(elements[i]));
	}
	DKString list = toString(elementAddresses, ",");
	duk_push_string(ctx, list.c_str());
	return true;
}

#endif //USE_DKDuktape