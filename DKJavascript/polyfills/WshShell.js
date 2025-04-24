
<<<<<<< HEAD
(function(wsh) {
=======
(function(wsh){
>>>>>>> Development
	if(typeof WScript === "object"){
		var WshShell = function(){ return new ActiveXObject("WScript.Shell"); }
		globalThis.WshShell = WshShell
	}
})(this.WshShell = this.WshShell || {});

