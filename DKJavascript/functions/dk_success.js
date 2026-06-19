

//################################################################################
//# dk_success(msg)
//#
//#     Print a dk_success message to the console
//#
//#     @msg    - The message to print
//#
dk_success = function dk_success_f(){
	//dk_debugFunc(0, 99);
	
	dk_depend("dk_log");
	dk_log("SUCCESS", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_success("test dk_success message");
}
