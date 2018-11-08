#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKEventTarget.h"


//////////////////////
bool DKEventTarget::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKEventTarget_clear", DKEventTarget::clear);
	DKDuktape::AttachFunction("DKEventTarget_debug", DKEventTarget::debug);
	DKDuktape::AttachFunction("DKEventTarget_error", DKEventTarget::error);
	DKDuktape::AttachFunction("DKEventTarget_info", DKEventTarget::info);
	DKDuktape::AttachFunction("DKEventTarget_warn", DKEventTarget::warn);
	
	DKClass::DKCreate("DKDuktape/DKEventTarget.js");
	return true;
}

//////////////////////////////////////
int DKEventTarget::clear(duk_context* ctx)
{
	//FIXME - make this work on all OS's
	if(!DKUtil::System("cls")){ return 0; }
	return 1;
}

//////////////////////////////////////
int DKEventTarget::debug(duk_context* ctx)
{
	DKString string;
	if(duk_is_string(ctx, 0)){
		string = duk_require_string(ctx, 0);
	}
	if(duk_is_boolean(ctx, 0)){
		string = toString(duk_require_boolean(ctx, 0));
	}
	if(duk_is_number(ctx, 0)){
		string = toString(duk_require_int(ctx, 0));
	}
	DKDEBUG(string);
	return 1;
}

//////////////////////////////////////
int DKEventTarget::error(duk_context* ctx)
{
	DKString string;
	if(duk_is_string(ctx, 0)){
		string = duk_require_string(ctx, 0);
	}
	if(duk_is_boolean(ctx, 0)){
		string = toString(duk_require_boolean(ctx, 0));
	}
	if(duk_is_number(ctx, 0)){
		string = toString(duk_require_int(ctx, 0));
	}
	DKERROR(string);
	return 1;
}

/////////////////////////////////////
int DKEventTarget::info(duk_context* ctx)
{
	DKString string;
	if(duk_is_string(ctx, 0)){
		string = duk_require_string(ctx, 0);
	}
	if(duk_is_boolean(ctx, 0)){
		string = toString(duk_require_boolean(ctx, 0));
	}
	if(duk_is_number(ctx, 0)){
		string = toString(duk_require_int(ctx, 0));
	}
	DKINFO(string);
	return 1;
}

/////////////////////////////////////
int DKEventTarget::warn(duk_context* ctx)
{
	DKString string;
	if(duk_is_string(ctx, 0)){
		string = duk_require_string(ctx, 0);
	}
	if(duk_is_boolean(ctx, 0)){
		string = toString(duk_require_boolean(ctx, 0));
	}
	if(duk_is_number(ctx, 0)){
		string = toString(duk_require_int(ctx, 0));
	}
	DKWARN(string);
	return 1;
}


#endif //USE_DKDuktape