"use strict";

dk.drag = DKPlugin(DKDrag, "singleton")

function DKDrag() {}

DKDrag.prototype.addHandle = function DKDrag_addHandle(element, drag_element) {
    //!dk.iE() && dk.getBrowser() !== "RML" && element.style.setProperty("pointer-events", "all");
    element.onmousedown = element.ontouchstart = function(event) {
        dk.drag.start(event, drag_element);
    }
}

DKDrag.prototype.removeDragHandle = function DKDrag_removeHandle(element) {
    //!dk.iE() && element.style.setProperty("pointer-events","none");
    element.onmousedown = element.ontouchstart = null;
}

DKDrag.prototype.start = function DKDrag_start(event, element) {
    !event && (event = window.event);
    if (dk.iE()) {
        dk.drag.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        dk.drag.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        dk.drag.mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        dk.drag.mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    if (element.style.left)
        dk.drag.positionX = dk.gui.getLeftPx(element);
    else
        dk.drag.positionX = parseInt(element.style.right);
    if (element.style.top)
        dk.drag.positionY = dk.gui.getTopPx(element);
    else
        dk.drag.positionY = parseInt(element.style.bottom);
    document.body.onmousemove = document.body.ontouchmove = function(event) {
        dk.drag.move(event, element);
    }
    document.body.onmouseup = document.body.ontouchend = function(event) {
        dk.drag.stop(event);
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
        element.style.left = dk.gui.pos(dk.drag.positionX + x - dk.drag.mouseStartX);
    else
        element.style.right = dk.gui.pos(dk.drag.positionX + dk.drag.mouseStartX - x);

    if (element.style.top)
        element.style.top = dk.gui.pos(dk.drag.positionY + y - dk.drag.mouseStartY);
    else
        element.style.bottom = dk.gui.pos(dk.drag.positionY + dk.drag.mouseStartY - y);
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
                dk.drag.Start(event, drag_element);
            }
        }
    }
}
*/
