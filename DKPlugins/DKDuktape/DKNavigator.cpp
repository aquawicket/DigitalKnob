#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKNavigator.h"


//////////////////////
bool DKNavigator::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKNavigator_clear", DKNavigator::clear);
	DKDuktape::AttachFunction("DKNavigator_debug", DKNavigator::debug);
	DKDuktape::AttachFunction("DKNavigator_error", DKNavigator::error);
	DKDuktape::AttachFunction("DKNavigator_info", DKNavigator::info);
	DKDuktape::AttachFunction("DKNavigator_warn", DKNavigator::warn);
	
	DKClass::DKCreate("DKDuktape/DKNavigator.js");
	return true;
}

//////////////////////////////////////
int DKNavigator::clear(duk_context* ctx)
{
	//FIXME - make this work on all OS's
	if(!DKUtil::System("cls")){ return 0; }
	return 1;
}

//////////////////////////////////////
int DKNavigator::debug(duk_context* ctx)
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
int DKNavigator::error(duk_context* ctx)
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
int DKNavigator::info(duk_context* ctx)
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
int DKNavigator::warn(duk_context* ctx)
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