//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var console;


///////////////////////////////
var Console = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Console()");
	
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		DKConsole_error(msg+"\n");
	}
	Console.prototype.clear = function(){
		DKConsole_clear();
	}
	Console.prototype.debug = function(msg){
		DKConsole_debug(msg+"\n");
	}
	Console.prototype.error = function(msg){
		DKConsole_error(msg+"\n");
	}
	Console.prototype.exception = Console.prototype.error; //alias
	Console.prototype.info = function(msg){
		DKConsole_info(msg+"\n");
	}
	Console.prototype.log = function(msg){
		DKConsole_info(msg+"\n");
	}
	Console.prototype.trace = function(){
		DKConsole_error("console.trace() not implemented\n");
	}
	Console.prototype.warn = function(msg){
			DKConsole_warn(msg+"\n");
	}
}

console = new Console("console");