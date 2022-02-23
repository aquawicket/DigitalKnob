#ifdef HAVE_DKDuktape
#include "DK/DKApp.h"
#include "DKDuktapeDom/DKConsole.h"

bool DKConsole::Init(){
	DKDEBUGFUNC();
	
	DKDuktape::AttachFunction("CPP_DKConsole_assert", DKConsole::_assert);
	DKDuktape::AttachFunction("CPP_DKConsole_clear", DKConsole::clear);
	DKDuktape::AttachFunction("CPP_DKConsole_count", DKConsole::count);
	DKDuktape::AttachFunction("CPP_DKConsole_countReset", DKConsole::countReset);
	DKDuktape::AttachFunction("CPP_DKConsole_debug", DKConsole::debug);
	DKDuktape::AttachFunction("CPP_DKConsole_dir", DKConsole::dir);
	DKDuktape::AttachFunction("CPP_DKConsole_dirxml", DKConsole::dirxml);
	DKDuktape::AttachFunction("CPP_DKConsole_error", DKConsole::error);
	DKDuktape::AttachFunction("CPP_DKConsole_exception", DKConsole::exception);
	DKDuktape::AttachFunction("CPP_DKConsole_group", DKConsole::group);
	DKDuktape::AttachFunction("CPP_DKConsole_groupCollapsed", DKConsole::groupCollapsed);
	DKDuktape::AttachFunction("CPP_DKConsole_groupEnd", DKConsole::groupEnd);
	DKDuktape::AttachFunction("CPP_DKConsole_info",  DKConsole::info);
	DKDuktape::AttachFunction("CPP_DKConsole_log", DKConsole::log);
	DKDuktape::AttachFunction("CPP_DKConsole_profile", DKConsole::profile);
	DKDuktape::AttachFunction("CPP_DKConsole_profileEnd", DKConsole::profileEnd);
	DKDuktape::AttachFunction("CPP_DKConsole_table", DKConsole::table);
	DKDuktape::AttachFunction("CPP_DKConsole_time", DKConsole::time);
	DKDuktape::AttachFunction("CPP_DKConsole_timeEnd", DKConsole::timeEnd);
	DKDuktape::AttachFunction("CPP_DKConsole_timeLog", DKConsole::timeLog);
	DKDuktape::AttachFunction("CPP_DKConsole_timeStamp", DKConsole::timeStamp);
	DKDuktape::AttachFunction("CPP_DKConsole_trace", DKConsole::trace);
	DKDuktape::AttachFunction("CPP_DKConsole_warn",  DKConsole::warn);
	
	DKClass::DKCreate("DKDuktapeDom/DKConsole.js");
	return true;
}

int DKConsole::_assert(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::assert not implemented\n");
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKERROR(string);
	return true;
}

int DKConsole::clear(duk_context* ctx){
	int out;
	if(!DKUtil::System("cls", out))
		return DKERROR("!DKUtil::System(\"cls\", out) failed\n");
	return true;
}

int DKConsole::count(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::count not implemented\n");
}

int DKConsole::countReset(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::countReset not implemented\n");
}

int DKConsole::debug(duk_context* ctx){
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKDEBUG(string);
	return true;
}

int DKConsole::dir(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::dir not implemented\n");
}

int DKConsole::dirxml(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::dirxml not implemented\n");
}

int DKConsole::error(duk_context* ctx){
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKERROR(string);
	return true;
}

int DKConsole::exception(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::exception not implemented\n");
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKERROR(string);
	return true;
}

int DKConsole::group(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::group not implemented\n");
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKINFO(string);
	return true;
}

int DKConsole::groupCollapsed(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::groupCollapsed not implemented\n");
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKINFO(string);
	return true;
}

int DKConsole::groupEnd(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::groupEnd not implemented\n");
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKINFO(string);
	return true;
}

int DKConsole::info(duk_context* ctx){
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKINFO(string);
	return true;
}

int DKConsole::log(duk_context* ctx){
	DKString string;
	if (duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if (duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if (duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKINFO(string);
	return true;
}

int DKConsole::profile(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::profile not implemented\n");
}

int DKConsole::profileEnd(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::profileEnd not implemented\n");
}

int DKConsole::table(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::table not implemented\n");
}

int DKConsole::time(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::time not implemented\n");
}

int DKConsole::timeEnd(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::timeEnd not implemented\n");
}

int DKConsole::timeLog(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::timeLog not implemented\n");
}

int DKConsole::timeStamp(duk_context* ctx){
	//TODO
	return DKERROR("DKConsole::timeStamp not implemented\n");
}

int DKConsole::trace(duk_context* ctx){
	if(!DKDuktape::Trace())
		return DKERROR("DKDuktape::Trace() invalid")
	return true;
}

int DKConsole::warn(duk_context* ctx){
	DKString string;
	if(duk_is_string(ctx, 0))
		string = duk_require_string(ctx, 0);
	if(duk_is_boolean(ctx, 0))
		string = toString(duk_require_boolean(ctx, 0));
	if(duk_is_number(ctx, 0))
		string = toString(duk_require_int(ctx, 0));
	DKWARN(string);
	return true;
}


#endif //HAVE_DKDuktape