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
		DKDuktape::AttachFunction("CPP_DKScreenDUK_constructor", 	DKScreenDUK::constructor);
		
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
		
		DKINFO("CPP_DKScreenDUK_constructor()\n");
		DKScreen* _screen = new DKScreen();
		dukglue_push(ctx, _screen->interfaceAddress);
		return true;
	}
	
	// readonly attribute long availWidth;
	static int availWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _availWidth = GetInt(ctx);
		if(duk_is_valid_index(ctx, 1)){
			eventTarget(ctx)->availWidth(_availWidth);
		}
		else{
			_availWidth = eventTarget(ctx)->availWidth();
		}
		dukglue_push(ctx, _availWidth);
		return true;
	}

	// readonly attribute long availHeight;
	static int availHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _availHeight = GetInt(ctx);
		if(duk_is_valid_index(ctx, 1)){
			eventTarget(ctx)->availHeight(_availHeight);
		}
		else{
			_availHeight = eventTarget(ctx)->availHeight();
		}
		dukglue_push(ctx, _availHeight);
		return true;
	}
	
	// readonly attribute long width;
	static int width(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _width = GetInt(ctx);
		if(duk_is_valid_index(ctx, 1)){
			eventTarget(ctx)->width(_width);
		}
		else{
			_width = eventTarget(ctx)->width();
		}
		dukglue_push(ctx, _width);
		return true;
	}
	
	// readonly attribute long height;
	static int height(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _height = GetInt(ctx);
		if(duk_is_valid_index(ctx, 1)){
			eventTarget(ctx)->height(_height);
		}
		else{
			_height = eventTarget(ctx)->height();
		}
		dukglue_push(ctx, _height);
		return true;
	}
	
	// readonly attribute unsigned long colorDepth;
	static int colorDepth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _colorDepth = GetInt(ctx);
		if(duk_is_valid_index(ctx, 1)){
			eventTarget(ctx)->colorDepth(_colorDepth);
		}
		else{
			_colorDepth = eventTarget(ctx)->colorDepth();
		}
		dukglue_push(ctx, _colorDepth);
		return true;
	}
	
	// readonly attribute unsigned long pixelDepth;
	static int pixelDepth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _pixelDepth = GetInt(ctx);
		if(duk_is_valid_index(ctx, 1)){
			eventTarget(ctx)->pixelDepth(_pixelDepth);
		}
		else{
			_pixelDepth = eventTarget(ctx)->pixelDepth();
		}
		dukglue_push(ctx, _pixelDepth);
		return true;
	}
};
REGISTER_OBJECT(DKScreenDUK, true)


#endif //DKScreenDUK_H
#endif //HAVE_DKDuktape