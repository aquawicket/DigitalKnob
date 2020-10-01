//https://developer.mozilla.org/en-US/docs/Web/API/Navigator

/////////////////////////////////
var Navigator = function(pointer)
{
	//Properties (Standard)
	Object.defineProperty(this, "activeVRDisplays",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "appCodeName",{ //Read only
		value: "Mozilla",
	});
	Object.defineProperty(this, "appName",{ //Read only
		value: "Netscape",
	});
	Object.defineProperty(this, "appVersion",{ //Read only
		value: "5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rml/3.3", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "battery",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "connection",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "cookieEnabled",{ //Read only
		value: "false",
	});
	Object.defineProperty(this, "geolocation",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "hardwareConcurrency",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "javaEnabled",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "keyboard ",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "language",{ //Read only
		value: "en-US",
	});
	Object.defineProperty(this, "languages",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "locks",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "mediaCapabilities",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "maxTouchPoints",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "mimeTypes",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "onLine",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "permissions",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "platform",{ //Read only
		get: function(){ return DKCPP_DKDomNavigator_platform(); } 
	});
	Object.defineProperty(this, "plugins",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "product",{ //Read only
		value: "Duktape",
	});
	Object.defineProperty(this, "serviceWorker",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "storage",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "userAgent",{ //Read only
		value: "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rml/3.3", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "webdriver",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "xr",{ //Read only
		value: "TODO",
	});
	
	//Properties (Non-standard)
	Object.defineProperty(this, "buildID",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "credentials",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "deviceMemory",{ //Read only, Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "doNotTrack",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "mediaDevices",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "mediaSession",{
		value: "TODO",
	});
	Object.defineProperty(this, "mozNotification",{ //Obsolete
		value: "TODO",
	});
	Object.defineProperty(this, "webkitNotification",{ //Obsolete
		value: "TODO",
	});
	Object.defineProperty(this, "mozSocial",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "oscpu",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "presentation",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "productSub",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "securitypolicy",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "standalone",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "storageQuota",{ //Read only, Experimental
		value: "TODO",
	});
	Object.defineProperty(this, "vendor",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "vendorSub",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "webkitPointer",{ //Not standardized
		value: "TODO",
	});
	
	//Methods (Standard)
	Navigator.prototype.canShare = function(){ //Experimental
		return "TODO";
	}
	Navigator.prototype.getVRDisplays = function(){ //Experimental
		return "TODO";
	}
	Navigator.prototype.getUserMedia = function(){ //Experimental
		return "TODO";
	}
	Navigator.prototype.registerContentHandler = function(){ //Obsolete
		return "TODO";
	}
	Navigator.prototype.registerProtocolHandler = function(){
		return "TODO";
	}
	Navigator.prototype.requestMediaKeySystemAccess = function(){ //Experimental
		return "TODO";
	}
	Navigator.prototype.sendBeacon = function(){ //Experimental
		return "TODO";
	}
	Navigator.prototype.share = function(){ //Experimental
		return "TODO";
	}
	Navigator.prototype.taintEnabled = function(){ //Obsolete, Experimental
		return "TODO";
	}
	Navigator.prototype.vibrate = function(){ //Obsolete, Experimental
		return "TODO";
	}
	
	//Methods (Non-standard)
	Navigator.prototype.mozIsLocallyAvailable = function(){ //Not standardized
		return "TODO";
	}
	Navigator.prototype.mozPay = function(){ //Not standardized
		return "TODO";
	}
}

var navigator = new Navigator("navigator");