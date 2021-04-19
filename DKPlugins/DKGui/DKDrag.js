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
    if (!dk.iE() && dk.getBrowser() !== "RML")
        element.style.setProperty("pointer-events", "all");
    element.onmousedown = function(event) {
        dk.drag.dragStart(event, drag_element);
    }
    /*
    element.addEventListener('touchstart', function(event) {
        dk.drag.dragStart(event, drag_element);
    }, false);
    */
    return true;
}

dk.drag.removeDragHandle = function dk_drag_removeDragHandle(element) {
    if (!dk.iE()) {//element.style.setProperty("pointer-events","none");
    }
    element.onmousedown = 0;
    //element.removeEventListener('touchstart', function(event){ DragStart(event, drag);});
}

dk.drag.dragStart = function dk_drag_dragStart(event, element) {
    if (!event)
        event = window.event;
    if (dk.iE()) {
        dk.drag.info.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        dk.drag.info.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        dk.drag.info.mouseStartX = event.clientX + window.scrollX;// || parseInt(event.changedTouches[0].clientX);
        dk.drag.info.mouseStartY = event.clientY + window.scrollY;// || parseInt(event.changedTouches[0].clientY);
    }
    dk.drag.info.objectX = dk.gui.getLeftPx(element);
    dk.drag.info.objectY = dk.gui.getTopPx(element);
    document.body.onmousemove = function(event) {
        dk.drag.dragMove(event, element);
    }
    document.body.onmouseup = function(event) {
        dk.drag.dragStop(event);
    }
    //document.body.addEventListener('touchmove', dk.drag.dragMove, false);
    //document.body.addEventListener('touchend', dk.drag.dragStop, false);
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
        x = event.clientX + window.scrollX;// || parseInt(event.changedTouches[0].clientX);
        y = event.clientY + window.scrollY;// || parseInt(event.changedTouches[0].clientY);
    }
    if (element.style.left)
        element.style.left = dk.gui.pos(dk.drag.info.objectX + x - dk.drag.info.mouseStartX);
    else
        element.style.right = dk.gui.pos(objectX + dk.drag.info.mouseStartX - x);
    if (element.style.top)
        element.style.top = dk.gui.pos(dk.drag.info.objectY + y - dk.drag.info.mouseStartY);
    else
        element.style.bottom = dk.gui.pos(dk.drag.info.objectY + dk.drag.info.mouseStartY - y);

    //Create a custom move event
    ///////////////////////////////////////////////////
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
    ////////////////////////////////////////////////////////////
}

dk.drag.dragStop = function dk_drag_dragStop(event) {
    document.body.onmousemove = function() {}
    document.body.onmouseup = function() {}
    //document.body.removeEventListener('touchmove', dk.drag.dragMove, false);
    //document.body.removeEventListener('touchend', dk.drag.dragStop, false);
}

dk.drag.addResizeHandle = function dk_drag_addResizeHandle(element, resize_element) {
    if (!dk.iE() && dk.getBrowser() !== "RML")
        element.style.setProperty("pointer-events", "all");
    element.onmousedown = function(event) {
        dk.drag.resizeStart(event, resize_element);
    }
    /*
    element.addEventListener('touchstart', function(event) {
        dk.drag.resizeStart(event, resize_element);
    }, false);
    */
    return true;
}

dk.drag.removeResizeHandle = function dk_drag_removeResizeHandle(element) {
    if (!dk.iE()) {//element.style.setProperty("pointer-events","none");
    }
    element.onmousedown = 0;
    //element.removeEventListener('touchstart', function(event){ dk.drag.dragStart(event, drag);});
}

dk.drag.resizeStart = function dk_drag_resizeStart(event, element) {
    if (!event)
        event = window.event;
    if (dk.iE()) {
        dk.drag.info.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        dk.drag.info.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        dk.drag.info.mouseStartX = event.clientX + window.scrollX;// || parseInt(event.changedTouches[0].clientX);
        dk.drag.info.mouseStartY = event.clientY + window.scrollY;// || parseInt(event.changedTouches[0].clientY);
    }
    dk.drag.info.objectX = dk.gui.getWidthPx(element);
    dk.drag.info.objectY = dk.gui.getHeightPx(element);
    document.body.onmousemove = function(event) {
        dk.drag.resizeMove(event, element);
    }
    document.body.onmouseup = function(event) {
        dk.drag.resizeStop(event);
    }
    //document.body.addEventListener('touchmove', dk.drag.resizeMove, false);
    //document.body.addEventListener('touchend', dk.drag.resizeStop, false);
}

dk.drag.resizeMove = function dk_drag_resizeMove(event, element) {
    if (!event)
        event = window.event;
    let x;
    let y;
    if (dk.iE()) {
        x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        x = event.clientX + window.scrollX;// || parseInt(event.changedTouches[0].clientX);
        y = event.clientY + window.scrollY;// || parseInt(event.changedTouches[0].clientY);
    }
    if ((dk.drag.info.objectX + x - dk.drag.info.mouseStartX) > 1)
        element.style.width = dk.gui.pos(dk.drag.info.objectX + x - dk.drag.info.mouseStartX);
    if ((dk.drag.info.objectY + y - dk.drag.info.mouseStartY) > 1)
        element.style.height = dk.gui.pos(dk.drag.info.objectY + y - dk.drag.info.mouseStartY);
}

dk.drag.resizeStop = function dk_drag_resizeStop(event) {
    document.body.onmousemove = function() {}
    document.body.onmouseup = function() {}
    //document.body.removeEventListener('touchmove', dk.drag.resizeMove, false);
    //document.body.removeEventListener('touchend', dk.drag.resizeStop, false);
}
