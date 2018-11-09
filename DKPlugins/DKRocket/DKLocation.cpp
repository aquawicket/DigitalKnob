#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKLocation.h"


///////////////////////
bool DKLocation::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKLocation_clear", DKLocation::clear);
	DKDuktape::AttachFunction("DKLocation_debug", DKLocation::debug);
	DKDuktape::AttachFunction("DKLocation_error", DKLocation::error);
	DKDuktape::AttachFunction("DKLocation_info", DKLocation::info);
	DKDuktape::AttachFunction("DKLocation_warn", DKLocation::warn);
	
	DKClass::DKCreate("DKDuktape/DKLocation.js");
	return true;
}

///////////////////////////////////////
int DKLocation::clear(duk_context* ctx)
{
	//FIXME - make this work on all OS's
	if(!DKUtil::System("cls")){ return 0; }
	return 1;
}

///////////////////////////////////////
int DKLocation::debug(duk_context* ctx)
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

///////////////////////////////////////
int DKLocation::error(duk_context* ctx)
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

//////////////////////////////////////
int DKLocation::info(duk_context* ctx)
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

//////////////////////////////////////
int DKLocation::warn(duk_context* ctx)
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