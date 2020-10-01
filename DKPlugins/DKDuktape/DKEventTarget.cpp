#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKEventTarget.h"


//////////////////////////
bool DKEventTarget::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKEventTarget_addEventListener", DKEventTarget::addEventListener);
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKEventTarget_removeEventListener", DKEventTarget::removeEventListener);

	// non-standard
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKEventTarget_id", DKEventTarget::id);
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKEventTarget_idLike", DKEventTarget::idLike);
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKEventTarget_type", DKEventTarget::type);
	DKDuktape::AttachFunction("DKCPP_DKDuktape_DKEventTarget_value", DKEventTarget::value);
	
	DKClass::DKCreate("DKDuktape/DKEventTarget.js");
	return true;
}

////////////////////////////////////////////
bool DKEventTarget::OnEvent(DKEvents* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	if(id.empty()){ return false; } //we need an id
	DKString type = event->GetType();
	if(type.empty()){ return false; } //we need a type
	DKString value = event->GetValue();
	DKString jsreturn = event->GetJSReturn();
	//replace(jsreturn, "() { [ecmascript code] }", ""); //remove () { [ecmascript code] }
	if(jsreturn.empty() || same(jsreturn,"0") || same(jsreturn,"undefined")){
		DKERROR("DKEventTarget::OnEvent(): jsreturn invalid\n");
		return false;
	}

	duk_context* ctx = DKDuktape::Get()->ctx;
	duk_require_stack(ctx, 1);
	duk_push_global_object(ctx);
	duk_get_prop_string(ctx, -1, jsreturn.c_str());

	DKString rmlEventAddress = event->data[0];
	DKString newEvent;
	if(same(type, "mousedown") || same(type, "mouseup") || same(type, "click") || same(type, "dblclick")){
		newEvent = "new MouseEvent(\"" + rmlEventAddress + "\")";
	}
	else{
		newEvent = "new Event(\"" + rmlEventAddress + "\")";
	}
	DKINFO("DKEventTarget::OnEvent(): "+newEvent+"\n");
	duk_eval_string(ctx, newEvent.c_str());
	
	if(duk_pcall(ctx, 1) != 0){
		duk_get_prop_string(ctx, -1, "name");  // push `err.name`
		DKString name = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.name`
		duk_get_prop_string(ctx, -1, "message");  // push `err.message`
		DKString message = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.message`
		message = name +": "+message;
		duk_get_prop_string(ctx, -1, "fileName");  // push `err.fileName`
		DKString fileName = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.fileName`
		duk_get_prop_string(ctx, -1, "lineNumber");  // push `err.lineNumber`
		DKString lineNumber = toString(duk_get_int(ctx, -1));
		duk_pop(ctx);  // pop `err.lineNumber`
		duk_get_prop_string(ctx, -1, "stack");  // push `err.stack`
		DKString stack = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.stack`

		DKERROR(message+"\n");

		replace(stack,"'","\\'");
		replace(stack,"\n","\\n");
		replace(message,"'","\\'");

		DKString str;
		str += "var err_error = {stack:'"+stack+"'};";
		str += "var err_event = {type:'error', message:'"+message+"', filename:'"+fileName+"', lineno:'"+lineNumber+"', colno:'0', error:err_error};";
		str += "EventFromCPP('window', err_event);";
		duk_eval_string(ctx, str.c_str());
	}
	else{
		//DKINFO(DKString(duk_safe_to_string(ctx, -1))+"\n"); //return value?
	}
	duk_pop(ctx);  // pop result/error

	return true;
}


/////////////////////////////////////////////////////
int DKEventTarget::addEventListener(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString jsreturn;
	if(duk_to_string(ctx, 2)){
		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}
	if(!DKEvents::AddEvent(id, type, jsreturn, &DKEventTarget::OnEvent, DKEventTarget::Get())){ return false; }
	return true;
}

////////////////////////////////////////////////////////
int DKEventTarget::removeEventListener(duk_context* ctx)
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


// non-standard
////////////////////////////////////////
int DKEventTarget::id(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if(events.size() < 1){ return 0; }
	if(!same(events[0],id)){ return 0; }
	return 1;
}

///////////////////////////////////////////
int DKEventTarget::idLike(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if(events.size() < 1){ return 0; }
	if(!has(events[0],id)){ return 0; }
	return 1;
}

/////////////////////////////////////////
int DKEventTarget::type(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if(events.size() < 2){ return 0; }
	if(!same(events[1],id)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKEventTarget::value(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString value = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");

	if(events.size() < 3){ return 0; }
	if(!same(events[2],value)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape