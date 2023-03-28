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

#ifdef HAVE_DKDuktape 
#include "DK/DKApp.h"
#include "JSEventsTest/DKConsole.h"


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
	DKClass::DKCreate("JSEventsTest/DKConsole.js");
	return true;
}

int DKConsole::_assert(duk_context* ctx){
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
	int rtnvalue = DKUtil::System("cls", rtnvalue);
	duk_push_int(ctx, rtnvalue);
	return true;
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

int DKConsole::trace(duk_context* ctx){
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