// [IDL] https://w3c.github.io/uievents/#idl-mouseevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
#pragma once
#ifndef DKMouseEvent_H
#define DKMouseEvent_H

#include "DKUIEvent/DKUIEvent.h"

////// MouseEventInit //////
typedef std::string MouseEventInit;


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface MouseEvent : UIEvent {
class DKMouseEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional MouseEventInit eventInitDict = {});
	DKMouseEvent(DOMString type, MouseEventInit eventInitDict) : DKUIEvent(type, eventInitDict) { // https://w3c.github.io/uievents/#dom-mouseevent-mouseevent
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "MouseEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKMouseEvent("+interfaceAddress+") \n");
	}
	virtual ~DKMouseEvent(){}
	
	// readonly attribute long screenX;
	int _screenX = 0; // https://w3c.github.io/uievents/#dom-mouseevent-screenx
	virtual int 			screenX()									{ return _screenX; }				// getter
	virtual void 			screenX(const int& screenX) 				{ _screenX = screenX; } 			// setter

	// readonly attribute long screenY;
	int _screenY = 0; // https://w3c.github.io/uievents/#dom-mouseevent-screeny
	virtual int 			screenY()									{ return _screenY; }				// getter
	virtual void 			screenY(const int& screenY) 				{ _screenY = screenY; } 			// setter
	
	// readonly attribute long clientX;
	int _clientX = 0; // https://w3c.github.io/uievents/#dom-mouseevent-clientx
	virtual int 			clientX()									{ return _clientX; }				// getter
	virtual void 			clientX(const int& clientX) 				{ _clientX = clientX; } 			// setter
	
	// readonly attribute long clientY;
	int _clientY = 0; // https://w3c.github.io/uievents/#dom-mouseevent-clienty
	virtual int 			clientY()									{ return _clientY; }				// getter
	virtual void 			clientY(const int& clientY) 				{ _clientY = clientY; } 			// setter

	// readonly attribute boolean ctrlKey;
	bool _ctrlKey = false; // https://w3c.github.io/uievents/#dom-mouseevent-ctrlkey
	virtual bool 			ctrlKey()									{ return _ctrlKey; }				// getter
	virtual void 			ctrlKey(const bool& ctrlKey) 				{ _ctrlKey = ctrlKey; } 			// setter
	
	// readonly attribute boolean shiftKey;
	bool _shiftKey = false; // https://w3c.github.io/uievents/#dom-mouseevent-shiftkey
	virtual bool 			shiftKey()									{ return _shiftKey; }				// getter
	virtual void 			shiftKey(const bool& shiftKey) 				{ _shiftKey = shiftKey; } 			// setter
	
	// readonly attribute boolean altKey;
	bool _altKey = false; // https://w3c.github.io/uievents/#dom-mouseevent-altkey
	virtual bool 			altKey()									{ return _altKey; }					// getter
	virtual void 			altKey(const bool& altKey) 					{ _altKey = altKey; } 				// setter
	
	// readonly attribute boolean metaKey;
	bool _metaKey = false; // https://w3c.github.io/uievents/#dom-mouseevent-metakey
	virtual bool 			metaKey()									{ return _metaKey; }				// getter
	virtual void 			metaKey(const bool& metaKey) 				{ _metaKey = metaKey; } 			// setter
	
	// readonly attribute short button;
	short _button = 0; // https://w3c.github.io/uievents/#dom-mouseevent-button
	virtual short 			button()									{ return _button; }					// getter
	virtual void 			button(const short& button) 				{ _button = button; } 				// setter
	
	// readonly attribute unsigned short buttons;
	unsigned short _buttons = 0; // https://w3c.github.io/uievents/#dom-mouseevent-buttons
	virtual unsigned short 	buttons()									{ return _buttons; }				// getter
	virtual void 			buttons(const unsigned short& buttons) 		{ _buttons = buttons; }				// setter
	
	// readonly attribute EventTarget? relatedTarget;
	DKString _relatedTarget = ""; // https://w3c.github.io/uievents/#dom-mouseevent-relatedtarget
	virtual DKString 		relatedTarget()								{ return _relatedTarget; }			// getter
	virtual void 			relatedTarget(const DKString& relatedTarget){ _relatedTarget = relatedTarget; } // setter
	
	// boolean getModifierState(DOMString keyArg);
	void getModifierState(DOMString& keyArg) { // https://w3c.github.io/uievents/#dom-mouseevent-getmodifierstate
		DKDEBUGFUNC(keyArg);
		DKTODO();
	}
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface MouseEvent {
	//  	readonly attribute double pageX;
			double _pageX = 0; // [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
			virtual double 		pageX()									{ return _pageX; }					// getter
			virtual void 		pageX(const double& pageX)				{ _pageX = pageX; } 				// setter
	//
	//  	readonly attribute double pageY;
			double _pageY = 0;  // [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
			virtual double 		pageY()									{ return _pageY; }					// getter
			virtual void 		pageY(const double& pageY)				{ _pageY = pageY; } 				// setter
	//
	//  	readonly attribute double x;
			double _x = 0; // [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
			virtual double 		x()										{ return _x; }						// getter
			virtual void 		x(const double& x)						{ _x = x; } 						// setter
	//
	//  	readonly attribute double y;
			double _y = 0;	// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
			virtual double 		y()										{ return _y; }						// getter
			virtual void 		y(const double& y)						{ _y = y; } 						// setter
	//
	//  	readonly attribute double offsetX; 
			double _offsetX = 0; // [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
			virtual double 		offsetX()								{ return _offsetX; }				// getter
			virtual void 		offsetX(const double& offsetX)			{ _offsetX = offsetX; } 			// setter
	//
	//  	readonly attribute double offsetY;
			double _offsetY = 0; // [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
			virtual double 		offsetY()								{ return _offsetY; }				// getter
			virtual void 		offsetY(const double& offsetY)			{ _offsetY = offsetY; } 			// setter
	// };
	
	// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
	// partial interface MouseEvent {
	//   	readonly attribute double movementX;
			double _movementX = 0; // [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
			virtual double 		movementX()								{ return _movementX; }				// getter
			virtual void 		movementX(const double& movementX)		{ _movementX = movementX; } 		// setter
	//
	//   	readonly attribute double movementY;
			double _movementY = 0; // [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
			virtual double 		movementY()								{ return _movementY; }				// getter
			virtual void 		movementY(const double& movementY)		{ _movementY = movementY; } 		// setter
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface MouseEvent {
	//		Deprecated in this specification
	//	  	undefined initMouseEvent(DOMString typeArg,
	//		optional boolean bubblesArg = false,
	//		optional boolean cancelableArg = false,
	//		optional Window? viewArg = null,
	//		optional long detailArg = 0,
	//		optional long screenXArg = 0,
	//		optional long screenYArg = 0,
	//		optional long clientXArg = 0,
	//		optional long clientYArg = 0,
	//		optional boolean ctrlKeyArg = false,
	//		optional boolean altKeyArg = false,
	//		optional boolean shiftKeyArg = false,
	//		optional boolean metaKeyArg = false,
	//		optional short buttonArg = 0,
	//		optional EventTarget? relatedTargetArg = null);
			void initMouseEvent(
				DOMString& typeArg, 
				bool& bubblesArg,
				bool& cancelableArg,
				DKString& viewArg,
				int& detailArg,
				int& screenXArg,
				int& screenYArg,
				int& clientXArg,
				int& clientYArg,
				bool& ctrlKeyArg,
				bool& altKeyArg,
				bool& shiftKeyArg,
				bool& metaKeyArg,
				short& buttonArg,
				DKString& relatedTargetArg) { // [MouseEvent.initMouseEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/initMouseEvent
					DKDEBUGFUNC(typeArg, bubblesArg, cancelableArg, viewArg, detailArg, screenXArg, screenYArg, clientXArg, clientYArg, ctrlKeyArg, altKeyArg, shiftKeyArg, metaKeyArg, buttonArg, relatedTargetArg);
					DKTODO();
			}
	// };
};


#endif //DKMouseEvent_H