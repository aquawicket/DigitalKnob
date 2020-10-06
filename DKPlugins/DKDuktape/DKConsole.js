//https://developer.mozilla.org/en-US/docs/Web/API/Console

///////////////////////////////
var Console = function(pointer)
{	
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		CPP_DKDuktape_DKConsole_error(msg+"\n");
	}
	Console.prototype.clear = function(){
		CPP_DKDuktape_DKConsole_clear();
	}
	Console.prototype.debug = function(msg){
		CPP_DKDuktape_DKConsole_debug(msg+"\n");
	}
	Console.prototype.error = function(msg){
		CPP_DKDuktape_DKConsole_error(msg+"\n");
	}
	Console.prototype.exception = Console.prototype.error; //Deprecated
	Console.prototype.info = function(msg){
		CPP_DKDuktape_DKConsole_info(msg+"\n");
	}
	Console.prototype.log = function(msg){
		CPP_DKDuktape_DKConsole_info(msg+"\n");
	}
	Console.prototype.trace = function(){
		CPP_DKDuktape_DKConsole_error("console.trace() not implemented\n");
	}
	Console.prototype.warn = function(msg){
			CPP_DKDuktape_DKConsole_warn(msg+"\n");
	}
}

var console = new Console("console");