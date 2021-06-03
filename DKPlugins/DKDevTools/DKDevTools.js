"use strict";

dk.devtools = new DKPlugin("dk_devtools");

/*
dk.devtools.init = function dk_devtools_init(callback) {
    console.log("dk.devtools.init()");
    callback && callback(dk.devtools);
}

dk.devtools.end = function dk_devtools_end() {
    console.log("dk.devtools.end()");
    DKPlugin.prototype.end.call(this);
}
*/

dk.devtools.create = function dk_devtools_create() {
    console.log("dk.devtools.create()");
    dk.devtools.div = document.createElement("div");
    dk.devtools.div.style.width = "200rem";
    dk.devtools.div.style.height = "300rem";
    dk.devtools.div.style.overflow = "auto";
    dk.devtools.setAccessNode(dk.devtools.div);
    dk.devtools.addTools();

    const frame = dk.frame.create(dk.devtools);
    frame.setTitle(dk.devtools, "DKDevTools");
    frame.setIcon(dk.devtools, "DKDevTools/developer.png");
    return true;
}

dk.devtools.close = function dk_devtools_close() {
    console.log("dk.devtools.close()");
    DKPlugin.prototype.close.call(this);
    dk.devtools.end();
}

dk.devtools.addTools = function dk_devtools_addTools() {
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
