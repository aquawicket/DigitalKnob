#ifdef USE_DKDuktape
#include "DKRocket.h"
#include "DKRocketJS.h"


///////////////////////
bool DKRocketJS::Init()
{
	DKDuktape::AttachFunction("DKRocket_Reload", DKRocketJS::Reload);
	DKDuktape::AttachFunction("DKRocket_ToggleDebugger", DKRocketJS::ToggleDebugger);
	DKDuktape::AttachFunction("DKRocket_getElementById", DKRocketJS::getElementById);
	DKDuktape::AttachFunction("DKRocket_getAttribute", DKRocketJS::getAttribute);
	DKDuktape::AttachFunction("DKRocket_hasAttribute", DKRocketJS::hasAttribute);
	DKDuktape::AttachFunction("DKRocket_setAttribute", DKRocketJS::setAttribute);
	return true;
}

////////////////////////////////////////
int DKRocketJS::Reload(duk_context* ctx)
{
	DKRocket::Get()->Reload();
	return 1;
}

////////////////////////////////////////////////
int DKRocketJS::ToggleDebugger(duk_context* ctx)
{
	DKRocket::Get()->ToggleDebugger();
	return 1;
}

////////////////////////////////////////////////
int DKRocketJS::getElementById(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->document->GetElementById(id.c_str());
	if(!element){
		DKLog("DKRocketJS::getElementById(): element invalid", DKERROR);
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_pointer(ctx, element);
	return true;
}

//////////////////////////////////////////////
int DKRocketJS::getAttribute(duk_context* ctx)
{
	Rocket::Core::Element* element = (Rocket::Core::Element*)duk_require_pointer(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	if(!element){
		DKLog("DKRocketJS::getAttribute(): element invalid", DKERROR);
		duk_push_boolean(ctx, false);
		return true;
	}
	Rocket::Core::Variant* variant = element->GetAttribute(attribute.c_str());
	if(!variant){ 
		DKLog("DKRocketJS::getAttribute(): variant invalid", DKERROR);
		duk_push_boolean(ctx, false);
		return true;
	}
	Rocket::Core::String temp = element->GetAttribute(attribute.c_str())->Get<Rocket::Core::String>();
	DKString value = temp.CString();
	duk_push_string(ctx, value.c_str());
	return true;
}

//////////////////////////////////////////////
int DKRocketJS::hasAttribute(duk_context* ctx)
{
	Rocket::Core::Element* element = (Rocket::Core::Element*)duk_require_pointer(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	if(!element){
		DKLog("DKRocketJS::hasAttribute(): element invalid", DKERROR);
		duk_push_boolean(ctx, false);
		return true;
	}
	if(!element->HasAttribute(attribute.c_str())){ 
		duk_push_boolean(ctx, false);
		return true;
	}
	duk_push_boolean(ctx, true);
	return true;
}

//////////////////////////////////////////////
int DKRocketJS::setAttribute(duk_context* ctx)
{
	Rocket::Core::Element* element = (Rocket::Core::Element*)duk_require_pointer(ctx, 0);
	DKString attribute = duk_require_string(ctx, 1);
	DKString value = duk_require_string(ctx, 2);
	if(!element){
		DKLog("DKRocketJS::hasAttribute(): element invalid", DKERROR);
		duk_push_boolean(ctx, false);
		return true;
	}
	element->SetAttribute(attribute.c_str(), value.c_str());
	duk_push_boolean(ctx, true);
	return true;
}

#endif //USE_DKDuktape