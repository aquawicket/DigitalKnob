"use strict";

dk.codemirror = new Object;

dk.codemirror.create = function dk_codemirror_create() {
    dk.create("DKCodeMirror/codemirror.css");
    dk.create("DKCodeMirror/codemirror.js", function dk_create_callback() {
        let codetext = document.createElement("textarea");
        codetext.id = "CodeMirror";
        document.body.appendChild(codetext);
        var editor = CodeMirror.fromTextArea(codetext, {
            lineNumbers: true
        });
        dk.frame.create(editor);
    });
}
