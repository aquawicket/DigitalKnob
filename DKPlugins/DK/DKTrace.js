"use strict";

window.onerror = function(msg, url, lineNo, columnNo, err) {
    if (!err) {
        return error("window.onerror failed: err variable invalid");
    }
    return error(err);
}

//https://stackoverflow.com/a/49560222/688352
//https://developer.mozilla.org/en-US/docs/Web/API/WindowEventHandlers/onunhandledrejection

window.onunhandledrejection = function(event) {
    return error(event);
}

function DKTrace_StackToConsoleString(arg, deleteTo) {
    let jsonStack;
    if (arg instanceof Error) {
        if (arg.stack) {
            jsonStack = DKTrace_StackToJSON(arg.stack);
        } else if (arg instanceof DOMException) {
            const str = arg.name + " " + arg.message;
            jsonStack = DKTrace_StackToJSON(DKTrace_GetStack(str));
        } else {
            return error("arg is an instance of Error, but it doesn't have a stack");
        }
    } else if (arg instanceof PromiseRejectionEvent) {
        jsonStack = DKTrace_StackToJSON(DKTrace_GetStack(arg.reason));
    } else if (typeof arg === 'string') {
        jsonStack = DKTrace_StackToJSON(DKTrace_GetStack(arg));
    } else {
        return error("StackToConsoleString(): typeof arg invalid: " + typeof arg);
    }

    //deleteTo = 0;
    //Remove calls up to the function specified in deleteTo
    if (deleteTo) {
        for (let n = 1; n < jsonStack.length; n++) {
            if (jsonStack[n].func.includes(deleteTo)) {
                jsonStack.splice(1, n);
            }
        }
    }

    let str = jsonStack[0].msg + "<br>";
    for (let n = 1; n < jsonStack.length; n++) {
        str += "  at " + jsonStack[n].func + " ";
        str += "(<a href='" + jsonStack[n].filePath + "' target='_blank' style='color:rgb(213,213,213)'>" + jsonStack[n].file + ":" + jsonStack[n].lineNum + "</a>)<br>";
    }
    return str;
}

function DKTrace_IsStrict() {
    if (eval("var __temp = null"),
    (typeof __temp === "undefined")) {
        return true;
    }
    return false;
}

function DKTrace_GetStack(msg) {
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

function DKTrace_StackToJSON(stack) {
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

function DKTrace_LastStackCall() {
    const stack = DKTrace_StackToJSON(DKTrace_GetStack());
    let nn;
    for (let n = 1; n < stack.length; n++) {
        if (stack[n].func === "LastStackCall") {
            nn = n + 1;
            break;
        }
    }
    if (!nn) {
        dkconsole.error("LastStackCall(): could not find 'LastStackCall' in the stack");
        return;
    }

    let str = "LastStackCall: " + stack[nn].func;
    str += "(<a href='" + stack[nn].filePath + "' target='_blank' style='color:rgb(213,213,213)'>" + stack[nn].file + ":" + stack[nn].lineNum + "</a>)";
    return str;
}

function DKTrace_GetArguments(func, getArgValues) {
    let argsString = "";
    let count = 0;
    const fn = window[func];
    if (!fn) {
        dkconsole.error(DKTrace_LastStackCall() + "<br>" + "  at if(!fn)");
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

function DKTrace_GetCurrentFunctionName(n) {
    return new Error().stack.split('\n')[2 + n].trim().split(" ")[1];
}
