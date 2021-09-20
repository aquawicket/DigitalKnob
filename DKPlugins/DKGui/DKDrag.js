//"use strict";

function DKDrag() {}

/*
DKDrag.prototype.create = function DKDrag_create(){
    const dkdrag = DKPlugin(DKDrag)
    return dkdrag;
}
*/

DKDrag.prototype.addHandle = function DKDrag_addHandle(element, drag_element) {
    const instance = this;
    element.onmousedown = element.ontouchstart = function(event) {
        instance.start(event, drag_element);
    }
}

DKDrag.prototype.removeDragHandle = function DKDrag_removeHandle(element) {
    element.onmousedown = element.ontouchstart = null;
}

DKDrag.prototype.start = function DKDrag_start(event, element) {
    const instance = this;
    !event && (event = window.event);
    if (dk.iE()) {
        this.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        this.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        this.mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        this.mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    if (element.style.left)
        this.positionX = dk.gui.getLeftPx(element);
    else
        this.positionX = parseInt(element.style.right);
    if (element.style.top)
        this.positionY = dk.gui.getTopPx(element);
    else
        this.positionY = parseInt(element.style.bottom);
    document.body.onmousemove = document.body.ontouchmove = function(event) {
        instance.move(event, element);
    }
    document.body.onmouseup = document.body.ontouchend = function(event) {
        instance.stop(event);
    }
}

DKDrag.prototype.move = function DKDrag_move(event, element) {
    if (!event)
        event = window.event;
    let x;
    let y;
    if (dk.iE()) {
        x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        x = event.clientX + window.scrollX || event.changedTouches && parseInt(event.changedTouches[0].clientX);
        y = event.clientY + window.scrollY || event.changedTouches && parseInt(event.changedTouches[0].clientY);
    }
    if (element.style.left)
        element.style.left = dk.gui.pos(this.positionX + x - this.mouseStartX);
    else
        element.style.right = dk.gui.pos(this.positionX + this.mouseStartX - x);

    if (element.style.top)
        element.style.top = dk.gui.pos(this.positionY + y - this.mouseStartY);
    else
        element.style.bottom = dk.gui.pos(this.positionY + this.mouseStartY - y);
    /*
    //Create a custom move event
    var moveevent;
    if (document.createEvent) {
        moveevent = document.createEvent("HTMLEvents");
        moveevent.initEvent("move", true, true);
    } else {
        moveevent = document.createEventObject();
        moveevent.eventType = "move";
    }
    moveevent.eventName = "move";
    if (document.createEvent)
        element.dispatchEvent(moveevent);
    else
        element.fireEvent("on" + moveevent.eventType, moveevent);
    */
}

DKDrag.prototype.stop = function DKDrag_stop() {
    document.body.onmousemove = null;
    document.body.onmouseup = null;
    document.body.ontouchmove = null;
    document.body.ontouchend = null;
}

/*
DKDrag.prototype.attachDrags = function DKDrag_attachDrags(parent) {
    const elements = parent.getElementsByTagName('*');
    for (let n = 0; n < elements.length; n++) {
        const element = elements[n];
        if (!dk.iE() && dk.getBrowser() !== "RML")
            element.style.setProperty("pointer-events", "all");
        if (element.getAttribute("drag") !== null) {
            var drag_element = element.getAttribute("drag");
            element.onmousedown = function(event) {
                this.Start(event, drag_element);
            }
        }
    }
}
*/

dk.drag = DKPlugin(DKDrag, "singleton")

