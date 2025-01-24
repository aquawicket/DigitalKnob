//console.log("dk_echo()");

// https://stackoverflow.com/a/950146/688352
function loadScript(url, callback) {
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


//################################################################################
//# dk_echo(message)
//#
//#     Print a message to the console
//#
//#     @msg    - The message to print
//#
dk_echo = function(msg) {
	console.log(msg);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc(0);
	

	dk_echo("Hello World")
}
