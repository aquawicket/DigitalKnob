//https://developer.mozilla.org/en-US/docs/Web/API/Console

///////////////////////////////
var Console = function(pointer)
{
	// Methods
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		CPP_DKDomConsole_error("[JS] "+msg+"\n");
	}
	Console.prototype.clear = function(){
		//DKDomConsole_clear();
		CPP_DKDomConsole_clear();
	}
	Console.prototype.count = function(){
		CPP_DKDomConsole_count();
	}
	Console.prototype.countReset = function(){
		CPP_DKDomConsole_countReset();
	}
	Console.prototype.debug = function(msg){
		CPP_DKDomConsole_debug("[JS] "+msg+"\n");
	}
	Console.prototype.dir = function(){
		CPP_DKDomConsole_dir();
	}
	Console.prototype.dirxml = function(){
		CPP_DKDomConsole_dirxml();
	}
	Console.prototype.error = function(msg){
		CPP_DKDomConsole_error("[JS] "+msg+"\n");
	}
	Console.prototype.exception = function(){
		CPP_DKDomConsole_exception();
	}
	Console.prototype.group = function(){
		CPP_DKDomConsole_group();
	}
	Console.prototype.groupCollapsed = function(){
		CPP_DKDomConsole_groupCollapsed();
	}
	Console.prototype.groupEnd = function(){
		CPP_DKDomConsole_groupEnd();
	}
	Console.prototype.info = function(msg){
		CPP_DKDomConsole_info("[JS] "+msg+"\n");
	}
	Console.prototype.log = function(msg){
		CPP_DKDomConsole_info("[JS] "+msg+"\n");
	}
	Console.prototype.profile = function(){
		CPP_DKDomConsole_profile();
	}
	Console.prototype.profileEnd = function(){
		CPP_DKDomConsole_profileEnd();
	}
	Console.prototype.table = function(){
		CPP_DKDomConsole_table();
	}
	Console.prototype.time = function(){
		CPP_DKDomConsole_time();
	}
	Console.prototype.timeEnd = function(){
		CPP_DKDomConsole_timeEnd();
	}
	Console.prototype.timeLog = function(){
		CPP_DKDomConsole_timeLog();
	}
	Console.prototype.timeStamp = function(){
		CPP_DKDomConsole_timeStamp();
	}
	Console.prototype.trace = function(){
		CPP_DKDomConsole_trace();
	}
	Console.prototype.warn = function(msg){
		CPP_DKDomConsole_warn("[JS] "+msg+"\n");
	}
}

var console = new Console("console");