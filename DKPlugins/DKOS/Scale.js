//"use strict";

function Scale(){}
dk.scale = DKPlugin(Scale)

Scale.prototype.init = function Scale_init() {
    dk.create("DKOS/Scale.html,DKOS/Taskbar.html", function() {
        byId("scale_minus").addEventListener("mousedown", Scale.onevent);
        byId("scale_plus").addEventListener("mousedown", Scale.onevent);
    });
}

Scale.prototype.end = function Scale_end() {
    byId("scale_minus").removeEventListener("mousedown", Scale.onevent);
    byId("scale_plus").removeEventListener("mousedown", Scale.onevent);
    dk.close("Scale.html");
}

Scale.onevent = function Scale_onevent(event) {
    if (event.currentTarget.id === "scale_minus")
        Scale_minus();
    if (event.currentTarget.id === "scale_plus") 
        Scale_plus();
}

Scale.prototype.minus = function Scale_minus() {
    var scale = window.getComputedStyle(document.documentElement).fontSize;
    scale = parseFloat(scale.replace("px", ""));
    scale = scale - 0.1;
    if (scale < 1.0) 
        scale = 1.0;
    document.documentElement.style.fontSize = scale + "px";
}

Scale.prototype.plus = function Scale_plus() {
    var scale = window.getComputedStyle(document.documentElement).fontSize;
    scale = parseFloat(scale.replace("px", ""));
    scale = scale + .1;
    if (scale > 100.0)
        scale = 100.0;
    document.documentElement.style.fontSize = scale + "px";
}
