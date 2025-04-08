"use strict";

function DKDevToolsButton(){}

DKDevToolsButton.prototype.init = function DKDevToolsButton_init(){
    dk.preloadImage("DKDevTools/developer.png");
}

DKDevToolsButton.prototype.create = function DKDevToolsButton_create(){
    dk.devtoolsbutton = DKPlugin(DKDevToolsButton, "singleton")
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
    elem.onmousemove = function elem_onmousemove(){
        dragDiv.style.top = elem.style.top;
        dragDiv.style.right = elem.style.right;
    }
    dragDiv.onclick = elem.onclick;
    document.body.appendChild(dragDiv);
    dk.drag.addHandle(dragDiv, elem);
    return dk.devtoolsbutton;
}

DKDevToolsButton.prototype.show = function DKDevToolsButton_show(){

    DKPlugin("DKDevTools/DKDevTools.js", "singleton", function dk_create_callback(klass){
        //DKDevTools.prototype.create();
        DKPlugin.prototype.create(klass)
    });
}
