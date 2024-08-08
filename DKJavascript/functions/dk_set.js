var script = document.createElement('script');
script.src = "DK.js";
document.head.appendChild(script);
script.onreadystatechange = script.onload = function(evt){
	
	//################################################################################
	//# dk_set(variable, value)
	//#
	//#
	function dk_set(variable, value) {
		
		var variable = value;
		return variable;
	}
	
	

	DKTEST = function DKTEST() { //###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
		//dk_debugFunc
		
		dk_set(myVarA, "the value of myVarA");
		console.log("myVarA = "+myVarA);
	}
}