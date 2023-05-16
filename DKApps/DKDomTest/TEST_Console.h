// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
#pragma once
#ifndef TEST_Console_H
#define TEST_Console_H

#include "DKConsole/DKConsole.h"


class TEST_Console : public DKObjectT<TEST_Console>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Console.h //////\n");
		
		//undefined assert(optional boolean condition = false, any... data);
		DKConsole::_assert("console.assert() test");

		//undefined clear();
		//DKConsole::clear();
		
		//undefined debug(any... data);
		DKConsole::debug("console.debug() test");
		
		//undefined error(any... data);
		DKConsole::error("console.error() test");

		//undefined info(any... data);
		DKConsole::info("console.info() test");
		
		//undefined log(any... data);
		DKConsole::log("console.log() test");
		DKConsole::log("abc"); 
		DKConsole::log(1);
		DKConsole::log(-1);
		DKConsole::log(1.0);
		DKConsole::log(-1.0);
		DKConsole::log(1.1);
		DKConsole::log(-1.1);
		DKConsole::log(true);
		//DKConsole::log(null);				//error C2065: 'null': undeclared identifier
		//DKConsole::log(undefined); 		//error C2065: 'undefined': undeclared identifier
		//DKConsole::log([1, 2, 3, 4]); 	//error C2143: syntax error: missing ']' before 'constant'
		//DKConsole::log({a:1, b:2, c:3}); 	//error C2065: 'b': undeclared identifier

		//undefined table(optional any tabularData, optional sequence<DOMString> properties);
		//DKConsole::table(); //TODO

		//undefined trace(any... data);
		DKConsole::trace("console.trace() test");

		//undefined warn(any... data);
		DKConsole::warn("console.warn() test");

		//undefined dir(optional any item, optional object? options);
		//DKConsole::dir(); //TODO

		//undefined dirxml(any... data);
		DKConsole::dirxml("console.dirxml() test");

		// Counting
		//undefined count(optional DOMString label = "default");
		DKConsole::count();

		//undefined countReset(optional DOMString label = "default");
		DKConsole::countReset();

		// Grouping
		//undefined group(any... data);
		DKConsole::group("console.group() test");

		//undefined groupCollapsed(any... data);
		DKConsole::groupCollapsed("console.groupCollapsed() test");

		//undefined groupEnd();
		DKConsole::groupEnd();

		// Timing
		//undefined time(optional DOMString label = "default");
		DKConsole::time();

		//undefined timeLog(optional DOMString label = "default", any... data);
		//DKConsole::timeLog("default", "console.timeLog() test");	//error C2660: 'DKConsole::timeLog': function does not take 2 arguments

		//undefined timeEnd(optional DOMString label = "default");
		DKConsole::timeEnd();

		return true;
	}
	
};
REGISTER_OBJECT(TEST_Console, true);


#endif //TEST_Console_H