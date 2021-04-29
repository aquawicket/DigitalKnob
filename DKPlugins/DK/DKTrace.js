"use strict";

dk.trace = new Object;

window.onerror = function(msg, url, lineNo, columnNo, err) {
    if (!err && !msg)
        return error("window.onerror failed: err and msg variables invalid");
    err = err ? err : msg;
    return error(err);
}

//https://stackoverflow.com/a/49560222/688352
//https://developer.mozilla.org/en-US/docs/Web/API/WindowEventHandlers/onunhandledrejection
window.onunhandledrejection = function(event) {
    return error(event);
}

dk.trace.editFile = function dk_trace_editFile(file) {
    /*
    dk.create("DKNotepad/DKNotepad.js", function dk_create_callback() {
        dk.frame.create(byId("DKNotepad/DKNotepad.html"));
        dk.notepad.open(file);
    });
    */

    file = file.replace("file:///", "");
    file = file.replaceAll("/", "\\");
    file = file.replace(dk.file.onlineAssets, "");

    const createPopup = function() {
        dk.codemirror.create();
        dk.codemirror.open(file);
        dk.codemirror.setSelection(10);
    }

    if (!dk.getObjects().includes("DKCodeMirror/DKCodeMirror.js")) {
        dk.create("DKCodeMirror/DKCodeMirror.js", function() {
            createPopup();
        });
    } else
        createPopup();

}
dk.trace.stackToConsoleString = function dk_trace_stackToConsoleString(arg, deleteTo) {
    let jsonStack;
    let headerMsg = false;
    if (arg instanceof Error) {
        if (arg.stack) {
            headerMsg = true;
            jsonStack = this.stackToJSON(arg.stack);
        } else if (arg instanceof DOMException) {
            headerMsg = true;
            const str = arg.name + " " + arg.message;
            jsonStack = stackToJSON(this.getStack(str));
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
    if (deleteTo) {
        for (let n = 1; n < jsonStack.length; n++) {
            if (jsonStack[n].func === deleteTo) {
                jsonStack.splice(1, n);
            }
        }
    }

    let str;
    headerMsg ? str = jssonStack[0] : str = "";
    for (let n = 1; n < jsonStack.length; n++) {
        str += "  at " + jsonStack[n].func + " ";
        str += "(<a href='#' onClick='dk.trace.editFile(\"" + jsonStack[n].filePath + "\")' style='color:rgb(213,213,213)'>" + jsonStack[n].file + ":" + jsonStack[n].lineNum + "</a>)<br>";
    }

    return str;
}

dk.trace.isStrict = function dk_trace_isStrict() {
    if (eval("var __temp = null"),
    (typeof __temp === "undefined")) {
        return true;
    }
    return false;
}

dk.trace.getStack = function dk_trace_getStack(msg) {
    const e = new Error(msg);
    if (!e.stack) {
        try {
            // old browsers need the Error thrown to fill the stack
            throw e;
        } catch (e) {
            if (!e.stack) {
                return 0;
                // browser too old
            }
        }
    }
    return e.stack;
}

dk.trace.stackToJSON = function dk_trace_stackToJSON(stack) {
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
        //FIXME: the original line should not be altered,
        //altering the line could mess up the extraction
        let line = lines[n].trim();
        line = line.replace("at ", "");
        line = line.replace("(", "");
        line = line.replace(")", "");

        const func = line.split(" ").shift();
        line = line.replace(func + " ", "");

        // some stack lines don't have a valid function name
        /*
        if (IsValidVarName(func)) {//func = "<i>anonymous</i>";
        } else {
            line = line.replace(func, "");
        }
        */

        const charNum = line.split(":").pop();
        line = line.replace(":" + charNum, "");

        const lineNum = line.split(":").pop();
        line = line.replace(":" + lineNum, "");

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

dk.trace.lastStackCall = function dk_trace_lastStackCall() {
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

dk.trace.getArguments = function dk_trace_getArguments(func, getArgValues) {
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
    for (let val of fn.arguments) {
        if (count > 0) {
            args[count] = " " + args[count];
        }
        args[count] += " = " + val;
        count++;
    }
    argsString = args.toString();
    return argsString;
}

dk.trace.getFunctionName = function dk_trace_getFunctionName() {
    return dk.trace.stackToJSON(dk.trace.getStack())[4].func;
}

dk.trace.getFilename = function dk_trace_getFilename() {
    return dk.trace.stackToJSON(dk.trace.getStack())[4].filePath.split("/").pop();
}
