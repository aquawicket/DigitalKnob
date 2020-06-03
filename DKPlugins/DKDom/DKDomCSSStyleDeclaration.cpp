#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDom/DKDomCSSStyleDeclaration.h"
#include "DKDom/DKDomElement.h"


/////////////////////////////////////
bool DKDomCSSStyleDeclaration::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDomCSSStyleDeclaration_getPropertyValue", DKDomCSSStyleDeclaration::getPropertyValue);
	DKDuktape::AttachFunction("DKDomCSSStyleDeclaration_setProperty", DKDomCSSStyleDeclaration::setProperty);

	DKClass::DKCreate("DKDom/DKDomCSSStyleDeclaration.js");
	return true;
}

////////////////////////////////////////////////////////////////
int DKDomCSSStyleDeclaration::getPropertyValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString propertyName = duk_require_string(ctx, 1);
	Rml::Core::Element* element = DKDomElement::addressToElement(address);
	if(!element){
		DKERROR("DKDomCSSStyleDeclaration::getPropertyValue(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	const Rml::Core::Property* prop = element->GetProperty(propertyName.c_str());
	if(!prop){ 
		DKERROR("DKDomCSSStyleDeclaration::getPropertyValue: prop is invalid\n");
		duk_push_boolean(ctx, false);
		return true; 
	}
	DKString propertyValue = element->GetProperty(propertyName.c_str())->ToString();
	duk_push_string(ctx, propertyValue.c_str());
	return true;
}

///////////////////////////////////////////////////////////
int DKDomCSSStyleDeclaration::setProperty(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString propertyName = duk_require_string(ctx, 1);
	DKString propertyValue;
	if(duk_is_string(ctx, 2)){
		propertyValue = duk_require_string(ctx, 2);
	}
	if(duk_is_boolean(ctx, 2)){
		propertyValue = toString(duk_require_boolean(ctx, 2));
	}
	//DKString priority = duk_require_string(ctx, 3); //TODO
	Rml::Core::Element* element = DKDomElement::addressToElement(address);
	if(element){
		if(!propertyValue.empty()){
			element->SetProperty(propertyName.c_str(), propertyValue.c_str());
		}
		else{
			element->RemoveProperty(propertyName.c_str());
		}
	}
	return true;
}

#endif //USE_DKDuktape