function DKINIT(callback){
    var head = document.head;
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = "DK.js";
    script.onreadystatechange = callback;
    script.onload = callback;
    head.appendChild(script);
} DKINIT(function(){
	
	
});


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