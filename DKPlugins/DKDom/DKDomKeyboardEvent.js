// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

/////////////////////////////////////
var KeyboardEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "altKey", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_altKey(pointer);
		}
	});
	Object.defineProperty(this, "code", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_code(pointer);
		}
	});
	Object.defineProperty(this, "ctrlKey", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_ctrlKey(pointer);
		}
	});
	Object.defineProperty(this, "isComposing", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_isComposing(pointer);
		}
	});
	Object.defineProperty(this, "key", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_key(pointer);
		}
	});
	Object.defineProperty(this, "locale", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_locale(pointer);
		}
	});
	Object.defineProperty(this, "location", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_location(pointer);
		}
	});
	Object.defineProperty(this, "metaKey", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_metaKey(pointer);
		}
	});
	Object.defineProperty(this, "repeat", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_repeat(pointer);
		}
	});
	Object.defineProperty(this, "shiftKey", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_shiftKey(pointer);
		}
	});

	// Methods
	KeyboardEvent.prototype.getModifierState = function(){
		DKCPP_DKDomKeyboardEvent_getModifierState(pointer);
	};
	
	// Obsolete methods
	KeyboardEvent.prototype.initKeyEvent = function(){
		DKCPP_DKDomKeyboardEvent_initKeyEvent(pointer);
	};
	KeyboardEvent.prototype.initKeyboardEvent = function(){
		DKCPP_DKDomKeyboardEvent_initKeyboardEvent(pointer);
	};
	
	//Obsolete properties
	Object.defineProperty(this, "char", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_char(pointer);
		}
	});
	Object.defineProperty(this, "charCode", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_charCode(pointer);
		}
	});
	Object.defineProperty(this, "keyCode", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_keyCode(pointer);
		}
	});
	Object.defineProperty(this, "keyIdentifier", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_keyIdentifier(pointer);
		}
	});
	Object.defineProperty(this, "keyLocation", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_keyLocation(pointer);
		}
	});
	Object.defineProperty(this, "which", {
		get: function(){ 
			return DKCPP_DKDomKeyboardEvent_which(pointer);
		}
	});
	
	return UIEvent.call(this, pointer);
};
KeyboardEvent.prototype = UIEvent.prototype;