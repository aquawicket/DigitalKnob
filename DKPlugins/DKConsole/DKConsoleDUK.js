// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console


const Console_HandleColor = function Console_HandleColor(data){
	//TODO: handle coloring, (currently disabled)
	if(data){
		data = data.replace("%c ","")
		data = data.replace("%c","")
	}
	return data;
}

//[Exposed=*]
//namespace console { // but see namespace object requirements below
var Console = function Console(address) {
	
	// Logging
	//undefined assert(optional boolean condition = false, any... data);
    Console.prototype.assert = function assert(data) {
		data = Console_HandleColor(data)
        CPP_DKConsoleDUK_assert(data);
    }
	
	//undefined clear();	
    Console.prototype.clear = function clear() {
        CPP_DKConsoleDUK_clear();
    }
	
	//undefined debug(any... data);
	Console.prototype.debug = function debug(data) {
		data = Console_HandleColor(data)
        CPP_DKConsoleDUK_debug(data);
    }
	
	//undefined error(any... data);
	Console.prototype.error = function error(data) {
		data = Console_HandleColor(data)
		if(!data){
			CPP_DKConsoleDUK_error("data invalid \n");
			return;
		}
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
		CPP_DKConsoleDUK_error(err.stack);
    }
	
	//undefined info(any... data);
	Console.prototype.info = function info(data) {
		data = Console_HandleColor(data)
        CPP_DKConsoleDUK_info(data);
    }
	
	//undefined log(any... data);
	Console.prototype.log = function log(data) {
		data = Console_HandleColor(data)
        CPP_DKConsoleDUK_log(data);
    }
	
	//undefined table(optional any tabularData, optional sequence<DOMString> properties);
	Console.prototype.table = function table() {
        //TODO
    }
	
	//undefined trace(any... data);
	Console.prototype.trace = function trace(data) {
		data = Console_HandleColor(data)
		CPP_DKConsoleDUK_trace(data);
    }
	
	//undefined warn(any... data);
	Console.prototype.warn = function warn(data) {
		data = Console_HandleColor(data)
        CPP_DKConsoleDUK_warn(data);
    }
	
	//undefined dir(optional any item, optional object? options);
	Console.prototype.dir = function dir() {
        //TODO
    }
	
	//undefined dirxml(any... data);
	Console.prototype.dirxml = function dirxml() {
        //TODO
    }
	
	// Counting
	//undefined count(optional DOMString label = "default");
	Console.prototype.count = function count() {
        //TODO
    }
	
	//undefined countReset(optional DOMString label = "default");
	Console.prototype.countReset = function countReset() {
        //TODO
    }
   
	// Grouping
	//undefined group(any... data);
	Console.prototype.group = function group(data) {
		data = Console_HandleColor(data)
        CPP_DKConsoleDUK_group(data);
    }
	
	//undefined groupCollapsed(any... data);
	Console.prototype.groupCollapsed = function groupCollapsed(data) {
		data = Console_HandleColor(data)
        CPP_DKConsoleDUK_groupCollapsed(data);
    }
	
	//undefined groupEnd();
	Console.prototype.groupEnd = function groupEnd() {
        CPP_DKConsoleDUK_groupEnd();
    }
	
	// Timing
	//undefined time(optional DOMString label = "default");
	Console.prototype.time = function time() {
        //TODO
    }
	
	//undefined timeLog(optional DOMString label = "default", any... data);
	Console.prototype.timeLog = function timeLog() {
        //TODO
    }
	
	//undefined timeEnd(optional DOMString label = "default");
	Console.prototype.timeEnd = function timeEnd() {
        //TODO
    }
	   
	
	////// toString //////
	//NOTE: Chrome returns [object Object]
	/*
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object Console]" }
	*/
}

var console = new Console("console");
