//################################################################################
//# dk_validate(VAR <code>)
//#
//#
dk_validate = function dk_validate_f(){
	console.log("dk_validate()");
	
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	console.log("dk_validate("+_ARGV_+")");
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_validate_f(myVar 'var myVar = "abc"');

}
