// https://console.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/Console

const Console_HandleColor = function(msg){
	//TODO: handle coloring, (currently disabled)
	if(msg){
		msg = msg.replace("%c ","")
		msg = msg.replace("%c","")
	}
	return msg;
}

// https://console.spec.whatwg.org/#console-namespace
var Console = function(pointer) {
    Console.prototype.assert = function(msg) {
		msg = Console_HandleColor(msg)
        //if (assertion)
        //    return;
        CPP_DKConsole_assert(msg + "\n");
    }
    Console.prototype.clear = function() {
        CPP_DKConsole_clear();
    }
    Console.prototype.debug = function(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_debug(msg + "\n");
    }
    Console.prototype.error = function(msg) {
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
    Console.prototype.exception = function(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_exception(msg + "\n");
    }
    Console.prototype.group = function(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_group(msg + "\n");
    }
    Console.prototype.groupCollapsed = function(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_groupCollapsed(msg + "\n");
    }
    Console.prototype.groupEnd = function(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_groupEnd(msg + "\n");
    }
    Console.prototype.info = function(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_info(msg + "\n");
    }
    Console.prototype.log = function(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_log(msg + "\n");
    }
    Console.prototype.trace = function(msg) {
		msg = Console_HandleColor(msg)
		CPP_DKConsole_trace(msg + "\n");
    }
    Console.prototype.warn = function(msg) {
		msg = Console_HandleColor(msg)
        CPP_DKConsole_warn(msg + "\n");
    }
}



var console = new Console("console");
window.console = console;