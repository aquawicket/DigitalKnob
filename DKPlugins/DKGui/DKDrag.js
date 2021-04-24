"use strict";

dk.drag = new Object;
dk.drag.info = [];

dk.drag.attachDrags = function dk_drag_attachDrags(parent) {
    const elements = parent.getElementsByTagName('*');
    for (let n = 0; n < elements.length; n++) {
        const element = elements[n];
        if (!dk.iE() && dk.getBrowser() !== "RML")
            element.style.setProperty("pointer-events", "all");
        if (element.getAttribute("drag") !== null) {
            var drag_element = element.getAttribute("drag");
            element.onmousedown = function(event) {
                dk.drag.dragStart(event, drag_element);
            }
        }
        if (element.getAttribute("resize") !== null) {
            var resize_element = element.getAttribute("resize");
            element.onmousedown = function(event) {
                dk.drag.resizeStart(event, resize_element);
            }
        }
    }
}

dk.drag.addDragHandle = function dk_drag_addDragHandle(element, drag_element) {
    //!dk.iE() && dk.getBrowser() !== "RML" && element.style.setProperty("pointer-events", "all");
    element.onmousedown = element.ontouchstart = function(event) {
        dk.drag.dragStart(event, drag_element);
    }
}

dk.drag.removeDragHandle = function dk_drag_removeDragHandle(element) {
    //!dk.iE() && element.style.setProperty("pointer-events","none");
    element.onmousedown = element.ontouchstart = null;
}

dk.drag.dragStart = function dk_drag_dragStart(event, element) {
    !event && (event = window.event);
    if (dk.iE()) {
        dk.drag.info.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        dk.drag.info.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        dk.drag.info.mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        dk.drag.info.mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    dk.drag.info.positionX = dk.gui.getLeftPx(element);
    dk.drag.info.positionY = dk.gui.getTopPx(element);
    document.body.onmousemove = document.body.ontouchmove = function(event) {
        dk.drag.dragMove(event, element);
    }
    document.body.onmouseup = document.body.ontouchend = function(event) {
        dk.drag.dragStop(event);
    }
}

dk.drag.dragMove = function dk_drag_dragMove(event, element) {
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
    if (element.style.left)
        element.style.left = dk.gui.pos(dk.drag.info.positionX + x - dk.drag.info.mouseStartX);
    else
        element.style.right = dk.gui.pos(dk.drag.info.positionX + dk.drag.info.mouseStartX - x);

    if (element.style.top)
        element.style.top = dk.gui.pos(dk.drag.info.positionY + y - dk.drag.info.mouseStartY);
    else
        element.style.bottom = dk.gui.pos(dk.drag.info.positionY + dk.drag.info.mouseStartY - y);

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

dk.drag.dragStop = function dk_drag_dragStop() {
    document.body.onmousemove = null;
    document.body.onmouseup = null;
    document.body.ontouchmove = null;
    document.body.ontouchend = null;
}

dk.drag.addResizeHandle = function dk_drag_addResizeHandle(element, resize_element, side) {
    //!dk.iE() && (dk.getBrowser() !== "RML") && element.style.setProperty("pointer-events", "all");
    element.onmousedown = element.touchstart = function(event) {
        dk.drag.resizeStart(event, resize_element, side);
    }
}

dk.drag.removeResizeHandle = function dk_drag_removeResizeHandle(element) {
    //!dk.iE() && element.style.setProperty("pointer-events", "none");
    element.onmousedown = element.ontouchstart = null;
}

dk.drag.resizeStart = function dk_drag_resizeStart(event, element, side) {
    !event && (event = window.event);
    if (dk.iE()) {
        dk.drag.info.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        dk.drag.info.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        dk.drag.info.mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        dk.drag.info.mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    (side === "top") && (dk.drag.info.positionY = dk.gui.getTopPx(element));
    (side === "left") && (dk.drag.info.positionX = dk.gui.getLeftPx(element));
    dk.drag.info.sizeX = dk.gui.getWidthPx(element);
    dk.drag.info.sizeY = dk.gui.getHeightPx(element);
    document.body.onmousemove = document.body.ontouchmove = function(event) {
        dk.drag.resizeMove(event, element, side);
    }
    document.body.onmouseup = document.body.ontouchend = function(event) {
        dk.drag.resizeStop(event);
    }
}

dk.drag.resizeMove = function dk_drag_resizeMove(event, element, side) {
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
            element.style.top = dk.gui.pos(dk.drag.info.positionY + y - dk.drag.info.mouseStartY);
        else
            element.style.bottom = dk.gui.pos(dk.drag.info.positionY + dk.drag.info.mouseStartY - y);
        element.style.height = dk.gui.pos(dk.drag.info.sizeY - (y - dk.drag.info.mouseStartY));
        return;
    }
    if (side === "left") {
        if (element.style.left)
            element.style.left = dk.gui.pos(dk.drag.info.positionX + x - dk.drag.info.mouseStartX);
        else
            element.style.right = dk.gui.pos(dk.drag.info.positionX + dk.drag.info.mouseStartX - x);
        element.style.width = dk.gui.pos(dk.drag.info.sizeX - (x - dk.drag.info.mouseStartX));
        return;
    }
    element.style.width = dk.gui.pos(dk.drag.info.sizeX + x - dk.drag.info.mouseStartX);
    element.style.height = dk.gui.pos(dk.drag.info.sizeY + y - dk.drag.info.mouseStartY);
}

dk.drag.resizeStop = function dk_drag_resizeStop() {
    document.body.onmousemove = null;
    document.body.onmouseup = null;
    document.body.ontouchmove = null;
    document.body.ontouchend = null;
}
