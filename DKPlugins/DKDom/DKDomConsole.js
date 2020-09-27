//https://developer.mozilla.org/en-US/docs/Web/API/Console

///////////////////////////////
var Console = function(pointer)
{
	// Methods
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		DKDomConsole_error("[JS] "+msg+"\n");
	}
	Console.prototype.clear = function(){
		DKDomConsole_clear();
	}
	Console.prototype.count = function(){
		DKDomConsole_count();
	}
	Console.prototype.countReset = function(){
		DKDomConsole_countReset();
	}
	Console.prototype.debug = function(msg){
		DKDomConsole_debug("[JS] "+msg+"\n");
	}
	Console.prototype.dir = function(){
		DKDomConsole_dir();
	}
	Console.prototype.dirxml = function(){
		DKDomConsole_dirxml();
	}
	Console.prototype.error = function(msg){
		DKDomConsole_error("[JS] "+msg+"\n");
	}
	Console.prototype.exception = function(){
		DKDomConsole_exception();
	}
	Console.prototype.group = function(){
		DKDomConsole_group();
	}
	Console.prototype.groupCollapsed = function(){
		DKDomConsole_groupCollapsed();
	}
	Console.prototype.groupEnd = function(){
		DKDomConsole_groupEnd();
	}
	Console.prototype.info = function(msg){
		DKDomConsole_info("[JS] "+msg+"\n");
	}
	Console.prototype.log = function(msg){
		DKDomConsole_info("[JS] "+msg+"\n");
	}
	Console.prototype.profile = function(){
		DKDomConsole_profile();
	}
	Console.prototype.profileEnd = function(){
		DKDomConsole_profileEnd();
	}
	Console.prototype.table = function(){
		DKDomConsole_table();
	}
	Console.prototype.time = function(){
		DKDomConsole_time();
	}
	Console.prototype.timeEnd = function(){
		DKDomConsole_timeEnd();
	}
	Console.prototype.timeLog = function(){
		DKDomConsole_timeLog();
	}
	Console.prototype.timeStamp = function(){
		DKDomConsole_timeStamp();
	}
	Console.prototype.trace = function(){
		DKDomConsole_trace();
	}
	Console.prototype.warn = function(msg){
		DKDomConsole_warn("[JS] "+msg+"\n");
	}
}

var console = new Console("console");