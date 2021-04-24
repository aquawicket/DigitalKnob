"use strict";

dk.devtools = new Object;

dk.devtools.init = function dk_devtools_init() {
    dk.preloadImage("DKDevTools/developer.png");
    dk.create("DKDebug/DKDebug.js");

}

dk.devtools.create = function dk_devtools_create() {
    const elem = dk.gui.createImageButton(dk.console.container, "DKDevToolsButton", "DKDevTools/developer.png", "", "22rem", "", "2rem", "20rem", "20rem", dk.devtools.show);
    elem.style.zIndex = "9999";
    dk.drag.addHandle(elem, elem);
}

dk.devtools.show = function dk_devtools_show() {
    const div = document.createElement("div");
    dk.devtools.div = div;
    div.id = "DKDevTools";
    div.style.position = "absolute";
    div.style.width = "200rem";
    div.style.height = "300rem";
    //div.style.fontSize = "12rem";
    //div.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
    //div.style.whiteSpace = "pre-wrap";
    //div.style.boxSizing = "border-box";
    //div.style.padding = "2rem";
    //div.style.paddingLeft = "20rem";
    //div.style.borderStyle = "solid";
    //div.style.borderWidth = "1rem";
    //div.style.borderTopWidth = "0rem";
    //div.style.borderLeftWidth = "0rem";
    //div.style.borderRightWidth = "0rem";
    //div.style.backgroundColor = "rgb(36,36,36)";
    //div.style.overflow = "auto";
    document.body.appendChild(div);
    dk.frame.create(div);
    const frame = dk.frame.getFrame(div);
    frame.titlebaricon.src = "DKDevTools/developer.png";
    dk.devtools.addTools();
}

dk.devtools.addTools = function dk_devtools_addTools() {
    dk.gui.createButton(dk.devtools.div, "DEBUG", "5rem", "", "5rem", "", "63rem", "20rem", dk.debug.debugFunc);
    dk.gui.createButton(dk.devtools.div, "Push Assets", "25rem", "", "5rem", "", "63rem", "34rem", dk.file.pushDKAssets);
}
