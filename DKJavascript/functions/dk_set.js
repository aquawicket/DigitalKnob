//###### DKINIT ######
var js = document.createElement("script");
js.type = "text/javascript";
js.src = "DK.js";
document.body.appendChild(js);



//################################################################################
//# dk_set(variable, value)
//#
//#
function dk_set(variable, value) {
	
	var variable = value;
	return variable;
}
	


DKTEST = function DKTEST() { //####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
    //dk_debugFunc
	
	dk_set(myVarA, "the value of myVarA");
	console.log("myVarA = "+myVarA);
}
