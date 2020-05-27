#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKRocketDocument.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKRocketDocument::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKRocketDocument_body", DKRocketDocument::body);
	DKDuktape::AttachFunction("DKRocketDocument_createElement", DKRocketDocument::createElement);
	DKDuktape::AttachFunction("DKRocketDocument_documentElement", DKRocketDocument::documentElement);
	DKDuktape::AttachFunction("DKRocketDocument_getElementById", DKRocketDocument::getElementById);
	DKDuktape::AttachFunction("DKRocketDocument_getElementsByTagName", DKRocketDocument::getElementsByTagName);
	
	DKClass::DKCreate("DKRocket/DKRocketDocument.js");
	return true;
}

//////////////////////////////////////
int DKRocketDocument::body(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rocket::Core::ElementList elements;
	DKRocket::Get()->document->GetElementsByTagName(elements, "body");
	if(!elements[0]){
		DKERROR("DKRocketDocument::body(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRocket::Get()->elementToAddress(elements[0]);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

///////////////////////////////////////////////
int DKRocketDocument::createElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rocket::Core::Element* doc = DKRocket::Get()->document;
	//Rocket::Core::Element* element = doc->AppendChild(DKRocket::Get()->document->CreateElement(tag.c_str()), true);
	Rocket::Core::Element* element = DKRocket::Get()->document->CreateElement(tag.c_str());
	doc->AppendChild(element, true);
	if(!element){
		DKERROR("DKRocketDocument::createElement(): element invalid\n");
		return false;
	}
	DKString elementAddress = DKRocket::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

/////////////////////////////////////////////////
int DKRocketDocument::documentElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rocket::Core::Element* element = DKRocket::Get()->document;
	if(!element){
		DKERROR("DKRocketDocument::documentElement(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRocket::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

////////////////////////////////////////////////
int DKRocketDocument::getElementById(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->document->GetElementById(id.c_str());
	if(!element){
		//DKERROR("DKRocketDocument::getElementById(): element invalid\n");
		duk_push_null(ctx);
		return true;
	}
	DKString elementAddress = DKRocket::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

//////////////////////////////////////////////////////
int DKRocketDocument::getElementsByTagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rocket::Core::ElementList elements;
	DKRocket::Get()->document->GetElementsByTagName(elements, tag.c_str());
	if(elements.empty()){
		//DKERROR("DKRocketDocument::getElementsByTagName(): element list invalid\n");
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