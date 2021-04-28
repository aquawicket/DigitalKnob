"use strict";

dk.codemirror = new Object;

dk.codemirror.init = function dk_codemirror_init() {
    dk.create("DKCodeMirror/codemirror.css");
    dk.create("DKCodeMirror/abcdef.css");
    dk.create("DKCodeMirror/DKCodeMirror.css");
    dk.create("DKCodeMirror/codemirror.js", function() {
        dk.create("DKCodeMirror/javascript/javascript.js");
    });
}
dk.codemirror.end = function dk_codemirror_end() {}

dk.codemirror.create = function dk_codemirror_create() {
    
    dk.codemirror.div = dk.frame.createNewWindow("DKCodeMirror", "500rem", "400rem");
    var myCodeMirror = CodeMirror(dk.codemirror.div, {
        theme: "abcdef",
        lineNumbers: true,
        value: "function myScript(){return 100;}\n",
        mode: "javascript"
    });
}
