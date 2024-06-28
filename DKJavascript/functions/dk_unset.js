//###### DKINIT ######
var js = document.createElement("script");
js.type = "text/javascript";
js.src = "DK.js";
document.body.appendChild(js);



//################################################################################
//# dk_unset(variable)
//#
//#
function dk_unset(obj) {
	
	//obj = undefined;
	//delete obj;
	//return obj ;
	
	obj.value = undefined;
	delete obj
	return obj.value ;
}
	


DKTEST = function DKTEST() { //####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
    //dk_debugFunc
	
	myVarA = "this is the value of myVarA";
	console.log(myVarA)
	//delete myVarA;
	console.log(myVarA)
	
	myVarB = "this is the value of myVarB";
	console.log(myVarB)
	dk_unset(myVarB)
	console.log(myVarB)
	
	var myVarC = {value: "this is the value of myVarC"};
	console.log(myVarC.value)
	dk_unset(myVarC)
	console.log(myVarC.value)
}
DKTEST()