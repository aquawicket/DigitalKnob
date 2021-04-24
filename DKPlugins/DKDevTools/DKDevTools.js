"use strict";

dk.devtools = new DKWidget;

dk.devtools.init = function dk_devtools_init() {
    console.debug(this instanceof DKWidget)
    dk.preloadImage("DKDevTools/developer.png");
    dk.create("DKDebug/DKDebug.js");
}

dk.devtools.create = function dk_devtools_create() {
    console.debug(this instanceof DKWidget)
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

/*
dk.devtools.close = function dk_devtools_close(){
    console.log("dk.devtools.close() called");
}
*/

dk.devtools.show = function dk_devtools_show() {
    if (typeof dk.devtools.div === "object" && dk.frame.getFrame(dk.devtools.div))
        return;
    const div = document.createElement("div");
    dk.devtools.setElement(div);
    div.id = "DKDevTools";
    div.style.position = "absolute";
    div.style.width = "200rem";
    div.style.height = "300rem";
    div.close = dk.devtools.close;
    document.body.appendChild(div);
    dk.frame.create(div);

    const frame = dk.frame.getFrame(div);
    frame.titlebaricon.src = "DKDevTools/developer.png";
    dk.devtools.addTools();
}

dk.devtools.addTools = function dk_devtools_addTools() {
    const div = dk.devtools.getElement();
    dk.gui.createButton(div, "DEBUG", "5rem", "", "5rem", "", "63rem", "20rem", dk.debug.debugFunc);
    dk.gui.createButton(div, "Push Assets", "25rem", "", "5rem", "", "90rem", "20rem", dk.file.pushDKAssets);
}
