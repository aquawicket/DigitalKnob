"use strict";

dk.devtoolsbutton = new DKPlugin("dk_devtoolsbutton");

dk.devtoolsbutton.init = function dk_devtoolsbutton_init() {
    dk.preloadImage("DKDevTools/developer.png");
    dk.create("DKDebug/DKDebug.js");
}

dk.devtoolsbutton.create = function dk_devtools_create() {
    const elem = dk.gui.createImageButton(dk.console.container, "DKDevToolsButton", "DKDevTools/developer.png", "", "22rem", "", "2rem", "20rem", "20rem", dk.devtoolsbutton.show);
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

dk.devtoolsbutton.show = function dk_devtools_show() {

    dk.create("DKDevTools/DKDevTools.js", function(){
        dk.devtools.create();
    });
    
    /*
    dk.devtools.div = dk.frame.createNewWindow("DevTools", "200rem", "300rem");
    if (!dk.devtools.div)
        return;

    const frame = dk.frame.getFrame(dk.devtools.div);
    frame.titlebaricon.src = "DKDevTools/developer.png";

    dk.devtools.addTools();
    */
}