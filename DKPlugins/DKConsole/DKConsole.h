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
	static bool _assert(const DKString& data) {
		DKDEBUGFUNC(data);
		DKERROR(data+"\n");
		return true;
	}

	//undefined clear();
	static bool clear() {
		DKDEBUGFUNC();
		int rtnvalue = DKUtil::System("cls", rtnvalue);
		return true;
	}

	//undefined debug(any... data);
	static bool debug(const DKString& data) {
		DKDEBUGFUNC(data);
		DKDEBUG(data+"\n");
		return true;
	}
	
	//undefined error(any... data);
	static bool error(const DKString& data) {
		DKDEBUGFUNC(data);
		DKERROR(data+"\n");
		return true;
	}
	
	//undefined info(any... data);
	static bool info(const DKString& data) {
		DKDEBUGFUNC(data);
		DKINFO(data+"\n");
		return true;
	}

	//undefined log(any... data);
	static bool log(const DKString& data) {
		DKDEBUGFUNC(data);
		DKINFO(data+"\n");
		return true;
	}
	static bool log(const bool& data){		return log(toString(data));	}
	static bool log(const int& data){		return log(toString(data));	}
	static bool log(const double& data){	return log(toString(data));	}
	
	//undefined table(optional any tabularData, optional sequence<DOMString> properties);
	static bool table() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	//undefined trace(any... data);
	static bool trace(const DKString& data) {
		DKDEBUGFUNC(data);
		return DKTODO();
	}
	
	//undefined warn(any... data);
	static bool warn(const DKString& data) {
		DKDEBUGFUNC(data);
		DKWARN(data+"\n");
		return true;
	}
	
	//undefined dir(optional any item, optional object? options);
	static bool dir() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	//undefined dirxml(any... data);
	static bool dirxml(const DKString& data) {
		DKDEBUGFUNC(data);
		return DKTODO();
	}
	
	// Counting
	//undefined count(optional DOMString label = "default");
	static bool count() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	//undefined countReset(optional DOMString label = "default");
	static bool countReset() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// Grouping
	//undefined group(any... data);
	static bool group(const DKString& data) {
		DKDEBUGFUNC(data);
		return DKTODO();
	}
	
	//undefined groupCollapsed(any... data);
	static bool groupCollapsed(const DKString& data) {
		DKDEBUGFUNC(data);
		return DKTODO();
	}
	
	//undefined groupEnd();
	static bool groupEnd() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// Timing
	//undefined time(optional DOMString label = "default");
	static bool time() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	//undefined timeLog(optional DOMString label = "default", any... data);
	static bool timeLog() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	//undefined timeEnd(optional DOMString label = "default");
	static bool timeEnd() {
		DKDEBUGFUNC();
		return DKTODO();
	}
};


#endif //DKConsole_H