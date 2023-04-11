// DKConsoleWindow.js

/////////////////////////////////////////////////////////
var DKConsoleWindow = function DKConsoleWindow(address) {
	console.log("DKConsoleWindow("+address+")");

	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKConsoleWindow();
	
	console.log("JS ConsoleWindow address = "+this.address)
	
	
	//// Instance properties ////
	Object.defineProperty(this, "columns", { //Read only
        get: function columns() { return CPP_DKConsoleWindow_columns(this.address) }
    })
	Object.defineProperty(this, "rows", { //Read only
        get: function rows() { return CPP_DKConsoleWindow_rows(this.address) }
    })

	
	//// Instance methods ////

	

	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKConsoleWindow]" }
	
	
	return Window.call(this, this.address)
}
DKConsoleWindow.prototype = Window.prototype;
