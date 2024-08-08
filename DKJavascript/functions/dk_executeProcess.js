
var script = document.createElement('script');
script.src = "DK.js";
document.appendChild(script);
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