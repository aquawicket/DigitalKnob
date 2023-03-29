#pragma once
#ifndef DKEventJS_H
#define DKEventJS_H

#include "DKDuktape/DKDuktape.h"
#include "CPPEventsTest/DKEventTarget.h"


class DKEventJS : public DKObjectT<DKEventJS>
{
public:
	bool Init(){
		DKDuktape::AttachFunction("CPP_DKEvent_bubbles", DKEventJS::bubbles);
		DKDuktape::AttachFunction("CPP_DKEvent_cancelable", DKEventJS::cancelable);
		DKDuktape::AttachFunction("CPP_DKEvent_composed", DKEventJS::composed);
		DKDuktape::AttachFunction("CPP_DKEvent_currentTarget", DKEventJS::currentTarget);
		DKDuktape::AttachFunction("CPP_DKEvent_defaultPrevented", DKEventJS::defaultPrevented);
		DKDuktape::AttachFunction("CPP_DKEvent_eventPhase", DKEventJS::eventPhase);
		DKDuktape::AttachFunction("CPP_DKEvent_isTrusted", DKEventJS::isTrusted);
		DKDuktape::AttachFunction("CPP_DKEvent_target", DKEventJS::target);
		DKDuktape::AttachFunction("CPP_DKEvent_timeStamp", DKEventJS::timeStamp);
		DKDuktape::AttachFunction("CPP_DKEvent_type", DKEventJS::type);
		return true;
	}
	
	//template <typename EventType>
	static int bubbles(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString pointer = duk_require_string(ctx, 0);
		
		/*
		for (auto& eventObj : DKEventTarget::events<EventType>) {
			if (eventObj.pointer == pointer)
				DKINFO("match");
		}
		*/

		return DKTODO();
	}
	static int cancelable(duk_context* ctx){
		return DKTODO();
	}
	static int composed(duk_context* ctx){
		return DKTODO();
	}
	static int currentTarget(duk_context* ctx){
		return DKTODO();
	}
	static int defaultPrevented(duk_context* ctx){
		return DKTODO();
	}
	static int eventPhase(duk_context* ctx){
		return DKTODO();
	}
	static int isTrusted(duk_context* ctx){
		return DKTODO();
	}
	static int target(duk_context* ctx){
		return DKTODO();
	}
	static int timeStamp(duk_context* ctx){
		return DKTODO();
	}
	static int type(duk_context* ctx){
		return DKTODO();
	}
};
REGISTER_OBJECT(DKEventJS, true)


#endif //DKEventJS_H