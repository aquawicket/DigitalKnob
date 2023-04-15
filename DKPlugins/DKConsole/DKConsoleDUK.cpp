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
#include "DKConsole/DKConsoleDUK.h"


bool DKConsoleDUK::Init(){
	DKDEBUGFUNC();
	
	////// Instance methods //////
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_assert",		DKConsoleDUK::_assert); 		// [console.assert()] https://developer.mozilla.org/en-US/docs/Web/API/console/assert
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_clear", 		DKConsoleDUK::clear);			// [console.clear()] https://developer.mozilla.org/en-US/docs/Web/API/console/clear
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_count", 		DKConsoleDUK::count);			// [console.count()] https://developer.mozilla.org/en-US/docs/Web/API/console/count
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_countReset", 	DKConsoleDUK::countReset);		// [console.countReset()] https://developer.mozilla.org/en-US/docs/Web/API/console/countReset
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_debug", 		DKConsoleDUK::debug);			// [console.debug()] https://developer.mozilla.org/en-US/docs/Web/API/console/debug
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_dir", 			DKConsoleDUK::dir);				// [console.dir()] https://developer.mozilla.org/en-US/docs/Web/API/console/dir
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_error", 		DKConsoleDUK::error);
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_exception", 	DKConsoleDUK::exception);
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_group", 		DKConsoleDUK::group);
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_groupCollapsed",DKConsoleDUK::groupCollapsed);
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_groupEnd", 		DKConsoleDUK::groupEnd);
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_info", 			DKConsoleDUK::info);
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_log", 			DKConsoleDUK::log);
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_trace", 		DKConsoleDUK::trace);
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_warn", 			DKConsoleDUK::warn);
	
	DKClass::DKCreate("DKConsole/DKConsoleDUK.js");
	return true;
}


////// Instance methods //////
// [console.assert()] https://developer.mozilla.org/en-US/docs/Web/API/console/assert
int DKConsoleDUK::_assert(duk_context* ctx){
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
// [console.clear()] https://developer.mozilla.org/en-US/docs/Web/API/console/clear
int DKConsoleDUK::clear(duk_context* ctx){
	int rtnvalue = DKUtil::System("cls", rtnvalue);
	duk_push_int(ctx, rtnvalue);
	return true;
}
// [console.count()] https://developer.mozilla.org/en-US/docs/Web/API/console/count
int DKConsoleDUK::count(duk_context* ctx){
	return DKTODO();
}
// [console.countReset()] https://developer.mozilla.org/en-US/docs/Web/API/console/countReset
int DKConsoleDUK::countReset(duk_context* ctx){
	return DKTODO();
}
// [console.debug()] https://developer.mozilla.org/en-US/docs/Web/API/console/debug
int DKConsoleDUK::debug(duk_context* ctx){
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
// [console.dir()] https://developer.mozilla.org/en-US/docs/Web/API/console/dir
int DKConsoleDUK::dir(duk_context* ctx){
	return DKTODO();
}

int DKConsoleDUK::error(duk_context* ctx){
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

int DKConsoleDUK::exception(duk_context* ctx){
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

int DKConsoleDUK::group(duk_context* ctx){
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

int DKConsoleDUK::groupCollapsed(duk_context* ctx){
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

int DKConsoleDUK::groupEnd(duk_context* ctx){
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

int DKConsoleDUK::info(duk_context* ctx){
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

int DKConsoleDUK::log(duk_context* ctx){
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

int DKConsoleDUK::trace(duk_context* ctx){
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

int DKConsoleDUK::warn(duk_context* ctx){
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