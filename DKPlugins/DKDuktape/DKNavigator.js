//https://developer.mozilla.org/en-US/docs/Web/API/Navigator

/////////////////////////////////
var Navigator = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Navigator()");
	
	Object.defineProperty(this, "appCodeName",{
		value: "Mozilla",
	});
	Object.defineProperty(this, "appName",{
		value: "Netscape",
	});
	Object.defineProperty(this, "appVersion",{
		value: "5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "cookieEnabled",{
		value: "false",
	});
	Object.defineProperty(this, "language",{
		value: "en-US",
	});
	Object.defineProperty(this, "mimeTypes",{
		value: "",
	});
	Object.defineProperty(this, "onLine",{
		value: true, //TODO - pull this value from C++
	});
	Object.defineProperty(this, "platform", { get: function(){ return DKNavigator_platform(); } });
	Object.defineProperty(this, "product",{
		value: "Duktape",
	});
	Object.defineProperty(this, "productSub",{
		value: "1", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "userAgent",{
		value: "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rocket/1.0", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "vendor",{
		value: "DigitalKnob.com",
	});
	
	Navigator.prototype.javaEnabled = function(){
		return false;
	}
}

var navigator = new Navigator("navigator");