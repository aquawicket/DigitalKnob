/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

//https://developer.mozilla.org/en-US/docs/Web/API/Console

#include "DK/DKApp.h"
#include "DKDom/DKDomConsole.h"


bool DKDomConsole::Init(){
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

int DKDomConsole::_assert(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("DKDomConsole::assert not implemented\n");
}

int DKDomConsole::clear(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int out;
	if(!DKUtil::System("cls", out))
		return DKERROR("!DKUtil::System(\"cls\", out) failed\n");
	return true;
}

int DKDomConsole::count(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::countReset(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::debug(duk_context* ctx){
	DKDEBUGFUNC(ctx);
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

int DKDomConsole::dir(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::dirxml(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::error(duk_context* ctx){
	DKDEBUGFUNC(ctx);
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

int DKDomConsole::exception(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::group(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::groupCollapsed(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::groupEnd(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::info(duk_context* ctx){
	DKDEBUGFUNC(ctx);
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

int DKDomConsole::log(duk_context* ctx){
	DKDEBUGFUNC(ctx);
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

int DKDomConsole::profile(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::profileEnd(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::table(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::time(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::timeEnd(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::timeLog(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::timeStamp(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return DKERROR("not implemented\n");
}

int DKDomConsole::trace(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKDuktape::Trace())
		return DKERROR("DKDuktape::Trace() invalid")
	return true;
}

int DKDomConsole::warn(duk_context* ctx){
	DKDEBUGFUNC(ctx);
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
