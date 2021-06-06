"use strict";

dk.devtoolsbutton = new DKDevToolsButton();

function DKDevToolsButton() {
    return DKPlugin.call(this, arguments);
}

DKDevToolsButton.prototype.init = function DKDevToolsButton_init() {
    dk.preloadImage("DKDevTools/developer.png");
}

DKDevToolsButton.prototype.create = function DKDevToolsButton_create() {
    const elem = dk.gui.createImageButton(document.body, "DKDevToolsButton", "DKDevTools/developer.png", "25rem", "", "", "2rem", "20rem", "20rem", dk.devtoolsbutton.show);
    elem.style.zIndex = "99";
    const dragDiv = document.createElement("div");
    dragDiv.style.zIndex = "100";
    dragDiv.style.position = "absolute";
    dragDiv.style.removeProperty("bottom");
    dragDiv.style.removeProperty("left");
    dragDiv.style.top = elem.style.top;
    dragDiv.style.right = elem.style.right;
    dragDiv.style.width = elem.style.width;
    dragDiv.style.height = elem.style.height;
    //dragDiv.style.backgroundColor = "rgba(100,100,100,0.5)";
    elem.onmousemove = function elem_onmousemove() {
        dragDiv.style.top = elem.style.top;
        dragDiv.style.right = elem.style.right;
    }
    dragDiv.onclick = elem.onclick;
    document.body.appendChild(dragDiv);
    dk.drag.addHandle(dragDiv, elem);
}

DKDevToolsButton.prototype.show = function DKDevToolsButton_show() {

    //DKPlugin.create("DKDevTools/DKDevTools.js");

    dk.create("DKDevTools/DKDevTools.js", function dk_create_callback() {
        dk.devtools.create();
    });

}
