// [IDL] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
#pragma once
#ifndef DKScreen_H
#define DKScreen_H

#include "DK/DK.h"
#include "DKEventTarget/DKEventTarget.h"


class DKScreen : public DKEventTarget
{
public:
	DKScreen() : DKEventTarget() {
		DKDEBUGFUNC();
	}
	
	
	////// Instance properties //////
	// [Screen.availTop](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availTop
	virtual bool availTop(unsigned int& _availTop, bool set) {
		DKDEBUGFUNC(_availTop, set)
		if(set){
			return DKTODO();
		}
		else{
			return 0;
		}
		return false; 
	}
	// [Screen.availLeft](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availLeft
	virtual bool availLeft(unsigned int& _availLeft, bool set) { 
		DKDEBUGFUNC(_availLeft, set)
		if(set){
			return DKTODO();
		}
		else{
			return 0;
		}
		return false;
	}
	// [Screen.availHeight] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availHeight
	virtual bool availHeight(unsigned int& _availHeight, bool set) { 
		DKDEBUGFUNC(_availHeight, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	// [Screen.availWidth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availWidth
	virtual bool availWidth(unsigned int& _availWidth, bool set) { 
		DKDEBUGFUNC(_availWidth, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	// [Screen.colorDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/colorDepth
	virtual bool colorDepth(unsigned int& _colorDepth, bool set) {
		DKDEBUGFUNC(_colorDepth, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	// [Screen.height] https://developer.mozilla.org/en-US/docs/Web/API/Screen/height
	virtual bool height(unsigned int& _height, bool set) {
		DKDEBUGFUNC(_height, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKUtil::GetScreenHeight(_height);
		}
		return false; 
	}
	// [Screen.left](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/left
	virtual bool left(unsigned int& _left, bool set) {
		DKDEBUGFUNC(_left, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	// [Screen.orientation] https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientation
	virtual bool orientation(DKString& _orientation, bool set) {
		DKDEBUGFUNC(_orientation, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	// [Screen.pixelDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/pixelDepth
	virtual bool pixelDepth(unsigned int& _pixelDepth, bool set) { 
		DKDEBUGFUNC(_pixelDepth, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	// [Screen.top](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/top
	virtual bool top(unsigned int& _top, bool set) {
		DKDEBUGFUNC(_top, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	// [Screen.width] https://developer.mozilla.org/en-US/docs/Web/API/Screen/width
	virtual bool width(unsigned int& _width, bool set) {
		DKDEBUGFUNC(_width, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKUtil::GetScreenWidth(_width);
		}
		return false; 
	}
	// [Screen.mozEnabled](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozEnabled
	virtual bool mozEnabled(bool& _mozEnabled, bool set) {
		DKDEBUGFUNC(_mozEnabled, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	// [Screen.mozBrightness](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozBrightness
	virtual bool mozBrightness(unsigned int& _mozBrightness, bool set) { 
		DKDEBUGFUNC(_mozBrightness, set)
		if(set){
			return DKTODO();
		}
		else{
			return DKTODO();
		}
		return false;
	}
	
	
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