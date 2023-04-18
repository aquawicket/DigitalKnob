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

#pragma once
#ifndef DKConsoleDUK_H
#define DKConsoleDUK_H

#include "DKConsole/DKConsole.h"
#include "DKDuktape/DKDuktape.h"



// [W3C] https://console.spec.whatwg.org/
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
class DKConsoleDUK : public DKObjectT<DKConsoleDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKConsoleDUK", DKConsoleDUK::constructor);
		
		
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
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKConsole/DKConsoleDUK.js");
		return true;
	}
	
	////// Constructor //////
	// [Console()]
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKConsoleDUK()\n");
		DKConsole* _console = new DKConsole();
		DKString eventTargetAddress = pointerToAddress(_console);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	////// Instance methods //////
	// [console.assert()] https://developer.mozilla.org/en-US/docs/Web/API/console/assert
	static int _assert(duk_context* ctx){
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
	static int clear(duk_context* ctx){
		int rtnvalue = DKUtil::System("cls", rtnvalue);
		duk_push_int(ctx, rtnvalue);
		return true;
	}
	// [console.count()] https://developer.mozilla.org/en-US/docs/Web/API/console/count
	static int count(duk_context* ctx){
		return DKTODO();
	}
	// [console.countReset()] https://developer.mozilla.org/en-US/docs/Web/API/console/countReset
	static int countReset(duk_context* ctx){
		return DKTODO();
	}	
	// [console.debug()] https://developer.mozilla.org/en-US/docs/Web/API/console/debug
	static int debug(duk_context* ctx){
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
	static int dir(duk_context* ctx){
		return DKTODO();
	}
	// [console.dirxml()] https://developer.mozilla.org/en-US/docs/Web/API/console/dirxml
	static int dirxml(duk_context* ctx){
		return DKTODO();
	}
	// [console.error()] https://developer.mozilla.org/en-US/docs/Web/API/console/error
	static int error(duk_context* ctx){
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
	static int exception(duk_context* ctx){
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
	static int group(duk_context* ctx){
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
	static int groupCollapsed(duk_context* ctx){
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
	static int groupEnd(duk_context* ctx){
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
	static int info(duk_context* ctx){
		DKString string;
		if(duk_is_string(ctx, 0))
			string = duk_require_string(ctx, 0);
		if(duk_is_boolean(ctx, 0))
			string = toString(duk_require_boolean(ctx, 0));
		if(duk_is_number(ctx, 0))
			string = toString(duk_require_int(ctx, 0));
		//DKINFO(string);
		DKConsole::info(string);
		return true;
	}
	// [console.log()] https://developer.mozilla.org/en-US/docs/Web/API/console/log
	static int log(duk_context* ctx){
		DKString string;
		if (duk_is_string(ctx, 0))
			string = duk_require_string(ctx, 0);
		if (duk_is_boolean(ctx, 0))
			string = toString(duk_require_boolean(ctx, 0));
		if (duk_is_number(ctx, 0))
			string = toString(duk_require_int(ctx, 0));
		//DKINFO(string);
		DKConsole::log(string);
		return true;
	}
	// [console.profile()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profile
	static int profile(duk_context* ctx){
		return DKTODO();
	}
	// [console.profileEnd()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profileEnd
	static int profileEnd(duk_context* ctx){
		return DKTODO();
	}
	// [console.table()] https://developer.mozilla.org/en-US/docs/Web/API/console/table
	static int table(duk_context* ctx){
		return DKTODO();
	}
	// [console.time()] https://developer.mozilla.org/en-US/docs/Web/API/console/time
	static int time(duk_context* ctx){
		return DKTODO();
	}
	// [console.timeEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeEnd
	static int timeEnd(duk_context* ctx){
		return DKTODO();
	}
	// [console.timeLog()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeLog
	static int timeLog(duk_context* ctx){
		return DKTODO();
	}
	// [console.timeStamp()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/timeStamp
	static int timeStamp(duk_context* ctx){
		return DKTODO();
	}
	// [console.trace() https://developer.mozilla.org/en-US/docs/Web/API/console/trace
	static int trace(duk_context* ctx){
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
	static int warn(duk_context* ctx){
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
	
};
REGISTER_OBJECT(DKConsoleDUK, true)


#endif //DKConsoleDUK_H
#endif //HAVE_DKDuktape