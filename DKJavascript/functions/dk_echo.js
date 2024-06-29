if(typeof DK !== 'function')
var DKINIT = document.createElement('script');
DKINIT.src = "DK.js";
document.head.appendChild(DKINIT);
DKINIT.onreadystatechange = DKINIT.onload = function(evt){

	//################################################################################
	//# dk_echo(message)
	//#
	//#	    Print a message to the console
	//#
	//#     @msg	- The message to print
	//#
	window.dk_echo = function dk_echo(message){
		//dk_debugFunc
		
		console.log(message)
	}

	DKTEST = function DKTEST() { //####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
		//dk_debugFunc
		
		console.log("This is a normal console.log commmand")
		dk_echo()
		dk_echo("")
		dk_echo("This is a dk_echo line")
		dk_echo(red+"This is "+white+"dk_echo "+blue+"with color"+clr)
	}
}
