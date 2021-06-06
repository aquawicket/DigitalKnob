"use strict";

dk.devtools = new DKDevTools("singleton");
function DKDevTools() {
    return DKPlugin.call(this, arguments);
}

DKDevTools.prototype.init = function DKDevTools_init(callback) {
    console.log("DKDevTools.prototype.init()");
    callback && callback(dk.devtools);
}

DKDevTools.prototype.end = function DKDevTools_end() {
    console.log("DKDevTools.prototype.end()");
}

DKDevTools.prototype.create = function DKDevTools_create() {
    console.log("DKDevTools.prototype.create()");
    dk.devtools.div = document.createElement("div");
    dk.devtools.div.style.width = "200rem";
    dk.devtools.div.style.height = "300rem";
    dk.devtools.div.style.overflow = "auto";
    dk.devtools.addTools();

    const dkframe = dk.frame.create(dk.devtools);
    dkframe.setTitle("DKDevTools");
    dkframe.setIcon("DKDevTools/developer.png");
    return true;
}

DKDevTools.prototype.close = function DKDevTools_close() {
    console.log("DKDevTools.prototype.close()");
    this.end();
}

DKDevTools.prototype.addTools = function DKDevTools_addTools() {
    dk.gui.createButton(dk.devtools.div, "DEBUG", "5rem", "", "5rem", "", "63rem", "20rem", dk.debug.debugFunc);
    dk.gui.createButton(dk.devtools.div, "Pull Assets", "25rem", "", "5rem", "", "90rem", "20rem", function dk_gui_createButton_onclick() {
        dk.file.pullDKAssets(function dk_file_pullDKAssets_callback(result) {
            console.log("done pulling assets. result = " + result);
            pull.disabled = false;
        });
    });
    const pull = dk.gui.createButton(dk.devtools.div, "Push Assets", "45rem", "", "5rem", "", "90rem", "20rem", function dk_gui_createButton_onclick() {
        dk.file.pushDKAssets(function dk_file_pushDKAssets_callback(result) {
            console.log("done copying assets. result = " + result);
        });
    });
    const runCode = dk.gui.createButton(dk.devtools.div, "Run Code", "65rem", "", "5rem", "", "90rem", "20rem", function dk_gui_createButton_onclick() {
        try {
            eval(codebox.value);
        } catch (err) {
            console.error("eval failed");
        }
    });
    //pull.disabled = true;
    dk.gui.createImageButton(dk.devtools.div, "File Manager", "DKFile/folder.png", "2rem", "", "", "2px", "", "", function() {
        dk.create("DKFile/filemanager.js", function() {
            dk.filemanager.create();
        });
    })

    const codebox = dk.gui.createTag("textarea", dk.devtools.div, {
        style: {
            position: "absolute",
            top: "90rem",
            left: "5rem",
            //right:"5rem",
            width: "95%",
            bottom: "5rem",
            fontSize: "9rem"
        }
    });
    //codebox.style.removeProperty("width");
}
