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

// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

#include "DK/DKApp.h"
#include "DKDuktapeDom/DKUIEvent.h"
#include "DKDuktapeDom/DKEvent.h"
//#include "DKRml/DKRml.h"


bool DKUIEvent::Init(){
	DKDEBUGFUNC();

	// Properties
	//DKDuktape::AttachFunction("CPP_DKUIEvent_cancelBubble", DKUIEvent::cancelBubble);

	// Methods
	DKDuktape::AttachFunction("CPP_DKUIEvent_initUIEvent", DKUIEvent::initUIEvent);

	DKClass::DKCreate("DKDuktapeDom/DKUIEvent.js");
	return true;
}


// Properties
/*
int DKUIEvent::cancelBubble(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKEvent::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKUIEvent::cencelBubble(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	bool flag = duk_require_boolean(ctx, 1);
	if(flag){
		event->StopPropagation();
		return true;
	}
	return true;
}
*/

// Methods
int DKUIEvent::initUIEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	/*
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		DKERROR("DKUIEvent::initEvent(): event invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}

	//TODO
	*/
	return false;
}