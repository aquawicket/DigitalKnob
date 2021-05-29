#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKRocketCSSStyleDeclaration.h"
#include "DKRocket/DKRocket.h"


//////////////////////////////////
bool DKRocketCSSStyleDeclaration::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKRocketCSSStyleDeclaration_getPropertyValue", DKRocketCSSStyleDeclaration::getPropertyValue);
	DKDuktape::AttachFunction("DKRocketCSSStyleDeclaration_setProperty", DKRocketCSSStyleDeclaration::setProperty);

	DKClass::DKCreate("DKRocket/DKRocketCSSStyleDeclaration.js");
	return true;
}

//////////////////////////////////////////////////////////////
int  DKRocketCSSStyleDeclaration::getPropertyValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	DKString propertyName = duk_require_string(ctx, 1);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketCSSStyleDeclaration::getPropertyValue(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	const Rocket::Core::Property* prop = element->GetProperty(propertyName.c_str());
	if(!prop){ 
		DKERROR("DKRocketCSSStyleDeclaration::getPropertyValue(): prop is invalid\n");
		duk_push_boolean(ctx, false);
		return true; 
	}
	DKString propertyValue = element->GetProperty(propertyName.c_str())->ToString().CString();
	duk_push_string(ctx, propertyValue.c_str());
	return true;
}

////////////////////////////////////////////////////////
int DKRocketCSSStyleDeclaration::setProperty(duk_context* ctx)
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
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
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