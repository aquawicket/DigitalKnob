// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

<<<<<<< HEAD:DKPlugins/DKDuktape/DKUIEvent.js
var UIEvent = function UIEvent(pointer) {
=======
var UIEvent = function UIEvent(pointer){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKUIEvent.js
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
<<<<<<< HEAD:DKPlugins/DKDuktape/DKUIEvent.js
        get: function detail() {
=======
        get: function detail(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKUIEvent.js
            return CPP_DKUIEvent_detail(pointer);
        }
    });
    Object.defineProperty(this, "isChar", {
        //Read only
<<<<<<< HEAD:DKPlugins/DKDuktape/DKUIEvent.js
        get: function isChar() {
=======
        get: function isChar(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKUIEvent.js
            return CPP_DKUIEvent_isChar(pointer);
        }
    });
    Object.defineProperty(this, "layerX", {
        //Read only
<<<<<<< HEAD:DKPlugins/DKDuktape/DKUIEvent.js
        get: function layerX() {
=======
        get: function layerX(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKUIEvent.js
            return CPP_DKUIEvent_layerX(pointer);
        }
    });
    Object.defineProperty(this, "layerY", {
        //Read only
<<<<<<< HEAD:DKPlugins/DKDuktape/DKUIEvent.js
        get: function layerY() {
=======
        get: function layerY(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKUIEvent.js
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
<<<<<<< HEAD:DKPlugins/DKDuktape/DKUIEvent.js
        get: function sourceCapabilities() {
=======
        get: function sourceCapabilities(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKUIEvent.js
            return CPP_DKUIEvent_sourceCapabilities(pointer);
        }
    });
    Object.defineProperty(this, "view", {
        //Read only
<<<<<<< HEAD:DKPlugins/DKDuktape/DKUIEvent.js
        get: function view() {
=======
        get: function view(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKUIEvent.js
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
<<<<<<< HEAD:DKPlugins/DKDuktape/DKUIEvent.js
    UIEvent.prototype.initUIEvent = function initUIEvent() {
=======
    UIEvent.prototype.initUIEvent = function initUIEvent(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKUIEvent.js
        //Deprecated
        CPP_DKUIEvent_initUIEvent(this.pointer);
    }
    ;

    return Event.call(this, pointer);
};
UIEvent.prototype = Event.prototype;
