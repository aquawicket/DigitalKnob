var Tray = function Tray() {
	console.log("Tray()");
	
	var pointer = CPP_DKDomDocument_createElement("tray");
	this.pointer = pointer;
	
	CPP_DK_Create("DKTray,"+pointer);


	//// Instance properties ////
	Object.defineProperty(this, "myProperty", {
        get: function myProperty() {
            return CPP_DKDomTray_myProperty(pointer)
        }
    })


	//// Instance methods ////
	Tray.prototype.addItem = function addItem(str, idNum) {
		CPP_DKDomTray_addItem(str, idNum)
    }
	Tray.prototype.getIcon = function getIcon(str) {
		CPP_DKDomTray_getIcon()
    }
	Tray.prototype.setTooltip = function setTooltip(str) {
		CPP_DKDomTray_setTooltip(str)
    }
	Tray.prototype.setIcon = function setIcon(file) {
		CPP_DKDomTray_setIcon(file)
    }
	Tray.prototype.showBalloon = function showBalloon(file) {
		CPP_DKDomTray_showBalloon(file)
    }
	
	
	//// Events ////
	this.myevent_func = null;
    Object.defineProperty(this, "onmyevent", {
        get: function onmyevent() {
            return this.myevent_func;
        },
        set: function onmyevent(func) {
            func && this.addEventListener("myevent", func)
			!func && this.removeEventListener("myevent", this.myevent_func)
            this.myevent_func = func
        }
    });

	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Tray]" }
	
    return EventTarget.call(this, pointer)
}

// https://html.spec.whatwg.org/multipage/webappapis.html#eventhandler
Tray.prototype = EventTarget.prototype;
