// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

/////////////////////////////////////
var KeyboardEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "altKey", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_altKey(pointer);
		}
	});
	Object.defineProperty(this, "code", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_code(pointer);
		}
	});
	Object.defineProperty(this, "ctrlKey", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_ctrlKey(pointer);
		}
	});
	Object.defineProperty(this, "isComposing", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_isComposing(pointer);
		}
	});
	Object.defineProperty(this, "key", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_key(pointer);
		}
	});
	Object.defineProperty(this, "locale", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_locale(pointer);
		}
	});
	Object.defineProperty(this, "location", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_location(pointer);
		}
	});
	Object.defineProperty(this, "metaKey", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_metaKey(pointer);
		}
	});
	Object.defineProperty(this, "repeat", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_repeat(pointer);
		}
	});
	Object.defineProperty(this, "shiftKey", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_shiftKey(pointer);
		}
	});

	// Methods
	KeyboardEvent.prototype.getModifierState = function(){
		CPP_DKDomKeyboardEvent_getModifierState(pointer);
	};
	
	// Obsolete methods
	KeyboardEvent.prototype.initKeyEvent = function(){
		CPP_DKDomKeyboardEvent_init()KeyEvent(pointer);
	};
	KeyboardEvent.prototype.initKeyboardEvent = function(){
		CPP_DKDomKeyboardEvent_init()KeyboardEvent(pointer);
	};
	
	//Obsolete properties
	Object.defineProperty(this, "char", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_char(pointer);
		}
	});
	Object.defineProperty(this, "charCode", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_charCode(pointer);
		}
	});
	Object.defineProperty(this, "keyCode", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_keyCode(pointer);
		}
	});
	Object.defineProperty(this, "keyIdentifier", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_keyIdentifier(pointer);
		}
	});
	Object.defineProperty(this, "keyLocation", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_keyLocation(pointer);
		}
	});
	Object.defineProperty(this, "which", {
		get: function(){ 
			return CPP_DKDomKeyboardEvent_which(pointer);
		}
	});
	
	return UIEvent.call(this, pointer);
};
KeyboardEvent.prototype = UIEvent.prototype;