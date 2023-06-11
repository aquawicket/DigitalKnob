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
	DKMouseEvent(const DOMString& type, const MouseEventInit& eventInitDict = "{}") : DKUIEvent(type, eventInitDict) {
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "MouseEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKMouseEvent("+interfaceAddress+") \n");
	}
	virtual ~DKMouseEvent(){}
	
	// readonly attribute long screenX;
	int _screenX = 0;
	virtual const int& 				screenX()									{ return _screenX; }				// getter
	virtual void 					screenX(const int& screenX) 				{ _screenX = screenX; } 			// setter

	// readonly attribute long screenY;
	int _screenY = 0;
	virtual const int& 				screenY()									{ return _screenY; }				// getter
	virtual void 					screenY(const int& screenY) 				{ _screenY = screenY; } 			// setter
	
	// readonly attribute long clientX;
	int _clientX = 0;
	virtual const int& 				clientX()									{ return _clientX; }				// getter
	virtual void 					clientX(const int& clientX) 				{ _clientX = clientX; } 			// setter
	
	// readonly attribute long clientY;
	int _clientY = 0;
	virtual const int& 				clientY()									{ return _clientY; }				// getter
	virtual void 					clientY(const int& clientY) 				{ _clientY = clientY; } 			// setter

	// readonly attribute boolean ctrlKey;
	bool _ctrlKey = false;
	virtual const bool& 			ctrlKey()									{ return _ctrlKey; }				// getter
	virtual void 					ctrlKey(const bool& ctrlKey) 				{ _ctrlKey = ctrlKey; } 			// setter
	
	// readonly attribute boolean shiftKey;
	bool _shiftKey = false;
	virtual const bool& 			shiftKey()									{ return _shiftKey; }				// getter
	virtual void 					shiftKey(const bool& shiftKey) 				{ _shiftKey = shiftKey; } 			// setter
	
	// readonly attribute boolean altKey;
	bool _altKey = false;
	virtual const bool& 			altKey()									{ return _altKey; }					// getter
	virtual void 					altKey(const bool& altKey) 					{ _altKey = altKey; } 				// setter
	
	// readonly attribute boolean metaKey;
	bool _metaKey = false;
	virtual const bool& 			metaKey()									{ return _metaKey; }				// getter
	virtual void 					metaKey(const bool& metaKey) 				{ _metaKey = metaKey; } 			// setter
	
	// readonly attribute short button;
	short _button = 0;
	virtual const short& 			button()									{ return _button; }					// getter
	virtual void 					button(const short& button) 				{ _button = button; } 				// setter
	
	// readonly attribute unsigned short buttons;
	unsigned short _buttons = 0;
	virtual const unsigned short& 	buttons()									{ return _buttons; }				// getter
	virtual void 					buttons(const unsigned short& buttons) 		{ _buttons = buttons; }				// setter
	
	// readonly attribute EventTarget? relatedTarget;
	DKEventTarget* _relatedTarget = NULL;
	virtual DKEventTarget* 			relatedTarget()								{ return _relatedTarget; }			// getter
	virtual void 					relatedTarget(DKEventTarget* relatedTarget)	{ _relatedTarget = relatedTarget; } // setter
	
	// boolean getModifierState(DOMString keyArg);
	bool _getModifierState = false;
	virtual const bool& getModifierState(const DOMString& keyArg) {
		DKDEBUGFUNC(keyArg);
		DKTODO();
		return _getModifierState;
	}
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface MouseEvent {
	// readonly attribute double pageX;
	double _pageX = 0;
	virtual const double& 			pageX()									{ return _pageX; }					// getter
	virtual void 					pageX(const double& pageX)				{ _pageX = pageX; } 				// setter
	
	// readonly attribute double pageY;
	double _pageY = 0;
	virtual const double& 			pageY()									{ return _pageY; }					// getter
	virtual void 					pageY(const double& pageY)				{ _pageY = pageY; } 				// setter

	// readonly attribute double x;
	double _x = 0;
	virtual const double& 			x()										{ return _x; }						// getter
	virtual void 					x(const double& x)						{ _x = x; } 						// setter
	//
	// readonly attribute double y;
	double _y = 0;
	virtual const double&			y()										{ return _y; }						// getter
	virtual void 					y(const double& y)						{ _y = y; } 						// setter
	
	// readonly attribute double offsetX; 
	double _offsetX = 0;
	virtual const double&			offsetX()								{ return _offsetX; }				// getter
	virtual void 					offsetX(const double& offsetX)			{ _offsetX = offsetX; } 			// setter
	
	// readonly attribute double offsetY;
	double _offsetY = 0;
	virtual const double&			offsetY()								{ return _offsetY; }				// getter
	virtual void 					offsetY(const double& offsetY)			{ _offsetY = offsetY; } 			// setter
	// };
	
	// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
	// partial interface MouseEvent {
	// readonly attribute double movementX;
	double _movementX = 0;
	virtual const double&			movementX()								{ return _movementX; }				// getter
	virtual void 					movementX(const double& movementX)		{ _movementX = movementX; } 		// setter

	// readonly attribute double movementY;
	double _movementY = 0;
	virtual const double&			movementY()								{ return _movementY; }				// getter
	virtual void 					movementY(const double& movementY)		{ _movementY = movementY; } 		// setter
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface MouseEvent {
	// Deprecated in this speciofication
	// undefined initMouseEvent(DOMString typeArg,
	// optional boolean bubblesArg = false,
	// optional boolean cancelableArg = false,
	// optional Window? viewArg = null,
	// optional long detailArg = 0,
	// optional long screenXArg = 0,
	// optional long screenYArg = 0,
	// optional long clientXArg = 0,
	// optional long clientYArg = 0,
	// optional boolean ctrlKeyArg = false,
	// optional boolean altKeyArg = false,
	// optional boolean shiftKeyArg = false,
	// optional boolean metaKeyArg = false,
	// optional short buttonArg = 0,
	// optional EventTarget? relatedTargetArg = null);
	virtual void initMouseEvent(
		const DOMString& typeArg, 
		const bool& bubblesArg = false,
		const bool& cancelableArg = false,
		DKWindow* viewArg = NULL,
		const int& detailArg = 0,
		const int& screenXArg = 0,
		const int& screenYArg = 0,
		const int& clientXArg = 0,
		const int& clientYArg = 0,
		const bool& ctrlKeyArg = false,
		const bool& altKeyArg = false,
		const bool& shiftKeyArg = false,
		const bool& metaKeyArg = false,
		const short& buttonArg = 0,
		DKEventTarget* relatedTargetArg = NULL) {
			DKDEBUGFUNC(typeArg, bubblesArg, cancelableArg, viewArg, detailArg, screenXArg, screenYArg, clientXArg, clientYArg, ctrlKeyArg, altKeyArg, shiftKeyArg, metaKeyArg, buttonArg, relatedTargetArg);
			DKTODO();
		}
	// };
};


#endif //DKMouseEvent_H