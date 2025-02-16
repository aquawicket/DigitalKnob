// https://console.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/Console

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
    Console.prototype.assert = function assert(msg) {
		msg = Console_HandleColor(msg)
        //if (assertion)
        //    return;
        CPP_DKConsole_assert(msg + "\n");
    }
    Console.prototype.clear = function clear() {
        CPP_DKConsole_clear();
    }
    Console.prototype.debug = function debug(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_debug(msg + "\n");
    }
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
    Console.prototype.exception = function exception(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_exception(msg + "\n");
    }
    Console.prototype.group = function group(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_group(msg + "\n");
    }
    Console.prototype.groupCollapsed = function groupCollapsed(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_groupCollapsed(msg + "\n");
    }
    Console.prototype.groupEnd = function groupEnd(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_groupEnd(msg + "\n");
    }
    Console.prototype.info = function info(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_info(msg + "\n");
    }
    Console.prototype.log = function log(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_log(msg + "\n");
    }
    Console.prototype.trace = function trace(msg) {
		msg = Console_HandleColor(msg)
		CPP_DKConsole_trace(msg + "\n");
    }
    Console.prototype.warn = function warn(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_warn(msg + "\n");
    }
}



var console = new Console("console");
window.console = console;