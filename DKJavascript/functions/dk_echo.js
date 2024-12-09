
// https://stackoverflow.com/questions/3054321/how-to-reference-a-jscript-file-from-another-one
// A object to which library functions can be attached
//var library = new Object;
eval((new ActiveXObject("Scripting.FileSystemObject")).OpenTextFile("DK.js", 1).ReadAll());



// https://stackoverflow.com/a/950146/688352
/*
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
*/




dk_echo = function(msg) {
	WScript.Echo(msg);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc(0);
	
	dk_echo("Hello World")
}

DKTEST();