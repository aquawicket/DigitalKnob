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

// https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent

#include "DK/DKApp.h"
#include "DKDuktape/DKEvent.h"
#include "DKDuktape/DKEventTarget.h"
#include "DKDuktape/DKWheelEvent.h"
#include "EventTest/ConsoleInput.h"


bool DKWheelEvent::Init(){
	DKDEBUGFUNC();

	//// Properties ////
	DKDuktape::AttachFunction("CPP_DKWheelEvent_deltaX", DKWheelEvent::deltaX);
	DKDuktape::AttachFunction("CPP_DKWheelEvent_deltaY", DKWheelEvent::deltaY);
	DKDuktape::AttachFunction("CPP_DKWheelEvent_deltaZ", DKWheelEvent::deltaZ);
	DKDuktape::AttachFunction("CPP_DKWheelEvent_deltaMode", DKWheelEvent::deltaMode);
	
	//// Deprecated Properties ////
	/*
	DKDuktape::AttachFunction("CPP_DKWheelEvent_wheelDelta", DKWheelEvent::wheelDelta);
	DKDuktape::AttachFunction("CPP_DKWheelEvent_wheelDeltaX", DKWheelEvent::wheelDeltaX);
	DKDuktape::AttachFunction("CPP_DKWheelEvent_wheelDeltaY", DKWheelEvent::wheelDeltaY);
	*/

	DKClass::DKCreate("DKDuktape/DKWheelEvent.js");
	return true;
}


//// Properties ////
int DKWheelEvent::deltaX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleInput* event = (ConsoleInput*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_int(ctx, event->deltaX);
	return true;
}

int DKWheelEvent::deltaY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleInput* event = (ConsoleInput*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_int(ctx, event->deltaY);
	return true;
}

int DKWheelEvent::deltaZ(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleInput* event = (ConsoleInput*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_int(ctx, event->deltaZ);
	return true;
}

int DKWheelEvent::deltaMode(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleInput* event = (ConsoleInput*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_uint(ctx, event->deltaMode);
	return true;
}

//// Deprecated Properties ////
/*
int DKWheelEvent::wheelDelta(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleInput* event = (ConsoleInput*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_uint(ctx, event->wheelDelta);
	return true;
}

int DKWheelEvent::wheelDeltaX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleInput* event = (ConsoleInput*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_boolean(ctx, event->wheelDeltaX);
	return true;
}

int DKWheelEvent::wheelDeltaY(duk_context* ctx) {
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleInput* event = (ConsoleInput*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_undefined(ctx);
		return true;
	}
	duk_push_int(ctx, event->wheelDeltaY);
	return true;
}
*/
