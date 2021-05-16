"use strict";

dk.devtools = new DKPlugin("dk_devtools");

dk.devtools.create = function dk_devtools_create() {
    //console.debug("dk.devtools.create()");
    dk.devtools.div = dk.frame.createNewWindow("DevTools", "200rem", "300rem");
    if (!dk.devtools.div)
        return false;

    const frame = dk.frame.getFrame(dk.devtools.div);
    frame.titlebaricon.src = "DKDevTools/developer.png";

    dk.devtools.addTools();
    return true;
}

dk.devtools.addTools = function dk_devtools_addTools() {
    dk.gui.createButton(dk.devtools.div, "DEBUG", "5rem", "", "5rem", "", "63rem", "20rem", dk.debug.debugFunc);
    dk.gui.createButton(dk.devtools.div, "Push Assets", "25rem", "", "5rem", "", "90rem", "20rem", function dk_gui_createButton_onclick() {
        dk.file.pushDKAssets(function dk_file_pushDKAssets_callback(result) {
            console.log("done copying assets. result = " + result);
        });
    });
    dk.gui.createButton(dk.devtools.div, "Pull Assets", "45rem", "", "5rem", "", "90rem", "20rem", function dk_gui_createButton_onclick() {
        dk.file.pullDKAssets(function dk_file_pullDKAssets_callback(result) {
            console.log("done pulling assets. result = " + result);
        });
    });
}
