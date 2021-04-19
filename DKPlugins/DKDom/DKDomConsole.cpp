//https://developer.mozilla.org/en-US/docs/Web/API/Console

#include "DK/DKApp.h"
#include "DKDom/DKDomConsole.h"


/////////////////////////
bool DKDomConsole::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomConsole_assert", DKDomConsole::_assert);
	DKDuktape::AttachFunction("CPP_DKDomConsole_clear", DKDomConsole::clear);
	DKDuktape::AttachFunction("CPP_DKDomConsole_count", DKDomConsole::count);
	DKDuktape::AttachFunction("CPP_DKDomConsole_countReset", DKDomConsole::countReset);
	DKDuktape::AttachFunction("CPP_DKDomConsole_debug", DKDomConsole::debug);
	DKDuktape::AttachFunction("CPP_DKDomConsole_dir", DKDomConsole::dir);
	DKDuktape::AttachFunction("CPP_DKDomConsole_dirxml", DKDomConsole::dirxml);
	DKDuktape::AttachFunction("CPP_DKDomConsole_error", DKDomConsole::error);
	DKDuktape::AttachFunction("CPP_DKDomConsole_exception", DKDomConsole::exception);
	DKDuktape::AttachFunction("CPP_DKDomConsole_group", DKDomConsole::group);
	DKDuktape::AttachFunction("CPP_DKDomConsole_groupCollapsed", DKDomConsole::groupCollapsed);
	DKDuktape::AttachFunction("CPP_DKDomConsole_groupEnd", DKDomConsole::groupEnd);
	DKDuktape::AttachFunction("CPP_DKDomConsole_info",  DKDomConsole::info);
	DKDuktape::AttachFunction("CPP_DKDomConsole_log", DKDomConsole::log);
	DKDuktape::AttachFunction("CPP_DKDomConsole_profile", DKDomConsole::profile);
	DKDuktape::AttachFunction("CPP_DKDomConsole_profileEnd", DKDomConsole::profileEnd);
	DKDuktape::AttachFunction("CPP_DKDomConsole_table", DKDomConsole::table);
	DKDuktape::AttachFunction("CPP_DKDomConsole_time", DKDomConsole::time);
	DKDuktape::AttachFunction("CPP_DKDomConsole_timeEnd", DKDomConsole::timeEnd);
	DKDuktape::AttachFunction("CPP_DKDomConsole_timeLog", DKDomConsole::timeLog);
	DKDuktape::AttachFunction("CPP_DKDomConsole_timeStamp", DKDomConsole::timeStamp);
	DKDuktape::AttachFunction("CPP_DKDomConsole_trace", DKDomConsole::trace);
	DKDuktape::AttachFunction("CPP_DKDomConsole_warn",  DKDomConsole::warn);
	
	DKClass::DKCreate("DKDom/DKDomConsole.js");
	return true;
}

///////////////////////////////////////////
int DKDomConsole::_assert(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::assert not implemented\n");
	return false;
}

/////////////////////////////////////////
int DKDomConsole::clear(duk_context* ctx)
{
	//FIXME - make this work on all OS's
	DKString out;
	if(!DKUtil::System("cls", out)){ return 0; }
	return 1;
}

/////////////////////////////////////////
int DKDomConsole::count(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::count not implemented\n");
	return false;
}

//////////////////////////////////////////////
int DKDomConsole::countReset(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::countReset not implemented\n");
	return false;
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

///////////////////////////////////////
int DKDomConsole::dir(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::dir not implemented\n");
	return false;
}

//////////////////////////////////////////
int DKDomConsole::dirxml(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::dirxml not implemented\n");
	return false;
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

/////////////////////////////////////////////
int DKDomConsole::exception(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::exception not implemented\n");
	return false;
}

/////////////////////////////////////////
int DKDomConsole::group(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::group not implemented\n");
	return false;
}

//////////////////////////////////////////////////
int DKDomConsole::groupCollapsed(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::groupCollapsed not implemented\n");
	return false;
}

////////////////////////////////////////////
int DKDomConsole::groupEnd(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::groupEnd not implemented\n");
	return false;
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

///////////////////////////////////////
int DKDomConsole::log(duk_context* ctx)
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

///////////////////////////////////////////
int DKDomConsole::profile(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::profile not implemented\n");
	return false;
}

//////////////////////////////////////////////
int DKDomConsole::profileEnd(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::profileEnd not implemented\n");
	return false;
}

/////////////////////////////////////////
int DKDomConsole::table(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::table not implemented\n");
	return false;
}

////////////////////////////////////////
int DKDomConsole::time(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::time not implemented\n");
	return false;
}

///////////////////////////////////////////
int DKDomConsole::timeEnd(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::timeEnd not implemented\n");
	return false;
}

///////////////////////////////////////////
int DKDomConsole::timeLog(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::timeLog not implemented\n");
	return false;
}

/////////////////////////////////////////////
int DKDomConsole::timeStamp(duk_context* ctx)
{
	//TODO
	DKERROR("DKDomConsole::timeStamp not implemented\n");
	return false;
}

/////////////////////////////////////////
int DKDomConsole::trace(duk_context* ctx)
{
	if(!DKDuktape::Trace()){ return false; }
	return true;
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