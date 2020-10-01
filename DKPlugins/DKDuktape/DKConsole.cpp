#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKConsole.h"


//////////////////////
bool DKConsole::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKConsole_clear", DKConsole::clear);
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKConsole_debug", DKConsole::debug);
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKConsole_error", DKConsole::error);
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKConsole_info", DKConsole::info);
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKConsole_warn", DKConsole::warn);
	
	DKClass::DKCreate("DKDuktape/DKConsole.js");
	return true;
}

//////////////////////////////////////
int DKConsole::clear(duk_context* ctx)
{
	//FIXME - make this work on all OS's
	if(!DKUtil::System("cls")){ return 0; }
	return 1;
}

//////////////////////////////////////
int DKConsole::debug(duk_context* ctx)
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
int DKConsole::error(duk_context* ctx)
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
int DKConsole::info(duk_context* ctx)
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
int DKConsole::warn(duk_context* ctx)
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