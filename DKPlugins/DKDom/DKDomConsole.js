//https://developer.mozilla.org/en-US/docs/Web/API/Console

///////////////////////////////
var Console = function(pointer)
{
	// Methods
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		DKCPP_DKDomConsole_error("[JS] "+msg+"\n");
	}
	Console.prototype.clear = function(){
		//DKDomConsole_clear();
		DKCPP_DKDomConsole_clear();
	}
	Console.prototype.count = function(){
		DKCPP_DKDomConsole_count();
	}
	Console.prototype.countReset = function(){
		DKCPP_DKDomConsole_countReset();
	}
	Console.prototype.debug = function(msg){
		DKCPP_DKDomConsole_debug("[JS] "+msg+"\n");
	}
	Console.prototype.dir = function(){
		DKCPP_DKDomConsole_dir();
	}
	Console.prototype.dirxml = function(){
		DKCPP_DKDomConsole_dirxml();
	}
	Console.prototype.error = function(msg){
		DKCPP_DKDomConsole_error("[JS] "+msg+"\n");
	}
	Console.prototype.exception = function(){
		DKCPP_DKDomConsole_exception();
	}
	Console.prototype.group = function(){
		DKCPP_DKDomConsole_group();
	}
	Console.prototype.groupCollapsed = function(){
		DKCPP_DKDomConsole_groupCollapsed();
	}
	Console.prototype.groupEnd = function(){
		DKCPP_DKDomConsole_groupEnd();
	}
	Console.prototype.info = function(msg){
		DKCPP_DKDomConsole_info("[JS] "+msg+"\n");
	}
	Console.prototype.log = function(msg){
		DKCPP_DKDomConsole_info("[JS] "+msg+"\n");
	}
	Console.prototype.profile = function(){
		DKCPP_DKDomConsole_profile();
	}
	Console.prototype.profileEnd = function(){
		DKCPP_DKDomConsole_profileEnd();
	}
	Console.prototype.table = function(){
		DKCPP_DKDomConsole_table();
	}
	Console.prototype.time = function(){
		DKCPP_DKDomConsole_time();
	}
	Console.prototype.timeEnd = function(){
		DKCPP_DKDomConsole_timeEnd();
	}
	Console.prototype.timeLog = function(){
		DKCPP_DKDomConsole_timeLog();
	}
	Console.prototype.timeStamp = function(){
		DKCPP_DKDomConsole_timeStamp();
	}
	Console.prototype.trace = function(){
		DKCPP_DKDomConsole_trace();
	}
	Console.prototype.warn = function(msg){
		DKCPP_DKDomConsole_warn("[JS] "+msg+"\n");
	}
}

var console = new Console("console");