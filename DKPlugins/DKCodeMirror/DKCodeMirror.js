const dkcodemirror = {};

dkcodemirror.Create = function() {
    DK_Create("DKCodeMirror/codemirror.css");
    DK_Create("DKCodeMirror/codemirror.js", function() {
        let codetext = document.createElement("textarea");
        codetext.id = "CodeMirror";
        document.body.appendChild(codetext);
        var editor = CodeMirror.fromTextArea(codetext, {
            lineNumbers: true
        });
        DKFrame_Create(editor);
    });
}
