// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
#ifdef HAVE_DKDuktape 

#pragma once
#ifndef DKConsoleDUK_H
#define DKConsoleDUK_H

#include "DKConsole/DKConsole.h"
#include "DKDuktape/DKDuktape.h"


//[Exposed=*]
//namespace console { // but see namespace object requirements below
class DKConsoleDUK : public DKObjectT<DKConsoleDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKConsoleDUK", 				DKConsoleDUK::constructor);
		
		// Logging
		//undefined assert(optional boolean condition = false, any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_assert",		DKConsoleDUK::_assert);
		
		//undefined clear();
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_clear", 		DKConsoleDUK::clear);
		
		//undefined debug(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_debug", 		DKConsoleDUK::debug);
		
		//undefined error(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_error", 		DKConsoleDUK::error);
		
		//undefined info(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_info", 			DKConsoleDUK::info);
		
		//undefined log(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_log", 			DKConsoleDUK::log);
		
		//undefined table(optional any tabularData, optional sequence<DOMString> properties);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_table", 		DKConsoleDUK::table);
		
		//undefined trace(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_trace", 		DKConsoleDUK::trace);
		
		//undefined warn(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_warn", 			DKConsoleDUK::warn);
		
		//undefined dir(optional any item, optional object? options);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_dir", 			DKConsoleDUK::dir);
		
		//undefined dirxml(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_dirxml", 		DKConsoleDUK::dirxml);
		
		// Counting
		//undefined count(optional DOMString label = "default");	
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_count", 		DKConsoleDUK::count);
		
		//undefined countReset(optional DOMString label = "default");
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_countReset", 	DKConsoleDUK::countReset);
		
		// Grouping
		//undefined group(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_group", 		DKConsoleDUK::group);
		
		//undefined groupCollapsed(any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_groupCollapsed",DKConsoleDUK::groupCollapsed);
		
		//undefined groupEnd();
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_groupEnd", 		DKConsoleDUK::groupEnd);
		
		// Timing
		//undefined time(optional DOMString label = "default");
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_time", 			DKConsoleDUK::time);
		
		//undefined timeLog(optional DOMString label = "default", any... data);
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_timeLog", 		DKConsoleDUK::timeLog);
		
		//undefined timeEnd(optional DOMString label = "default");
		DKDuktape::AttachFunction("CPP_DKConsoleDUK_timeEnd", 		DKConsoleDUK::timeEnd);
				
		
		////// Load .js files //////
		DKClass::DKCreate("DKConsole/DKConsoleDUK.js");
		return true;
	}
	
	
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKConsoleDUK()\n");
		DKConsole* _console = new DKConsole();
		DKString consoleAddress = pointerToAddress(_console);
		duk_push_string(ctx, consoleAddress.c_str());
		return true;
	}
	
	// Logging
	//undefined assert(optional boolean condition = false, any... data);
	static int _assert(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString string;
		if(duk_is_string(ctx, 0))
			string = duk_require_string(ctx, 0);
		if(duk_is_boolean(ctx, 0))
			string = toString(duk_require_boolean(ctx, 0));
		if(duk_is_number(ctx, 0))
			string = toString(duk_require_int(ctx, 0));
		DKConsole::_assert(string);
		return true;
	}

	//undefined clear();
	static int clear(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKConsole::clear();
		return true;
	}

	//undefined debug(any... data);
	static int debug(duk_context* ctx){
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
	
	//undefined error(any... data);
	static int error(duk_context* ctx){
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
	
	//undefined info(any... data);
	static int info(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString string;
		if(duk_is_string(ctx, 0))
			string = duk_require_string(ctx, 0);
		if(duk_is_boolean(ctx, 0))
			string = toString(duk_require_boolean(ctx, 0));
		if(duk_is_number(ctx, 0))
			string = toString(duk_require_int(ctx, 0));
		DKConsole::info(string);
		return true;
	}
	
	//undefined log(any... data);
	static int log(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString string;
		if (duk_is_string(ctx, 0))
			string = duk_require_string(ctx, 0);
		if (duk_is_boolean(ctx, 0))
			string = toString(duk_require_boolean(ctx, 0));
		if (duk_is_number(ctx, 0))
			string = toString(duk_require_int(ctx, 0));
		DKConsole::log(string);
		return true;
	}
	
	//undefined table(optional any tabularData, optional sequence<DOMString> properties);
	static int table(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	//undefined trace(any... data);
	static int trace(duk_context* ctx){
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
	
	//undefined warn(any... data);
	static int warn(duk_context* ctx){
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
	
	//undefined dir(optional any item, optional object? options);
	static int dir(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	//undefined dirxml(any... data);
	static int dirxml(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// Counting
	//undefined count(optional DOMString label = "default");
	static int count(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	//undefined countReset(optional DOMString label = "default");
	static int countReset(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}	
	
	// Grouping
	//undefined group(any... data);
	static int group(duk_context* ctx){
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
	
	//undefined groupCollapsed(any... data);
	static int groupCollapsed(duk_context* ctx){
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
	
	//undefined groupEnd();
	static int groupEnd(duk_context* ctx){
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
	
	// Timing
	//undefined time(optional DOMString label = "default");
	static int time(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	//undefined timeLog(optional DOMString label = "default", any... data);
	static int timeLog(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	//undefined timeEnd(optional DOMString label = "default");
	static int timeEnd(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
};
REGISTER_OBJECT(DKConsoleDUK, true)


#endif //DKConsoleDUK_H
#endif //HAVE_DKDuktape