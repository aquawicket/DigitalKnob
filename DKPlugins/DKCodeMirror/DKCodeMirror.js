"use strict";

DKCodeMirror.prototype = Object.create(DKPlugin.prototype);
function DKCodeMirror(identifier) {
    return DKPlugin.call(this, identifier);
}
dk.codemirror = new DKCodeMirror("DKCodeMirror");
dk.codemirror = new DKPlugin("dk_codemirror");

dk.codemirror.init = function dk_codemirror_init(dk_codemirror_init_callback) {
    dk.create("DKCodeMirror/lib/codemirror.js", function() {
        dk.create("DKCodeMirror/lib/codemirror.css", function() {
            dk.create("DKCodeMirror/theme/abcdef.css", function() {
                dk.create("DKCodeMirror/DKCodeMirror.css", function() {
                    dk.create("DKCodeMirror/mode/javascript/javascript.js", function() {
                        dk_codemirror_init_callback && dk_codemirror_init_callback();
                    });
                });
            });
        });
    });
}

dk.codemirror.end = function dk_codemirror_end(dk_codemirror_end_callback) {
    dk.close("DKCodeMirror/lib/codemirror.js");
    //, function() {
    dk.close("DKCodeMirror/lib/codemirror.css");
    //, function() {
    dk.close("DKCodeMirror/theme/abcdef.css");
    //, function() {
    dk.close("DKCodeMirror/DKCodeMirror.css");
    //, function() {
    dk.close("DKCodeMirror/mode/javascript/javascript.js");
    //, function() {
    dk_codemirror_end_callback && dk_codemirror_end_callback();
    //});
    //});
    //});
    //});
    //});
}

dk.codemirror.create = function dk_codemirror_create(dk_codemirror_create_callback) {
    const instance = new DKPlugin("new");
    if (!instance)
        return error("instance invalid", dk_codemirror_create_callback);

    const div = dk.gui.createElement(document.body, "div", "DKCodeMirror", "", "", "", "", "500rem", "400rem");
    instance.div = div;
    instance.setAccessNode(div);
    instance.myCodeMirror = CodeMirror(instance.div, {
        theme: "abcdef",
        lineNumbers: true,
        lineWrapping: true,
        mode: "javascript"/*value: "function myScript(){return 100;}\n"*/
    });
    dk.frame.create(instance);
    return dk_codemirror_create_callback && dk_codemirror_create_callback(instance);
}

dk.codemirror.createOpen = function dk_codemirror_createOpen(file, dk_codemirror_createOpen_callback) {
    dk.codemirror.create(function(instance) {
        dk.frame.setTitle(instance, "DKCodeMirror - " + file);
        instance.currentfile = file;
        dk.file.fileToString(file, function(str) {
            instance.myCodeMirror.setValue(str);
            dk_codemirror_createOpen_callback && dk_codemirror_createOpen_callback(instance);
        });
    });
}

dk.codemirror.setSelection = function dk_codemirror_setSelection(instance, line) {
    instance.myCodeMirror.setSelection(CodeMirror.Pos(line, 0), CodeMirror.Pos(line, 10));
}

dk.codemirror.highlightError = function dk_codemirror_highlightError(instance, line, ch) {
    instance.myCodeMirror.focus();
    instance.myCodeMirror.setCursor({
        line: line - 1,
        ch: ch - 1
    });
    instance.myCodeMirror.scrollIntoView({
        line: line - 1,
        char: ch
    }, 200);
    instance.myCodeMirror.getDoc().markText({
        line: line - 1,
        ch: (ch - 1)
    }, {
        line: line - 1,
        ch: (ch + 1)
    }, {
        css: "background-color: rgb(100,0,0)"
    });
}
