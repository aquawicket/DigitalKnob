//https://developer.mozilla.org/en-US/docs/Web/API/EventTarget

#include "DK/DKApp.h"
#include "DKDuktape/DKEventTarget.h"


//////////////////////////
bool DKEventTarget::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKEventTarget_addEventListener", DKEventTarget::addEventListener);
	DKDuktape::AttachFunction("CPP_DKEventTarget_removeEventListener", DKEventTarget::removeEventListener);
	DKDuktape::AttachFunction("CPP_DKEventTarget_dispatchEvent", DKEventTarget::dispatchEvent);

	// non-standard
	DKDuktape::AttachFunction("CPP_DKEventTarget_id", DKEventTarget::id);
	DKDuktape::AttachFunction("CPP_DKEventTarget_idLike", DKEventTarget::idLike);
	DKDuktape::AttachFunction("CPP_DKEventTarget_type", DKEventTarget::type);
	DKDuktape::AttachFunction("CPP_DKEventTarget_value", DKEventTarget::value);

	DKClass::DKCreate("DKDuktape/DKEventTarget.js");
	return true;
}

///////////////////////////////////////////////
bool DKEventTarget::OnEvent(DKEvents* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	if (id.empty()) { return false; } //we need an id
	DKString type = event->GetType();
	if (type.empty()) { return false; } //we need a type
	DKString value = event->GetValue();
	DKString jsreturn = event->GetJSReturn();
	//replace(jsreturn, "() { [ecmascript code] }", ""); //remove () { [ecmascript code] }

	duk_context* ctx = DKDuktape::Get()->ctx;

	//FIXME: calling jsreturn only works if a function name is passed in.
	//Example:  document.onmousemove = function(e){} does not work since the function has no name
	//For this reason we currently let DKEvent.js dispatch the events it receives.
	//https://wiki.duktape.org/howtonativepersistentreferences
	/*
	if(jsreturn.empty() || same(jsreturn,"0") || same(jsreturn,"undefined")){
		DKERROR("DKEventTarget::OnEvent("+id+","+type+","+value+"): jsreturn invalid\n");
		//return false;
	}
	else{
		duk_require_stack(ctx, 1);
		duk_push_global_object(ctx);
		duk_get_prop_string(ctx, -1, jsreturn.c_str());
	}
	*/

	//DKString eventAddress = event->data[0];
	DKString eventAddress = DKDuktape::eventToAddress(event);

	//This is current evaluated javascript side at DKEvent.js: DispatchEvent(pointer)
	/*
	DKString newEvent;
	if(same(type, "mousemove") || same(type, "mousedown") || same(type, "mouseup") || same(type, "click") || same(type, "dblclick") || same(type, "contextmenu")){
		newEvent = "new MouseEvent(\"" + rmlEventAddress + "\")";
	}
	else if (same(type, "keydown") || same(type, "keyup") || same(type, "keypress"))
	{
		newEvent = "new KeyboardEvent(\"" + rmlEventAddress + "\")";
	}
	else{
		newEvent = "new Event(\"" + rmlEventAddress + "\")";
	}

	//create the event
	if(duk_peval_string(ctx, newEvent.c_str()) != 0){
		DKDuktape::DumpError(newEvent);
	}
	*/

	//dispatch the event
	DKString dispatchEvent = "DispatchEvent(\"" + eventAddress + "\")";
	if (duk_peval_string(ctx, dispatchEvent.c_str()) != 0) {
		DKDuktape::DumpError(dispatchEvent);
	}

	duk_pop(ctx);  // pop result/error
	return true;
}


////////////////////////////////////////////////////////
int DKEventTarget::addEventListener(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString jsreturn;
	if (duk_to_string(ctx, 2)) {
		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}
	if (!DKEvents::AddEvent(id, type, jsreturn, &DKEventTarget::OnEvent, DKEventTarget::Get())) { return false; }
	return true;
}

///////////////////////////////////////////////////////////
int DKEventTarget::removeEventListener(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString jsreturn;
	if (duk_to_string(ctx, 2)) {

		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}
	if (!DKEvents::RemoveEvent(id, type, jsreturn)) { return false; }
	return true;
}

/////////////////////////////////////////////////////
int DKEventTarget::dispatchEvent(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString jsreturn;
	if (duk_to_string(ctx, 2)) {
		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}
	if (!DKEvents::SendEvent(id, type, jsreturn)) { return false; }
	return true;
}


// non-standard
//////////////////////////////////////////
int DKEventTarget::id(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if (events.size() < 1) { return 0; }
	if (!same(events[0], id)) { return 0; }
	return 1;
}

//////////////////////////////////////////////
int DKEventTarget::idLike(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if (events.size() < 1) { return 0; }
	if (!has(events[0], id)) { return 0; }
	return 1;
}

////////////////////////////////////////////
int DKEventTarget::type(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if (events.size() < 2) { return 0; }
	if (!same(events[1], id)) { return 0; }
	return 1;
}

/////////////////////////////////////////////
int DKEventTarget::value(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString value = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if (events.size() < 3) { return 0; }
	if (!same(events[2], value)) { return 0; }
	return 1;
}