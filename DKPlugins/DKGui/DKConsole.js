"use strict";
// @https://console.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/console
// https://developer.mozilla.org/en-US/docs/Web/API/Console#outputting_text_to_the_console

dk.console = new Object;

//intercept console and reroute it to xconsole and dk.console
//Example:
// If you use console.log, it will now go to the dk.console AND the browser console.
// If you use dk.console.log, it will only log to the dk.console.
// If you use xconsole.log, it will only log the browser console.
// Note: some messages cannot be withheld from the browser console.
const xconsole = new Object;
(function() {
    xconsole.on = true;
    xconsole.assert = console.assert;
    xconsole.clear = console.clear;
    xconsole.context = console.context;
    xconsole.count = console.count;
    xconsole.countReset = console.countReset;
    xconsole.debug = console.debug;
    xconsole.dir = console.dir;
    xconsole.dirxml = console.dirxml;
    xconsole.error = console.error;
    xconsole.group = console.group;
    xconsole.groupCollapsed = console.groupCollapsed;
    xconsole.groupEnd = console.groupEnd;
    xconsole.info = console.info;
    xconsole.log = console.log;
    xconsole.memory = console.memory;
    xconsole.profile = console.profile;
    xconsole.profileEnd = console.profileEnd;
    xconsole.table = console.table;
    xconsole.time = console.time;
    xconsole.timeEnd = console.timeEnd;
    xconsole.timeLog = console.timeLog;
    xconsole.timeStamp = console.timeStamp;
    xconsole.trace = console.trace;
    xconsole.warn = console.warn;

    console.assert = function() {
        xconsole.on && xconsole.assert.apply(this, Array.prototype.slice.call(arguments));
        dk.console.assert && dk.console.assert.apply(this, Array.prototype.slice.call(arguments));
    }
    console.clear = function() {
        xconsole.on && xconsole.clear.apply(this, Array.prototype.slice.call(arguments));
        dk.console.clear && dk.console.clear.apply(this, Array.prototype.slice.call(arguments));
    }
    console.context = function() {
        xconsole.on && xconsole.context.apply(this, Array.prototype.slice.call(arguments));
        dk.console.context && dk.console.context.apply(this, Array.prototype.slice.call(arguments));
    }
    console.count = function() {
        xconsole.on && xconsole.count.apply(this, Array.prototype.slice.call(arguments));
        dk.console.count && dk.console.count.apply(this, Array.prototype.slice.call(arguments));
    }
    console.countReset = function() {
        xconsole.on && xconsole.countReset.apply(this, Array.prototype.slice.call(arguments));
        dk.console.countReset && dk.console.countReset.apply(this, Array.prototype.slice.call(arguments));
    }
    console.debug = function() {
        xconsole.on && xconsole.debug.apply(this, Array.prototype.slice.call(arguments));
        dk.console.debug && dk.console.debug.apply(this, Array.prototype.slice.call(arguments));
    }
    console.dir = function() {
        xconsole.on && xconsole.dir.apply(this, Array.prototype.slice.call(arguments));
        dk.console.dir && dk.console.dir.apply(this, Array.prototype.slice.call(arguments));
    }
    console.dirxml = function() {
        xconsole.on && xconsole.dirxml.apply(this, Array.prototype.slice.call(arguments));
        dk.console.dirxml && dk.console.dirxml.apply(this, Array.prototype.slice.call(arguments));
    }
    console.error = function() {
        xconsole.on && xconsole.error.apply(this, Array.prototype.slice.call(arguments));
        dk.console.error && dk.console.error.apply(this, Array.prototype.slice.call(arguments));
    }
    console.group = function() {
        xconsole.on && xconsole.group.apply(this, Array.prototype.slice.call(arguments));
        dk.console.group && dk.console.group.apply(this, Array.prototype.slice.call(arguments));
    }
    console.groupCollapsed = function() {
        xconsole.on && xconsole.groupCollapsed.apply(this, Array.prototype.slice.call(arguments));
        dk.console.groupCollapsed && dk.console.groupCollapsed.apply(this, Array.prototype.slice.call(arguments));
    }
    console.groupEnd = function() {
        xconsole.on && xconsole.groupEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.groupEnd && dk.console.groupEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.info = function() {
        xconsole.on && xconsole.info.apply(this, Array.prototype.slice.call(arguments));
        dk.console.info && dk.console.info.apply(this, Array.prototype.slice.call(arguments));
    }
    console.log = function() {
        xconsole.on && xconsole.log.apply(this, Array.prototype.slice.call(arguments));
        dk.console.log && dk.console.log.apply(this, Array.prototype.slice.call(arguments));
    }
    //console.memory;
    console.profile = function() {
        xconsole.on && xconsole.profile.apply(this, Array.prototype.slice.call(arguments));
        dk.console.profile && dk.console.profile.apply(this, Array.prototype.slice.call(arguments));
    }
    console.profileEnd = function() {
        xconsole.on && xconsole.profileEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.profileEnd && dk.console.profileEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.table = function() {
        xconsole.on && xconsole.table.apply(this, Array.prototype.slice.call(arguments));
        dk.console.table && dk.console.table.apply(this, Array.prototype.slice.call(arguments));
    }
    console.time = function() {
        xconsole.on && xconsole.time.apply(this, Array.prototype.slice.call(arguments));
        dk.console.time && dk.console.time.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeEnd = function() {
        xconsole.on && xconsole.timeEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeEnd && dk.console.timeEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeLog = function() {
        xconsole.on && xconsole.timeLog.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeLog && dk.console.timeLog.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeStamp = function() {
        xconsole.on && xconsole.timeStamp.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeStamp && dk.console.timeStamp.apply(this, Array.prototype.slice.call(arguments));
    }
    console.trace = function() {
        xconsole.on && xconsole.trace.apply(this, Array.prototype.slice.call(arguments));
        dk.console.trace && dk.console.trace.apply(this, Array.prototype.slice.call(arguments));
    }
    console.warn = function() {
        xconsole.on && xconsole.warn.apply(this, Array.prototype.slice.call(arguments));
        dk.console.warn && dk.console.warn.apply(this, Array.prototype.slice.call(arguments));
    }
}());

dk.console.create = function dk_console_create(parent, id, top, bottom, left, right, width, height) {
    dk.create("DKGui/DKConsole.css");
    dk.console.limit = 100;
    const container = document.createElement("div");
    dk.console.container = container;
    container.setAttribute("dk_console","container");
    container.id = id;
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
    div.setAttribute("dk_console","div");
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
    command.setAttribute("dk_console","command");
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
        const key = event.charCode || event.keyCode;
        if (key === 13) {
            //enter
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

    dk.console.Logger = function dl_console_Logger(){
        const args = dk.console.ColorChromeConsole(arguments);

        const msgDiv = document.createElement("div");
        msgDiv.setAttribute("dk_console","msgDiv");
        msgDiv.style.width = "100%";
        msgDiv.style.fontSize = "12rem";
        msgDiv.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
        msgDiv.style.whiteSpace = "pre-wrap";
        msgDiv.style.boxSizing = "border-box";
        msgDiv.style.padding = "2rem";
        msgDiv.style.paddingLeft = "20rem";
        msgDiv.style.borderStyle = "solid";
        msgDiv.style.borderWidth = "1rem";
        msgDiv.style.borderTopWidth = "0rem";
        msgDiv.style.borderLeftWidth = "0rem";
        msgDiv.style.borderRightWidth = "0rem";

        const msgSpan = document.createElement("span");
        //msgSpan.className = "dkconsole";
        //TODO: If the message is the same as the last, just have a count next to the original. 
        msgSpan.innerHTML = arguments[0];
        msgSpan.setAttribute("dk_console","msgSpan");
        
        if (arguments[1] === "red") {
            msgSpan.style.color = "rgb(255,128,128)";
            msgDiv.style.backgroundColor = "rgb(41,0,0)";
            msgDiv.style.borderColor = "rgb(92,0,0)";
        } else if (arguments[1] === "yellow") {
            msgSpan.style.color = "rgb(255,221,158)";
            msgDiv.style.backgroundColor = "rgb(51,43,0)";
            msgDiv.style.borderColor = "rgb(102,85,0)";
        } else if (arguments[1] === "blue") {
            msgSpan.style.color = "rgb(77,136,255)";
            msgDiv.style.backgroundColor = "rgb(36,36,36)";
            msgDiv.style.borderColor = "rgb(58,58,58)";
        } else if (arguments[1] === "green") {
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
        div.scrollTop = div.scrollHeight;

        //Limit the number of stored lines
        if (div.childElementCount > dk.console.limit) {
            div.removeChild(div.firstChild);
        }

        return msgDiv.innerHTML;
    }

    //Set up dk.console variables
    dk.console.assert;
    dk.console.clear = function() {
        div.innerHTML = "";
    }
    dk.console.context;
    dk.console.count;
    dk.console.countReset;
    dk.console.debug = function dk_console_debug(str) {
        dk.console.Logger(str, "blue");
    }
    dk.console.dir;
    dk.console.dirxml;
    dk.console.error = function dk_console_error(str) {
        if (!str)
            return warn("str invalid");
        const newstr = str+"\n"+dk.trace.stackToConsoleString("", "console.error");
        dk.console.Logger(newstr, "red");
    }
    dk.console.group = function dk_console_group(str, style) {
        dk.console.Logger(str, style);
    }
    dk.console.groupCollapsed;
    dk.console.groupEnd;
    dk.console.info = function dk_console_info(str, style) {
        dk.console.Logger(str, style);
    }
    dk.console.log = function(str, style) {
        dk.console.Logger(str, style);
    }
    dk.console.memory;
    dk.console.profile;
    dk.console.profileEnd;
    dk.console.table;
    dk.console.time;
    dk.console.timeEnd;
    dk.console.timeLog;
    dk.console.timeStamp;
    dk.console.trace = function dk_console_trace(str, style) {
        if (!str)
            return warn("str invalid");
        const newstr = str+"\n"+dk.trace.stackToConsoleString("", "console.trace");
        dk.console.Logger(newstr);
    }
    dk.console.warn = function dk_console_warn(str) {
        if (!str)
            return warn("str invalid");
        const newstr = str+"\n"+dk.trace.stackToConsoleString("", "console.warn");
        dk.console.Logger(newstr, "yellow");
    }

    return container;
}

dk.console.SpanFilter = function(args) {
    let argArray = [];
    if (args.length) {
        const startTagRe = /<span\s+style=(['"])([^'"]*)\1\s*>/gi;
        const endTagRe = /<\/span>/gi;
        let reResultArray;
        if (typeof args[0].replace !== "function") {
            return args;
        }
        argArray.push(args[0].replace(startTagRe, '%c').replace(endTagRe, '%c'));
        while (reResultArray = startTagRe.exec(args[0])) {
            argArray.push(reResultArray[2]);
            argArray.push('');
        }
        // pass through subsequent args since chrome dev tools does not (yet) support console.log styling of the following form: console.log('%cBlue!', 'color: blue;', '%cRed!', 'color: red;');
        for (let n = 1; n < args.length; n++) {
            argArray.push(args[n]);
        }
    }
    return argArray;
}

dk.console.ColorChromeConsole = function(args) {
    let argArray = [];
    argArray.push("%c " + args[0]);
    if (args[1] === "red") {
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(41,0,0)", "color: rgb(255,128,128)"].join(";"));
    }
    if (args[1] === "yellow") {
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(51,43,0)", "color: rgb(255,221,158)"].join(";"));
    }
    if (args[1] === "blue") {
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(36,36,36)", "color: rgb(77,136,255)"].join(";"));
    }
    if (args[1] === "green") {
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(0,41,0)", "color: rgb(128,255,128)"].join(";"));
    }
    return argArray;
}
