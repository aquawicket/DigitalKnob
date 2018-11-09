#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKHTMLElement.h"
#include "DKRocket/DKRocket.h"


///////////////////////
bool DKHTMLElement::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKHTMLElement_href", DKHTMLElement::href);
	
	DKClass::DKCreate("DKRocket/DKHTMLElement.js");
	return true;
}

//////////////////////////////////////
int DKHTMLElement::href(duk_context* ctx)
{
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRocket::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRocket::Get()->_url.c_str());
	return true;
}

#endif //USE_DKDuktape