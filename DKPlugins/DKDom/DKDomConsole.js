//https://developer.mozilla.org/en-US/docs/Web/API/Console

///////////////////////////////
var Console = function(pointer)
{
	//DKDEBUGFUNC();
	
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		DKDomConsole_error(msg+"\n");
	}
	Console.prototype.clear = function(){
		DKDomConsole_clear();
	}
	Console.prototype.debug = function(msg){
		DKDomConsole_debug(msg+"\n");
	}
	Console.prototype.error = function(msg){
		DKDomConsole_error(msg+"\n");
	}
	Console.prototype.exception = Console.prototype.error; //Deprecated
	Console.prototype.info = function(msg){
		DKDomConsole_info(msg+"\n");
	}
	Console.prototype.log = function(msg){
		DKDomConsole_info(msg+"\n");
	}
	Console.prototype.trace = function(){
		DKDomConsole_error("console.trace() not implemented\n");
	}
	Console.prototype.warn = function(msg){
		DKDomConsole_warn(msg+"\n");
	}
}

var console = new Console("console");