#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKDom/DKDomDocumentOrShadowRoot.h"
#include "DKDom/DKDomElement.h"


//////////////////////////////////////
bool DKDomDocumentOrShadowRoot::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_activeElement", DKDomDocumentOrShadowRoot::activeElement);
	DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_caretPositionFromPoint", DKDomDocumentOrShadowRoot::caretPositionFromPoint);
	DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_elementFromPoint", DKDomDocumentOrShadowRoot::elementFromPoint);
	DKClass::DKCreate("DKDom/DKDomDocumentOrShadowRoot.js");
	return true;
}

//////////////////////////////////////////////////////////////
int DKDomDocumentOrShadowRoot::activeElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rml::Core::Element* element;// = DKRml::Get()->document->GetActiveElement(); //TODO
	if(element){
		DKERROR("DKDomDocumentOrShadowRoot::activeElement(): element invalid\n");
		duk_push_null(ctx);
		return false;
	}
	DKString elementAddress = DKRml::elementToAddress(element);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

///////////////////////////////////////////////////////////////////////
int DKDomDocumentOrShadowRoot::caretPositionFromPoint(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

/////////////////////////////////////////////////////////////////
int DKDomDocumentOrShadowRoot::elementFromPoint(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rml::Core::Element* hoverElement = DKRml::Get()->document->GetContext()->GetHoverElement();
	if(!hoverElement){ return false; }
	DKString elementAddress = DKRml::elementToAddress(hoverElement);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}

#endif //USE_DKDuktape