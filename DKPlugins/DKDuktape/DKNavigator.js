// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Navigator
// [OBJECT] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object


var Navigator = function Navigator(pointer) {
    
	////// Standard properties //////
	// [Navigator.connection](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/connection
	Object.defineProperty(this, "connection", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.cookieEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/cookieEnabled
	Object.defineProperty(this, "cookieEnabled", {
        configurable: true,
        value: "false",
    })
	// [Navigator.credentials](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/credentials
	Object.defineProperty(this, "credentials", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.deviceMemory](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/deviceMemory
	Object.defineProperty(this, "deviceMemory", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.geolocation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/geolocation
	Object.defineProperty(this, "geolocation", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.hid](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/hid
	Object.defineProperty(this, "hid", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.hardwareConcurrency](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/hardwareConcurrency
	Object.defineProperty(this, "hardwareConcurrency", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.ink](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/ink
	Object.defineProperty(this, "ink", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.keyboard](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/keyboard
	Object.defineProperty(this, "keyboard ", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.language](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/language
	Object.defineProperty(this, "language", {
        configurable: true,
        value: "en-US",
    })
	// [Navigator.languages](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/languages
	Object.defineProperty(this, "languages", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.locks](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/locks
	Object.defineProperty(this, "locks", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.maxTouchPoints](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/maxTouchPoints
	Object.defineProperty(this, "maxTouchPoints", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.mediaCapabilities](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/mediaCapabilities
	Object.defineProperty(this, "mediaCapabilities", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.mediaDevices](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/mediaDevices
	Object.defineProperty(this, "mediaDevices", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.mediaSession](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/mediaSession
	Object.defineProperty(this, "mediaSession", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.onLine](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/onLine
	Object.defineProperty(this, "onLine", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.pdfViewerEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/pdfViewerEnabled
	Object.defineProperty(this, "pdfViewerEnabled", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.permissions](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/permissions
	Object.defineProperty(this, "permissions", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.permissions](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/presentation
	Object.defineProperty(this, "presentation", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.serial](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/serial
	Object.defineProperty(this, "serial", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.serviceWorker](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/serviceWorker
	Object.defineProperty(this, "serviceWorker", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.storage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/storage
	Object.defineProperty(this, "storage", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.userActivation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/userActivation
	Object.defineProperty(this, "userActivation", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.userAgent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/userAgent
	Object.defineProperty(this, "userAgent", {
        configurable: true,
        value: "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rml/3.3",
        //TODO - pull this value from C++
    })
	// [Navigator.userAgentData](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/userAgentData
	Object.defineProperty(this, "userAgentData", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.virtualKeyboard](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/virtualKeyboard
	Object.defineProperty(this, "virtualKeyboard", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.webdriver](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/webdriver
	Object.defineProperty(this, "webdriver", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.windowControlsOverlay](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/windowControlsOverlay
	Object.defineProperty(this, "windowControlsOverlay", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.xr](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/xr
	Object.defineProperty(this, "xr", {
        configurable: true,
        value: "TODO",
    })
	
	////// Non-standard properties //////
	// [Navigator.buildID](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/buildID
	Object.defineProperty(this, "buildID", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.contacts](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/contacts
	Object.defineProperty(this, "contacts", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.globalPrivacyControl](Non-standard)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/globalPrivacyControl
	Object.defineProperty(this, "globalPrivacyControl", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.securitypolicy](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Navigator
	Object.defineProperty(this, "securitypolicy", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.standalone](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Navigator
	Object.defineProperty(this, "standalone", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.wakeLock](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/wakeLock
	Object.defineProperty(this, "wakeLock", {
        configurable: true,
        value: "TODO",
    })
	
	////// Deprecated properties //////
	// [Navigator.appCodeName](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/appCodeName
	Object.defineProperty(this, "appCodeName", {
        configurable: true,
        value: "Mozilla",
    })
	// [Navigator.appName](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/appName
	Object.defineProperty(this, "appName", {
        configurable: true,
        value: "Netscape",
    })
	// [Navigator.appVersion](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/appVersion
	Object.defineProperty(this, "appVersion", {
        configurable: true,
        value: "5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rml/3.3",
        //TODO - pull this value from C++
    })
	// [Navigator.activeVRDisplays](Read only)(Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/activeVRDisplays
	Object.defineProperty(this, "activeVRDisplays", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.doNotTrack](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/doNotTrack
	Object.defineProperty(this, "doNotTrack", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.mimeTypes](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/mimeTypes
	Object.defineProperty(this, "mimeTypes", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.oscpu](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/oscpu
	Object.defineProperty(this, "oscpu", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.platform](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/platform
	Object.defineProperty(this, "platform", {
        configurable: true,
        get: function platform() {
            return CPP_DKNavigatorplatform()
        }
    })
	// [Navigator.plugins](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/plugins
	Object.defineProperty(this, "plugins", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.product](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/product
	Object.defineProperty(this, "product", {
        configurable: true,
        value: "Duktape",
    })
	// [Navigator.productSub](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/productSub
	Object.defineProperty(this, "productSub", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.vendor](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/vendor
	Object.defineProperty(this, "vendor", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.vendorSub](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/vendorSub
	Object.defineProperty(this, "vendorSub", {
        configurable: true,
        value: "TODO",
    })
	
	////// Obsolete properties //////
	/*
	// [Navigator.battery]
    Object.defineProperty(this, "battery", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.javaEnabled]
    Object.defineProperty(this, "javaEnabled", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.mozNotification]
    Object.defineProperty(this, "mozNotification", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.webkitNotification]
    Object.defineProperty(this, "webkitNotification", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.mozSocial]
    Object.defineProperty(this, "mozSocial", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.storageQuota]
    Object.defineProperty(this, "storageQuota", {
        configurable: true,
        value: "TODO",
    })
	// [Navigator.webkitPointer]
    Object.defineProperty(this, "webkitPointer", {
        configurable: true,
        value: "TODO",
    })
	*/

    ////// Instance methods //////
	// [Navigator.canShare()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/canShare
    Navigator.prototype.canShare = function canShare() {
        return "TODO"
    }
	// [Navigator.clearAppBadge()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/clearAppBadge
	Navigator.prototype.clearAppBadge = function clearAppBadge() {
        return "TODO"
    }
	// [Navigator.getAutoplayPolicy()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/getAutoplayPolicy
	Navigator.prototype.getAutoplayPolicy = function getAutoplayPolicy() {
        return "TODO"
    }
	// [Navigator.getBattery()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/getBattery
	Navigator.prototype.getBattery = function getBattery() {
        return "TODO"
    }
	// [Navigator.registerProtocolHandler()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/registerProtocolHandler
	Navigator.prototype.registerProtocolHandler = function registerProtocolHandler() {
        return "TODO"
    }
	// [Navigator.unregisterProtocolHandler()]
	Navigator.prototype.unregisterProtocolHandler = function unregisterProtocolHandler() {
        return "TODO"
    }
	// [Navigator.requestMediaKeySystemAccess()]
	Navigator.prototype.requestMediaKeySystemAccess = function requestMediaKeySystemAccess() {
        return "TODO"
    }
	// [Navigator.requestMIDIAccess()]
	Navigator.prototype.requestMIDIAccess = function requestMIDIAccess() {
        return "TODO"
    }
	// [Navigator.sendBeacon()]
	Navigator.prototype.sendBeacon = function sendBeacon() {
        return "TODO"
    }
	// [Navigator.setAppBadge()](Experimental)
	Navigator.prototype.setAppBadge = function sendBeacon() {
        return "TODO"
    }
	// [Navigator.share()]
	Navigator.prototype.share = function share() {
        return "TODO"
    }
	// [Navigator.vibrate()]
	Navigator.prototype.vibrate = function vibrate() {
        return "TODO"
    }
	
	////// Deprecated methods //////
	// [Navigator.getVRDisplays()](Deprecated)(Non-standard)
	Navigator.prototype.getVRDisplays = function getVRDisplays() {
        return "TODO"
    }
	// [Navigator.getUserMedia()](Deprecated)
	Navigator.prototype.getUserMedia = function getUserMedia() {
        return "TODO"
    }
	// [Navigator.taintEnabled()](Deprecated)
	Navigator.prototype.taintEnabled = function taintEnabled() {
        return "TODO"
    }
	// [Navigator.javaEnabled()](Deprecated)
	Navigator.prototype.javaEnabled = function javaEnabled() {
        return "TODO"
    }
	
	
	////// Obsolete methods //////
	/*
	// [Navigator.registerContentHandler()]
    Navigator.prototype.registerContentHandler = function registerContentHandler() {
        return "TODO"
    }
	// [Navigator.mozIsLocallyAvailable()]
    Navigator.prototype.mozIsLocallyAvailable = function mozIsLocallyAvailable() {
        return "TODO"
    }
	// [Navigator.mozPay()]
    Navigator.prototype.mozPay = function mozPay() {
        return "TODO"
    }
	*/
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Navigator]"
		}
	}
}

var navigator = new Navigator("navigator")
//window.navigator = navigator
