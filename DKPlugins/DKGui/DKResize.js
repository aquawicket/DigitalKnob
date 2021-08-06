"use strict";

function DKResize() {}

DKResize.prototype.createBox = function DKResize_create(element) {
    const dkresize = DKPlugin(DKResize)

    dkresize.image = dk.gui.createElement(element, "img", "dk_resize_image");
    dkresize.image.setAttribute("src", "DKGui/resize.png");
    dkresize.image.style.removeProperty("top");
    dkresize.image.style.position = "absolute";
    dkresize.image.style.right = "0rem";
    dkresize.image.style.bottom = "0rem";
    dkresize.image.style.width = "18rem";
    dkresize.image.style.height = "18rem";

    dkresize.corner = dk.gui.createElement(element, "div", "dk_resize_corner");
    dkresize.corner.style.removeProperty("top");
    dkresize.corner.style.position = "absolute";
    dkresize.corner.style.right = "0rem";
    dkresize.corner.style.bottom = "0rem";
    dkresize.corner.style.width = "16rem";
    dkresize.corner.style.height = "16rem";
    dkresize.corner.style.cursor = "nw-resize";
    dkresize.addHandle(dkresize.corner, element);

    dkresize.top = dk.gui.createElement(element, "div", "dk_resize_top");
    dkresize.top.style.removeProperty("bottom");
    dkresize.top.style.removeProperty("width");
    dkresize.top.style.position = "absolute";
    dkresize.top.style.top = "0rem";
    dkresize.top.style.left = "0rem";
    dkresize.top.style.right = "0rem";
    dkresize.top.style.height = "4rem";
    dkresize.top.style.cursor = "n-resize";
    dkresize.addHandle(dkresize.top, element, "top");

    dkresize.left = dk.gui.createElement(element, "div", "dk_resize_left");
    dkresize.left.style.removeProperty("right");
    dkresize.left.style.removeProperty("height");
    dkresize.left.style.position = "absolute";
    dkresize.left.style.top = "0rem";
    dkresize.left.style.bottom = "0rem";
    dkresize.left.style.left = "0rem";
    dkresize.left.style.width = "4rem";
    dkresize.left.style.cursor = "e-resize";
    dkresize.addHandle(dkresize.left, element, "left");

    dkresize.right = dk.gui.createElement(element, "div", "dk_resize_right");
    dkresize.right.style.removeProperty("left");
    dkresize.right.style.removeProperty("height");
    dkresize.right.style.position = "absolute";
    dkresize.right.style.top = "0rem";
    dkresize.right.style.bottom = "16rem";
    dkresize.right.style.right = "0rem";
    dkresize.right.style.width = "4rem";
    dkresize.right.style.cursor = "e-resize";
    dkresize.addHandle(dkresize.right, element);

    dkresize.bottom = dk.gui.createElement(element, "div", "dk_resize_bottom");
    dkresize.bottom.style.removeProperty("top");
    dkresize.bottom.style.removeProperty("width");
    dkresize.bottom.style.position = "absolute";
    dkresize.bottom.style.bottom = "0rem";
    dkresize.bottom.style.left = "0rem";
    dkresize.bottom.style.right = "16rem";
    dkresize.bottom.style.height = "4rem";
    dkresize.bottom.style.cursor = "n-resize";
    dkresize.addHandle(dkresize.bottom, element);

    return dkresize;
}

DKResize.prototype.close = function DKResize_close() {
    /*
    this.removeHandle(this.corner);
    this.removeHandle(this.top);
    this.removeHandle(this.left);
    this.removeHandle(this.right);
    this.removeHandle(this.bottom);
    this.image.parentElement.removeChild(this.image);
    this.corner.parentElement.removeChild(this.corner);
    this.top.parentElement.removeChild(this.top);
    this.left.parentElement.removeChild(this.left);
    this.right.parentElement.removeChild(this.right);
    this.bottom.parentElement.removeChild(this.bottom);
    delete this.image
    delete this.corner;
    delete this.top;
    delete this.left;
    delete this.right;
    delete this.bottom;
    */
}

DKResize.prototype.addHandle = function DKResize_addHandle(element, resize_element, side) {
    const dkresize = this;
    element.onmousedown = element.touchstart = function(event) {
        dkresize.start(event, resize_element, side);
    }
}

DKResize.prototype.removeHandle = function DKResize_removeHandle(element) {
    element.onmousedown = element.ontouchstart = null;
}

DKResize.prototype.start = function DKResize_start(event, element, side) {
    const instance = this;
    !event && (event = window.event);
    if (dk.iE()) {
        this.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        this.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        this.mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        this.mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    (side === "top") && (this.positionY = dk.gui.getTopPx(element));
    (side === "left") && (this.positionX = dk.gui.getLeftPx(element));
    this.sizeX = dk.gui.getWidthPx(element);
    this.sizeY = dk.gui.getHeightPx(element);
    document.body.onmousemove = document.body.ontouchmove = function(event) {
        instance.move(event, element, side);
    }
    document.body.onmouseup = document.body.ontouchend = function(event) {
        instance.stop(event);
    }
}

DKResize.prototype.move = function DKResize_move(event, element, side) {
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
            element.style.top = dk.gui.pos(this.positionY + y - this.mouseStartY);
        else
            element.style.bottom = dk.gui.pos(this.positionY + this.mouseStartY - y);
        element.style.height = dk.gui.pos(this.sizeY - (y - this.mouseStartY));
        return;
    }
    if (side === "left") {
        if (element.style.left)
            element.style.left = dk.gui.pos(this.positionX + x - this.mouseStartX);
        else
            element.style.right = dk.gui.pos(this.positionX + this.mouseStartX - x);
        element.style.width = dk.gui.pos(this.sizeX - (x - this.mouseStartX));
        return;
    }
    element.style.width = dk.gui.pos(this.sizeX + x - this.mouseStartX);
    element.style.height = dk.gui.pos(this.sizeY + y - this.mouseStartY);
}

DKResize.prototype.stop = function DKResize_stop() {
    document.body.onmousemove = null;
    document.body.onmouseup = null;
    document.body.ontouchmove = null;
    document.body.ontouchend = null;
}

/*
DKResize.prototype.attachResizes = function DKResize_attachResizes(parent) {
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
