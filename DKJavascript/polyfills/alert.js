// https://www.codeproject.com/Articles/369858/Writing-Polyfills-in-JavaScript

if(typeof window.alert !== "function"){
	
	// Windows Scripting Host
	if(typeof WScript === "object"){
<<<<<<< HEAD
		window.alert = function(msg) {
=======
		window.alert = function(msg){
>>>>>>> Development
			var objShell = WScript.CreateObject("WScript.Shell");
			objShell.Popup(msg, 5, "Alert");
		}
	}
}

/*
<<<<<<< HEAD
if(typeof Window.prototype.alert !== "function") {
	
	// Windows Scripting Host
	if(typeof WScript === "object"){
		Window.prototype.alert = function(msg) {
=======
if(typeof Window.prototype.alert !== "function"){
	
	// Windows Scripting Host
	if(typeof WScript === "object"){
		Window.prototype.alert = function(msg){
>>>>>>> Development
			var objShell = WScript.CreateObject("WScript.Shell");
			objShell.Popup(msg, 5, "Alert");
		}
	}
}
<<<<<<< HEAD
*/
=======
*/





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST(){
	//dk_debugFunc(0);
	
	alert("DKTEST()")
}
>>>>>>> Development
