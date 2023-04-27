// [IDL] https://console.spec.whatwg.org/
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
#pragma once
#ifndef DKConsole_H
#define DKConsole_H

#include "DK/DK.h"


class DKConsole
{
public:
	DKConsole() {
		DKDEBUGFUNC();
		//eventTargetClass = "Console";
		//eventTargetAddress = pointerToAddress(this);
	}
	
	
	////// Instance methods //////
	// [console.assert()] https://developer.mozilla.org/en-US/docs/Web/API/console/assert
	static bool _assert(DKString& string) {
		DKDEBUGFUNC();
		DKERROR(string);
		return true;
	}
	// [console.clear()] https://developer.mozilla.org/en-US/docs/Web/API/console/clear
	static bool clear() {
		DKDEBUGFUNC();
		int rtnvalue = DKUtil::System("cls", rtnvalue);
		return true;
	}
	// [console.count()] https://developer.mozilla.org/en-US/docs/Web/API/console/count
	// [console.countReset()] https://developer.mozilla.org/en-US/docs/Web/API/console/countReset
	// [console.debug()] https://developer.mozilla.org/en-US/docs/Web/API/console/debug
	// [console.dir()] https://developer.mozilla.org/en-US/docs/Web/API/console/dir
	// [console.dirxml()] https://developer.mozilla.org/en-US/docs/Web/API/console/dirxml
	// [console.error()] https://developer.mozilla.org/en-US/docs/Web/API/console/error
	// [console.exception()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/console/exception
	// [console.group()] https://developer.mozilla.org/en-US/docs/Web/API/console/group
	// [console.groupCollapsed()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupCollapsed
	// [console.groupEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupEnd
	// [console.info()] https://developer.mozilla.org/en-US/docs/Web/API/console/info
	static bool info(DKString& string) {
		DKDEBUGFUNC();
		DKINFO(string);
		return true;
	}
	// [console.log()] https://developer.mozilla.org/en-US/docs/Web/API/console/log
	static bool log(DKString& string) {
		DKDEBUGFUNC();
		DKINFO(string);
		return true;
	}
	// [console.profile()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profile
	// [console.profileEnd()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profileEnd
	// [console.table()] https://developer.mozilla.org/en-US/docs/Web/API/console/table
	// [console.time()] https://developer.mozilla.org/en-US/docs/Web/API/console/time
	// [console.timeEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeEnd
	// [console.timeLog()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeLog
	// [console.timeStamp()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/timeStamp
	// [console.trace() https://developer.mozilla.org/en-US/docs/Web/API/console/trace
	// [console.warn() https://developer.mozilla.org/en-US/docs/Web/API/console/warn
};


#endif //DKConsole_H