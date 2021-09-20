// https://console.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/Console

// https://console.spec.whatwg.org/#console-namespace
var Console = function(pointer) {
    Console.prototype.assert = function(msg) {
        //if (assertion)
        //    return;
        CPP_DKConsole_assert(msg + "\n");
    }
    Console.prototype.clear = function() {
        CPP_DKConsole_clear();
    }
    Console.prototype.debug = function(msg) {
        CPP_DKConsole_debug(msg + "\n");
    }
    Console.prototype.error = function(msg) {
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
    Console.prototype.exception = function(msg) {
        CPP_DKConsole_exception(msg + "\n");
    }
    Console.prototype.group = function(msg) {
        CPP_DKConsole_group(msg + "\n");
    }
    Console.prototype.groupCollapsed = function(msg) {
        CPP_DKConsole_groupCollapsed(msg + "\n");
    }
    Console.prototype.groupEnd = function(msg) {
        CPP_DKConsole_groupEnd(msg + "\n");
    }
    Console.prototype.info = function(msg) {
        CPP_DKConsole_info(msg + "\n");
    }
    Console.prototype.log = function(msg) {
        CPP_DKConsole_log(msg + "\n");
    }
    Console.prototype.trace = function(msg) {
		CPP_DKConsole_trace(msg + "\n");
    }
    Console.prototype.warn = function(msg) {
        CPP_DKConsole_warn(msg + "\n");
    }
}

var console = new Console("console");
