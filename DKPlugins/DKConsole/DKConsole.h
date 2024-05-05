// TODO: We should make Console a non static interface. Then we can derive from it to direct it anywhere we want just like other Interfaces
// NOTE: As far as WebIDL goes, i'm not sure what a namespace refers to.  It could very well be an underlying Console interface anyway.   Need to do some research. 
// NOTE: ALL WebIDL code will include DKInterface for now. 

// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
#pragma once
#ifndef DKConsole_H
#define DKConsole_H

#include "DKInterface/DKInterface.h"

//[Exposed=*]
//namespace console { // but see namespace object requirements below
class DKConsole : virtual public DKInterface
{
public:
	DKConsole() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "Console";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	
	// Logging
	//undefined assert(optional boolean condition = false, any... data);
	virtual void _assert(const DKString& data) {
		DKDEBUGFUNC(data);
		DKERROR(data+"\n");
	}
	virtual void _assert(const bool& condition, const DKString& data){
		DKDEBUGFUNC(condition, data);
		if(!condition)
			_assert(data);
	}
	virtual void _assert(const char* data)							{ _assert(toString(data)); }
	virtual void _assert(const bool& data)							{ _assert(toString(data)); }
	virtual void _assert(const int& data)							{ _assert(toString(data)); }
	virtual void _assert(const double& data)						{ _assert(toString(data)); }
	virtual void _assert(const bool& condition, const char* data)	{ _assert(condition, toString(data)); }
	virtual void _assert(const bool& condition, const bool& data)	{ _assert(condition, toString(data)); }
	virtual void _assert(const bool& condition, const int& data)	{ _assert(condition, toString(data)); }
	virtual void _assert(const bool& condition, const double& data)	{ _assert(condition, toString(data)); }

	//undefined clear();
	virtual void clear() {
		DKDEBUGFUNC();
		int rtnvalue = DKUtil::System("cls", rtnvalue);
	}

	//undefined debug(any... data);
	virtual void debug(const DKString& data) {
		DKDEBUGFUNC(data);
		DKDEBUG(data+"\n");
	}
	virtual void debug(const char* data)	{ debug(toString(data)); }
	virtual void debug(const bool& data)	{ debug(toString(data)); }
	virtual void debug(const int& data)		{ debug(toString(data)); }
	virtual void debug(const double& data)	{ debug(toString(data)); }
	
	//undefined error(any... data);
	virtual void error(const DKString& data) {
		DKDEBUGFUNC(data);
		DKERROR(data+"\n");
	}
	virtual void error(const char* data)	{ error(toString(data)); }
	virtual void error(const bool& data)	{ error(toString(data)); }
	virtual void error(const int& data)		{ error(toString(data)); }
	virtual void error(const double& data)	{ error(toString(data)); }
	
	//undefined info(any... data);
	virtual void info(const DKString& data) {
		DKDEBUGFUNC(data);
		DKINFO(data+"\n");
	}
	virtual void info(const char* data)		{ info(toString(data)); }
	virtual void info(const bool& data)		{ info(toString(data)); }
	virtual void info(const int& data)		{ info(toString(data)); }
	virtual void info(const double& data)	{ info(toString(data)); }

	//undefined log(any... data);
	virtual void log(const DKString& data) {
		DKDEBUGFUNC(data);
		DKINFO(data+"\n");
	}
	virtual void log(const char* data)	{ log(toString(data)); }
	virtual void log(const bool& data)	{ log(toString(data)); }
	virtual void log(const int& data)	{ log(toString(data)); }
	virtual void log(const double& data){ log(toString(data)); }
	
	//undefined table(optional any tabularData, optional sequence<DOMString> properties);
	virtual void table(const DKString& tabularData = "", const DKString& properties = "") {
		DKDEBUGFUNC(tabularData, properties);
		DKTODO();
	}
	
	//undefined trace(any... data);
	virtual void trace(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	virtual void trace(const char* data)	{ trace(toString(data)); }
	virtual void trace(const bool& data)	{ trace(toString(data)); }
	virtual void trace(const int& data)		{ trace(toString(data)); }
	virtual void trace(const double& data)	{ trace(toString(data)); }
	
	//undefined warn(any... data);
	virtual void warn(const DKString& data) {
		DKDEBUGFUNC(data);
		DKWARN(data+"\n");
	}
	virtual void warn(const char* data)		{ warn(toString(data)); }
	virtual void warn(const bool& data)		{ warn(toString(data)); }
	virtual void warn(const int& data)		{ warn(toString(data)); }
	virtual void warn(const double& data)	{ warn(toString(data)); }
	
	//undefined dir(optional any item, optional object? options);
	virtual void dir(const DKString& item = "", const DKString& options = "") {
		DKDEBUGFUNC(item, options);
		DKTODO();
	}
	
	//undefined dirxml(any... data);
	virtual void dirxml(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	
	// Counting
	//undefined count(optional DOMString label = "default");
	virtual void count(const DOMString& label = "default") {
		DKDEBUGFUNC(label);
		DKTODO();
	}
	
	//undefined countReset(optional DOMString label = "default");
	virtual void countReset(const DOMString& label = "default") {
		DKDEBUGFUNC(label);
		DKTODO();
	}
	
	// Grouping
	//undefined group(any... data);
	virtual void group(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	virtual void group(const char* data)	{ group(toString(data)); }
	virtual void group(const bool& data)	{ group(toString(data)); }
	virtual void group(const int& data)		{ group(toString(data)); }
	virtual void group(const double& data)	{ group(toString(data)); }
	
	//undefined groupCollapsed(any... data);
	virtual void groupCollapsed(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	virtual void groupCollapsed(const char* data)	{ groupCollapsed(toString(data)); }
	virtual void groupCollapsed(const bool& data)	{ groupCollapsed(toString(data)); }
	virtual void groupCollapsed(const int& data)	{ groupCollapsed(toString(data)); }
	virtual void groupCollapsed(const double& data)	{ groupCollapsed(toString(data)); }
	
	//undefined groupEnd();
	virtual void groupEnd() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// Timing
	//undefined time(optional DOMString label = "default");
	virtual void time(const DOMString& label = "default") {
		DKDEBUGFUNC(label);
		DKTODO();
	}
	
	//undefined timeLog(optional DOMString label = "default", any... data);
	virtual void timeLog(const DKString& data) {
		DKDEBUGFUNC(data);
		DKTODO();
	}
	virtual void timeLog(const DOMString& label, const DKString& data){
		DKDEBUGFUNC(label, data);
		DKTODO();
	}
	
	//undefined timeEnd(optional DOMString label = "default");
	virtual void timeEnd(const DOMString& label = "default") {
		DKDEBUGFUNC(label);
		DKTODO();
	}
};


#endif //DKConsole_H