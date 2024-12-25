//##################################################################################
//# dk_log(<level> <message>)
//#
//#    Print a log message to the console
//#
//#    @level   - The message level
//#    @message - The message to print
//#
dk_log = function(msg) {
	//dk_debugFunc(1 2);
	
	console.log(msg);
	
	//dk_source(dk_echo)
	//dk_echo(msg);
}
	
	


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc(0);
	
	dk_log("Hello World");
}