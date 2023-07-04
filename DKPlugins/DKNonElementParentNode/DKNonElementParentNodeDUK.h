// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
#if HAVE_DKDuktape

#pragma once
#ifndef DKNonElementParentNodeDUK_H
#define DKNonElementParentNodeDUK_H

#include "DKDuktape/DKDuktape.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKNonElementParentNodeDUK : public DKObjectT<DKNonElementParentNodeDUK>
{
public:
	bool Init(){
		DKDuktape::AttachFunction("CPP_DKNonElementParentNodeDUK_constructor", 		DKNonElementParentNodeDUK::constructor);
		
		// Element? getElementById(DOMString elementId);
		DKDuktape::AttachFunction("CPP_DKNonElementParentNodeDUK_getElementById", 	DKNonElementParentNodeDUK::getElementById);
		
		
		DKClass::DKCreate("DKNonElementParentNode/DKNonElementParentNodeDUK.js");
		
		return true;
	}
	
	static DKNonElementParentNode* nonElementParentNode(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString nonElementParentNodeAddress = interface->address["NonElementParentNode"];
		if(nonElementParentNodeAddress.empty())
			DKERROR("nonElementParentNodeAddress.empty()! \n");
		DKNonElementParentNode* _nonElementParentNode = (DKNonElementParentNode*)addressToPointer(nonElementParentNodeAddress);
		return _nonElementParentNode;
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
		
		DKINFO("CPP_DKNonElementParentNodeDUK_constructor()\n");
		DKNonElementParentNode* _nonElementParentNode = new DKNonElementParentNode();
		dukglue_push(ctx, _nonElementParentNode->interfaceAddress);
		return true;
	}
	
	// Element? getElementById(DOMString elementId);
	static int getElementById(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString elementId = GetString(ctx, 1);
		
		dukglue_push(ctx, nonElementParentNode(ctx)->getElementById(elementId)->interfaceAddress);	
		return true;
	}
};
REGISTER_OBJECT(DKNonElementParentNodeDUK, true)

#endif //DKNonElementParentNodeDUK_H
#endif //HAVE_DKDuktape