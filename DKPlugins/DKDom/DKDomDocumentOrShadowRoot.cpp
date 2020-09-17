// https://developer.mozilla.org/en-US/docs/Web/API/DocumentOrShadowRoot
// https://javascript.info/mixins

#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKDom/DKDomDocumentOrShadowRoot.h"
#include "DKDom/DKDomElement.h"


//////////////////////////////////////
bool DKDomDocumentOrShadowRoot::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_activeElement", DKDomDocumentOrShadowRoot::activeElement);
	//DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_fullscreenElement", DKDomDocumentOrShadowRoot::fullscreenElement);
	//DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_pointerLockElement", DKDomDocumentOrShadowRoot::pointerLockElement);
	//DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_styleSheets", DKDomDocumentOrShadowRoot::styleSheets);
	
	DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_caretPositionFromPoint", DKDomDocumentOrShadowRoot::caretPositionFromPoint);
	DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_elementFromPoint", DKDomDocumentOrShadowRoot::elementFromPoint);
	//DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_elementsFromPoint, DKDomDocumentOrShadowRoot::elementsFromPoint);
	//DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_getSelection, DKDomDocumentOrShadowRoot::getSelection);
	//DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_nodeFromPoint, DKDomDocumentOrShadowRoot::nodeFromPoint);
	//DKDuktape::AttachFunction("DKDomDocumentOrShadowRoot_nodesFromPoint, DKDomDocumentOrShadowRoot::nodesFromPoint);
	
	DKClass::DKCreate("DKDom/DKDomDocumentOrShadowRoot.js");
	return true;
}

//////////////////////////////////////////////////////////////
int DKDomDocumentOrShadowRoot::activeElement(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	Rml::Element* element;// = DKRml::Get()->document->GetActiveElement(); //TODO
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
	//DKINFO("DKDomDocumentOrShadowRoot::elementFromPoint()\n");
	Rml::Element* hoverElement = DKRml::Get()->document->GetContext()->GetHoverElement();
	if(!hoverElement){ return false; }
	DKString elementAddress = DKRml::elementToAddress(hoverElement);
	duk_push_string(ctx, elementAddress.c_str());
	return true;
}