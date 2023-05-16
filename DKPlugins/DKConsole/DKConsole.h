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
	static bool _assert(const bool& condition, const DKString& data){
		DKDEBUGFUNC(condition, data);
		if(!condition)
			_assert(data);
		return true;
	}
	static bool _assert(const char* data){							return _assert(toString(data)); }
	static bool _assert(const bool& data){							return _assert(toString(data)); }
	static bool _assert(const int& data){							return _assert(toString(data)); }
	static bool _assert(const double& data){						return _assert(toString(data)); }
	static bool _assert(const bool& condition, const char* data){	return _assert(condition, toString(data)); }
	static bool _assert(const bool& condition, const bool& data){	return _assert(condition, toString(data)); }
	static bool _assert(const bool& condition, const int& data){	return _assert(condition, toString(data)); }
	static bool _assert(const bool& condition, const double& data){	return _assert(condition, toString(data)); }

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
	static bool debug(const char* data){	return debug(toString(data)); }
	static bool debug(const bool& data){	return debug(toString(data)); }
	static bool debug(const int& data){		return debug(toString(data)); }
	static bool debug(const double& data){	return debug(toString(data)); }
	
	//undefined error(any... data);
	static bool error(const DKString& data) {
		DKDEBUGFUNC(data);
		DKERROR(data+"\n");
		return true;
	}
	static bool error(const char* data){	return error(toString(data)); }
	static bool error(const bool& data){	return error(toString(data)); }
	static bool error(const int& data){		return error(toString(data)); }
	static bool error(const double& data){	return error(toString(data)); }
	
	//undefined info(any... data);
	static bool info(const DKString& data) {
		DKDEBUGFUNC(data);
		DKINFO(data+"\n");
		return true;
	}
	static bool info(const char* data){		return info(toString(data)); }
	static bool info(const bool& data){		return info(toString(data)); }
	static bool info(const int& data){		return info(toString(data)); }
	static bool info(const double& data){	return info(toString(data)); }

	//undefined log(any... data);
	static bool log(const DKString& data) {
		DKDEBUGFUNC(data);
		DKINFO(data+"\n");
		return true;
	}
	static bool log(const char* data){		return log(toString(data)); }
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
	static bool trace(const char* data){	return trace(toString(data)); }
	static bool trace(const bool& data){	return trace(toString(data)); }
	static bool trace(const int& data){		return trace(toString(data)); }
	static bool trace(const double& data){	return trace(toString(data)); }
	
	//undefined warn(any... data);
	static bool warn(const DKString& data) {
		DKDEBUGFUNC(data);
		DKWARN(data+"\n");
		return true;
	}
	static bool warn(const char* data){		return warn(toString(data)); }
	static bool warn(const bool& data){		return warn(toString(data)); }
	static bool warn(const int& data){		return warn(toString(data)); }
	static bool warn(const double& data){	return warn(toString(data)); }
	
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
	static bool group(const char* data){	return group(toString(data)); }
	static bool group(const bool& data){	return group(toString(data)); }
	static bool group(const int& data){		return group(toString(data)); }
	static bool group(const double& data){	return group(toString(data)); }
	
	//undefined groupCollapsed(any... data);
	static bool groupCollapsed(const DKString& data) {
		DKDEBUGFUNC(data);
		return DKTODO();
	}
	static bool groupCollapsed(const char* data){	return groupCollapsed(toString(data)); }
	static bool groupCollapsed(const bool& data){	return groupCollapsed(toString(data)); }
	static bool groupCollapsed(const int& data){	return groupCollapsed(toString(data)); }
	static bool groupCollapsed(const double& data){	return groupCollapsed(toString(data)); }
	
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