// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/UIEvent.idl
// [SOURCE] https://w3c.github.io/uievents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface UIEvent : Event {
//constructor(DOMString type, optional UIEventInit eventInitDict = {});
var UIEvent = function UIEvent(type, eventInitDict, address) {
	console.log("UIEvent("+type+","+eventInitDict+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKUIEventDUK_constructor(type, eventInitDict);
	
	// readonly attribute Window? view;
	Object.defineProperty(this, "view", {
        get: function view() 		{ return new Window(CPP_DKUIEventDUK_view(this.address)) },
		set: function view(data)	{ return CPP_DKUIEventDUK_view(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute long detail;
	Object.defineProperty(this, "detail", {
        get: function detail() 		{ return CPP_DKUIEventDUK_detail(this.address) },
		set: function detail(data)	{ return CPP_DKUIEventDUK_detail(this.address, data) },
		configurable: true,
    })
	
	// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
	// partial interface UIEvent {
	// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
			Object.defineProperty(this, "sourceCapabilities", {
				get: function sourceCapabilities()		{ return CPP_DKUIEventDUK_sourceCapabilities(this.address) },
				set: function sourceCapabilities(data)	{ return CPP_DKUIEventDUK_sourceCapabilities(this.address, data) },
				configurable: true,
			})
	// };
		
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	// 		Deprecated in this specification
	//		undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
			UIEvent.prototype.initUIEvent = function initUIEvent(typeArg, bubblesArg, cancelableArg, viewArg, detailArg) {
				CPP_DKUIEventDUK_initUIEvent(this.address, typeArg, bubblesArg, cancelableArg, viewArg, detailArg);
			}
	//	};
		
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	//		The following support legacy user agents
	//		readonly attribute unsigned long which;
			Object.defineProperty(this, "which", {
				get: function which()	 { return CPP_DKUIEventDUK_which(this.address) },
				//set: function which(data){ return CPP_DKUIEventDUK_which(this.address, data) },
				//configurable: true,
			})
	// };	
		

	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object UIEvent]" }
	
	
	var event = Event.call(this, type, eventInitDict);
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "detail", 				{ set: undefined });
	Object.defineProperty(this, "sourceCapabilities", 	{ set: undefined });
	Object.defineProperty(this, "view", 				{ set: undefined });
	
	return event;
};
UIEvent.prototype = Event.prototype;
