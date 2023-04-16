#pragma once
#ifndef DKScreen_H
#define DKScreen_H

#include "DK/DK.h"


// [INTERFACE] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
class DKScreen : public DKEventTarget
{
public:
	DKScreen() : DKEventTarget() {
		DKDEBUGFUNC();
	}
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

};


#endif //DKScreen_H