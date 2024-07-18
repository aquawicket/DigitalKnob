if(typeof DK !== 'function')
var DKINIT = document.createElement('script');
DKINIT.src = "DK.js";
document.head.appendChild(DKINIT);
DKINIT.onreadystatechange = DKINIT.onload = function(evt){

//##################################################################################
//# dk_realpath(path) -> rtn_var
//#
//#    Javascript: https://nodejs.org/api/fs.html#fspromisesrealpathpath-options
//#
window.dk_realpath = function dk_realpath(path){
	//dk_debugFunc()
	
	console.log(message)
}








//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
DKTEST = function DKTEST() { 
	//dk_debugFunc()
	
	let realpath = dk_realpath("bash")
	dk_info("realpath = "+realpath)
}

}
