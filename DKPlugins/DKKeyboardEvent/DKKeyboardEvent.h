// [IDL] https://w3c.github.io/uievents/#idl-keyboardevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
#pragma once
#ifndef DKKeyboardEvent_H
#define DKKeyboardEvent_H

#include "DKUIEvent/DKUIEvent.h"

////// KeyboardEventInit //////
typedef std::string KeyboardEventInit;


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface KeyboardEvent : UIEvent {
class DKKeyboardEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
	DKKeyboardEvent(const DOMString& type, const KeyboardEventInit& eventInitDict = "{}") : DKUIEvent(type, eventInitDict) {
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "KeyboardEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKKeyboardEvent("+interfaceAddress+") \n");
	}
	virtual ~DKKeyboardEvent(){}
	
	// KeyLocationCode
	
#if !EMSCRIPTEN	//FIXME
	// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
	const unsigned int _DOM_KEY_LOCATION_STANDARD = 0x00;
	virtual const unsigned int& 	DOM_KEY_LOCATION_STANDARD()												{ return _DOM_KEY_LOCATION_STANDARD; }						// getter
	//virtual void 					DOM_KEY_LOCATION_STANDARD(const unsigned int& DOM_KEY_LOCATION_STANDARD){ _DOM_KEY_LOCATION_STANDARD = DOM_KEY_LOCATION_STANDARD; } // setter
	
	// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
	const unsigned int _DOM_KEY_LOCATION_LEFT = 0x01;
	virtual const unsigned int& 	DOM_KEY_LOCATION_LEFT()													{ return _DOM_KEY_LOCATION_LEFT; }							// getter
	//virtual void 					DOM_KEY_LOCATION_LEFT(const unsigned int& DOM_KEY_LOCATION_LEFT)		{ _DOM_KEY_LOCATION_LEFT = DOM_KEY_LOCATION_LEFT; } 		// setter
	
	// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
	const unsigned int _DOM_KEY_LOCATION_RIGHT = 0x02;
	virtual const unsigned int& 	DOM_KEY_LOCATION_RIGHT()												{ return _DOM_KEY_LOCATION_RIGHT; }							// getter
	//virtual void 					DOM_KEY_LOCATION_RIGHT(const unsigned int& DOM_KEY_LOCATION_RIGHT)		{ _DOM_KEY_LOCATION_RIGHT = DOM_KEY_LOCATION_RIGHT; } 		// setter
	
	// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
	const unsigned int _DOM_KEY_LOCATION_NUMPAD = 0x03;
	virtual const unsigned int& 	DOM_KEY_LOCATION_NUMPAD()												{ return _DOM_KEY_LOCATION_NUMPAD; }						// getter
	//virtual void 					DOM_KEY_LOCATION_NUMPAD(const unsigned int& DOM_KEY_LOCATION_NUMPAD)	{ _DOM_KEY_LOCATION_NUMPAD = DOM_KEY_LOCATION_NUMPAD; } 	// setter
#endif
	
	// readonly attribute DOMString key;
	DOMString _key = "";
	virtual const DOMString& 		key()																	{ return _key; }											// getter
	virtual void 					key(const DOMString& key)												{ _key = key; } 											// setter
	
	// readonly attribute DOMString code;
	DOMString _code = "";
	virtual const DOMString& 		code()																	{ return _code; }											// getter
	virtual void 					code(const DOMString& code)												{ _code = code; } 											// setter
	
	// readonly attribute unsigned long location;
	unsigned int _location = 0;
	virtual const unsigned int& 	location()																{ return _location; }										// getter
	virtual void 					location(const unsigned int& location)									{ _location = location; } 									// setter
	
	// readonly attribute boolean ctrlKey;
	bool _ctrlKey = false;
	virtual const bool& 			ctrlKey()																{ return _ctrlKey; }										// getter
	virtual void 					ctrlKey(const bool& ctrlKey)											{ _ctrlKey = ctrlKey; } 									// setter
	
	// readonly attribute boolean shiftKey;
	bool _shiftKey = false;
	virtual const bool& 			shiftKey()																{ return _shiftKey; }										// getter
	virtual void 					shiftKey(const bool& shiftKey)											{ _shiftKey = shiftKey; } 									// setter
	
	// readonly attribute boolean altKey;
	bool _altKey = false;
	virtual const bool& 			altKey()																{ return _altKey; }											// getter
	virtual void 					altKey(const bool& altKey)												{ _altKey = altKey; } 										// setter
	
	// readonly attribute boolean metaKey;
	bool _metaKey = false;
	virtual const bool& 			metaKey()																{ return _metaKey; }										// getter
	virtual void 					metaKey(const bool& metaKey)											{ _metaKey = metaKey; } 									// setter
  
	// readonly attribute boolean repeat;
	bool _repeat = false;
	virtual const bool& 			repeat()																{ return _repeat; }											// getter
	virtual void 					repeat(const bool& repeat)												{ _repeat = repeat; } 										// setter
	
	// readonly attribute boolean isComposing;
	bool _isComposing = false;
	virtual const bool& 			isComposing()															{ return _isComposing; }									// getter
	virtual void 					isComposing(const bool& isComposing)									{ _isComposing = isComposing; } 							// setter
	
	// boolean getModifierState(DOMString keyArg);
	bool _getModifierState = false;
	virtual const bool& getModifierState(const DOMString& keyArg) {
		DKDEBUGFUNC(keyArg);
		DKTODO();
		return _getModifierState;
	}
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	// Originally introduced (and deprecated) in this specification
	// undefined initKeyboardEvent(DOMString typeArg,
	// optional boolean bubblesArg = false,
	// optional boolean cancelableArg = false,
	// optional Window? viewArg = null,
	// optional DOMString keyArg = "",
	// optional unsigned long locationArg = 0,
	// optional boolean ctrlKey = false,
	// optional boolean altKey = false,
	// optional boolean shiftKey = false,
	// optional boolean metaKey = false);
	virtual void initKeyboardEvent(
		const DOMString& typeArg,
		const bool& bubblesArg = false,
		const bool& cancelableArg = false,
		DKWinow* viewArg = NULL,
		const DOMString& keyArg = "",
		const unsigned int& locationArg = 0,
		const bool& ctrlKey = false,
		const bool& altKey = false,
		const bool& shiftKey = false,
		const bool& metaKey = false) {
			DKDEBUGFUNC(typeArg, bubblesArg, cancelableArg, viewArg, keyArg, locationArg, ctrlKey, altKey, shiftKey, metaKey);
			DKTODO();
		}
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	// The following support legacy user agents
	// readonly attribute unsigned long charCode;
	unsigned int _charCode = 0;
	virtual const unsigned int& 	charCode()															{ return _charCode; }										// getter
	virtual void 					charCode(const unsigned int& charCode)								{ _charCode = charCode; } 									// setter
	
	//		readonly attribute unsigned long keyCode;
	unsigned int _keyCode = 0;
	virtual const unsigned int& 	keyCode()															{ return _keyCode; }										// getter
	virtual void 					keyCode(const unsigned int& keyCode)								{ _keyCode = keyCode; } 									// setter
	// };
};


#endif //DKKeyboardEvent_H