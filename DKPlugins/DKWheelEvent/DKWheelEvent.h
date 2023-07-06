// [IDL] https://w3c.github.io/uievents/#idl-wheelevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
#pragma once
#ifndef DKWheelEvent_H
#define DKWheelEvent_H

#include "DKMouseEvent/DKMouseEvent.h"

////// WheelEventInit //////
typedef std::string WheelEventInit;


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface WheelEvent : MouseEvent {
class DKWheelEvent : public DKMouseEvent
{
public:
	// constructor(DOMString type, optional WheelEventInit eventInitDict = {});
	DKWheelEvent(const DOMString& type, const WheelEventInit& eventInitDict = "{}") : DKMouseEvent(type, eventInitDict) {
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "WheelEvent";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	
	// DeltaModeCode
	
#if !EMSCRIPTEN	//FIXME
	// const unsigned long DOM_DELTA_PIXEL = 0x00;
	const unsigned int _DOM_DELTA_PIXEL = 0x00;
	virtual const unsigned int& 	DOM_DELTA_PIXEL()									{ return _DOM_DELTA_PIXEL; }			// getter
	//virtual void 					DOM_DELTA_PIXEL(const unsigned int& DOM_DELTA_PIXEL){ _DOM_DELTA_PIXEL = DOM_DELTA_PIXEL; } // setter
	
	// const unsigned long DOM_DELTA_LINE  = 0x01;
	const unsigned int _DOM_DELTA_LINE  = 0x01;
	virtual const unsigned int& 	DOM_DELTA_LINE()									{ return _DOM_DELTA_LINE; }				// getter
	//virtual void 					DOM_DELTA_LINE(const unsigned int& DOM_DELTA_LINE) 	{ _DOM_DELTA_LINE = DOM_DELTA_LINE; } 	// setter
	
	// const unsigned long DOM_DELTA_PAGE  = 0x02;
	const unsigned int _DOM_DELTA_PAGE  = 0x02;
	virtual const unsigned int& 	DOM_DELTA_PAGE()									{ return _DOM_DELTA_PAGE; }				// getter
	//virtual void 					DOM_DELTA_PAGE(const unsigned int& DOM_DELTA_PAGE) 	{ _DOM_DELTA_PAGE = DOM_DELTA_PAGE; } 	// setter
#endif
	
	// readonly attribute double deltaX;
	double _deltaX = 0.0;
	virtual const double&			deltaX()											{ return _deltaX; }						// getter
	virtual void 					deltaX(const double& deltaX) 						{ _deltaX = deltaX; } 					// setter
	
	// readonly attribute double deltaY;
	double _deltaY = 0.0;
	virtual const double&			deltaY()											{ return _deltaY; }						// getter
	virtual void 					deltaY(const double& deltaY) 						{ _deltaY = deltaY; } 					// setter
	
	// readonly attribute double deltaZ;
	double _deltaZ = 0.0;
	virtual const double& 			deltaZ()											{ return _deltaZ; }						// getter
	virtual void 					deltaZ(const double& deltaZ) 						{ _deltaZ = deltaZ; } 					// setter
	
	// readonly attribute unsigned long deltaMode;
	unsigned int _deltaMode = 0;
	virtual const unsigned int&		deltaMode()											{ return _deltaMode; }					// getter
	virtual void 					deltaMode(const unsigned int& deltaMode) 			{ _deltaMode = deltaMode; } 			// setter
	
	
	////// toString //////
	operator std::string() const { return "[object WheelEvent]"; }
};


#endif //DKWheelEvent_H