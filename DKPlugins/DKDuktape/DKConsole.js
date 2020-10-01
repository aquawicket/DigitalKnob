//https://developer.mozilla.org/en-US/docs/Web/API/Console

///////////////////////////////
var Console = function(pointer)
{	
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		DKCPP_DKDuktape_DKConsole_error(msg+"\n");
	}
	Console.prototype.clear = function(){
		DKCPP_DKDuktape_DKConsole_clear();
	}
	Console.prototype.debug = function(msg){
		DKCPP_DKDuktape_DKConsole_debug(msg+"\n");
	}
	Console.prototype.error = function(msg){
		DKCPP_DKDuktape_DKConsole_error(msg+"\n");
	}
	Console.prototype.exception = Console.prototype.error; //Deprecated
	Console.prototype.info = function(msg){
		DKCPP_DKDuktape_DKConsole_info(msg+"\n");
	}
	Console.prototype.log = function(msg){
		DKCPP_DKDuktape_DKConsole_info(msg+"\n");
	}
	Console.prototype.trace = function(){
		DKCPP_DKDuktape_DKConsole_error("console.trace() not implemented\n");
	}
	Console.prototype.warn = function(msg){
			DKCPP_DKDuktape_DKConsole_warn(msg+"\n");
	}
}

var console = new Console("console");