// [W3C] https://console.spec.whatwg.org/
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
#pragma once
#ifndef TEST_Console_H
#define TEST_Console_H

#include "DK/DK.h"
#include "DKConsole/DKConsole.h"


class TEST_Console : public DKObjectT<TEST_Console>
{
public:
	bool Init(){
		DKINFO("////// TEST_Console.h ////// \n");
		
		////// Instance methods //////
		// [console.assert()] https://developer.mozilla.org/en-US/docs/Web/API/console/assert
		DKString assert_string = "assert test \n";
		DKConsole::_assert(assert_string);
		// [console.clear()] https://developer.mozilla.org/en-US/docs/Web/API/console/clear
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
		// [console.log()] https://developer.mozilla.org/en-US/docs/Web/API/console/log
		// [console.profile()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profile
		// [console.profileEnd()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profileEnd
		// [console.table()] https://developer.mozilla.org/en-US/docs/Web/API/console/table
		// [console.time()] https://developer.mozilla.org/en-US/docs/Web/API/console/time
		// [console.timeEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeEnd
		// [console.timeLog()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeLog
		// [console.timeStamp()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/timeStamp
		// [console.trace() https://developer.mozilla.org/en-US/docs/Web/API/console/trace
		// [console.warn() https://developer.mozilla.org/en-US/docs/Web/API/console/warn
		
		return true;
	}
	
};
REGISTER_OBJECT(TEST_Console, true);


#endif //TEST_Console_H