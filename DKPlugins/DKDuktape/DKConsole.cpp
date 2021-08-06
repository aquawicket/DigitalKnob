#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKConsole.h"


bool DKConsole::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKConsole_assert", DKConsole::_assert);
	DKDuktape::AttachFunction("CPP_DKConsole_clear", DKConsole::clear);
	DKDuktape::AttachFunction("CPP_DKConsole_debug", DKConsole::debug);
	DKDuktape::AttachFunction("CPP_DKConsole_error", DKConsole::error);
	DKDuktape::AttachFunction("CPP_DKConsole_exception", DKConsole::exception);
	DKDuktape::AttachFunction("CPP_DKConsole_group", DKConsole::group);
	DKDuktape::AttachFunction("CPP_DKConsole_groupCollapsed", DKConsole::groupCollapsed);
	DKDuktape::AttachFunction("CPP_DKConsole_groupEnd", DKConsole::groupEnd);
	DKDuktape::AttachFunction("CPP_DKConsole_info", DKConsole::info);
	DKDuktape::AttachFunction("CPP_DKConsole_log", DKConsole::log);
	DKDuktape::AttachFunction("CPP_DKConsole_trace", DKConsole::trace);
	DKDuktape::AttachFunction("CPP_DKConsole_warn", DKConsole::warn);
	
	DKClass::DKCreate("DKDuktape/DKConsole.js");
	return true;
}

int DKConsole::_assert(duk_context* ctx){
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

int DKConsole::clear(duk_context* ctx)
{
	//FIXME - make this work on all OS's
	DKString out;
	if(!DKUtil::System("cls", out)){ return 0; }
	return 1;
}

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

int DKConsole::exception(duk_context* ctx)
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

int DKConsole::group(duk_context* ctx)
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

int DKConsole::groupCollapsed(duk_context* ctx)
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

int DKConsole::groupEnd(duk_context* ctx)
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

int DKConsole::log(duk_context* ctx)
{
	DKString string;
	if (duk_is_string(ctx, 0)) {
		string = duk_require_string(ctx, 0);
	}
	if (duk_is_boolean(ctx, 0)) {
		string = toString(duk_require_boolean(ctx, 0));
	}
	if (duk_is_number(ctx, 0)) {
		string = toString(duk_require_int(ctx, 0));
	}
	DKINFO(string);
	return 1;
}

int DKConsole::trace(duk_context* ctx)
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