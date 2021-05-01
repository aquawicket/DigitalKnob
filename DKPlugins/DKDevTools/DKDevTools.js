"use strict";

dk.devtools = new Object;

dk.devtools.init = function dk_devtools_init() {
    dk.preloadImage("DKDevTools/developer.png");
    dk.create("DKDebug/DKDebug.js");
}

dk.devtools.create = function dk_devtools_create() {
    const elem = dk.gui.createImageButton(dk.console.container, "DKDevToolsButton", "DKDevTools/developer.png", "", "22rem", "", "2rem", "20rem", "20rem", dk.devtools.show);
    elem.style.zIndex = "99";
    const dragDiv = document.createElement("div");
    dragDiv.style.zIndex = "100";
    dragDiv.style.position = "absolute";
    dragDiv.style.removeProperty("top");
    dragDiv.style.removeProperty("left");
    dragDiv.style.bottom = "22rem";
    dragDiv.style.right = "2rem";
    dragDiv.style.width = "20rem";
    dragDiv.style.height = "20rem";
    //dragDiv.style.backgroundColor = "rgba(100,100,100,0.5)";
    elem.onmousemove = function() {
        dragDiv.style.bottom = elem.style.bottom;
        dragDiv.style.right = elem.style.right;
    }
    dragDiv.onclick = elem.onclick;
    document.body.appendChild(dragDiv);
    dk.drag.addHandle(dragDiv, elem);
}

dk.devtools.show = function dk_devtools_show() {

    dk.devtools.div = dk.frame.createNewWindow("DevTools", "200rem", "300rem");
    if (!dk.devtools.div)
        return;

    const frame = dk.frame.getFrame(dk.devtools.div);
    frame.titlebaricon.src = "DKDevTools/developer.png";

    dk.devtools.addTools();
}

dk.devtools.addTools = function dk_devtools_addTools() {
    dk.gui.createButton(dk.devtools.div, "DEBUG", "5rem", "", "5rem", "", "63rem", "20rem", dk.debug.debugFunc);
    dk.gui.createButton(dk.devtools.div, "Push Assets", "25rem", "", "5rem", "", "90rem", "20rem", function() {
        dk.file.pushDKAssets(function(result) {
            console.log("done copying assets. result = " + result);
        });
    });
    dk.gui.createButton(dk.devtools.div, "Pull Assets", "45rem", "", "5rem", "", "90rem", "20rem", function() {
        dk.file.pullDKAssets(function(result) {
            console.log("done pulling assets. result = " + result);
        });
    });
}
