"use strict";

dk.resize = new Object;

dk.resize.create = function dk_resize_create(element) {
    if (!element)
        return error("element invalid");
    dk.resize.image = dk.gui.createElement(element, "img", "dk_resize_image");
    dk.resize.image.setAttribute("src", "DKGui/resize.png");
    dk.resize.image.style.removeProperty("top");
    dk.resize.image.style.position = "absolute";
    dk.resize.image.style.right = "0rem";
    dk.resize.image.style.bottom = "0rem";
    dk.resize.image.style.width = "18rem";
    dk.resize.image.style.height = "18rem";

    dk.resize.corner = dk.gui.createElement(element, "div", "dk_resize_corner");
    dk.resize.corner.style.removeProperty("top");
    dk.resize.corner.style.position = "absolute";
    dk.resize.corner.style.right = "0rem";
    dk.resize.corner.style.bottom = "0rem";
    dk.resize.corner.style.width = "16rem";
    dk.resize.corner.style.height = "16rem";
    dk.resize.corner.style.cursor = "nw-resize";
    dk.resize.addHandle(dk.resize.corner, element);

    dk.resize.top = dk.gui.createElement(element, "div", "dk_resize_top");
    dk.resize.top.style.removeProperty("bottom");
    dk.resize.top.style.removeProperty("width");
    dk.resize.top.style.position = "absolute";
    dk.resize.top.style.top = "0rem";
    dk.resize.top.style.left = "0rem";
    dk.resize.top.style.right = "0rem";
    dk.resize.top.style.height = "4rem";
    dk.resize.top.style.cursor = "n-resize";
    dk.resize.addHandle(dk.resize.top, element, "top");

    dk.resize.left = dk.gui.createElement(element, "div", "dk_resize_left");
    dk.resize.left.style.removeProperty("right");
    dk.resize.left.style.removeProperty("height");
    dk.resize.left.style.position = "absolute";
    dk.resize.left.style.top = "0rem";
    dk.resize.left.style.bottom = "0rem";
    dk.resize.left.style.left = "0rem";
    dk.resize.left.style.width = "4rem";
    dk.resize.left.style.cursor = "e-resize";
    dk.resize.addHandle(dk.resize.left, element, "left");

    dk.resize.right = dk.gui.createElement(element, "div", "dk_resize_right");
    dk.resize.right.style.removeProperty("left");
    dk.resize.right.style.removeProperty("height");
    dk.resize.right.style.position = "absolute";
    dk.resize.right.style.top = "0rem";
    dk.resize.right.style.bottom = "16rem";
    dk.resize.right.style.right = "0rem";
    dk.resize.right.style.width = "4rem";
    dk.resize.right.style.cursor = "e-resize";
    dk.resize.addHandle(dk.resize.right, element);
    
    dk.resize.bottom = dk.gui.createElement(element, "div", "dk_resize_bottom");
    dk.resize.bottom.style.removeProperty("top");
    dk.resize.bottom.style.removeProperty("width");
    dk.resize.bottom.style.position = "absolute";
    dk.resize.bottom.style.bottom = "0rem";
    dk.resize.bottom.style.left = "0rem";
    dk.resize.bottom.style.right = "16rem";
    dk.resize.bottom.style.height = "4rem";
    dk.resize.bottom.style.cursor = "n-resize";
    dk.resize.addHandle(dk.resize.bottom, element);

    return this;
}

dk.resize.addHandle = function dk_resize_addHandle(element, resize_element, side) {
    //!dk.iE() && (dk.getBrowser() !== "RML") && element.style.setProperty("pointer-events", "all");
    element.onmousedown = element.touchstart = function(event) {
        dk.resize.start(event, resize_element, side);
    }
}

dk.resize.removeHandle = function dk_resize_removeHandle(element) {
    //!dk.iE() && element.style.setProperty("pointer-events", "none");
    element.onmousedown = element.ontouchstart = null;
}

dk.resize.start = function dk_resize_start(event, element, side) {
    !event && (event = window.event);
    if (dk.iE()) {
        dk.resize.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        dk.resize.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        dk.resize.mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        dk.resize.mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    (side === "top") && (dk.resize.positionY = dk.gui.getTopPx(element));
    (side === "left") && (dk.resize.positionX = dk.gui.getLeftPx(element));
    dk.resize.sizeX = dk.gui.getWidthPx(element);
    dk.resize.sizeY = dk.gui.getHeightPx(element);
    document.body.onmousemove = document.body.ontouchmove = function(event) {
        dk.resize.move(event, element, side);
    }
    document.body.onmouseup = document.body.ontouchend = function(event) {
        dk.resize.stop(event);
    }
}

dk.resize.move = function dk_resize_move(event, element, side) {
    if (!event)
        event = window.event;
    let x;
    let y;
    if (dk.iE()) {
        x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        x = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        y = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }

    if (side === "top") {
        if (element.style.top)
            element.style.top = dk.gui.pos(dk.resize.positionY + y - dk.resize.mouseStartY);
        else
            element.style.bottom = dk.gui.pos(dk.resize.positionY + dk.resize.mouseStartY - y);
        element.style.height = dk.gui.pos(dk.resize.sizeY - (y - dk.resize.mouseStartY));
        return;
    }
    if (side === "left") {
        if (element.style.left)
            element.style.left = dk.gui.pos(dk.resize.positionX + x - dk.resize.mouseStartX);
        else
            element.style.right = dk.gui.pos(dk.resize.positionX + dk.resize.mouseStartX - x);
        element.style.width = dk.gui.pos(dk.resize.sizeX - (x - dk.resize.mouseStartX));
        return;
    }
    element.style.width = dk.gui.pos(dk.resize.sizeX + x - dk.resize.mouseStartX);
    element.style.height = dk.gui.pos(dk.resize.sizeY + y - dk.resize.mouseStartY);
}

dk.resize.stop = function dk_resize_stop() {
    document.body.onmousemove = null;
    document.body.onmouseup = null;
    document.body.ontouchmove = null;
    document.body.ontouchend = null;
}

/*
dk.resize.attachResizes = function dk_resize_attachResizes(parent) {
    const elements = parent.getElementsByTagName('*');
    for (let n = 0; n < elements.length; n++) {
        const element = elements[n];
        if (!dk.iE() && dk.getBrowser() !== "RML")
            element.style.setProperty("pointer-events", "all");
         if (element.getAttribute("resize") !== null) {
            var resize_element = element.getAttribute("resize");
            element.onmousedown = function(event) {
                dk.drag.resizeStart(event, resize_element);
            }
        }
    }
}
*/