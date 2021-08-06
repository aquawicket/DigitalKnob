//https://developer.mozilla.org/en-US/docs/Web/API/EventTarget

#include "DK/DKApp.h"
#include "DKDom/DKDomEventTarget.h"


//////////////////////////
bool DKDomEventTarget::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomEventTarget_addEventListener", DKDomEventTarget::addEventListener);
	DKDuktape::AttachFunction("CPP_DKDomEventTarget_removeEventListener", DKDomEventTarget::removeEventListener);
	DKDuktape::AttachFunction("CPP_DKDomEventTarget_dispatchEvent", DKDomEventTarget::dispatchEvent);

	// non-standard
	DKDuktape::AttachFunction("CPP_DKDomEventTarget_id", DKDomEventTarget::id);
	DKDuktape::AttachFunction("CPP_DKDomEventTarget_idLike", DKDomEventTarget::idLike);
	DKDuktape::AttachFunction("CPP_DKDomEventTarget_type", DKDomEventTarget::type);
	DKDuktape::AttachFunction("CPP_DKDomEventTarget_value", DKDomEventTarget::value);
	
	DKClass::DKCreate("DKDom/DKDomEventTarget.js");
	return true;
}

///////////////////////////////////////////////
bool DKDomEventTarget::OnEvent(DKEvents* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	if(id.empty()){ return false; } //we need an id
	DKString type = event->GetType();
	if(type.empty()){ return false; } //we need a type
	DKString value = event->GetValue();
	DKString jsreturn = event->GetJSReturn();
	//replace(jsreturn, "() { [ecmascript code] }", ""); //remove () { [ecmascript code] }

	duk_context* ctx = DKDuktape::Get()->ctx;

	//FIXME: calling jsreturn only works if a function name is passed in.
	//Example:  document.onmousemove = function(e){} does not work since the function has no name
	//For this reason we currently let DKDomEvent.js dispatch the events it receives.
	//https://wiki.duktape.org/howtonativepersistentreferences
	/*
	if(jsreturn.empty() || same(jsreturn,"0") || same(jsreturn,"undefined")){
		DKERROR("DKDomEventTarget::OnEvent("+id+","+type+","+value+"): jsreturn invalid\n");
		//return false;
	}
	else{
		duk_require_stack(ctx, 1);
		duk_push_global_object(ctx);
		duk_get_prop_string(ctx, -1, jsreturn.c_str());
	}
	*/

	DKString rmlEventAddress = event->data[0];
	
	//This is current evaluated javascript side at DKDomEvent.js: DispatchEvent(pointer)
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
	DKString dispatchEvent = "DispatchEvent(\""+rmlEventAddress+"\")";
	if(duk_peval_string(ctx, dispatchEvent.c_str()) != 0){
		DKDuktape::DumpError(dispatchEvent);
	}

	duk_pop(ctx);  // pop result/error
	return true;
}


////////////////////////////////////////////////////////
int DKDomEventTarget::addEventListener(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString jsreturn;
	if(duk_to_string(ctx, 2)){
		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}
	if(!DKEvents::AddEvent(id, type, jsreturn, &DKDomEventTarget::OnEvent, DKDomEventTarget::Get())){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
int DKDomEventTarget::removeEventListener(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString jsreturn;
	if(duk_to_string(ctx, 2)){
	
		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}
	if(!DKEvents::RemoveEvent(id, type, jsreturn)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
int DKDomEventTarget::dispatchEvent(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString jsreturn;
	if(duk_to_string(ctx, 2)){
		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}
	if (!DKEvents::SendEvent(id, type, jsreturn)) { return false; }
	return true;
}


// non-standard
//////////////////////////////////////////
int DKDomEventTarget::id(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if(events.size() < 1){ return 0; }
	if(!same(events[0],id)){ return 0; }
	return 1;
}

//////////////////////////////////////////////
int DKDomEventTarget::idLike(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if(events.size() < 1){ return 0; }
	if(!has(events[0],id)){ return 0; }
	return 1;
}

////////////////////////////////////////////
int DKDomEventTarget::type(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if(events.size() < 2){ return 0; }
	if(!same(events[1],id)){ return 0; }
	return 1;
}

/////////////////////////////////////////////
int DKDomEventTarget::value(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString value = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if(events.size() < 3){ return 0; }
	if(!same(events[2],value)){ return 0; }
	return 1;
}