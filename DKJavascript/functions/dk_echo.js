// shebang
/*
//#####################################################################################################
if(typeof ActiveXObject === "function"){
	if(typeof wscript_shell !== "object")	{ var wscript_shell = new ActiveXObject("WScript.Shell"); }
	if(typeof ENV !== "object")				{ var ENV = wscript_shell.Environment("Process"); }
	if(typeof ENV === "object" && typeof wscript_shell === "object" && ENV("DKINIT_js") === "") {	
		ENV("DKINIT_js") = WScript.ScriptFullName;
		wscript_shell.Run("cmd /k mshta.exe \"file:///C:/Users/Administrator/DigitalKnob/Development/DKHta/functions/DK.hta\" | for /f \"delims=\" %a in ('findstr \"^\"') do 	@echo %a", 1, 1);
		//throw new Error('Program Terminated');
	}
}
//#####################################################################################################
*/

 /* 
 else {
	//https://stackoverflow.com/a/950146/688352
	function loadScript(url, callback){
		// Adding the script tag to the head as suggested before
		var head = document.head;
		var script = document.createElement('script');
		script.type = 'text/javascript';
		script.src = url;
		// Then bind the event to the callback function.
		// There are several events for cross browser compatibility.
		script.onreadystatechange = callback;
		script.onload = callback;
		head.appendChild(script);
}
*/


//################################################################################
//# dk_echo(message)
//#
//#     Print a message to the console
//#
//#     @msg    - The message to print
//#
dk_echo = function dk_echo_f(){
	//dk_debugFunc(0 1);
	
	if(arguments[0]){
		console.log(arguments[0]);
	}	
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_echo("Hello World");
}
