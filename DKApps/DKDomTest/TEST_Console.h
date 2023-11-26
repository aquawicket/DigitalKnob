// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
#pragma once
#ifndef TEST_Console_H
#define TEST_Console_H

#include "DKConsole/DKConsole.h"


class TEST_Console //: public DKObjectT<TEST_Console>
{
public:
	TEST_Console() {
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Console.h //////\n");
		
		DKConsole _console;
		
		//undefined assert(optional boolean condition = false, any... data);
		_console._assert("console.assert() test");

		//undefined clear();
		//_console.clear();
		
		//undefined debug(any... data);
		_console.debug("console.debug() test");
		
		//undefined error(any... data);
		_console.error("console.error() test");

		//undefined info(any... data);
		_console.info("console.info() test");
		
		//undefined log(any... data);
		_console.log("console.log() test");
		_console.log("abc"); 
		_console.log(1);
		_console.log(-1);
		_console.log(1.0);
		_console.log(-1.0);
		_console.log(1.1);
		_console.log(-1.1);
		_console.log(true);
		//_console.log(null);				//error C2065: 'null': undeclared identifier
		//_console.log(undefined); 		//error C2065: 'undefined': undeclared identifier
		//_console.log([1, 2, 3, 4]); 	//error C2143: syntax error: missing ']' before 'constant'
		//_console.log({a:1, b:2, c:3}); 	//error C2065: 'b': undeclared identifier

		//undefined table(optional any tabularData, optional sequence<DOMString> properties);
		//_console.table(); //TODO

		//undefined trace(any... data);
		_console.trace("console.trace() test");

		//undefined warn(any... data);
		_console.warn("console.warn() test");

		//undefined dir(optional any item, optional object? options);
		//_console.dir(); //TODO

		//undefined dirxml(any... data);
		_console.dirxml("console.dirxml() test");

		// Counting
		//undefined count(optional DOMString label = "default");
		_console.count();

		//undefined countReset(optional DOMString label = "default");
		_console.countReset();

		// Grouping
		//undefined group(any... data);
		_console.group("console.group() test");

		//undefined groupCollapsed(any... data);
		_console.groupCollapsed("console.groupCollapsed() test");

		//undefined groupEnd();
		_console.groupEnd();

		// Timing
		//undefined time(optional DOMString label = "default");
		_console.time();

		//undefined timeLog(optional DOMString label = "default", any... data);
		//_console.timeLog("default", "console.timeLog() test");	//error C2660: '_console.timeLog': function does not take 2 arguments

		//undefined timeEnd(optional DOMString label = "default");
		_console.timeEnd();
	}
	
};
//REGISTER_OBJECT(TEST_Console, true);

DKConsole console;	// global console variable

#endif //TEST_Console_H