// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
#if HAVE_DKDuktape

#pragma once
#ifndef DKNonElementParentNodeDUK_H
#define DKNonElementParentNodeDUK_H

#include "DKDuktape/DKDuktape.h"
#include "DKDocument/DKDocument.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKNonElementParentNodeDUK : public DKObjectT<DKNonElementParentNodeDUK>
{
public:
	bool Init(){
		
		// Element? getElementById(DOMString elementId);
		DKDuktape::AttachFunction("CPP_DKNonElementParentNodeDUK_getElementById", 	DKNonElementParentNodeDUK::getElementById);
		
		DKClass::DKCreate("DKNonElementParentNode/DKNonElementParentNodeDUK.js");
		
		return true;
	}
	
	static DKDocument* nonElementParentNode(duk_context* ctx){		
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString documentAddress = interface->address["Document"];
		DKDocument* _document = (DKDocument*)addressToPointer(documentAddress);
		return _document;
	}
	
	// Element? getElementById(DOMString elementId);
	static int getElementById(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DOMString elementId = duk_require_string(ctx, 1);
		DKINFO("DKNonElementParentNodeDUK::getElementById("+interfaceAddress+", "+elementId+")\n");
		
		dukglue_push(ctx, nonElementParentNode(ctx)->getElementById(elementId)->interfaceAddress);	
		return true;
	}
};
REGISTER_OBJECT(DKNonElementParentNodeDUK, true)

#endif //DKNonElementParentNodeDUK_H
#endif //HAVE_DKDuktape