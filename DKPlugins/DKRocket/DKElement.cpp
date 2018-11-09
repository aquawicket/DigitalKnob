#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKElement.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKElement::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKElement_href", DKElement::href);
	
	DKClass::DKCreate("DKRocket/DKElement.js");
	return true;
}

//////////////////////////////////////
int DKElement::href(duk_context* ctx)
{
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRocket::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRocket::Get()->_url.c_str());
	return true;
}

#endif //USE_DKDuktape