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

// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

#include "DK/DKApp.h"
#include "DKDuktape/DKEvent.h"
#include "DKDuktape/DKEventTarget.h"
#include "DKDuktape/DKMouseEvent.h"
#include "EventTest/ConsoleInput.h"


bool DKMouseEvent::Init(){
	DKDEBUGFUNC();
	// Properties
	DKDuktape::AttachFunction("CPP_DKMouseEvent_altKey", DKMouseEvent::altKey);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_button", DKMouseEvent::button);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_buttons", DKMouseEvent::buttons);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_clientX", DKMouseEvent::clientX);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_clientY", DKMouseEvent::clientY);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_ctrlKey", DKMouseEvent::ctrlKey);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_metaKey", DKMouseEvent::metaKey);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_movementX", DKMouseEvent::movementX);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_movementY", DKMouseEvent::movementY);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_offsetX", DKMouseEvent::offsetX);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_offsetY", DKMouseEvent::offsetY);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_offsetX", DKMouseEvent::offsetX);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_pageX", DKMouseEvent::pageX);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_pageY", DKMouseEvent::pageY);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_region", DKMouseEvent::region);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_relatedTarget", DKMouseEvent::relatedTarget);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_screenX", DKMouseEvent::screenX);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_screenY", DKMouseEvent::screenY);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_shiftKey", DKMouseEvent::shiftKey);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_which", DKMouseEvent::which);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_mozPressure", DKMouseEvent::mozPressure);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_mozIputSource", DKMouseEvent::mozInputSource);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_webkitForce", DKMouseEvent::webkitForce);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_x", DKMouseEvent::x);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_y", DKMouseEvent::y);

	// Methods
	DKDuktape::AttachFunction("CPP_DKMouseEvent_getModifierState", DKMouseEvent::getModifierState);
	DKDuktape::AttachFunction("CPP_DKMouseEvent_initMouseEvent", DKMouseEvent::initMouseEvent);

	DKClass::DKCreate("DKDuktape/DKMouseEvent.js");
	return true;
}


// Properties
int DKMouseEvent::altKey(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKMouseEvent::button(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	ConsoleInput* event = (ConsoleInput*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	unsigned int button = event->button;
	duk_push_uint(ctx, button);
	return true;
}

int DKMouseEvent::buttons(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::clientX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKMouseEvent::clientY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKMouseEvent::ctrlKey(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKMouseEvent::metaKey(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKMouseEvent::movementX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::movementY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::offsetX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::offsetY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::pageX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::pageY(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::region(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::relatedTarget(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::screenX(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int x, y;
	DKUtil::GetMousePos(x, y);
	duk_push_int(ctx, x);
	return true;
}

int DKMouseEvent::screenY(duk_context* ctx) {
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	int x, y;
	DKUtil::GetMousePos(x, y);
	duk_push_int(ctx, y);
	return true;
}

int DKMouseEvent::shiftKey(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKMouseEvent::which(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::mozPressure(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::mozInputSource(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::webkitForce(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::x(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}

int DKMouseEvent::y(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return true;
}


// Methods
///////////////////////////////////////////////////////
int DKMouseEvent::getModifierState(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}

int DKMouseEvent::initMouseEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	DKEvents* event = (DKEvents*)DKDuktape::addressToPointer(eventAddress);
	if (!event) {
		DKERROR("event invalid! \n");
		duk_push_boolean(ctx, false);
		return true;
	}
	//TODO
	return false;
}
