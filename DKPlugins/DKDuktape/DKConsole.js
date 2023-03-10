// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
// [NAMESPACE] https://console.spec.whatwg.org/#console-namespace


const Console_HandleColor = function Console_HandleColor(msg){
	//TODO: handle coloring, (currently disabled)
	if(msg){
		msg = msg.replace("%c ","")
		msg = msg.replace("%c","")
	}
	return msg;
}

// https://console.spec.whatwg.org/#console-namespace
var Console = function Console(pointer) {
	
	////// Instance methods //////
	// [console.assert()] https://developer.mozilla.org/en-US/docs/Web/API/console/assert
    Console.prototype.assert = function assert(msg) {
		msg = Console_HandleColor(msg)
        //if (assertion)
        //    return;
        CPP_DKConsole_assert(msg + "\n");
    }
	// [console.clear()] https://developer.mozilla.org/en-US/docs/Web/API/console/clear
    Console.prototype.clear = function clear() {
        CPP_DKConsole_clear();
    }
	// [console.count()] https://developer.mozilla.org/en-US/docs/Web/API/console/count
	Console.prototype.count = function count() {
        //TODO
    }
	// [console.countReset()] https://developer.mozilla.org/en-US/docs/Web/API/console/countReset
	Console.prototype.countReset = function countReset() {
        //TODO
    }
	// [console.debug()] https://developer.mozilla.org/en-US/docs/Web/API/console/debug
    Console.prototype.debug = function debug(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_debug(msg + "\n");
    }
	// [console.dir()] https://developer.mozilla.org/en-US/docs/Web/API/console/dir
	Console.prototype.dir = function dir() {
        //TODO
    }
	// [console.dirxml()] https://developer.mozilla.org/en-US/docs/Web/API/console/dirxml
	Console.prototype.dirxml = function dirxml() {
        //TODO
    }
	// [console.error()] https://developer.mozilla.org/en-US/docs/Web/API/console/error
    Console.prototype.error = function error(msg) {
		msg = Console_HandleColor(msg)
		if(!msg){
			CPP_DKConsole_error("msg invalid \n");
			return;
		}
		const err = new Error(msg);
		if (!err.stack) {
			try {
				throw err; // old browsers need the Error thrown to fill the stack
			} 
			catch (err) {
				if (!err.stack)
					return error("err.stack invalid"); // browser too old
			}
		}
		CPP_DKConsole_error(err.stack+"\n");
    }
	// [console.exception()](Non-standard)(Deprecated) "An alias for error()."
    Console.prototype.exception = function exception(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_exception(msg + "\n");
    }
	// [console.group()] https://developer.mozilla.org/en-US/docs/Web/API/console/group
    Console.prototype.group = function group(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_group(msg + "\n");
    }
	// [console.groupCollapsed()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupCollapsed
    Console.prototype.groupCollapsed = function groupCollapsed(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_groupCollapsed(msg + "\n");
    }
	// [console.groupEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/groupEnd
    Console.prototype.groupEnd = function groupEnd(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_groupEnd(msg + "\n");
    }
	// [console.info()] https://developer.mozilla.org/en-US/docs/Web/API/console/info
    Console.prototype.info = function info(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_info(msg + "\n");
    }
	// [console.log()] https://developer.mozilla.org/en-US/docs/Web/API/console/log
    Console.prototype.log = function log(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_log(msg + "\n");
    }
	// [console.profile()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profile
	Console.prototype.profile = function profile() {
        //TODO
    }
	// [console.profileEnd()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/profileEnd
	Console.prototype.profileEnd = function profileEnd() {
        //TODO
    }
	// [console.table()] https://developer.mozilla.org/en-US/docs/Web/API/console/table
	Console.prototype.table = function table() {
        //TODO
    }
	// [console.time()] https://developer.mozilla.org/en-US/docs/Web/API/console/time
	Console.prototype.time = function time() {
        //TODO
    }
	// [console.timeEnd()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeEnd
	Console.prototype.timeEnd = function timeEnd() {
        //TODO
    }
	// [console.timeLog()] https://developer.mozilla.org/en-US/docs/Web/API/console/timeLog
	Console.prototype.timeLog = function timeLog() {
        //TODO
    }
	// [console.timeStamp()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/console/timeStamp
	Console.prototype.timeStamp = function timeStamp() {
        //TODO
    }
	// [console.trace()] https://developer.mozilla.org/en-US/docs/Web/API/console/trace
    Console.prototype.trace = function trace(msg) {
		msg = Console_HandleColor(msg)
		CPP_DKConsole_trace(msg + "\n");
    }
	// [console.warn()] https://developer.mozilla.org/en-US/docs/Web/API/console/warn
    Console.prototype.warn = function warn(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_warn(msg + "\n");
    }
	
	////// toString //////
	//NOTE: Chrome returns [object Object]
	/*
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Console]"
		}
	}
	*/
}

var console = new Console("console");
