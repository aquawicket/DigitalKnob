//###### DKINIT ######
var js = document.createElement("script");
js.type = "text/javascript";
js.src = "DK.js";
document.body.appendChild(js);



//################################################################################
//# dk_unset(variable)
//#
//#
window.dk_unset = function dk_unset(variable){
	//dk_debugFunc
	
    delete variable
}



DKTEST = function DKTEST() { //####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
    //dk_debugFunc
	
	const var = "the value of var"
	echo "var = ${var}"
	dk_unset const var
	echo "var = ${var}"
}