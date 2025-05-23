//"use strict";

function DKCodeMirror(){}


DKCodeMirror.prototype.init = function DKCodeMirror_init(DKCodeMirror_init_callback){
    DKPlugin("DKCodeMirror/lib/codemirror.js", function(){
        dk.create("DKCodeMirror/lib/codemirror.css", function(){
            dk.create("DKCodeMirror/theme/abcdef.css", function(){
                dk.create("DKCodeMirror/DKCodeMirror.css", function(){
                    DKPlugin("DKCodeMirror/mode/javascript/javascript.js", function(){
                        DKCodeMirror_init_callback && DKCodeMirror_init_callback();
                    });
                });
            });
        });
    });
}

DKCodeMirror.prototype.end = function DKCodeMirror_end(DKCodeMirror_end_callback){
    dk.close("DKCodeMirror/lib/codemirror.js");
    //, function(){
    dk.close("DKCodeMirror/lib/codemirror.css");
    //, function(){
    dk.close("DKCodeMirror/theme/abcdef.css");
    //, function(){
    dk.close("DKCodeMirror/DKCodeMirror.css");
    //, function(){
    dk.close("DKCodeMirror/mode/javascript/javascript.js");
    //, function(){
    DKCodeMirror_end_callback && DKCodeMirror_end_callback();
    //});
    //});
    //});
    //});
    //});
}

DKCodeMirror.prototype.create = function DKCodeMirror_create(DKCodeMirror_create_callback){
    const instance = DKPlugin(DKCodeMirror)
    if (!instance)
        return error("instance invalid", DKCodeMirror_create_callback);

    const div = dk.gui.createElement(document.body, "div", "DKCodeMirror", "", "", "", "", "500rem", "400rem");
    instance.div = div;
    instance.myCodeMirror = CodeMirror(instance.div, {
        zIndex: 0,
        theme: "abcdef",
        lineNumbers: true,
        lineWrapping: true,
        mode: "javascript"/*value: "function myScript(){return 100;}\n"*/
    });
    instance.dkframe = DKFrame.prototype.create(instance);
    DKCodeMirror_create_callback && DKCodeMirror_create_callback(instance);
    return instance;
}

DKCodeMirror.prototype.createOpen = function DKCodeMirror_createOpen(file, DKCodeMirror_createOpen_callback){
    this.create(function(instance){
        instance.dkframe.setTitle("DKCodeMirror - " + file);
        instance.currentfile = file;
        dk.file.fileToString(file, function(str){
            instance.myCodeMirror.setValue(str);
            DKCodeMirror_createOpen_callback && DKCodeMirror_createOpen_callback(instance);
        });
    });
}

DKCodeMirror.prototype.setSelection = function DKCodeMirror_setSelection(instance, line){
    instance.myCodeMirror.setSelection(CodeMirror.Pos(line, 0), CodeMirror.Pos(line, 10));
}

DKCodeMirror.prototype.highlightError = function DKCodeMirror_highlightError(instance, line, ch){
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