#if HAVE_DKDuktape

#pragma once
#ifndef DKDocumentDUK_H
#define DKDocumentDUK_H

#include "DKDuktape/DKDuktape.h"


// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
class DKDocumentDUK : public DKObjectT<DKDocumentDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKDocumentDUK", DKDocumentDUK::constructor);		// [Document()] https://developer.mozilla.org/en-US/docs/Web/API/Document/Document

		
		////// Load .js files //////
		DKClass::DKCreate("DKDocument/DKDocumentDUK.js");
		
		return true;
	}
	
	static DKDocument* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKDocument*)addressToPointer(eventTargetAddress);
	}
	static bool GetBool(duk_context* ctx){
		if (duk_is_boolean(ctx, 1))
			return duk_to_boolean(ctx, 1);
		return false;
	}
	static double GetDouble(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_number(ctx, 1);
		return 0.0;
	}
	static int GetInt(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_int(ctx, 1);
		return 0;
	}
	static DKString GetString(duk_context* ctx){
		if (duk_is_string(ctx, 1))
			return duk_to_string(ctx, 1);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_uint(ctx, 1);
		return 0;
	}
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKDocumentDUK()\n");
		DKDocument* _document = new DKDocument();
		DKString eventTargetAddress = pointerToAddress(_document);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	// TODO
	
};
REGISTER_OBJECT(DKDocumentDUK, true)


#endif //DKDocumentDUK_H
#endif //HAVE_DKDuktape