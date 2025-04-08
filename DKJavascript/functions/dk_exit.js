//################################################################################
//# dk_exit(msg)
//#
//#
dk_exit = function dk_exit_f(){
	console.log("dk_exit()");
	die();
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_exit();
	
	console.log("...SHOULD NOT GET HERE...");
}
