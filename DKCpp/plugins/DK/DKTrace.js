//"use strict";
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
=======

function DKTrace(){}
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js

DKTrace.prototype.editFile = function dk_trace_editFile(file, line, ch){
    file = file.replace("file:///", "");
    !line && (line = 1);
    !ch && (ch = 0);
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
    DKPlugin("DKCodeMirror/DKCodeMirror.js", function dk_create() {
        DKCodeMirror.prototype.createOpen(file, function dk_codemirror_createOpen_callback(instance) {
=======
    DKPlugin("DKCodeMirror/DKCodeMirror.js", function dk_create(){
        DKCodeMirror.prototype.createOpen(file, function dk_codemirror_createOpen_callback(instance){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
            instance.highlightError(instance, line, ch);
        });
    });

}

<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
DKTrace.prototype.stackToConsoleString = function dk_trace_stackToConsoleString(arg, deleteTo) {
    var jsonStack;
    var headerMsg = false;
    if (arg instanceof Error) {
        if (arg.stack) {
            headerMsg = true;
            jsonStack = this.stackToJSON(arg.stack);
        } 
		else if (arg instanceof DOMException) {
=======
DKTrace.prototype.stackToConsoleString = function dk_trace_stackToConsoleString(arg, deleteTo){
    var jsonStack;
    var headerMsg = false;
    if (arg instanceof Error){
        if (arg.stack){
            headerMsg = true;
            jsonStack = this.stackToJSON(arg.stack);
        } 
		else if (arg instanceof DOMException){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
            headerMsg = true;
            const str = arg.name + " " + arg.message;
            jsonStack = this.stackToJSON(this.getStack(str));
        } 
		else {
            return error("arg is an instance of Error, but it doesn't have a stack");
        }
    } 
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
	else if (arg instanceof PromiseRejectionEvent) {
        headerMsg = true;
        jsonStack = this.stackToJSON(this.getStack(arg.reason));
    } 
	else if (typeof arg === 'string') {
        jsonStack = this.stackToJSON(this.getStack(arg));
    } 
	else if (!arg) {
=======
	else if (arg instanceof PromiseRejectionEvent){
        headerMsg = true;
        jsonStack = this.stackToJSON(this.getStack(arg.reason));
    } 
	else if (typeof arg === 'string'){
        jsonStack = this.stackToJSON(this.getStack(arg));
    } 
	else if (!arg){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
        jsonStack = this.stackToJSON(this.getStack());
    } 
	else {
        return error("StackToConsoleString(): typeof arg invalid: " + typeof arg);
    }
    //Remove calls up to the function specified in deleteTo
    //deleteTo = null;
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
    if (deleteTo) {
        for (var n = 1; n < jsonStack.length; n++) {
=======
    if (deleteTo){
        for (var n = 1; n < jsonStack.length; n++){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
            if (jsonStack[n].func === deleteTo)
                jsonStack.splice(1, n);
        }
    }
    var str;
    headerMsg ? str = jsonStack[0].msg + "\n" : str = "";
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
    for (var n = 1; n < jsonStack.length; n++) {
=======
    for (var n = 1; n < jsonStack.length; n++){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
        str += "    at " + jsonStack[n].func + " ";
        str += "(<a href='#' onClick='dk.trace.editFile(\"" + jsonStack[n].filePath + "\",\"" + jsonStack[n].lineNum + "\",\"" + jsonStack[n].charNum + "\")' style='color:rgb(213,213,213)'>" + jsonStack[n].file + ":" + jsonStack[n].lineNum + "</a>)<br>";
    }
    return str;
}

<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
DKTrace.prototype.isStrict = function dk_trace_isStrict() {
=======
DKTrace.prototype.isStrict = function dk_trace_isStrict(){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
    if (eval("var __temp = null"), (typeof __temp === "undefined"))
        return true;
    return false;
}

DKTrace.prototype.getStack = function dk_trace_getStack(msg){
    const e = new Error(msg);
    if (!e.stack){
        try {
            throw e; // old browsers need the Error thrown to fill the stack
        } 
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
		catch (e) {
=======
		catch (e){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
            if (!e.stack)
                return error("e.stack invalid"); // browser too old
        }
    }
    return e.stack;
}

<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
DKTrace.prototype.stackToJSON = function dk_trace_stackToJSON(stack) {
=======
DKTrace.prototype.stackToJSON = function dk_trace_stackToJSON(stack){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
    if (!stack || typeof stack !== 'string')
        return error("StackToJSON(): invalid stack");
    //split the call stack lines into an array
    const lines = stack.toString().split(/\r\n|\n/);
    //The first line should be the call stack message
    const msg = lines[0];
    const jsonStack = [{
        msg
    }];
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
    for (var n = 1; n < lines.length; n++) {
=======
    for (var n = 1; n < lines.length; n++){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
        var line = lines[n].trim();
        line = line.replace("at ", "");
        line = line.replace("(", "");
        line = line.replace(")", "");
        const func = line.split(" ").shift();
        line = line.replace(func + " ", "");
        const charNum = line.split(":").pop();
        line = line.replace(":" + charNum, "");
        const lineNum = line.split(":").pop();
        line = line.replace(":" + lineNum, "");
        const as = line.split("]").shift() + "]";
        line = line.replace(as + " ", "");
        const file = line.split("/").pop();
        const filePath = line.trim();
        jsonStack.push({
            func,
            file,
            lineNum,
            charNum,
            filePath
        });
    }
    return jsonStack;
}

DKTrace.prototype.lastStackCall = function dk_trace_lastStackCall(){
    const stack = this.stackToJSON(this.getStack());
    var nn;
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
    for (var n = 1; n < stack.length; n++) {
        if (stack[n].func === "LastStackCall") {
=======
    for (var n = 1; n < stack.length; n++){
        if (stack[n].func === "LastStackCall"){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
            nn = n + 1;
            break;
        }
    }
    if (!nn)
        return error("LastStackCall(): could not find 'LastStackCall' in the stack");
    var str = "LastStackCall: " + stack[nn].func;
    str += "(<a href='" + stack[nn].filePath + "' target='_blank' style='color:rgb(213,213,213)'>" + stack[nn].file + ":" + stack[nn].lineNum + "</a>)";
    return str;
}

<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
DKTrace.prototype.getArguments = function dk_trace_getArguments(func, getArgValues) {
=======
DKTrace.prototype.getArguments = function dk_trace_getArguments(func, getArgValues){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
    var argsString = "";
    var count = 0;
    const fn = window[func];
    if (!fn){
        console.error(this.lastStackCall() + "<br>" + "  at if(!fn)");
        return "";
    }
    argsString += new RegExp('(?:' + fn.name + '\\s*|^)\\s*\\((.*?)\\)').exec(fn.toString().replace(/\n/g, ''))[1].replace(/\/\*.*?\*\//g, '').replace(/ /g, '');
    if (isStrict()) 
        return argsString;
    if (!getArgValues)
        return argsString;
    if (!fn.arguments)
        return argsString;
    var args = argsString.split(",");

    //FIXME: duktape
    console.error("FIXME");
    /*
<<<<<<< HEAD:DKPlugins/DK/DKTrace.js
    for (var val of fn.arguments) {
        if (count > 0) {
=======
    for (var val of fn.arguments){
        if (count > 0){
>>>>>>> Development:DKCpp/plugins/DK/DKTrace.js
            args[count] = " " + args[count];
        }
        args[count] += " = " + val;
        count++;
    }
    argsString = args.toString();
    return argsString;
	*/
}

DKTrace.prototype.getFunctionName = function dk_trace_getFunctionName(){
    return dk.trace.stackToJSON(dk.trace.getStack())[4].func;
}

DKTrace.prototype.getFilename = function dk_trace_getFilename(){
    return dk.trace.stackToJSON(dk.trace.getStack())[4].filePath.split("/").pop();
}

dk.trace = DKPlugin(DKTrace, "singleton");