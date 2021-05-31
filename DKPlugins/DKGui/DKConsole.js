"use strict";
// @https://console.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/console
// https://developer.mozilla.org/en-US/docs/Web/API/Console#outputting_text_to_the_console

dk.console = new DKPlugin("dk_console");

//intercept console and reroute it to xconsole and dk.console
//Example:
// If you use console.log, it will now go to the dk.console AND the browser console.
// If you use dk.console.log, it will only log to the dk.console.
// If you use xconsole.log, it will only log the browser console.
// Note: some messages cannot be withheld from the browser console.

dk.console.setXConsole = function dk_console_setXConsole() {
    xconsole.assert = console.assert;
    xconsole.clear = console.clear;
    xconsole.context = console.context;
    xconsole.count = console.count;
    xconsole.countReset = console.countReset;
    //xconsole.debug = console.debug;
    xconsole.dir = console.dir;
    xconsole.dirxml = console.dirxml;
    //xconsole.error = console.error;
    xconsole.group = console.group;
    xconsole.groupCollapsed = console.groupCollapsed;
    xconsole.groupEnd = console.groupEnd;
    xconsole.info = console.info;
    //xconsole.log = console.log;
    xconsole.memory = console.memory;
    xconsole.profile = console.profile;
    xconsole.profileEnd = console.profileEnd;
    xconsole.table = console.table;
    xconsole.time = console.time;
    xconsole.timeEnd = console.timeEnd;
    xconsole.timeLog = console.timeLog;
    xconsole.timeStamp = console.timeStamp;
    xconsole.trace = console.trace;
    //xconsole.warn = console.warn;
    xconsole.on = true;

    console.assert = function console_assert() {
        xconsole.on && xconsole.assert.apply(this, Array.prototype.slice.call(arguments));
        dk.console.assert && dk.console.assert.apply(this, Array.prototype.slice.call(arguments));
    }
    console.clear = function console_clear() {
        xconsole.on && xconsole.clear.apply(this, Array.prototype.slice.call(arguments));
        dk.console.clear && dk.console.clear.apply(this, Array.prototype.slice.call(arguments));
    }
    console.context = function console_context() {
        xconsole.on && xconsole.context.apply(this, Array.prototype.slice.call(arguments));
        dk.console.context && dk.console.context.apply(this, Array.prototype.slice.call(arguments));
    }
    console.count = function console_count() {
        xconsole.on && xconsole.count.apply(this, Array.prototype.slice.call(arguments));
        dk.console.count && dk.console.count.apply(this, Array.prototype.slice.call(arguments));
    }
    console.countReset = function console_countReset() {
        xconsole.on && xconsole.countReset.apply(this, Array.prototype.slice.call(arguments));
        dk.console.countReset && dk.console.countReset.apply(this, Array.prototype.slice.call(arguments));
    }
    console.debug = function console_debug() {
        xconsole.on && xconsole.debug.apply(this, Array.prototype.slice.call(arguments));
        dk.console.debug && dk.console.debug.apply(this, Array.prototype.slice.call(arguments));
    }
    console.dir = function console_dir() {
        xconsole.on && xconsole.dir.apply(this, Array.prototype.slice.call(arguments));
        dk.console.dir && dk.console.dir.apply(this, Array.prototype.slice.call(arguments));
    }
    console.dirxml = function console_dirxml() {
        xconsole.on && xconsole.dirxml.apply(this, Array.prototype.slice.call(arguments));
        dk.console.dirxml && dk.console.dirxml.apply(this, Array.prototype.slice.call(arguments));
    }
    console.error = function console_error() {
        xconsole.on && xconsole.error.apply(this, Array.prototype.slice.call(arguments));
        dk.console.error && dk.console.error.apply(this, Array.prototype.slice.call(arguments));
    }
    console.group = function console_group() {
        xconsole.on && xconsole.group.apply(this, Array.prototype.slice.call(arguments));
        dk.console.group && dk.console.group.apply(this, Array.prototype.slice.call(arguments));
    }
    console.groupCollapsed = function console_groupCollapsed() {
        xconsole.on && xconsole.groupCollapsed.apply(this, Array.prototype.slice.call(arguments));
        dk.console.groupCollapsed && dk.console.groupCollapsed.apply(this, Array.prototype.slice.call(arguments));
    }
    console.groupEnd = function console_groupEnd() {
        xconsole.on && xconsole.groupEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.groupEnd && dk.console.groupEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.info = function console_info() {
        xconsole.on && xconsole.info.apply(this, Array.prototype.slice.call(arguments));
        dk.console.info && dk.console.info.apply(this, Array.prototype.slice.call(arguments));
    }
    console.log = function console_log() {
        xconsole.on && xconsole.info.apply(this, Array.prototype.slice.call(arguments));
        dk.console.log && dk.console.info.apply(this, Array.prototype.slice.call(arguments));
    }
    //console.memory;
    console.profile = function console_profile() {
        xconsole.on && xconsole.profile.apply(this, Array.prototype.slice.call(arguments));
        dk.console.profile && dk.console.profile.apply(this, Array.prototype.slice.call(arguments));
    }
    console.profileEnd = function console_profileEnd() {
        xconsole.on && xconsole.profileEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.profileEnd && dk.console.profileEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.table = function console_table() {
        xconsole.on && xconsole.table.apply(this, Array.prototype.slice.call(arguments));
        dk.console.table && dk.console.table.apply(this, Array.prototype.slice.call(arguments));
    }
    console.time = function console_time() {
        xconsole.on && xconsole.time.apply(this, Array.prototype.slice.call(arguments));
        dk.console.time && dk.console.time.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeEnd = function console_timeEnd() {
        xconsole.on && xconsole.timeEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeEnd && dk.console.timeEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeLog = function console_timeLog() {
        xconsole.on && xconsole.timeLog.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeLog && dk.console.timeLog.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeStamp = function console_timeStamp() {
        xconsole.on && xconsole.timeStamp.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeStamp && dk.console.timeStamp.apply(this, Array.prototype.slice.call(arguments));
    }
    console.trace = function console_trace() {
        xconsole.on && xconsole.trace.apply(this, Array.prototype.slice.call(arguments));
        dk.console.trace && dk.console.trace.apply(this, Array.prototype.slice.call(arguments));
    }
    console.warn = function console_warn() {
        xconsole.on && xconsole.warn.apply(this, Array.prototype.slice.call(arguments));
        dk.console.warn && dk.console.warn.apply(this, Array.prototype.slice.call(arguments));
    }
}
;

dk.console.init = function dk_console_init() {
    dk.create("DKGui/DKConsole.css");
}

dk.console.end = function dk_console_end() {
    dk.close("DKGui/DKConsole.css");
}

dk.console.create = function dk_console_create(parent, top, bottom, left, right, width, height) {
    dk.console.limit = 100;
    const container = document.createElement("div");
    dk.console.container = container;
    container.setAttribute("dk_console", "container");
    container.style.top = top;
    container.style.bottom = bottom;
    container.style.left = left;
    container.style.right = right;
    container.style.width = width;
    container.style.height = height;
    container.oncontextmenu = function container_oncontextmenu(event) {
        event.preventDefault();
        const menu = dk.menu.createInstance();
        dk.menu.addItem(menu, "Clear console", function DKMenu_Clear() {
            dk.console.clear();
        });
        //dk.menu.addItem(menu, "Cancel", function DKMenu_Cancel() {
        //    console.log("cancel");
        //});
    }
    parent.appendChild(container);

    const div = document.createElement("div");
    div.setAttribute("dk_console", "div");
    div.style.position = "absolute";
    div.style.padding = "0rem";
    div.style.backgroundColor = "rgb(36,36,36)";
    div.style.color = "white";
    div.style.fontColor = "white";
    div.style.top = "0rem";
    div.style.bottom = "20rem";
    div.style.left = "0rem";
    div.style.right = "0rem";
    //div.style.width = "";
    //div.style.height = "";
    div.style.visibility = "visible";
    div.style.overflow = "auto";
    container.appendChild(div);

    const command = document.createElement("input");
    command.setAttribute("dk_console", "command");
    command.type = "text";
    command.style.position = "absolute";
    command.style.left = "0rem";
    command.style.bottom = "0rem";
    command.style.right = "0rem";
    command.style.height = "20rem";
    command.style.width = "100%";
    command.style.backgroundColor = "rgb(150,150,150)";
    command.style.borderColor = "rgb(40,40,40)";
    command.onkeydown = function command_onkeydown(event) {
        if (event.code === "Enter") {
            if (command.value === "clear" || command.value === "cls") {
                dk.console.clear();
                command.value = "";
                return;
            }
            console.debug("RUN Javascript -> " + command.value);
            try {
                eval(command.value);
            } catch (x) {
                console.error("eval failed", x.stack);
            }
            command.value = "";
        }
    }
    container.appendChild(command);

    // https://console.spec.whatwg.org/#logger
    dk.console.Logger = function dl_console_Logger(logLevel, args) {
        // 1. If args is empty, return.
        // 2. Let first be args[0].
        // 3. Let rest be all elements following first in args.
        // 4. If rest is empty, perform Printer(logLevel, « first ») and return.
        // 5. If first does not contain any format specifiers, perform Printer(logLevel, args).
        // 6. Otherwise, perform Printer(logLevel, Formatter(args)).
        // 7. Return undefined.
        const _args = dk.console.ColorChromeConsole(arguments);
        if ((div.scrollHeight - div.scrollTop) < (div.offsetHeight + 1))
            div.scroll = true;
        else
            div.scroll = false;
        const msgDiv = document.createElement("div");
        msgDiv.setAttribute("dk_console", "msgDiv");
        const msgSpan = document.createElement("span");
        //TODO: If the message is the same as the last, just have a count next to the original.
        if (arguments[1] && arguments[1].includes && arguments[1].includes("<anonymous>")) {
            arguments[1] = arguments[1].replace("<anonymous>", "&lt;anonymous&gt;");
        }
        msgSpan.innerHTML = arguments[1];
        msgSpan.setAttribute("dk_console", "msgSpan");

        if (logLevel === "error") {
            msgSpan.style.color = "rgb(255,128,128)";
            msgDiv.style.backgroundColor = "rgb(41,0,0)";
            msgDiv.style.borderColor = "rgb(92,0,0)";
        } else if (logLevel === "warn") {
            msgSpan.style.color = "rgb(255,221,158)";
            msgDiv.style.backgroundColor = "rgb(51,43,0)";
            msgDiv.style.borderColor = "rgb(102,85,0)";
        } else if (logLevel === "debug") {
            msgSpan.style.color = "rgb(77,136,255)";
            msgDiv.style.backgroundColor = "rgb(36,36,36)";
            msgDiv.style.borderColor = "rgb(58,58,58)";
        } else if (logLevel === "green") {
            msgSpan.style.color = "rgb(128,255,128)";
            msgDiv.style.backgroundColor = "rgb(0,41,0)";
            msgDiv.style.borderColor = "rgb(0,92,0)";
        } else {
            msgSpan.style.color = "rgb(213,213,213)";
            msgDiv.style.backgroundColor = "rgb(36,36,36)";
            msgDiv.style.borderColor = "rgb(58,58,58)";
        }

        div.appendChild(msgDiv);
        msgDiv.appendChild(msgSpan);
        div.scroll && (div.scrollTop = div.scrollHeight);

        //Limit the number of stored lines
        if (div.childElementCount > dk.console.limit)
            div.removeChild(div.firstChild);
        return msgDiv.innerHTML;
    }
    // https://console.spec.whatwg.org/#formatter
    dk.console.Formatter = function dk_console_Formatter(args) {
        // 1. Let target be the first element of args.
        // 2. Let current be the second element of args.
        // 3. Find the first possible format specifier specifier, from the left to the right in target.
        //     1. If specifier is %s, let converted be the result of Call(%String%, undefined, « current »).
        //     2. If specifier is %d or %i:
        //          1. If Type(current) is Symbol, let converted be NaN
        //          2. Otherwise, let converted be the result of Call(%parseInt%, undefined, « current, 10 »).
        //     3. If specifier is %f:
        //          1. If Type(current) is Symbol, let converted be NaN
        //          2. Otherwise, let converted be the result of Call(%parseFloat%, undefined, « current »).
        //     4. If specifier is %o, optionally let converted be current with optimally useful formatting applied.
        //     5. If specifier is %O, optionally let converted be current with generic JavaScript object formatting applied.
        //     6. TODO: process %c
        //     7. If any of the previous steps set converted, replace specifier in target with converted.
        //     8. Let result be a list containing target together with the elements of args starting from the third onward.
        // 4. If target does not have any format specifiers left, return result.
        // 5. If result’s size is 1, return result.
        // 6. Return Formatter(result).
    }
    // https://console.spec.whatwg.org/#printer
    dk.console.Printer = function dk_console_Printer(logLevel, args/*[, options]*/){//TODO
    }
    // https://console.spec.whatwg.org/#assert
    dk.console.assert = function dk_console_assert(condition, ...data){
        !condition && (condition = false);   
        // 1. If condition is true, return.
        // 2. Let message be a string without any formatting specifiers indicating generically an assertion failure (such as "Assertion failed").
        // 3. If data is empty, append message to data.
        // 4. Otherwise: 
        //     1. Let first be data[0].
        //     2. If Type(first) is not String, then prepend message to data.
        //     3. Otherwise:
        //        1. Let concat be the concatenation of message, U+003A (:), U+0020 SPACE, and first.
        //        2. Set data[0] to concat.
        //     5. Perform Logger("assert", data).
    }
    // https://console.spec.whatwg.org/#clear
    dk.console.clear = function dk_console_clear() {
        // 1. Empty the appropriate group stack.
        // 2. If possible for the environment, clear the console. (Otherwise, do nothing.)
        div.innerHTML = "";
    }
    dk.console.context;
    // https://console.spec.whatwg.org/#count
    dk.console.count = function dk_console_count(label) {
        !label && (label = "default");
        // 1. Let map be the associated count map.
        // 2. If map[label] exists, set map[label] to map[label] + 1.
        // 3. Otherwise, set map[label] to 1.
        // 4. Let concat be the concatenation of label, U+003A (:), U+0020 SPACE, and ToString(map[label]).
        // 5. Perform Logger("count", « concat »).
    }
    // https://console.spec.whatwg.org/#countReset
    dk.console.countReset = function dk_console_countReset(label) {
        !label && (label = "default");
        // 1. Let map be the associated count map.
        // 2. If map[label] exists, set map[label] to 0.
        // 3. Otherwise:
            // 1. Let message be a string without any formatting specifiers indicating generically that the given label does not have an associated count.
            // 2. Perform Logger("countReset", « message »); 
    }
    // https://console.spec.whatwg.org/#debug
    dk.console.debug = function dk_console_debug(...data) {
        dk.console.Logger("debug", data);
    }
    // https://console.spec.whatwg.org/#dir
    dk.console.dir = function dk_console_dir(item, options) {
        // 1. Let object be item with generic JavaScript object formatting applied.
        // 2. Perform Printer("dir", « object », options).
    }
    // https://console.spec.whatwg.org/#dirxml
    dk.console.dirxml = function dk_console_dirxml(...data) {
        // 1. Let finalList be a new list, initially empty.
        // 2. For each item of data:
        //     1. Let converted be a DOM tree representation of item if possible; otherwise let converted be item with optimally useful formatting applied.
        //     2. Append converted to finalList.
        // 3. Perform Logger("dirxml", finalList).
    }
    // https://console.spec.whatwg.org/#error
    dk.console.error = function dk_console_error(...data) {
        if (!data)
            return warn("data invalid");
        data += "\n" + dk.trace.stackToConsoleString("", "DKPlugin.dk_console_error");
        dk.console.Logger("error", data);
    }
    // https://console.spec.whatwg.org/#group
    dk.console.group = function dk_console_group(...data) {
        // 1. Let group be a new group.
        // 2. If data is not empty, let groupLabel be the result of Formatter(data). Otherwise, let groupLabel be an implementation-chosen label representing a group.
        // 3. Incorporate groupLabel as a label for group.
        // 4. Optionally, if the environment supports interactive groups, group should be expanded by default.
        // 5. Perform Printer("group", « group »).
        // 6. Push group onto the appropriate group stack.
        dk.console.Logger("group", data);
    }
    // https://console.spec.whatwg.org/#groupcollapsed
    dk.console.groupCollapsed = function dk_console_groupCollapsed(...data) {
        // 1. Let group be a new group.
        // 2. If data is not empty, let groupLabel be the result of Formatter(data). Otherwise, let groupLabel be an implementation-chosen label representing a group.
        // 3. Incorporate groupLabel as a label for group.
        // 4. Optionally, if the environment supports interactive groups, group should be collapsed by default.
        // 5. Perform Printer("groupCollapsed", « group »).
        // 6. Push group onto the appropriate group stack.
    }
    // https://console.spec.whatwg.org/#groupend
    dk.console.groupEnd = function dk_console_groupEnd(...data) {
        // Pop the last group from the group stack.
    }
    // https://console.spec.whatwg.org/#info
    dk.console.info = function dk_console_info(...data) {
        dk.console.Logger("info", data);
    }
    // https://console.spec.whatwg.org/#log
    dk.console.log = function dk_console_log(...data) {
        dk.console.Logger("log", data);
    }
    dk.console.memory;
    dk.console.profile;
    dk.console.profileEnd;
    // https://console.spec.whatwg.org/#table
    dk.console.table = function dk_console_table(tabularData, properties){
        // Try to construct a table with the columns of the properties of tabularData (or use properties) and rows of tabularData 
        // and log it with a logLevel of "log". Fall back to just logging the argument if it can’t be parsed as tabular.
    }
    // https://console.spec.whatwg.org/#time
    dk.console.time = function dk_console_time(label) {
        !label && (label = "default");
        // 1. If the associated timer table contains an entry with key label, return, optionally reporting a warning to the console indicating that a timer with label label has already been started.
        // 2. Otherwise, set the value of the entry with key label in the associated timer table to the current time.
    }
    // https://console.spec.whatwg.org/#timeEnd
    dk.console.timeEnd = function dk_console_timeEnd(label) {
        !label && (label = "default");
        // 1. Let timerTable be the associated timer table.
        // 2. Let startTime be timerTable[label].
        // 3. Remove timerTable[label].
        // 4. Let duration be a string representing the difference between the current time and startTime, in an implementation-defined format.
        // 5. Let concat be the concatenation of label, U+003A (:), U+0020 SPACE, and duration.
        // 6. Perform Printer("timeEnd", « concat »).
    }
    // https://console.spec.whatwg.org/#timeLog
    dk.console.timeLog = function dk_console_timeLog(label, ...data) {
        !label && (label = "default");
        // 1. Let timerTable be the associated timer table.
        // 2. Let startTime be timerTable[label].
        // 3. Let duration be a string representing the difference between the current time and startTime, in an implementation-defined format.
        // 4. Let concat be the concatenation of label, U+003A (:), U+0020 SPACE, and duration.
        // 5. Prepend concat to data.
        // 6. Perform Printer("timeLog", data).
    }
    dk.console.timeStamp;
    // https://console.spec.whatwg.org/#trace
    dk.console.trace = function dk_console_trace(...data) {
        // 1. Let trace be some implementation-specific, potentially-interactive representation of the callstack from where this function was called.
        // 2. Optionally, let formattedData be the result of Formatter(data), and incorporate formattedData as a label for trace.
        // 3. Perform Printer("trace", « trace »).
        if (!data)
            return warn("data invalid");
        data += "\n" + dk.trace.stackToConsoleString("", "console.trace");
        dk.console.Logger("trace", data);
    }
    // https://console.spec.whatwg.org/#warn
    dk.console.warn = function dk_console_warn(...data) {
        if (!data)
            return warn("data invalid");
        data += "\n" + dk.trace.stackToConsoleString("", "console.warn");
        dk.console.Logger("warn", data);
    }

    dk.console.setXConsole();
    dk.console.record = dk.x.record
    delete dk.x;
    //restore the record of messages from the program beginning
    for (let n = 0; n < dk.console.record.length; n++) {
        const lvl = Object.keys(dk.console.record[n])[0];
        const msg = dk.console.record[n][lvl];
        dk.console[lvl](msg);
    }
    delete dk.console.record;
    setTimeout(function() {
        div.scroll && (div.scrollTop = div.scrollHeight);
    }, 100);

    return container;
}

dk.console.SpanFilter = function dk_console_SpanFilter(args) {
    let argArray = [];
    if (args.length) {
        const startTagRe = /<span\s+style=(['"])([^'"]*)\1\s*>/gi;
        const endTagRe = /<\/span>/gi;
        let reResultArray;
        if (typeof args[0].replace !== "function")
            return args;
        argArray.push(args[0].replace(startTagRe, '%c').replace(endTagRe, '%c'));
        while (reResultArray = startTagRe.exec(args[0])) {
            argArray.push(reResultArray[2]);
            argArray.push('');
        }
        // pass through subsequent args since chrome dev tools does not (yet) support console.log styling of the following form: console.log('%cBlue!', 'color: blue;', '%cRed!', 'color: red;');
        for (let n = 1; n < args.length; n++)
            argArray.push(args[n]);
    }
    return argArray;
}

dk.console.ColorChromeConsole = function dk_console_ColorChromeConsole(args) {
    let argArray = [];
    argArray.push("%c " + args[0]);
    if (args[1] === "red")
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(41,0,0)", "color: rgb(255,128,128)"].join(";"));
    if (args[1] === "yellow")
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(51,43,0)", "color: rgb(255,221,158)"].join(";"));
    if (args[1] === "blue") 
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(36,36,36)", "color: rgb(77,136,255)"].join(";"));
    if (args[1] === "green")
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(0,41,0)", "color: rgb(128,255,128)"].join(";"));
    return argArray;
}
