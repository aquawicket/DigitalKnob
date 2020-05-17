#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKDocument.h"
#include "DKRml/DKRml.h"


///////////////////////
bool DKDocument::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDocument_body", DKDocument::body);
	DKDuktape::AttachFunction("DKDocument_createElement", DKDocument::createElement);
	DKDuktape::AttachFunction("DKDocument_documentElement", DKDocument::documentElement);
	DKDuktape::AttachFunction("DKDocument_getElementById", DKDocument::getElementById);
	DKDuktape::AttachFunction("DKDocument_getElementsByTagName", DKDocument::getElementsByTagName);
	
	DKClass::DKCreate("DKRml/DKDocument.js");
	return true;
}

//////////////////////////////////////
int DKDocument::body(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rml::Core::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, "body");
	if(!elements[0]){
		DKERROR("DKDocument::body(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRml::Get()->elementToAddress(elements[0]);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

///////////////////////////////////////////////
int DKDocument::createElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::Get()->document->CreateElement(tag.c_str()).get();
	if(!element){
		DKERROR("DKDocument::createElement(): element invalid\n");
		return false;
	}
	DKString elementAddress = DKRml::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

/////////////////////////////////////////////////
int DKDocument::documentElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rml::Core::Element* element = DKRml::Get()->document;
	if(!element){
		DKERROR("DKDocument::documentElement(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRml::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

////////////////////////////////////////////////
int DKDocument::getElementById(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	Rml::Core::Element* element = DKRml::Get()->document->GetElementById(id.c_str());
	if(!element){
		//DKERROR("DKRmlJS::getElementById(): element invalid\n");
		duk_push_null(ctx);
		return true;
	}
	DKString elementAddress = DKRml::Get()->elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

//////////////////////////////////////////////////////
int DKDocument::getElementsByTagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rml::Core::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, tag.c_str());
	if(elements.empty()){
		//DKERROR("DKRmlJS::getElementsByTagName(): element list invalid\n");
		duk_push_null(ctx);
		return true;
	}
	DKStringArray elementAddresses;
	for(unsigned int i = 0; i<elements.size(); i++){
		elementAddresses.push_back(DKRml::Get()->elementToAddress(elements[i]));
	}
	DKString list = toString(elementAddresses, ",");
	duk_push_string(ctx, list.c_str());
	return true;
}

#endif //USE_DKDuktape