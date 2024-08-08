var script = document.createElement('script');
script.src = "DK.js";
document.head.appendChild(script);
script.onreadystatechange = script.onload = function(evt){

	//################################################################################
	//# dk_debugFunc()
	//#
	//#
	function dk_debugFunc() {
		console.log("dk_debugFunc");
	}
}