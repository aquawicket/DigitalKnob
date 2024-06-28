function loadScript(url, callback){
    var head = document.head;
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;
    script.onreadystatechange = callback;
    script.onload = callback;
    head.appendChild(script);
}
if(typeof DKINIT === 'undefined'){ loadScript("DK.js", function(){
	console.log("DK.js loaded");
});}



//################################################################################
//# dk_load()
//#
//#
function dk_load(name) {
	console.log("dk_load("+name+")");
}
	


DKTEST = function DKTEST() { //####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
    console.log("DKTEST()");
}
