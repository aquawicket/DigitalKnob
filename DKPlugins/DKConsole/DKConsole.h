// TODO - we should make Console a non static interface. Then we can derive from it to direct it anywhere we want just like other Interfaces

// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
#pragma once
#ifndef DKConsole_H
#define DKConsole_H

#include "DK/DK.h"

//[Exposed=*]
//namespace console { // but see namespace object requirements below
class DKConsole
{
public:
	DKConsole() {
		DKDEBUGFUNC();
		//eventTargetClass = "Console";
		//eventTargetAddress = pointerToAddress(this);
	}
	
	// Logging
	//undefined assert(optional boolean condition = false, any... data);
	static void _assert(const DKString& data) {
		DKDEBUGFUNC(data);
		DKERROR(data+"\n");
	}
	static void _assert(const bool& condition, const DKString& data){
		DKDEBUGFUNC(condition, data);
		if(!condition)
			_assert(data);
	}
	static void _assert(const char* data)							{ _assert(toString(data)); }
	static void _assert(const bool& data)							{ _assert(toString(data)); }
	static void _assert(const int& data)							{ _assert(toString(data)); }
	static void _assert(const double& data)							{ _assert(toString(data)); }
	static void _assert(const bool& condition, const char* data)	{ _assert(condition, toString(data)); }
	static void _assert(const bool& condition, const bool& data)	{ _assert(condition, toString(data)); }
	static void _assert(const bool& condition, const int& data)		{ _assert(condition, toString(data)); }
	static void _assert(const bool& condition, const double& data)	{ _assert(condition, toString(data)); }

	//undefined clear();
	static void clear() {
		DKDEBUGFUNC();
		int rtnvalue = DKUtil::System("cls", rtnvalue);
	}

	//undefined debug(any... data);
	static void debug(const DKString& data) {
		DKDEBUGFUNC(data);
		DKDEBUG(data+"\n");
	}
	static void debug(const char* data)		{ debug(toString(data)); }
	static void debug(const bool& data)		{ debug(toString(data)); }
	static void debug(const int& data)		{ debug(toString(data)); }
	static void debug(const double& data)	{ debug(toString(data)); }
	
	//undefined error(any... data);
	static void error(const DKString& data) {
		DKDEBUGFUNC(data);
		DKERROR(data+"\n");
	}
	static void error(const char* data)		{ error(toString(data)); }
	static void error(const bool& data)		{ error(toString(data)); }
	static void error(const int& data)		{ error(toString(data)); }
	static void error(const double& data)	{ error(toString(data)); }
	
	//undefined info(any... data);
	static void info(const DKString& data) {
		DKDEBUGFUNC(data);
		DKINFO(data+"\n");
	}
	static void info(const char* data)	{ info(toString(data)); }
	static void info(const bool& data)	{ info(toString(data)); }
	static void info(const int& data)	{ info(toString(data)); }
	static void info(const double& data){ info(toString(data)); }

	//undefined log(any... data);
	static void log(const DKString& data) {
		DKDEBUGFUNC(data);
		DKINFO(data+"\n");
	}
	static void log(const char* data)	{ log(toString(data)); }
	static void log(const bool& data)	{ log(toString(data)); }
	static void log(const int& data)	{ log(toString(data)); }
	static void log(const double& data)	{ log(toString(data)); }
	
	//undefined table(optional any tabularData, optional sequence<DOMString> properties);
	static void table() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	//undefined trace(any... data);
	static void trace(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	static void trace(const char* data)		{ trace(toString(data)); }
	static void trace(const bool& data)		{ trace(toString(data)); }
	static void trace(const int& data)		{ trace(toString(data)); }
	static void trace(const double& data)	{ trace(toString(data)); }
	
	//undefined warn(any... data);
	static void warn(const DKString& data) {
		DKDEBUGFUNC(data);
		DKWARN(data+"\n");
	}
	static void warn(const char* data)	{ warn(toString(data)); }
	static void warn(const bool& data)	{ warn(toString(data)); }
	static void warn(const int& data)	{ warn(toString(data)); }
	static void warn(const double& data){ warn(toString(data)); }
	
	//undefined dir(optional any item, optional object? options);
	static void dir() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	//undefined dirxml(any... data);
	static void dirxml(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	
	// Counting
	//undefined count(optional DOMString label = "default");
	static void count() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	//undefined countReset(optional DOMString label = "default");
	static void countReset() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// Grouping
	//undefined group(any... data);
	static void group(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	static void group(const char* data)		{ group(toString(data)); }
	static void group(const bool& data)		{ group(toString(data)); }
	static void group(const int& data)		{ group(toString(data)); }
	static void group(const double& data)	{ group(toString(data)); }
	
	//undefined groupCollapsed(any... data);
	static void groupCollapsed(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	static void groupCollapsed(const char* data)	{ groupCollapsed(toString(data)); }
	static void groupCollapsed(const bool& data)	{ groupCollapsed(toString(data)); }
	static void groupCollapsed(const int& data)		{ groupCollapsed(toString(data)); }
	static void groupCollapsed(const double& data)	{ groupCollapsed(toString(data)); }
	
	//undefined groupEnd();
	static void groupEnd() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// Timing
	//undefined time(optional DOMString label = "default");
	static void time() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	//undefined timeLog(optional DOMString label = "default", any... data);
	static void timeLog() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	//undefined timeEnd(optional DOMString label = "default");
	static void timeEnd() {
		DKDEBUGFUNC();
		DKTODO();
	}
};


#endif //DKConsole_H