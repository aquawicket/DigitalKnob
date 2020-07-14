#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKDom/DKDomDocument.h"
#include "DKDom/DKDomElement.h"


//////////////////////////
bool DKDomDocument::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDomDocument_body", DKDomDocument::body);
	DKDuktape::AttachFunction("DKDomDocument_createElement", DKDomDocument::createElement);
	DKDuktape::AttachFunction("DKDomDocument_documentElement", DKDomDocument::documentElement);
	DKDuktape::AttachFunction("DKDomDocument_getElementById", DKDomDocument::getElementById);
	DKDuktape::AttachFunction("DKDomDocument_getElementsByTagName", DKDomDocument::getElementsByTagName);
	
	DKClass::DKCreate("DKDom/DKDomDocument.js");
	return true;
}

/////////////////////////////////////////
int DKDomDocument::body(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rml::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, "body");
	if(!elements[0]){
		DKERROR("DKDomDocument::body(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRml::elementToAddress(elements[0]);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

//////////////////////////////////////////////////
int DKDomDocument::createElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rml::Element* doc = DKRml::Get()->document;
	Rml::Element* element = doc->AppendChild(DKRml::Get()->document->CreateElement(tag.c_str()), true);
	if(!element){
		DKERROR("DKDomDocument::createElement(): element invalid\n");
		return false;
	}
	DKString elementAddress = DKRml::elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

////////////////////////////////////////////////////
int DKDomDocument::documentElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rml::Element* element = DKRml::Get()->document;
	if(!element){
		DKERROR("DKDomDocument::documentElement(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRml::elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

///////////////////////////////////////////////////
int DKDomDocument::getElementById(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::Get()->document->GetElementById(id.c_str());
	if(!element){
		//DKERROR("DKDomDocument::getElementById(): element invalid\n");
		duk_push_null(ctx);
		return true;
	}
	DKString elementAddress = DKRml::elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

/////////////////////////////////////////////////////////
int DKDomDocument::getElementsByTagName(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString tag = duk_require_string(ctx, 0);
	Rml::ElementList elements;
	DKRml::Get()->document->GetElementsByTagName(elements, tag.c_str());
	if(elements.empty()){
		//DKERROR("DKDomDocument::getElementsByTagName(): element list invalid\n");
		duk_push_null(ctx);
		return true;
	}
	DKStringArray elementAddresses;
	for(unsigned int i = 0; i<elements.size(); i++){
		elementAddresses.push_back(DKRml::elementToAddress(elements[i]));
	}
	DKString list = toString(elementAddresses, ",");
	duk_push_string(ctx, list.c_str());
	return true;
}

#endif //USE_DKDuktape