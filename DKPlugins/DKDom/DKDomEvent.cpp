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

// https://developer.mozilla.org/en-US/docs/Web/API/Event

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomEvent.h"
#include "DKDom/DKDomElement.h"


bool DKDomEvent::Init(){
	DKDEBUGFUNC();
	// Properties
	DKDuktape::AttachFunction("CPP_DKDomEvent_bubbles", DKDomEvent::bubbles);
	DKDuktape::AttachFunction("CPP_DKDomEvent_cancelBubble", DKDomEvent::cancelBubble);
	DKDuktape::AttachFunction("CPP_DKDomEvent_cancelable", DKDomEvent::cancelable);
	DKDuktape::AttachFunction("CPP_DKDomEvent_composed", DKDomEvent::composed);
	DKDuktape::AttachFunction("CPP_DKDomEvent_currentTarget", DKDomEvent::currentTarget);
	DKDuktape::AttachFunction("CPP_DKDomEvent_deepPath", DKDomEvent::deepPath);
	DKDuktape::AttachFunction("CPP_DKDomEvent_defaultPrevented", DKDomEvent::defaultPrevented);
	DKDuktape::AttachFunction("CPP_DKDomEvent_eventPhase", DKDomEvent::eventPhase);
	DKDuktape::AttachFunction("CPP_DKDomEvent_explicitOriginalTarget", DKDomEvent::explicitOriginalTarget);
	DKDuktape::AttachFunction("CPP_DKDomEvent_originalTarget", DKDomEvent::originalTarget);
	DKDuktape::AttachFunction("CPP_DKDomEvent_returnValue", DKDomEvent::returnValue);
	DKDuktape::AttachFunction("CPP_DKDomEvent_srcElement", DKDomEvent::srcElement);
	DKDuktape::AttachFunction("CPP_DKDomEvent_target", DKDomEvent::target);
	DKDuktape::AttachFunction("CPP_DKDomEvent_timeStamp", DKDomEvent::timeStamp);
	DKDuktape::AttachFunction("CPP_DKDomEvent_type", DKDomEvent::type);
	DKDuktape::AttachFunction("CPP_DKDomEvent_isTrusted", DKDomEvent::isTrusted);

	// Obsolete properties
	DKDuktape::AttachFunction("CPP_DKDomEvent_scoped", DKDomEvent::scoped);

	// Methods
	DKDuktape::AttachFunction("CPP_DKDomEvent_createEvent", DKDomEvent::createEvent);
	DKDuktape::AttachFunction("CPP_DKDomEvent_composedPath", DKDomEvent::composedPath);
	DKDuktape::AttachFunction("CPP_DKDomEvent_initEvent", DKDomEvent::initEvent);
	DKDuktape::AttachFunction("CPP_DKDomEvent_preventDefault", DKDomEvent::preventDefault);
	DKDuktape::AttachFunction("CPP_DKDomEvent_stopImmediatePropagation", DKDomEvent::stopImmediatePropagation);
	DKDuktape::AttachFunction("CPP_DKDomEvent_stopPropagation", DKDomEvent::stopPropagation);

	// Obsolete methods
	DKDuktape::AttachFunction("CPP_DKDomEvent_getPreventDefault", DKDomEvent::getPreventDefault);
	DKDuktape::AttachFunction("CPP_DKDomEvent_preventBubble", DKDomEvent::preventBubble);
	DKDuktape::AttachFunction("CPP_DKDomEvent_preventCapture", DKDomEvent::preventCapture);

	// Extra
	DKDuktape::AttachFunction("CPP_DKDomEvent_getParameters", DKDomEvent::getParameters);

	DKClass::DKCreate("DKDom/DKDomEvent.js");
	return true;
}

// Properties
int DKDomEvent::bubbles(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::bubbles(): event invalid\n");
	}
	int phase = (int)event->GetPhase();
	if(phase == 4){
		duk_push_boolean(ctx, true);
		return true;
	}
	duk_push_boolean(ctx, false);
	return true;
}

int DKDomEvent::cancelBubble(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::cencelBubble(): event invalid\n");
	}
	bool flag = duk_require_boolean(ctx, 1);
	if(flag){
		event->StopPropagation();
		return true;
	}
	return true;
}

int DKDomEvent::cancelable(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::cancelable(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::composed(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::composed(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::currentTarget(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::currentTarget(): event invalid\n");
	}
	Rml::Element* currentElement = event->GetCurrentElement();
	DKString currentElementAddress = DKRml::elementToAddress(currentElement);
	if(currentElementAddress.empty()){
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::currentTarget(): currentElementAddress invalid\n");
	}
	duk_push_string(ctx, currentElementAddress.c_str());
	return true;
}

int DKDomEvent::deepPath(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::deepPath(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::defaultPrevented(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::defaultPrevented(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::eventPhase(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::eventPhase(): event invalid\n");
	}
	int phase = (int)event->GetPhase();
	duk_push_int(ctx, phase);
	return true;
}

int DKDomEvent::explicitOriginalTarget(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::explicitOriginalTarget(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::originalTarget(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::originalTarget(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::returnValue(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::returnValue(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::srcElement(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::srcElement(): event invalid\n");
	}
	Rml::Element* srcElement = event->GetCurrentElement();
	DKString srcElementAddress = DKRml::elementToAddress(srcElement);
	if (srcElementAddress.empty()){
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::srcElement(): srcElementAddress invalid\n");
	}
	duk_push_string(ctx, srcElementAddress.c_str());
	return true;
}

int DKDomEvent::target(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::target(): event invalid\n");
	}
	Rml::Element* targetElement = event->GetCurrentElement();
	DKString targetElementAddress = DKRml::elementToAddress(targetElement);
	if (targetElementAddress.empty()) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::target(): targetElementAddress invalid\n");
	}
	duk_push_string(ctx, targetElementAddress.c_str());
	return true;
}

int DKDomEvent::timeStamp(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::timeStamp(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::type(duk_context* ctx){
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::type(): event invalid\n");
	}
	DKString type = event->GetType();
	if(type.empty()){
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::type(): event type invalid\n");
	}
	if(same(type, "mouseup") && event->GetParameter<int>("button", 0) == 1){
		type = "contextmenu";
	}
	duk_push_string(ctx, type.c_str());
	return true && DKDEBUGRETURN(ctx, type);
}

int DKDomEvent::isTrusted(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::isTrusted(): event invalid\n");
	}
	//TODO
	return false;
}


// Obsolete properties
////////////////////////////////////////
int DKDomEvent::scoped(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::scoped(): event invalid\n");
	}
	//TODO
	return false;
}


// Methods
/////////////////////////////////////////////
int DKDomEvent::createEvent(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::createEvent(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::composedPath(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::composedPath(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::initEvent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::initEvent(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::preventDefault(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::preventDefault(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::stopImmediatePropagation(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::stopImmediatePropagation(): event invalid\n");
	}
	event->StopImmediatePropagation();
	return true;
}

int DKDomEvent::stopPropagation(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if(!event){
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::stopPropagation(): event invalid\n");
	}
	event->StopPropagation();
	return true;
}


// Obsolete methods
///////////////////////////////////////////////////
int DKDomEvent::getPreventDefault(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::getPreventDefault(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::preventBubble(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::preventBubble(): event invalid\n");
	}
	//TODO
	return false;
}

int DKDomEvent::preventCapture(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::preventCapture(): event invalid\n");
	}
	//TODO
	return false;
}


// Extra
///////////////////////////////////////////////
int DKDomEvent::getParameters(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString eventAddress = duk_require_string(ctx, 0);
	Rml::Event* event = DKRml::addressToEvent(eventAddress);
	if (!event) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomEvent::getParameters(): event invalid\n");
	}
	//List event parameters and values
	DKINFO("LISTING EVENT PARAMETERS\n");
	const auto& p = event->GetParameters();
	DKString output = "";
	for(auto& entry : p){
		output += entry.first + ": " + entry.second.Get<Rml::String>() + "\n";
	}
	DKINFO(output);
	duk_push_string(ctx, output.c_str());
	return true;
}