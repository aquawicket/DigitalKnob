// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

/////////////////////////////////////
var KeyboardEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "altKey", {
		get: function(){ 
			return DKDomKeyboardEvent_altKey(pointer);
		}
	});
	Object.defineProperty(this, "code", {
		get: function(){ 
			return DKDomKeyboardEvent_code(pointer);
		}
	});
	Object.defineProperty(this, "ctrlKey", {
		get: function(){ 
			return DKDomKeyboardEvent_ctrlKey(pointer);
		}
	});
	Object.defineProperty(this, "isComposing", {
		get: function(){ 
			return DKDomKeyboardEvent_isComposing(pointer);
		}
	});
	Object.defineProperty(this, "key", {
		get: function(){ 
			return DKDomKeyboardEvent_key(pointer);
		}
	});
	Object.defineProperty(this, "locale", {
		get: function(){ 
			return DKDomKeyboardEvent_locale(pointer);
		}
	});
	Object.defineProperty(this, "location", {
		get: function(){ 
			return DKDomKeyboardEvent_location(pointer);
		}
	});
	Object.defineProperty(this, "metaKey", {
		get: function(){ 
			return DKDomKeyboardEvent_metaKey(pointer);
		}
	});
	Object.defineProperty(this, "repeat", {
		get: function(){ 
			return DKDomKeyboardEvent_repeat(pointer);
		}
	});
	Object.defineProperty(this, "shiftKey", {
		get: function(){ 
			return DKDomKeyboardEvent_shiftKey(pointer);
		}
	});

	// Methods
	KeyboardEvent.prototype.getModifierState = function(){
		DKDomKeyboardEvent_getModifierState(pointer);
	};
	
	// Obsolete methods
	KeyboardEvent.prototype.initKeyEvent = function(){
		DKDomKeyboardEvent_initKeyEvent(pointer);
	};
	KeyboardEvent.prototype.initKeyboardEvent = function(){
		DKDomKeyboardEvent_initKeyboardEvent(pointer);
	};
	
	//Obsolete properties
	Object.defineProperty(this, "char", {
		get: function(){ 
			return DKDomKeyboardEvent_char(pointer);
		}
	});
	Object.defineProperty(this, "charCode", {
		get: function(){ 
			return DKDomKeyboardEvent_charCode(pointer);
		}
	});
	Object.defineProperty(this, "keyCode", {
		get: function(){ 
			return DKDomKeyboardEvent_keyCode(pointer);
		}
	});
	Object.defineProperty(this, "keyIdentifier", {
		get: function(){ 
			return DKDomKeyboardEvent_keyIdentifier(pointer);
		}
	});
	Object.defineProperty(this, "keyLocation", {
		get: function(){ 
			return DKDomKeyboardEvent_keyLocation(pointer);
		}
	});
	Object.defineProperty(this, "which", {
		get: function(){ 
			return DKDomKeyboardEvent_which(pointer);
		}
	});
	
	return UIEvent.call(this, pointer);
};
KeyboardEvent.prototype = UIEvent.prototype;