// [IDL] https://drafts.csswg.org/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
#if HAVE_DKDuktape

#pragma once
#ifndef DKScreenDUK_H
#define DKScreenDUK_H

#include "DKDuktape/DKDuktape.h"


// [Exposed=Window]
// interface Screen {
class DKScreenDUK : public DKObjectT<DKScreenDUK>
{
public:
	bool Init(){
		DKDuktape::AttachFunction("CPP_DKScreenDUK", 				DKScreenDUK::constructor);
		
		// readonly attribute long availWidth;
		DKDuktape::AttachFunction("CPP_DKScreenDUK_availWidth", 	DKScreenDUK::availWidth);	

		// readonly attribute long availHeight;
		DKDuktape::AttachFunction("CPP_DKScreenDUK_availHeight", 	DKScreenDUK::availHeight);
		
		// readonly attribute long width;
		DKDuktape::AttachFunction("CPP_DKScreenDUK_width", 			DKScreenDUK::width);
		
		// readonly attribute long height;
		DKDuktape::AttachFunction("CPP_DKScreenDUK_height", 		DKScreenDUK::height);
		
		// readonly attribute unsigned long colorDepth;
		DKDuktape::AttachFunction("CPP_DKScreenDUK_colorDepth", 	DKScreenDUK::colorDepth);
		
		// readonly attribute unsigned long pixelDepth;
		DKDuktape::AttachFunction("CPP_DKScreenDUK_pixelDepth", 	DKScreenDUK::pixelDepth);
		
		
		DKClass::DKCreate("DKScreen/DKScreenDUK.js");
		
		return true;
	}
	
	static DKScreen* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKScreen*)addressToPointer(eventTargetAddress);
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
		DKINFO("CPP_DKScreenDUK()\n");
		DKScreen* _screen = new DKScreen();
		DKString eventTargetAddress = pointerToAddress(_screen);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// readonly attribute long availWidth;
	static int availWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _availWidth = GetUint(ctx);
		if(!eventTarget(ctx)->availWidth(_availWidth, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _availWidth);
		return true;
	}

	// readonly attribute long availHeight;
	static int availHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _availHeight = GetUint(ctx);
		if(!eventTarget(ctx)->availHeight(_availHeight, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _availHeight);
		return true;
	}
		
	// readonly attribute long width;
	static int width(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _width = GetUint(ctx);
		if(!eventTarget(ctx)->width(_width, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _width);
		return true;
	}
		
	// readonly attribute long height;
	static int height(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _height = GetUint(ctx);
		if(!eventTarget(ctx)->height(_height, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _height);
		return true;
	}
		
	// readonly attribute unsigned long colorDepth;
	static int colorDepth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _colorDepth = GetUint(ctx);
		if(!eventTarget(ctx)->colorDepth(_colorDepth, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _colorDepth);
		return true;
	}
	
	// readonly attribute unsigned long pixelDepth;
	static int pixelDepth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _pixelDepth = GetUint(ctx);
		if(!eventTarget(ctx)->pixelDepth(_pixelDepth, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _pixelDepth);
		return true;
	}	
};
REGISTER_OBJECT(DKScreenDUK, true)


#endif //DKScreenDUK_H
#endif //HAVE_DKDuktape