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


// [W3C] https://console.spec.whatwg.org/
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
bool DKConsoleDUK::Init(){
	DKDEBUGFUNC();
	
	////// Instance methods //////
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_assert",		DKConsoleDUK::_assert); 		// [console.assert()] https://developer.mozilla.org/en-US/docs/Web/API/console/assert
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_clear", 		DKConsoleDUK::clear);			// [console.clear()] https://developer.mozilla.org/en-US/docs/Web/API/console/clear
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_count", 		DKConsoleDUK::count);			// [console.count()] https://developer.mozilla.org/en-US/docs/Web/API/console/count
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_countReset", 	DKConsoleDUK::countReset);		// [console.countReset()] https://developer.mozilla.org/en-US/docs/Web/API/console/countReset
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_debug", 		DKConsoleDUK::debug);			// [console.debug()] https://developer.mozilla.org/en-US/docs/Web/API/console/debug
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_dir", 			DKConsoleDUK::dir);				// [console.dir()] https://developer.mozilla.org/en-US/docs/Web/API/console/dir
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_dirxml", 		DKConsoleDUK::dirxml);			// [console.dirxml()] https://developer.mozilla.org/en-US/docs/Web/API/console/dirxml
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_error", 		DKConsoleDUK::error);			// [console.error()] https://developer.mozilla.org/en-US/docs/Web/API/console/error
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_exception", 	DKConsoleDUK::exception);		// [console.exception()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/console/exception
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_group", 		DKConsoleDUK::group);			// [console.group()] https://developer.mozilla.org/en-US/docs/Web/API/console/group
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_groupCollapsed",DKConsoleDUK::groupCollapsed);	// [console.groupCollapsed()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupCollapsed
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_groupEnd", 		DKConsoleDUK::groupEnd);		// [console.groupEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupEnd
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_info", 			DKConsoleDUK::info);			// [console.info()] https://developer.mozilla.org/en-US/docs/Web/API/console/info
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_log", 			DKConsoleDUK::log);				// [console.log()] https://developer.mozilla.org/en-US/docs/Web/API/console/log
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_profile", 		DKConsoleDUK::profile);			// [console.profile()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profile
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_profileEnd", 	DKConsoleDUK::profileEnd);		// [console.profileEnd()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profileEnd
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_table", 		DKConsoleDUK::table);			// [console.table()] https://developer.mozilla.org/en-US/docs/Web/API/console/table
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_time", 			DKConsoleDUK::time);			// [console.time()] https://developer.mozilla.org/en-US/docs/Web/API/console/time
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_timeEnd", 		DKConsoleDUK::timeEnd);			// [console.timeEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeEnd
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_timeLog", 		DKConsoleDUK::timeLog);			// [console.timeLog()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeLog
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_timeStamp", 	DKConsoleDUK::timeStamp);		// [console.timeStamp()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/timeStamp
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_trace", 		DKConsoleDUK::trace);			// [console.trace() https://developer.mozilla.org/en-US/docs/Web/API/console/trace
	DKDuktape::AttachFunction("CPP_DKConsoleDUK_warn", 			DKConsoleDUK::warn);			// [console.warn() https://developer.mozilla.org/en-US/docs/Web/API/console/warn
	
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
// [console.dirxml()] https://developer.mozilla.org/en-US/docs/Web/API/console/dirxml
int DKConsoleDUK::dirxml(duk_context* ctx){
	return DKTODO();
}
// [console.error()] https://developer.mozilla.org/en-US/docs/Web/API/console/error
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
// [console.exception()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/console/exception
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
// [console.group()] https://developer.mozilla.org/en-US/docs/Web/API/console/group
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
// [console.groupCollapsed()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupCollapsed
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
// [console.groupEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupEnd
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
// [console.info()] https://developer.mozilla.org/en-US/docs/Web/API/console/info
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
// [console.log()] https://developer.mozilla.org/en-US/docs/Web/API/console/log
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
// [console.profile()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profile
int DKConsoleDUK::profile(duk_context* ctx){
	return DKTODO();
}
// [console.profileEnd()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profileEnd
int DKConsoleDUK::profileEnd(duk_context* ctx){
	return DKTODO();
}
// [console.table()] https://developer.mozilla.org/en-US/docs/Web/API/console/table
int DKConsoleDUK::table(duk_context* ctx){
	return DKTODO();
}
// [console.time()] https://developer.mozilla.org/en-US/docs/Web/API/console/time
int DKConsoleDUK::time(duk_context* ctx){
	return DKTODO();
}
// [console.timeEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeEnd
int DKConsoleDUK::timeEnd(duk_context* ctx){
	return DKTODO();
}
// [console.timeLog()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeLog
int DKConsoleDUK::timeLog(duk_context* ctx){
	return DKTODO();
}
// [console.timeStamp()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/timeStamp
int DKConsoleDUK::timeStamp(duk_context* ctx){
	return DKTODO();
}
// [console.trace() https://developer.mozilla.org/en-US/docs/Web/API/console/trace
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
// [console.warn() https://developer.mozilla.org/en-US/docs/Web/API/console/warn
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