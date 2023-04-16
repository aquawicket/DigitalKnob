#if HAVE_DKDuktape

#pragma once
#ifndef DKScreenDUK_H
#define DKScreenDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [INTERFACE] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
class DKScreenDUK : public DKObjectT<DKScreenDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKScreenDUK", DKScreenDUK::constructor);
		
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKScreenDUK_availTop", 		DKScreenDUK::availTop);		// [Screen.availTop](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availTop
		DKDuktape::AttachFunction("CPP_DKScreenDUK_availLeft", 		DKScreenDUK::availLeft);	// [Screen.availLeft](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availLeft
		DKDuktape::AttachFunction("CPP_DKScreenDUK_availHeight", 	DKScreenDUK::availHeight);	// [Screen.availHeight] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availHeight
		DKDuktape::AttachFunction("CPP_DKScreenDUK_availWidth", 	DKScreenDUK::availWidth);	// [Screen.availWidth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availWidth
		DKDuktape::AttachFunction("CPP_DKScreenDUK_colorDepth", 	DKScreenDUK::colorDepth);	// [Screen.colorDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/colorDepth
		DKDuktape::AttachFunction("CPP_DKScreenDUK_height", 		DKScreenDUK::height);		// [Screen.height] https://developer.mozilla.org/en-US/docs/Web/API/Screen/height
		DKDuktape::AttachFunction("CPP_DKScreenDUK_left", 			DKScreenDUK::left);			// [Screen.left](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/left
		DKDuktape::AttachFunction("CPP_DKScreenDUK_orientation", 	DKScreenDUK::orientation);	// [Screen.orientation] https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientation
		DKDuktape::AttachFunction("CPP_DKScreenDUK_pixelDepth",		DKScreenDUK::pixelDepth);	// [Screen.pixelDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/pixelDepth
		DKDuktape::AttachFunction("CPP_DKScreenDUK_top", 			DKScreenDUK::top);			// [Screen.top](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/top
		DKDuktape::AttachFunction("CPP_DKScreenDUK_width", 			DKScreenDUK::width);		// [Screen.width] https://developer.mozilla.org/en-US/docs/Web/API/Screen/width
		DKDuktape::AttachFunction("CPP_DKScreenDUK_mozEnabled", 	DKScreenDUK::mozEnabled);	// [Screen.mozEnabled](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozEnabled
		DKDuktape::AttachFunction("CPP_DKScreenDUK_mozBrightness", 	DKScreenDUK::mozBrightness);// [Screen.mozBrightness](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozBrightness
		
		
		////// Instance methods //////
		// [Screen.lockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
		// [Screen.unlockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
		
		
		////// Events //////
		// [orientationchange](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientationchange_event
		
		////// Load .js files
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
	
	
	////// Constructor //////
	// [Screen()]
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKScreenDUK()\n");
		DKScreen* _screen = new DKScreen();
		DKString eventTargetAddress = pointerToAddress(_screen);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	////// Instance properties //////
	// [Screen.availTop](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availTop
	static int availTop(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _availTop = GetUint(ctx);
		if(!eventTarget(ctx)->availTop(_availTop, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _availTop);
		return true;
	}
	// [Screen.availLeft](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availLeft
	static int availLeft(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _availLeft = GetUint(ctx);
		if(!eventTarget(ctx)->availLeft(_availLeft, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _availLeft);
		return true;
	}
	// [Screen.availHeight] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availHeight
	static int availHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _availHeight = GetUint(ctx);
		if(!eventTarget(ctx)->availHeight(_availHeight, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _availHeight);
		return true;
	}
	// [Screen.availWidth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availWidth
	static int availWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _availWidth = GetUint(ctx);
		if(!eventTarget(ctx)->availWidth(_availWidth, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _availWidth);
		return true;
	}
	// [Screen.colorDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/colorDepth
	static int colorDepth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _colorDepth = GetUint(ctx);
		if(!eventTarget(ctx)->colorDepth(_colorDepth, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _colorDepth);
		return true;
	}
	// [Screen.height] https://developer.mozilla.org/en-US/docs/Web/API/Screen/height
	static int height(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _height = GetUint(ctx);
		if(!eventTarget(ctx)->height(_height, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _height);
		return true;
	}
	// [Screen.left](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/left
	static int left(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _left = GetUint(ctx);
		if(!eventTarget(ctx)->left(_left, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _left);
		return true;
	}
	// [Screen.orientation] https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientation
	static int orientation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _orientation = GetString(ctx);
		if(!eventTarget(ctx)->orientation(_orientation, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _orientation);
		return true;
	}
	// [Screen.pixelDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/pixelDepth
	static int pixelDepth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _pixelDepth = GetUint(ctx);
		if(!eventTarget(ctx)->pixelDepth(_pixelDepth, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _pixelDepth);
		return true;
	}
	// [Screen.top](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/top
	static int top(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _top = GetUint(ctx);
		if(!eventTarget(ctx)->top(_top, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _top);
		return true;
	}
	// [Screen.width] https://developer.mozilla.org/en-US/docs/Web/API/Screen/width
	static int width(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _width = GetUint(ctx);
		if(!eventTarget(ctx)->width(_width, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _width);
		return true;
	}
	// [Screen.mozEnabled](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozEnabled
	static int mozEnabled(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool _mozEnabled = GetBool(ctx);
		if(!eventTarget(ctx)->mozEnabled(_mozEnabled, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _mozEnabled);
		return true;
	}
	// [Screen.mozBrightness](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozBrightness
	static int mozBrightness(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _mozBrightness = GetUint(ctx);
		if(!eventTarget(ctx)->mozBrightness(_mozBrightness, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _mozBrightness);
		return true;
	}
	
};
REGISTER_OBJECT(DKScreenDUK, true)


#endif //DKScreenDUK_H
#endif //HAVE_DKDuktape