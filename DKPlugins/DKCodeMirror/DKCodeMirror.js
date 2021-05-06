"use strict";

dk.codemirror = new Object;

dk.codemirror.init = function dk_codemirror_init(callback) {

    dk.create("DKCodeMirror/lib/codemirror.js", function() {
        dk.create("DKCodeMirror/lib/codemirror.css", function() {
            dk.create("DKCodeMirror/theme/abcdef.css", function() {
                dk.create("DKCodeMirror/DKCodeMirror.css", function() {
                    dk.create("DKCodeMirror/mode/javascript/javascript.js", function() {
                        callback && callback();
                    });
                });
            });
        });
    });
}
dk.codemirror.end = function dk_codemirror_end() {
    dk.close("DKCodeMirror/lib/codemirror.js");//, function() {
        dk.close("DKCodeMirror/lib/codemirror.css");//, function() {
            dk.close("DKCodeMirror/theme/abcdef.css");//, function() {
                dk.close("DKCodeMirror/DKCodeMirror.css");//, function() {
                    dk.close("DKCodeMirror/mode/javascript/javascript.js");//, function() {
                        //callback && callback();
                    //});
                //});
            //});
        //});
    //});
}

dk.codemirror.create = function dk_codemirror_create() {

    dk.codemirror.div = dk.frame.createNewWindow("DKCodeMirror", "500rem", "400rem");
    dk.codemirror.myCodeMirror = CodeMirror(dk.codemirror.div, {
        theme: "abcdef",
        lineNumbers: true,
        lineWrapping: true,
        mode: "javascript"
        /*value: "function myScript(){return 100;}\n"*/
    });
}

dk.codemirror.open = function dk_codemirror_open(file, callback) {
    dk.file.fileToString(file, function(str) {
        dk.codemirror.myCodeMirror.setValue(str);
        callback && callback(true);
    });
}

dk.codemirror.setSelection = function dk_codemirror_setSelection(line) {
    dk.codemirror.myCodeMirror.setSelection(CodeMirror.Pos(line, 0), CodeMirror.Pos(line, 10));
}
