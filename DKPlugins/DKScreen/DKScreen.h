#pragma once
#ifndef DKScreen_H
#define DKScreen_H

#include "DK/DK.h"
#include "DKEventTarget/DKEventTarget.h"


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
	virtual bool availTop(unsigned int&, bool) { return false; }
	// [Screen.availLeft](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availLeft
	virtual bool availLeft(unsigned int&, bool) { return false; }
	// [Screen.availHeight] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availHeight
	virtual bool availHeight(unsigned int&, bool) { return false; }
	// [Screen.availWidth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availWidth
	virtual bool availWidth(unsigned int&, bool) { return false; }
	// [Screen.colorDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/colorDepth
	virtual bool colorDepth(unsigned int&, bool) { return false; }
	// [Screen.height] https://developer.mozilla.org/en-US/docs/Web/API/Screen/height
	virtual bool height(unsigned int&, bool) { return false; }
	// [Screen.left](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/left
	virtual bool left(unsigned int&, bool) { return false; }
	// [Screen.orientation] https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientation
	virtual bool left(DKString&, bool) { return false; }
	// [Screen.pixelDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/pixelDepth
	virtual bool pixelDepth(unsigned int&, bool) { return false; }
	// [Screen.top](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/top
	virtual bool top(unsigned int&, bool) { return false; }
	// [Screen.width] https://developer.mozilla.org/en-US/docs/Web/API/Screen/width
	virtual bool width(unsigned int&, bool) { return false; }
	// [Screen.mozEnabled](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozEnabled
	virtual bool mozEnabled(bool&, bool) { return false; }
	// [Screen.mozBrightness](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozBrightness
	virtual bool mozBrightness(unsigned int&, bool) { return false; }
	
	
	////// Instance methods //////
	// [Screen.lockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
	virtual bool lockOrientation(DKString& orientation) {
		DKDEBUGFUNC(orientation);
		return DKTODO();
	}
	// [Screen.unlockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
	virtual bool unlockOrientation() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	
	////// Events //////
	// [orientationchange](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientationchange_event

};


#endif //DKScreen_H