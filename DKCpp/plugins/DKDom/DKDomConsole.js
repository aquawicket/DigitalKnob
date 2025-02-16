//********************************************
//***  ALLREADY LOADED FROM DKDuktape

/*
// https://console.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/Console

// https://console.spec.whatwg.org/#console-namespace
var Console = function Console(pointer) {
    Console.prototype.assert = function assert(msg) {
        //if (assertion)
        //    return;
        CPP_DKConsole_assert(msg + "\n");
    }
    Console.prototype.clear = function clear() {
        CPP_DKConsole_clear();
    }
    Console.prototype.debug = function debug(msg) {
        CPP_DKConsole_debug(msg + "\n");
    }
    Console.prototype.error = function error(msg) {
        //CPP_DKConsole_error(msg + "\n");
		const e = new Error(msg);
		if (!e.stack) {
			try {
				throw e; // old browsers need the Error thrown to fill the stack
			} 
			catch (e) {
				if (!e.stack)
					return error("e.stack invalid"); // browser too old
			}
		}
		CPP_DKConsole_error(e.stack+"\n");
    }
    Console.prototype.exception = function exception(msg) {
        CPP_DKConsole_exception(msg + "\n");
    }
    Console.prototype.group = function group(msg) {
        CPP_DKConsole_group(msg + "\n");
    }
    Console.prototype.groupCollapsed = function groupCollapsed(msg) {
        CPP_DKConsole_groupCollapsed(msg + "\n");
    }
    Console.prototype.groupEnd = function groupEnd(msg) {
        CPP_DKConsole_groupEnd(msg + "\n");
    }
    Console.prototype.info = function info(msg) {
        CPP_DKConsole_info(msg + "\n");
    }
    Console.prototype.log = function log(msg) {
        CPP_DKConsole_log(msg + "\n");
    }
    Console.prototype.trace = function trace(msg) {
		CPP_DKConsole_trace(msg + "\n");
    }
    Console.prototype.warn = function warn(msg) {
        CPP_DKConsole_warn(msg + "\n");
    }
}

var console = new Console("console");
window.console = console;
*/