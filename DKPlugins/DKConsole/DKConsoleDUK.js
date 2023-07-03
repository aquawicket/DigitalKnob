// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console


//[Exposed=*]
//namespace console { // but see namespace object requirements below
var Console = function Console(address) {
	console.log("Console("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKConsoleDUK_constructor();
	
	
	// Logging
	//undefined assert(optional boolean condition = false, any... data);
    Console.prototype.assert = function assert(condition, data) {
        CPP_DKConsoleDUK_assert(condition, data);
    }
	
	//undefined clear();	
    Console.prototype.clear = function clear() {
        CPP_DKConsoleDUK_clear();
    }
	
	//undefined debug(any... data);
	Console.prototype.debug = function debug(data) {
        CPP_DKConsoleDUK_debug(data);
    }
	
	//undefined error(any... data);
	Console.prototype.error = function error(data) {
		/*
		const err = new Error(data);
		if (!err.stack) {
			try {
				throw err; // old browsers need the Error thrown to fill the stack
			} 
			catch (err) {
				if (!err.stack)
					return error("err.stack invalid"); // browser too old
			}
		}
		*/
		CPP_DKConsoleDUK_error(data);
    }
	
	//undefined info(any... data);
	Console.prototype.info = function info(data) {
        CPP_DKConsoleDUK_info(data);
    }
	
	//undefined log(any... data);
	Console.prototype.log = function log(data) {
        CPP_DKConsoleDUK_log(data);
    }
	
	//undefined table(optional any tabularData, optional sequence<DOMString> properties);
	Console.prototype.table = function table(tabularData, properties) {
        CPP_DKConsoleDUK_table(tabularData, properties);
    }
	
	//undefined trace(any... data);
	Console.prototype.trace = function trace(data) {
		CPP_DKConsoleDUK_trace(data);
    }
	
	//undefined warn(any... data);
	Console.prototype.warn = function warn(data) {
        CPP_DKConsoleDUK_warn(data);
    }
	
	//undefined dir(optional any item, optional object? options);
	Console.prototype.dir = function dir(item, options) {
        CPP_DKConsoleDUK_dir(item, options);
    }
	
	//undefined dirxml(any... data);
	Console.prototype.dirxml = function dirxml(data) {
        CPP_DKConsoleDUK_dirxml(data);
    }
	
	// Counting
	//undefined count(optional DOMString label = "default");
	Console.prototype.count = function count(label) {
        CPP_DKConsoleDUK_count(label);
    }
	
	//undefined countReset(optional DOMString label = "default");
	Console.prototype.countReset = function countReset(label) {
        CPP_DKConsoleDUK_dirxml(label);
    }
   
	// Grouping
	//undefined group(any... data);
	Console.prototype.group = function group(data) {
        CPP_DKConsoleDUK_group(data);
    }
	
	//undefined groupCollapsed(any... data);
	Console.prototype.groupCollapsed = function groupCollapsed(data) {
        CPP_DKConsoleDUK_groupCollapsed(data);
    }
	
	//undefined groupEnd();
	Console.prototype.groupEnd = function groupEnd() {
        CPP_DKConsoleDUK_groupEnd();
    }
	
	// Timing
	//undefined time(optional DOMString label = "default");
	Console.prototype.time = function time(label) {
        CPP_DKConsoleDUK_time(label);
    }
	
	//undefined timeLog(optional DOMString label = "default", any... data);
	Console.prototype.timeLog = function timeLog(label, data) {
        CPP_DKConsoleDUK_timeLog(label, data);
    }
	
	//undefined timeEnd(optional DOMString label = "default");
	Console.prototype.timeEnd = function timeEnd(label) {
        CPP_DKConsoleDUK_timeEnd(label);
    }
	   
	
	////// toString //////
	//NOTE: Chrome returns [object Object]
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object Console]" }
	
	return this;
}

var console = new Console();
