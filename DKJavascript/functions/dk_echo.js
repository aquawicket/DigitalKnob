//###### DKINIT ######
var js = document.createElement("script");
js.type = "text/javascript";
js.src = "DK.js";
document.body.appendChild(js);



//################################################################################
//# dk_echo(message)
//#
//#	    Print a message to the console
//#
//#     @msg	- The message to print
//#
const dk_echo = function dk_echo(message){
	//dk_debugFunc
	
    console.log(message)
}



const DKTEST = function DKTEST() { //####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
    //dk_debugFunc
	
	const ESC = "\x1b"
	const clr = "\x1b[0m"
	const red = "\x1b[31m"
	const white = "\x1b[37m"
	const blue = "\x1b[34m"
	
	
	console.log("This is a normal console.log commmand")
	dk_echo()
	dk_echo("")
	dk_echo("This is a dk_echo line")
	dk_echo(red+"This is "+white+"dk_echo "+blue+"with color"+clr)
}


DKTEST()