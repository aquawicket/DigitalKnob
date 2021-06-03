//"use strict";
// @https://console.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/console
// https://developer.mozilla.org/en-US/docs/Web/API/Console#outputting_text_to_the_console
// https://developer.chrome.com/docs/devtools/console/api/

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

dk.console.init = function dk_console_init() {
    dk.create("DKGui/DKConsole.css");
}

dk.console.end = function dk_console_end() {
    dk.close("DKGui/DKConsole.css");
}

dk.console.create = function dk_console_create(parent, top, bottom, left, right, width, height) {
    dk.console.limit = 100;

    dk.console.container = dk.gui.createTag("div", parent, {
        style: {
            top: top,
            bottom: bottom,
            left: left,
            right: right,
            width: width,
            height: height
        },
        oncontextmenu: function container_oncontextmenu(event) {
            event.preventDefault();
            const menu = dk.menu.createInstance();
            dk.menu.addItem(menu, "Clear console", function DKMenu_Clear() {
                dk.console.clear();
            });
        }
    });
    dk.console.container.setAttribute("dk_console", "container");

    dk.console.toolbar = dk.gui.createTag("div", dk.console.container, {});
    dk.console.toolbar.setAttribute("dk_console", "toolbar");

    dk.console.logDiv = dk.gui.createTag("div", dk.console.container, {});
    dk.console.logDiv.setAttribute("dk_console", "logDiv");

    dk.console.commandDiv = dk.gui.createTag("div", dk.console.logDiv, {});
    dk.console.commandDiv.setAttribute("dk_console", "commandDiv");

    dk.console.command = dk.gui.createTag("input", dk.console.commandDiv, {
        type: "text",
        onkeydown: function command_onkeydown(event) {
            if (event.code === "Enter") {
                if (event.currentTarget.value === "clear" || event.currentTarget.value === "cls") {
                    dk.console.clear();
                    event.currentTarget.value = "";
                    return;
                }
                //console.debug("RUN Javascript -> " + event.currentTarget.value);
                try {
                    eval(event.currentTarget.value);
                } catch (x) {
                    console.error("eval failed");
                }
                event.currentTarget.value = "";
            }
        }
    }).setAttribute("dk_console", "command");

    //FIXME: initiating before dk.console.commandDiv
    /*
    dk.console.logDiv.onclick = function() {
        setTimeout(function() {
            dk.console.command.focus();
        }, 100);
    }
    */

    dk.gui.createTag("img", dk.console.commandDiv, {
        src: "DKGui/cmndArrow.png",
    }).setAttribute("dk_console", "cmnd");

    // https://console.spec.whatwg.org/#logger
    dk.console.Logger = function dl_console_Logger(logLevel, args) {
        if (!args)
            return;
        const [first,...rest] = args;
        if (!rest) {
            dk.console.Printer(legLevel, first);
            return;
        }
        if (!first)
            return error("first invalid");
        if (first.includes && !first.includes("%"))
            dk.console.Printer(logLevel, args);
        else
            dk.console.Printer(logLevel, dk.console.Formatter(args));
        return;
    }

    // https://console.spec.whatwg.org/#formatter
    dk.console.Formatter = function dk_console_Formatter(args) {
        if (!args.length)
            return;
        let target = args[0];
        if (!target.indexOf)
            return args;
        const current = args[1];
        const index = target.indexOf("%");
        if (index <= -1)
            return args;
        const specifier = target.substring(index, index + 2);
        let converted = undefined;
        if (specifier === "%s")
            converted = current.toString();
        if (specifier === "%d" || specifier === "%i") {
            if (typeof current === "symbol")
                converted = NaN;
            else
                converted = parseInt(current, 10);
        }
        if (specifier === "%f") {
            if (typeof current === "symbol")
                converted = NaN;
            else
                converted = parseFloat(current, 10);
        }
        // 4. If specifier is %o, optionally let converted be current with optimally useful formatting applied.
        if (specifier === "%o") {// TODO
        }
        // 5. If specifier is %O, optionally let converted be current with generic JavaScript object formatting applied.
        if (specifier === "%O") {// TODO
        }
        // 6. TODO: process %c
        if (specifier === "%c") {
            if (typeof current === "symbol")
                converted = NaN;
            else
                converted = "<a style='" + current.toString() + "'>";
        }
        if (converted)
            target = target.replace(specifier, converted);
        const result = [];
        result.push(target);
        let n = 2;
        while (args[n]) {
            result.push(args[n]);
            n++;
        }
        const index2 = target.indexOf("%");
        if (index2 <= -1)
            return result;
        if (result.length === 1)
            return result;
        return Formatter(result);
    }

    // https://console.spec.whatwg.org/#printer
    dk.console.Printer = function dk_console_Printer(logLevel, args) {
        //const _args = dk.console.ColorChromeConsole(arguments);
        if ((dk.console.logDiv.scrollHeight - dk.console.logDiv.scrollTop) < (dk.console.logDiv.offsetHeight + 1))
            dk.console.logDiv.scroll = true;
        else
            dk.console.logDiv.scroll = false;
        const msgDiv = document.createElement("div");
        msgDiv.setAttribute("dk_console", "msgDiv");
        if (logLevel !== "group" && logLevel !== "groupCollapsed" && dk.console.currentGroup) {
            msgDiv.setAttribute("group", dk.console.currentGroup.id);
            msgDiv.style.display = dk.console.currentGroup.display;
        }
        const magIcon = dk.gui.createTag("div", msgDiv, {
            style: {
                position: "absolute",
                left: "6rem",
                width: "12rem",
                height: "12rem",
            }
        })

        const msgSpan = document.createElement("span");
        msgSpan.setAttribute("dk_console", "msgSpan");

        //If the message is the same as the last, just increase a count next to the original.
        const lastMsgDiv = dk.console.logDiv.lastChild.previousSibling;
        if (lastMsgDiv) {
            const lastMsgSpan = lastMsgDiv.firstChild.nextSibling;
            if ((arguments[1] == lastMsgSpan.innerText) || (arguments[1].includes && arguments[1].includes(lastMsgSpan.innerText))) {
                const lastMsgIcon = lastMsgDiv.firstChild;
                if (!lastMsgIcon.childElementCount) {
                    dk.gui.createTag("img", lastMsgIcon, {
                        src: "DKGui/circle.png",
                        style: {
                            height: "12rem",
                            verticalAlign: "middle"
                        }
                    });
                    const count = dk.gui.createTag("div", lastMsgIcon, {
                        style: {
                            position: "absolute",
                            top: "50%",
                            left: "50%",
                            transform: "translate(-50%, -50%)",
                            color: "black"
                        },
                        innerHTML: 2
                    });
                } else {
                    const total = (parseInt(lastMsgIcon.firstChild.nextSibling.innerHTML) + 1);
                    lastMsgIcon.firstChild.nextSibling.innerHTML = total.toString();
                }
                return;
            }
        }

        if (arguments[1] && arguments[1].includes && arguments[1].includes("<anonymous>")) {
            arguments[1] = arguments[1].replace("<anonymous>", "&lt;anonymous&gt;");
        }
        if (logLevel === "group" || logLevel === "groupCollapsed") {
            const group = arguments[1];
            if (arguments.length === 3)
                logLevel = arguments[2][1];
            const groupArrow = dk.gui.createTag("img", msgSpan, {
                src: "DKGui/groupArrow2.png",
                style: {
                    height: "6rem",
                    paddingRight: "4rem"
                }
            });
            if (group.display === "none") {
                groupArrow.setAttribute("src", "DKGui/groupArrow1.png");
            }
            dk.gui.createTag("a", msgSpan, {}).innerHTML = group.label[0];
            msgDiv.onclick = function() {
                if (group.display === "block") {
                    groupArrow.setAttribute("src", "DKGui/groupArrow1.png");
                    group.display = "none";
                } else {
                    groupArrow.setAttribute("src", "DKGui/groupArrow2.png");
                    group.display = "block";
                }
                const elements = dk.console.logDiv.querySelectorAll("[group='" + group.id + "']");
                for (let n = 0; n < elements.length; n++)
                    elements[n].style.display = group.display;
            }

        } else {
            msgSpan.innerHTML = arguments[1];
        }

        if (logLevel === "error") {
            msgDiv.setAttribute("dk_console", "msgDivError");
            msgSpan.setAttribute("dk_console", "msgSpanError");
        }
        if (logLevel === "warn") {
            msgDiv.setAttribute("dk_console", "msgDivWarn");
            msgSpan.setAttribute("dk_console", "msgSpanWarn");
        }
        if (logLevel === "debug") {
            msgDiv.setAttribute("dk_console", "msgDivDebug");
            msgSpan.setAttribute("dk_console", "msgSpanDebug");
        }
        if (logLevel === "green") {
            msgDiv.setAttribute("dk_console", "msgDivGreen");
            msgSpan.setAttribute("dk_console", "msgSpanGreen");
        }

        dk.console.logDiv.appendChild(msgDiv);
        dk.console.logDiv.appendChild(dk.console.commandDiv);
        msgDiv.appendChild(msgSpan);

        //Limit the number of stored lines
        if (dk.console.logDiv.childElementCount > dk.console.limit)
            dk.console.logDiv.removeChild(dk.console.logDiv.firstChild);

        setTimeout(function() {
            dk.console.logDiv.scrollTop = (dk.console.logDiv.scrollHeight - dk.console.logDiv.style.height);
        }, 0);

        return msgDiv.innerHTML;
    }

    // https://console.spec.whatwg.org/#assert
    dk.console.assert = function dk_console_assert(condition, ...data) {
        !condition && (condition = false);
        if (condition)
            return;
        // 2. Let message be a string without any formatting specifiers indicating generically an assertion failure (such as "Assertion failed").
        const message = "Assertion failed";
        // 3. If data is empty, append message to data.
        if (!data) {
            data = message;
        } else {
            // 4. Otherwise: 
            //     1. Let first be data[0].
            const first = data[0];
            //     2. If Type(first) is not String, then prepend message to data.
            if (typeof first !== "String")
                data = message + "\n" + data;
            else {//     3. Otherwise:
            //        1. Let concat be the concatenation of message, U+003A (:), U+0020 SPACE, and first.
            //        2. Set data[0] to concat.
            }
            //     5. Perform Logger("assert", data).
            dk.console.Logger("assert", data);
        }
    }

    // https://console.spec.whatwg.org/#clear
    dk.console.clear = function dk_console_clear() {
        // 1. Empty the appropriate group stack.
        dk.console.groupStack = [];
        // 2. If possible for the environment, clear the console. (Otherwise, do nothing.)
        const backup = dk.console.commandDiv;
        dk.console.logDiv.innerHTML = "";
        dk.console.logDiv.appendChild(backup);
    }

    //dk.console.context;

    // https://console.spec.whatwg.org/#count
    dk.console.count = function dk_console_count(label) {
        !label && (label = "default");
        // 1. Let map be the associated count map.
        !dk.console.map && (dk.console.map = new Object);
        // 2. If map[label] exists, set map[label] to map[label] + 1.
        if (dk.console.map[label])
            dk.console.map[label] = dk.console.map[label] + 1;
            // 3. Otherwise, set map[label] to 1.
        else
            dk.console.map[label] = 1;
        // 4. Let concat be the concatenation of label, U+003A (:), U+0020 SPACE, and ToString(map[label]).
        const concat = label + ":" + " " + toString(dk.console.map[label]);
        // 5. Perform Logger("count", concat).
        dk.console.Logger("count", concat);
    }

    // https://console.spec.whatwg.org/#countReset
    dk.console.countReset = function dk_console_countReset(label) {
        !label && (label = "default");
        // 1. Let map be the associated count map.
        !dk.console.map && (dk.console.map = new Object);
        // 2. If map[label] exists, set map[label] to 0.
        if (dk.console.map[label]) {
            dk.console.map[label] = 0;
        }// 3. Otherwise:
        else {
            // 1. Let message be a string without any formatting specifiers indicating generically that the given label does not have an associated count.
            // 2. Perform Logger("countReset", message); 
            dk.console.Logger("countReset", message);
        }
    }

    // https://console.spec.whatwg.org/#debug
    dk.console.debug = function dk_console_debug(...data) {
        dk.console.Logger("debug", data);
    }

    // https://console.spec.whatwg.org/#dir
    dk.console.dir = function dk_console_dir(item, options) {// 1. Let object be item with generic JavaScript object formatting applied.
    // 2. Perform Printer("dir", object, options).
    }

    // https://console.spec.whatwg.org/#dirxml
    dk.console.dirxml = function dk_console_dirxml(...data) {// 1. Let finalList be a new list, initially empty.
    // 2. For each item of data:
    //     1. Let converted be a DOM tree representation of item if possible; otherwise let converted be item with optimally useful formatting applied.
    //     2. Append converted to finalList.
    // 3. Perform Logger("dirxml", finalList).
    }

    // https://console.spec.whatwg.org/#error
    dk.console.error = function dk_console_error(...data) {
        if (!data)
            return warn("data invalid");
        dk.console.groupCollapsed(data, "error");
        const stack = dk.trace.stackToConsoleString("", "console.error");
        dk.console.Logger("error", stack);
        dk.console.groupEnd();
    }

    //////  GROUP STACK
    dk.console.groupStack = [];

    // https://console.spec.whatwg.org/#group
    dk.console.group = function dk_console_group(...data) {

        let n = 0;
        while (dk.console.logDiv.querySelector("[group='" + n + "']"))
            n++;
        // 1. Let group be a new group.
        const group = {
            label: "dk.console.group",
            display: "block",
            id: n
        }
        // 2. If data is not empty, let groupLabel be the result of Formatter(data). Otherwise, let groupLabel be an implementation-chosen label representing a group.
        if (data)
            group.label = dk.console.Formatter(data[0]);
        // 3. Incorporate groupLabel as a label for group.
        dk.console.currentGroup = group;
        // 4. Optionally, if the environment supports interactive groups, group should be expanded by default.
        // 5. Perform Printer("group", group).
        dk.console.Printer("group", group, data);
        // 6. Push group onto the appropriate group stack.
        dk.console.groupStack.push(group);
    }

    // https://console.spec.whatwg.org/#groupcollapsed
    dk.console.groupCollapsed = function dk_console_groupCollapsed(...data) {

        let n = 0;
        while (dk.console.logDiv.querySelector("[group='" + n + "']"))
            n++;
        // 1. Let group be a new group.
        const group = {
            label: "dk.console.group",
            display: "none",
            id: n
        }
        // 2. If data is not empty, let groupLabel be the result of Formatter(data). Otherwise, let groupLabel be an implementation-chosen label representing a group.
        if (data)
            group.label = dk.console.Formatter(data);
        // 3. Incorporate groupLabel as a label for group.
        dk.console.currentGroup = group;
        // 4. Optionally, if the environment supports interactive groups, group should be expanded by default.
        // 5. Perform Printer("group", group).
        dk.console.Printer("groupCollapsed", group, data);
        // 6. Push group onto the appropriate group stack.
        dk.console.groupStack.push(group);
    }

    // https://console.spec.whatwg.org/#groupend
    dk.console.groupEnd = function dk_console_groupEnd(...data) {
        // Pop the last group from the group stack.
        dk.console.groupStack.pop();
        if (dk.console.groupStack.length)
            dk.console.currentGroup = dk.console.groupStack[dk.console.groupStack.length - 1];
        else
            dk.console.currentGroup = null;
    }

    // https://console.spec.whatwg.org/#info
    dk.console.info = function dk_console_info(...data) {
        dk.console.Logger("info", data);
    }

    // https://console.spec.whatwg.org/#log
    dk.console.log = function dk_console_log(...data) {
        dk.console.Logger("log", data);
    }

    //dk.console.memory;
    //dk.console.profile;
    //dk.console.profileEnd;

    // https://console.spec.whatwg.org/#table
    dk.console.table = function dk_console_table(tabularData, properties) {// Try to construct a table with the columns of the properties of tabularData (or use properties) and rows of tabularData 
    // and log it with a logLevel of "log". Fall back to just logging the argument if it can be parsed as tabular.
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
        // 6. Perform Printer("timeEnd", concat).
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

    //dk.console.timeStamp;

    // https://console.spec.whatwg.org/#trace
    dk.console.trace = function dk_console_trace(...data) {
        // 1. Let trace be some implementation-specific, potentially-interactive representation of the callstack from where this function was called.
        // 2. Optionally, let formattedData be the result of Formatter(data), and incorporate formattedData as a label for trace.
        // 3. Perform Printer("trace", trace).
        if (!data)
            return warn("data invalid");
        dk.console.group(data);
        const stack = dk.trace.stackToConsoleString("", "console.trace");
        dk.console.Logger("info", stack);
        dk.console.groupEnd();
    }

    // https://console.spec.whatwg.org/#warn
    dk.console.warn = function dk_console_warn(...data) {
        if (!data)
            return warn("data invalid");
        dk.console.groupCollapsed(data, "warn");
        const stack = dk.trace.stackToConsoleString("", "console.warn");
        dk.console.Logger("warn", stack);
        dk.console.groupEnd();
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
    return dk.console.container;
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

/*
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
*/
