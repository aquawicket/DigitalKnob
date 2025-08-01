dk_source(DKJAVASCRIPT_DIR+"/functions/dk_debugFunc.js");

//################################################################################
//# dk_testReturn()
//#
//#
dk_testReturn = function dk_testReturn_f(){
	dk_debugFunc(1, 2);
	
//	export dk_testReturn=${1/input/output};

//	if [ -n "${2-}" ]; then
//		export ${2}=${dk_testReturn};
//	else
//		builtin echo "${dk_testReturn}";
//	fi
	
//	return $?;
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	dk_debugFunc(0);
	
	//### Result as global variable
	dk_echo("");
//	dk_call dk_testReturn "inputA";
//	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
	//### Result as parameter
//	dk_call dk_echo
//	dk_call dk_testReturn "inputB" resultB;
//	dk_call dk_echo "resultB = ${resultB}";
//	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
	//### Result as return value
//	dk_call dk_echo
//	resultC=$(dk_call dk_testReturn "inputC");
//	dk_call dk_echo "resultC = ${resultC}";
//	#dk_call dk_echo "dk_testReturn = ${dk_testReturn}";					#NOTE: export cannot be seen outside of command substituion
}