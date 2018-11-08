//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var console;


///////////////////////////////
var Console = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Console()");
	
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		DKNavigator_error(msg+"\n");
	}
	Console.prototype.clear = function(){
		DKNavigator_clear();
	}
	Console.prototype.debug = function(msg){
		DKNavigator_debug(msg+"\n");
	}
	Console.prototype.error = function(msg){
		DKNavigator_error(msg+"\n");
	}
	Console.prototype.exception = Console.prototype.error; //Deprecated
	Console.prototype.info = function(msg){
		DKNavigator_info(msg+"\n");
	}
	Console.prototype.log = function(msg){
		DKNavigator_info(msg+"\n");
	}
	Console.prototype.trace = function(){
		DKNavigator_error("console.trace() not implemented\n");
	}
	Console.prototype.warn = function(msg){
			DKNavigator_warn(msg+"\n");
	}
}

console = new Console("console");