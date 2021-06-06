"use strict";

dk.trace = new DKTrace();

function DKTrace() {
    return DKPlugin.call(this, arguments)
}

DKTrace.prototype.editFile = function dk_trace_editFile(file, line, ch) {
    file = file.replace("file:///", "");
    !line && (line = 1);
    !ch && (ch = 0);

    dk.create("DKCodeMirror/DKCodeMirror.js", function dk_create() {
        dk.codemirror.createOpen(file, function dk_codemirror_createOpen_callback(instance) {
            dk.codemirror.highlightError(instance, line, ch);
        });
    });

}

DKTrace.prototype.stackToConsoleString = function dk_trace_stackToConsoleString(arg, deleteTo) {
    let jsonStack;
    let headerMsg = false;
    if (arg instanceof Error) {
        if (arg.stack) {
            headerMsg = true;
            jsonStack = this.stackToJSON(arg.stack);
        } else if (arg instanceof DOMException) {
            headerMsg = true;
            const str = arg.name + " " + arg.message;
            jsonStack = this.stackToJSON(this.getStack(str));
        } else {
            return error("arg is an instance of Error, but it doesn't have a stack");
        }
    } else if (arg instanceof PromiseRejectionEvent) {
        headerMsg = true;
        jsonStack = this.stackToJSON(this.getStack(arg.reason));
    } else if (typeof arg === 'string') {
        jsonStack = this.stackToJSON(this.getStack(arg));
    } else if (!arg) {
        jsonStack = this.stackToJSON(this.getStack());
    } else {
        return error("StackToConsoleString(): typeof arg invalid: " + typeof arg);
    }

    //Remove calls up to the function specified in deleteTo
    //deleteTo = null;
    if (deleteTo) {
        for (let n = 1; n < jsonStack.length; n++) {
            if (jsonStack[n].func === deleteTo) {
                jsonStack.splice(1, n);
            }
        }
    }

    let str;
    headerMsg ? str = jsonStack[0].msg + "\n" : str = "";
    for (let n = 1; n < jsonStack.length; n++) {
        str += "    at " + jsonStack[n].func + " ";
        str += "(<a href='#' onClick='dk.trace.editFile(\"" + jsonStack[n].filePath + "\",\"" + jsonStack[n].lineNum + "\",\"" + jsonStack[n].charNum + "\")' style='color:rgb(213,213,213)'>" + jsonStack[n].file + ":" + jsonStack[n].lineNum + "</a>)<br>";
    }

    return str;
}

DKTrace.prototype.isStrict = function dk_trace_isStrict() {
    if (eval("var __temp = null"),
    (typeof __temp === "undefined")) {
        return true;
    }
    return false;
}

DKTrace.prototype.getStack = function dk_trace_getStack(msg) {
    const e = new Error(msg);
    if (!e.stack) {
        try {
            // old browsers need the Error thrown to fill the stack
            throw e;
        } catch (e) {
            if (!e.stack) {
                return error("e.stack invalid");
                // browser too old
            }
        }
    }
    return e.stack;
}

DKTrace.prototype.stackToJSON = function dk_trace_stackToJSON(stack) {
    if (!stack || typeof stack !== 'string') {
        return error("StackToJSON(): invalid stack");
    }

    //split the call stack lines into an array
    const lines = stack.toString().split(/\r\n|\n/);

    //The first line should be the call stack message
    const msg = lines[0];
    const jsonStack = [{
        msg
    }];
    for (let n = 1; n < lines.length; n++) {
        let line = lines[n].trim();
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

DKTrace.prototype.lastStackCall = function dk_trace_lastStackCall() {
    const stack = this.stackToJSON(this.getStack());
    let nn;
    for (let n = 1; n < stack.length; n++) {
        if (stack[n].func === "LastStackCall") {
            nn = n + 1;
            break;
        }
    }
    if (!nn)
        return error("LastStackCall(): could not find 'LastStackCall' in the stack");

    let str = "LastStackCall: " + stack[nn].func;
    str += "(<a href='" + stack[nn].filePath + "' target='_blank' style='color:rgb(213,213,213)'>" + stack[nn].file + ":" + stack[nn].lineNum + "</a>)";
    return str;
}

DKTrace.prototype.getArguments = function dk_trace_getArguments(func, getArgValues) {
    let argsString = "";
    let count = 0;
    const fn = window[func];
    if (!fn) {
        console.error(this.lastStackCall() + "<br>" + "  at if(!fn)");
        return "";
    }
    argsString += new RegExp('(?:' + fn.name + '\\s*|^)\\s*\\((.*?)\\)').exec(fn.toString().replace(/\n/g, ''))[1].replace(/\/\*.*?\*\//g, '').replace(/ /g, '');
    if (isStrict()) {
        return argsString;
    }

    if (!getArgValues) {
        return argsString;
    }
    if (!fn.arguments) {
        return argsString;
    }
    let args = argsString.split(",");

    //FIXME: duktape
    console.error("FIXME");
    /*
    for (let val of fn.arguments) {
        if (count > 0) {
            args[count] = " " + args[count];
        }
        args[count] += " = " + val;
        count++;
    }
    argsString = args.toString();
    return argsString;
	*/
}

DKTrace.prototype.getFunctionName = function dk_trace_getFunctionName() {
    return dk.trace.stackToJSON(dk.trace.getStack())[4].func;
}

DKTrace.prototype.getFilename = function dk_trace_getFilename() {
    return dk.trace.stackToJSON(dk.trace.getStack())[4].filePath.split("/").pop();
}
