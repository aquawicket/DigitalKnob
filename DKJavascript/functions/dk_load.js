//function DKINIT(callback){
//    var script = document.createElement('script');
//    script.src = "DK.js";
//    script.onreadystatechange = script.onload = callback;
//	document.head.appendChild(script);
//} DKINIT(function(evt){
//});

//################################################################################
//# dk_load()
//#
//#
window.dk_load = function dk_load(src, callback) {
	console.log("dk_load("+src+")")
	var script = document.createElement('script');
	script.src = src+'.js';
	script.onreadystatechange = script.onload = callback;
	document.head.appendChild(script);
}
