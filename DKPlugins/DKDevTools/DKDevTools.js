"use strict";

function DKDevTools() {}

DKDevTools.prototype.create = function DKDevTools_create() {
    console.log("DKDevTools.prototype.create()");
    const instance = DKPlugin(DKDevTools, "singleton")
    if (!instance)
        return;
    instance.div = document.createElement("div");
    instance.div.style.width = "400rem";
    instance.div.style.height = "300rem";
    instance.div.style.overflow = "auto";
    const dkframe = DKFrame.prototype.create(instance);
    instance.addTools(instance);
    dkframe.setTitle("DKDevTools");
    dkframe.setIcon("DKDevTools/developer.png");
    return instance;
}

DKDevTools.prototype.addTools = function DKDevTools_addTools(instance) {
    dk.gui.createButton(instance.div, "Pull Assets", "10rem", "", "5rem", "", "90rem", "20rem", function dk_gui_createButton_onclick() {
        dk.file.pullDKAssets(function dk_file_pullDKAssets_callback(result) {
            console.log("done pulling assets. result = " + result);
            pull.disabled = false;
        });
    });
    const pull = dk.gui.createButton(instance.div, "Push Assets", "32rem", "", "5rem", "", "90rem", "20rem", function dk_gui_createButton_onclick() {
        dk.file.pushDKAssets(function dk_file_pushDKAssets_callback(result) {
            console.log("done copying assets. result = " + result);
        });
    });
    const runCode = dk.gui.createButton(instance.div, "Run Code", "70rem", "", "5rem", "", "80rem", "20rem", function dk_gui_createButton_onclick() {
        try {
            eval(codebox.value);
        } catch (err) {
            console.error(err);
        }
    });
    dk.gui.createImageButton(instance.div, "File Manager", "DKFile/folder.png", "2rem", "", "", "2px", "", "", function() {
        dk.create("DKFile/filemanager.js", function() {
            DKFileManager.prototype.init();
            DKFileManager.prototype.create();
        });
    })

    const codebox = dk.gui.createTag("textarea", instance.div, {
        style: {
            position: "absolute",
            top: "90rem",
            left: "5rem",
            //right:"5rem",
            width: "95%",
            bottom: "5rem",
            fontSize: "9rem",
            tabSize: "3"
        },
        oninput: function() {
            dk.file.stringToFile(codebox.value, "USER/devtoolscode.js");
        },
        onkeydown: function(e) {
            if (e.key == 'Tab') {
                e.preventDefault();
                var start = this.selectionStart;
                var end = this.selectionEnd;
                // set textarea value to: text before caret + tab + text after caret
                this.value = this.value.substring(0, start) + "\t" + this.value.substring(end);
                // put caret at right position again
                this.selectionStart = this.selectionEnd = start + 1;
                dk.file.stringToFile(codebox.value, "USER/devtoolscode.js");
            }
        }
    });

    codebox.setAttribute("spellcheck","false");
    dk.file.exists("USER/devtoolscode.js", function(result) {
        if (!result) {
            console.log("file does not exist");
            return;
        }

        dk.file.fileToString("USER/devtoolscode.js", function(str) {
            if (!str && str != "") {
                console.log("str invalid");
                return;
            }
            codebox.value = str;
        })
    })
}
