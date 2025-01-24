// https://www.codeproject.com/Articles/369858/Writing-Polyfills-in-JavaScript

if(typeof window.alert !== "function"){
	
	// Windows Scripting Host
	if(typeof WScript === "object"){
		window.alert = function(msg) {
			var objShell = WScript.CreateObject("WScript.Shell");
			objShell.Popup(msg, 5, "Alert");
		}
	}
}

/*
if(typeof Window.prototype.alert !== "function") {
	
	// Windows Scripting Host
	if(typeof WScript === "object"){
		Window.prototype.alert = function(msg) {
			var objShell = WScript.CreateObject("WScript.Shell");
			objShell.Popup(msg, 5, "Alert");
		}
	}
}
*/





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST() {
	//dk_debugFunc(0);
	
	alert("DKTEST()")
}
