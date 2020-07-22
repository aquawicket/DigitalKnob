//https://developer.mozilla.org/en-US/docs/Web/API/Console

#include "DK/DKApp.h"
#include "DKDom/DKDomConsole.h"


/////////////////////////
bool DKDomConsole::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKDomConsole_clear", DKDomConsole::clear);
	DKDuktape::AttachFunction("DKDomConsole_debug", DKDomConsole::debug);
	DKDuktape::AttachFunction("DKDomConsole_error", DKDomConsole::error);
	DKDuktape::AttachFunction("DKDomConsole_info",  DKDomConsole::info);
	DKDuktape::AttachFunction("DKDomConsole_warn",  DKDomConsole::warn);
	
	DKClass::DKCreate("DKDom/DKDomConsole.js");
	return true;
}

/////////////////////////////////////////
int DKDomConsole::clear(duk_context* ctx)
{
	//FIXME - make this work on all OS's
	if(!DKUtil::System("cls")){ return 0; }
	return 1;
}

/////////////////////////////////////////
int DKDomConsole::debug(duk_context* ctx)
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

/////////////////////////////////////////
int DKDomConsole::error(duk_context* ctx)
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

////////////////////////////////////////
int DKDomConsole::info(duk_context* ctx)
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

////////////////////////////////////////
int DKDomConsole::warn(duk_context* ctx)
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