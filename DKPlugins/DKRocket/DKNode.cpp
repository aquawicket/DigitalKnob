#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKRocket.h"
#include "DKRocket/DKNode.h"


///////////////////
bool DKNode::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKNode_href", DKNode::href);
	
	DKClass::DKCreate("DKRocket/DKNode.js");
	return true;
}

//////////////////////////////////
int DKNode::href(duk_context* ctx)
{
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRocket::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRocket::Get()->_url.c_str());
	return true;
}

#endif //USE_DKDuktape