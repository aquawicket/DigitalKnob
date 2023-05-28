// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLCollectionDUK_H
#define DKHTMLCollectionDUK_H

#include "DKInterface/DKInterface.h"

// [Exposed=Window, LegacyUnenumerableNamedProperties]
// interface HTMLCollection {
class DKHTMLCollectionDUK : public DKObjectT<DKHTMLCollectionDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKHTMLCollectionDUK", DKHTMLCollectionDUK::constructor);
		
		// readonly attribute unsigned long length;
		DKDuktape::AttachFunction("CPP_DKHTMLCollectionDUK_length", DKHTMLCollectionDUK::length);

		// getter Element? item(unsigned long index);
		//DKDuktape::AttachFunction("CPP_DKHTMLCollectionDUK_item", DKHTMLCollectionDUK::item);
	
		// getter Element? namedItem(DOMString name);
		//DKDuktape::AttachFunction("CPP_DKHTMLCollectionDUK_namedItem", DKHTMLCollectionDUK::namedItem);
		
	
		////// Load .js files
		DKClass::DKCreate("DKHTMLCollection/DKHTMLCollectionDUK.js");
		
		return true;
	}
	
	static DKHTMLCollection* htmlCollection(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKHTMLCollection*)addressToPointer(eventTargetAddress);
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

	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKHTMLCollectionDUK()\n");
		DKHTMLCollection* _htmlCollection = new DKHTMLCollection();
		DKString htmlCollectionAddress = pointerToAddress(_htmlCollection);
		duk_push_string(ctx, htmlCollectionAddress.c_str());
		return true;
	}
	
	// readonly attribute unsigned long length;
	static int length(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			htmlCollection(ctx)->length(GetUint(ctx));
		dukglue_push(ctx, htmlCollection(ctx)->length());
		return true;
	}
	
	// getter Element? item(unsigned long index);
	// TODO
	
	// getter Element? namedItem(DOMString name);
	// TODO
		
};
REGISTER_OBJECT(DKHTMLCollectionDUK, true)


#endif //DKHTMLCollectionDUK_H
#endif //HAVE_DKDuktape