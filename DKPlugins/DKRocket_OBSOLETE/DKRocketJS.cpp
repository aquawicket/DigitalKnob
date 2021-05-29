#ifdef USE_DKDuktape
#include "DKRocket.h"
#include "DKRocketJS.h"


///////////////////////
bool DKRocketJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKRocket_LoadUrl", DKRocketJS::LoadUrl);
	DKDuktape::AttachFunction("DKRocket_Reload", DKRocketJS::Reload);
	DKDuktape::AttachFunction("DKRocket_ToggleDebugger", DKRocketJS::ToggleDebugger);
	DKDuktape::AttachFunction("DKRocket_innerHeight", DKRocketJS::innerHeight);
	DKDuktape::AttachFunction("DKRocket_innerWidth", DKRocketJS::innerWidth);
	DKDuktape::AttachFunction("DKRocket_name", DKRocketJS::name);
	DKDuktape::AttachFunction("DKRocket_addEventListener", DKRocketJS::addEventListener);
	DKDuktape::AttachFunction("DKRocket_removeEventListener", DKRocketJS::removeEventListener);
	
	return true;
}

/////////////////////////////////////////
int DKRocketJS::LoadUrl(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if(!DKRocket::Get()->LoadUrl(file)){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKRocketJS::Reload(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKRocket::Get()->Reload();
	return 1;
}

////////////////////////////////////////////////
int DKRocketJS::ToggleDebugger(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKRocket::Get()->ToggleDebugger();
	return 1;
}

/////////////////////////////////////////////
int DKRocketJS::innerHeight(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int y = DKRocket::Get()->context->GetDimensions().y;
	duk_push_int(ctx, y);
	return 1;
}

////////////////////////////////////////////
int DKRocketJS::innerWidth(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int x = DKRocket::Get()->context->GetDimensions().x;
	duk_push_int(ctx, x);
	return 1;
}

//////////////////////////////////////
int DKRocketJS::name(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = DKRocket::Get()->context->GetName().CString();
	duk_push_string(ctx, name.c_str());
	return 1;
}

//////////////////////////////////////////////////
int DKRocketJS::addEventListener(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element;
	if(same(address,"document")){
		element = DKRocket::Get()->document;
	}
	else{
		element = DKRocket::Get()->addressToElement(address);
	}
	if(!element){
		DKERROR("DKRocketJS::addEventListener(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString type = duk_require_string(ctx, 1);
	bool phase = false;
	if(duk_is_boolean(ctx, 2)){
		phase = duk_require_boolean(ctx, 2);
	}
	element->AddEventListener(type.c_str(), DKRocket::Get(), phase);
	return true;
}

/////////////////////////////////////////////////////
int DKRocketJS::removeEventListener(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rocket::Core::Element* element = DKRocket::Get()->addressToElement(address);
	if(!element){
		DKERROR("DKRocketJS::removeEventListener(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	DKString type = duk_require_string(ctx, 1);
	bool phase = false;
	if(duk_is_boolean(ctx, 2)){
		phase = duk_require_boolean(ctx, 2);
	}
	element->RemoveEventListener(type.c_str(), DKRocket::Get(), phase);
	return true;
}

#endif //USE_DKDuktape