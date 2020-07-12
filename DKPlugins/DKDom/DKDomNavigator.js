//https://developer.mozilla.org/en-US/docs/Web/API/Navigator

/////////////////////////////////
var Navigator = function(pointer)
{
	//Properties (Standard)
	Object.defineProperty(this, "activeVRDisplays",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "appCodeName",{ //Read only
		configurable: true,
		value: "Mozilla",
	});
	Object.defineProperty(this, "appName",{ //Read only
		configurable: true,
		value: "Netscape",
	});
	Object.defineProperty(this, "appVersion",{ //Read only
		configurable: true,
		value: "5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rml/3.3", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "battery",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "connection",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "cookieEnabled",{ //Read only
		configurable: true,
		value: "false",
	});
	Object.defineProperty(this, "geolocation",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "hardwareConcurrency",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "javaEnabled",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "keyboard ",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "language",{ //Read only
		configurable: true,
		value: "en-US",
	});
	Object.defineProperty(this, "languages",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "locks",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "mediaCapabilities",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "maxTouchPoints",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "mimeTypes",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "onLine",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "permissions",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "platform",{ //Read only
		configurable: true,
		get: function(){ return DKDomNavigator_platform(); } 
	});
	Object.defineProperty(this, "plugins",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "product",{ //Read only
		configurable: true,
		value: "Duktape",
	});
	Object.defineProperty(this, "serviceWorker",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "storage",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "userAgent",{ //Read only
		configurable: true,
		value: "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rml/3.3", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "webdriver",{ //Read only
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "xr",{ //Read only
		configurable: true,
		value: "TODO",
	});
	
	//Properties (Non-standard)
	Object.defineProperty(this, "buildID",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "credentials",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "deviceMemory",{ //Read only, Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "doNotTrack",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "mediaDevices",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "mediaSession",{
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "mozNotification",{ //Obsolete
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "webkitNotification",{ //Obsolete
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "mozSocial",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "oscpu",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "presentation",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "productSub",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "securitypolicy",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "standalone",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "storageQuota",{ //Read only, Experimental
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "vendor",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "vendorSub",{ //Not standardized
		configurable: true,
		value: "TODO",
	});
	Object.defineProperty(this, "webkitPointer",{ //Not standardized
		configurable: true,
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