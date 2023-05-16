// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
#if HAVE_DKDuktape

#pragma once
#ifndef DKElementDUK_H
#define DKElementDUK_H

#include "DKDuktape/DKDuktape.h"


// [Exposed=Window]
// interface Element : Node {
class DKElementDUK : public DKObjectT<DKElementDUK>
{
public:
	bool Init(){
		DKDuktape::AttachFunction("CPP_DKElementDUK", DKElementDUK::constructor);
		
		// readonly attribute DOMString? namespaceURI;
		DKDuktape::AttachFunction("CPP_DKElementDUK_namespaceURI", DKElementDUK::namespaceURI);
		
		// TODO
		
		////// Load .js files //////
		DKClass::DKCreate("DKElement/DKElementDUK.js");
		
		return true;
	}
	
	static DKElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKElement*)addressToPointer(eventTargetAddress);
	}
	static bool GetBool(duk_context* ctx, int index = 1){
		if (duk_is_boolean(ctx, index))
			return duk_to_boolean(ctx, index);
		return false;
	}
	static double GetDouble(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_number(ctx, index);
		return 0.0;
	}
	static int GetInt(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_int(ctx, index);
		return 0;
	}
	static DKString GetString(duk_context* ctx, int index = 1){
		if (duk_is_string(ctx, index))
			return duk_to_string(ctx, index);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_uint(ctx, index);
		return 0;
	}

	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKElementDUK()\n");
		DKElement* _element = new DKElement();
		DKString eventTargetAddress = pointerToAddress(_element);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// readonly attribute DOMString? namespaceURI;
	static int namespaceURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString _namespaceURI = GetString(ctx);
		if(!eventTarget(ctx)->namespaceURI(_namespaceURI, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _namespaceURI);
		return true;
	}
	
	// TODO
};
REGISTER_OBJECT(DKElementDUK, true)


#endif //DKElementDUK_H
#endif //HAVE_DKDuktape