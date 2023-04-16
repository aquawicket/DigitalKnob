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
		// [Screen.availTop](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availTop
		// [Screen.availLeft](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availLeft
		// [Screen.availHeight] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availHeight
		// [Screen.availWidth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availWidth
		// [Screen.colorDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/colorDepth
		// [Screen.height] https://developer.mozilla.org/en-US/docs/Web/API/Screen/height
		// [Screen.left](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/left
		// [Screen.orientation] https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientation
		// [Screen.pixelDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/pixelDepth
		// [Screen.top](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/top
		// [Screen.width] https://developer.mozilla.org/en-US/docs/Web/API/Screen/width
		// [Screen.mozEnabled](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozEnabled
		// [Screen.mozBrightness](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozBrightness
		
		
		////// Instance methods //////
		// [Screen.lockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
		// [Screen.unlockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
		
		
		////// Events //////
		// [orientationchange](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientationchange_event
		
		////// Load .js files
		DKClass::DKCreate("DKScreen/DKScreenDUK.js");
		
		return true;
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
	
};
REGISTER_OBJECT(DKScreenDUK, true)


#endif //DKScreenDUK_H
#endif //HAVE_DKDuktape