// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
// [IDL] https://w3c.github.io/uievents/#idl-uievent


// [UIEvent()] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/UIEvent
var UIEvent = function UIEvent(_type, _options, _pointer) {
	
    ////// Instance properties //////
	// [UIEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail
    Object.defineProperty(this, "detail", {
        get: function detail() {
            return CPP_DKUIEvent_detail(_pointer);
        }
    })
	// [UIEvent.sourceCapabilities](Experimental)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/sourceCapabilities
    Object.defineProperty(this, "sourceCapabilities", {
        get: function sourceCapabilities () {
            return CPP_DKUIEvent_sourceCapabilities(_pointer);
        }
    })
	// [UIEvent.view](Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/view
	Object.defineProperty(this, "view", {
        get: function view() {
            return CPP_DKUIEvent_view(_pointer);
        }
    })
	// [UIEvent.which](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/which
	Object.defineProperty(this, "which", {
        get: function which() {
            return CPP_DKUIEvent_which(_pointer);
        }
    })

    ////// Methods //////
	// [UIEvent.initUIEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/initUIEvent
    UIEvent.prototype.initUIEvent = function initUIEvent() {
        CPP_DKUIEvent_initUIEvent(this._pointer);
    }

	//// toString ////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object UIEvent]"
		}
	}
	
    return Event.call(this, _type, _options, _pointer);
};
UIEvent.prototype = Event.prototype;


// Called from C++ to dispatch UIEvents events
/////////////////////////////////////////////////////
function dispatchUIEvent(_type, _options, _pointer) {
	const event = new UIEvent(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}