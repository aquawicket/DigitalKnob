#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKCSSStyleDeclaration.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKCSSStyleDeclaration::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCSSStyleDeclaration_href", DKCSSStyleDeclaration::href);
	
	DKClass::DKCreate("DKRocket/DKCSSStyleDeclaration.js");
	return true;
}

//////////////////////////////////////
int DKCSSStyleDeclaration::href(duk_context* ctx)
{
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRocket::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRocket::Get()->_url.c_str());
	return true;
}

#endif //USE_DKDuktape