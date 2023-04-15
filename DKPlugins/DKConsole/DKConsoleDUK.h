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

#include "DKDuktape/DKDuktape.h"


// [W3C] https://console.spec.whatwg.org/
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
class DKConsoleDUK : public DKObjectT<DKConsoleDUK>
{
public:
	bool Init();
	
	////// Instance methods //////
	// [console.assert()] https://developer.mozilla.org/en-US/docs/Web/API/console/assert
	static int _assert(duk_context* ctx);
	// [console.clear()] https://developer.mozilla.org/en-US/docs/Web/API/console/clear
	static int clear(duk_context* ctx);
	// [console.count()] https://developer.mozilla.org/en-US/docs/Web/API/console/count
	static int count(duk_context* ctx);
	// [console.countReset()] https://developer.mozilla.org/en-US/docs/Web/API/console/countReset
	static int countReset(duk_context* ctx);
	// [console.debug()] https://developer.mozilla.org/en-US/docs/Web/API/console/debug
	static int debug(duk_context* ctx);
	// [console.dir()] https://developer.mozilla.org/en-US/docs/Web/API/console/dir
	static int dir(duk_context* ctx);
	// [console.dirxml()] https://developer.mozilla.org/en-US/docs/Web/API/console/dirxml
	static int dirxml(duk_context* ctx);
	// [console.error()] https://developer.mozilla.org/en-US/docs/Web/API/console/error
	static int error(duk_context* ctx);
	// [console.exception()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/console/exception
	static int exception(duk_context* ctx);
	// [console.group()] https://developer.mozilla.org/en-US/docs/Web/API/console/group
	static int group(duk_context* ctx);
	// [console.groupCollapsed()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupCollapsed
	static int groupCollapsed(duk_context* ctx);
	// [console.groupEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupEnd
	static int groupEnd(duk_context* ctx);
	// [console.info()] https://developer.mozilla.org/en-US/docs/Web/API/console/info
	static int info(duk_context* ctx);
	// [console.log()] https://developer.mozilla.org/en-US/docs/Web/API/console/log
	static int log(duk_context* ctx);
	// [console.profile()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profile
	static int profile(duk_context* ctx);
	// [console.profileEnd()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profileEnd
	static int profileEnd(duk_context* ctx);
	// [console.table()] https://developer.mozilla.org/en-US/docs/Web/API/console/table
	static int table(duk_context* ctx);
	// [console.time()] https://developer.mozilla.org/en-US/docs/Web/API/console/time
	static int time(duk_context* ctx);
	// [console.timeEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeEnd
	static int timeEnd(duk_context* ctx);
	// [console.timeLog()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeLog
	static int timeLog(duk_context* ctx);
	// [console.timeStamp()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/timeStamp
	static int timeStamp(duk_context* ctx);
	// [console.trace() https://developer.mozilla.org/en-US/docs/Web/API/console/trace
	static int trace(duk_context* ctx);
	// [console.warn() https://developer.mozilla.org/en-US/docs/Web/API/console/warn
	static int warn(duk_context* ctx);
	
};
REGISTER_OBJECT(DKConsoleDUK, true)


#endif //DKConsoleDUK_H
#endif //HAVE_DKDuktape