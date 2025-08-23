

//################################################################################
//# dk_depend()
//#
//#
dk_depend = function dk_depend_f(){
	//dk_debugFunc(1)
	
	//console.log("dk_depend("+arguments[0]+")");
	if( !dk_valid(arguments[0]) ){ 
		dk_source(DKJAVASCRIPT_DIR+"/functions/"+arguments[0]+".js", function(){});	
	};

	dk_assert(arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_depend("dk_success");
	dk_success("dk_depend test successful");
}
