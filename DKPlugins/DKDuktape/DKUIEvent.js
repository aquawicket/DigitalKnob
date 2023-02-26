// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

var UIEvent = function UIEvent(_type, _options) 
{	
	this._type = _type;
	this._options = _options;
	const pointer = "";
	
    // Properties
    /*
	Object.defineProperty(this, "cancelBubble", { //Not standardized, Deprecated
		get: function cancelBubble(){ 
			return CPP_DKUIEvent_cancelBubble(pointer);
		}
		set: function cancelBubble(flag){ 
			return CPP_DKUIEvent_cancelBubble(pointer, flag);
		}
	});
	*/
    Object.defineProperty(this, "detail", {
        //Read only
        get: function detail() {
            return CPP_DKUIEvent_detail(pointer);
        }
    });
    Object.defineProperty(this, "isChar", {
        //Read only
        get: function isChar() {
            return CPP_DKUIEvent_isChar(pointer);
        }
    });
    Object.defineProperty(this, "layerX", {
        //Read only
        get: function layerX() {
            return CPP_DKUIEvent_layerX(pointer);
        }
    });
    Object.defineProperty(this, "layerY", {
        //Read only
        get: function layerY() {
            return CPP_DKUIEvent_layerY(pointer);
        }
    });
    /*
	Object.defineProperty(this, "pageX", { //Read only
		get: function pageX(){ 
			return CPP_DKUIEvent_pageX(pointer);
		}
	});
	Object.defineProperty(this, "pageY", { //Read only
		get: function pageY(){ 
			return CPP_DKUIEvent_pageY(pointer);
		}
	});
	*/
    Object.defineProperty(this, "sourceCapabilities", {
        //Read only
        get: function sourceCapabilities() {
            return CPP_DKUIEvent_sourceCapabilities(pointer);
        }
    });
    Object.defineProperty(this, "view", {
        //Read only
        get: function view() {
            return CPP_DKUIEvent_view(pointer);
        }
    });
    /*
	Object.defineProperty(this, "which", { //Read only
		get: function which(){ 
			return CPP_DKUIEvent_which(pointer);
		}
	});
	*/

    // Methods
    UIEvent.prototype.initUIEvent = function initUIEvent() {
        //Deprecated
        CPP_DKUIEvent_initUIEvent(this.pointer);
    }
    ;


	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object UIEvent]"
		}
	}
	
    return Event.call(this, _type, _options);
};
UIEvent.prototype = Event.prototype;
