
var script = document.createElement('script');
script.src = "file:///C:/Users/Administrator/digitalknob/Development/DKJavascript/functions/DK.js";
document.head.appendChild(script);
script.onreadystatechange = script.onload = function(evt){

	alert("dk_executeProcess.js loaded");
	//################################################################################
	//# dk_executeProcess()
	//#
	//#
	function dk_executeProcess() {
		alert("dk_executeProcess");
		console.log("dk_executeProcess");
	}
}