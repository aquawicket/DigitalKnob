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
	DKKeyboardEvent(DOMString _type, KeyboardEventInit _eventInitDict) : DKUIEvent(_type, _eventInitDict) {
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "KeyboardEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKKeyboardEvent("+interfaceAddress+") \n");
	}
	virtual ~DKKeyboardEvent(){}
	
	// KeyLocationCode
	
#if !EMSCRIPTEN	//FIXME
	// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
	const unsigned int DOM_KEY_LOCATION_STANDARD = 0x00;
	
	// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
	const unsigned int DOM_KEY_LOCATION_LEFT = 0x01;
	
	// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
	const unsigned int DOM_KEY_LOCATION_RIGHT = 0x02;
	
	// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
	const unsigned int DOM_KEY_LOCATION_NUMPAD = 0x03;
#endif
	
	// readonly attribute DOMString key;
	DOMString key = "";
	
	// readonly attribute DOMString code;
	DOMString code = "";
	
	// readonly attribute unsigned long location;
	unsigned int location = 0;
	
	// readonly attribute boolean ctrlKey;
	bool ctrlKey = false;
	
	// readonly attribute boolean shiftKey;
	bool shiftKey = false;
	
	// readonly attribute boolean altKey;
	bool altKey = false;
	
	// readonly attribute boolean metaKey;
	bool metaKey = false;
  
	// readonly attribute boolean repeat;
	bool repeat = false;
	
	// readonly attribute boolean isComposing;
	bool isComposing = false;
	
	// boolean getModifierState(DOMString keyArg);
	void getModifierState(DOMString& _keyArg) {
		DKDEBUGFUNC(_keyArg);
		DKTODO();
	}
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// Originally introduced (and deprecated) in this specification
	//		undefined initKeyboardEvent(DOMString typeArg,
	// 		optional boolean bubblesArg = false,
	// 		optional boolean cancelableArg = false,
	//		optional Window? viewArg = null,
	//		optional DOMString keyArg = "",
	//		optional unsigned long locationArg = 0,
	//		optional boolean ctrlKey = false,
	//		optional boolean altKey = false,
	//		optional boolean shiftKey = false,
	//		optional boolean metaKey = false);
			void initKeyboardEvent(
				DOMString& _typeArg,
				bool& _bubblesArg,
				bool& _cancelableArg,
				DKString& _viewArg,
				DOMString& _keyArg,
				unsigned int& _locationArg,
				bool& _ctrlKey,
				bool& _altKey,
				bool& _shiftKey,
				bool& _metaKey
			) {
				DKDEBUGFUNC(_typeArg, _bubblesArg, _cancelableArg, _viewArg, _keyArg, _locationArg, _ctrlKey, _altKey, _shiftKey, _metaKey);
				DKTODO();
			}
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// The following support legacy user agents
	//		readonly attribute unsigned long charCode;
			unsigned int charCode = 0;
	//
	//		readonly attribute unsigned long keyCode;
			unsigned int keyCode = 0;
	// };
};


#endif //DKKeyboardEvent_H