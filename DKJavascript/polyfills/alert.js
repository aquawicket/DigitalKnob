// https://www.codeproject.com/Articles/369858/Writing-Polyfills-in-JavaScript

if(typeof Window.prototype.alert !== "function") {
    Window.prototype.alert = function(msg) {
		var objShell = WScript.CreateObject("WScript.Shell");
		objShell.Popup(msg, 5, "Alert");
	}
}
