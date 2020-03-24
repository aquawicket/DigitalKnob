#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRml/DKCSSStyleDeclaration.h"
#include "DKRml/DKRml.h"


//////////////////////////////////
bool DKCSSStyleDeclaration::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCSSStyleDeclaration_getPropertyValue", DKCSSStyleDeclaration::getPropertyValue);
	DKDuktape::AttachFunction("DKCSSStyleDeclaration_setProperty", DKCSSStyleDeclaration::setProperty);

	DKClass::DKCreate("DKRml/DKCSSStyleDeclaration.js");
	return true;
}

//////////////////////////////////////////////////////////////
int  DKCSSStyleDeclaration::getPropertyValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString propertyName = duk_require_string(ctx, 1);
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
	if(!element){
		DKERROR("DKRmlJS::getPropertyValue(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	const Rml::Core::Property* prop = element->GetProperty(propertyName.c_str());
	if(!prop){ 
		DKERROR("DKRmlJS::getPropertyValue(): prop is invalid\n");
		duk_push_boolean(ctx, false);
		return true; 
	}
	DKString propertyValue = element->GetProperty(propertyName.c_str())->ToString();//.CString();
	duk_push_string(ctx, propertyValue.c_str());
	return true;
}

////////////////////////////////////////////////////////
int DKCSSStyleDeclaration::setProperty(duk_context* ctx)
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
	Rml::Core::Element* element = DKRml::Get()->getElementByAddress(address);
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