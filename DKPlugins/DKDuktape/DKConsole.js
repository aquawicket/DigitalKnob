//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var console;


///////////////////////////////
var Console = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Console()");
	
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		DKDuktape_LogError(msg+"\n");
	}
	Console.prototype.clear = function(){
		DKDuktape_System("cls");
	}
	Console.prototype.debug = function(msg){
		DKDuktape_LogDebug(msg+"\n");
	}
	Console.prototype.error = function(msg){
		DKDuktape_LogError(msg+"\n");
	}
	Console.prototype.exception = Console.prototype.error; //alias
	Console.prototype.info = function(msg){
		DKDuktape_LogInfo(msg+"\n");
	}
	Console.prototype.log = function(msg){
		DKDuktape_LogInfo(msg+"\n");
	}
	Console.prototype.trace = function(){
		DKDuktape_LogError("console.trace() not implemented\n");
	}
	Console.prototype.warn = function(msg){
			DKDuktape_LogWarn(msg+"\n");
	}
}

console = new Console("console");