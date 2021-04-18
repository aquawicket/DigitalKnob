"use strict";

const DKDrag = [];

function DKDrag_AttachDrags(parent) {
    const elements = parent.getElementsByTagName('*');
    for (let n = 0; n < elements.length; n++) {
        const element = elements[n];
        if (!dk.iE() && dk.getBrowser() !== "RML") {
            element.style.setProperty("pointer-events", "all");
        }

        if (element.getAttribute("drag") !== null) {
            var drag_element = element.getAttribute("drag");
            element.onmousedown = function(event) {
                DKDrag_DragStart(event, drag_element);
            }
        }
        if (element.getAttribute("resize") !== null) {
            var resize_element = element.getAttribute("resize");
            element.onmousedown = function(event) {
                DKDrag_ResizeStart(event, resize_element);
            }
        }
    }
}

function DKDrag_AddDragHandle(element, drag_element) {
    if (!dk.iE() && dk.getBrowser() !== "RML") {
        element.style.setProperty("pointer-events", "all");
    }
    element.onmousedown = function(event) {
        DKDrag_DragStart(event, drag_element);
    }
    element.addEventListener('touchstart', function(event) {
        DKDrag_DragStart(event, drag_element);
    }, false);
    return true;
}

function DKDrag_RemoveDragHandle(element) {
    if (!dk.iE()) {//element.style.setProperty("pointer-events","none");
    }
    element.onmousedown = 0;
    //element.removeEventListener('touchstart', function(event){ DragStart(event, drag);});
}

function DKDrag_DragStart(event, element) {
    if (!event) {
        event = window.event;
    }
    if (dk.iE()) {
        DKDrag.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        DKDrag.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        DKDrag.mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        DKDrag.mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    DKDrag.objectX = DKGui_GetLeftPx(element);
    DKDrag.objectY = DKGui_GetTopPx(element);
    document.body.onmousemove = function(event) {
        DKDrag_DragMove(event, element);
    }
    document.body.onmouseup = function(event) {
        DKDrag_DragStop(event);
    }
    document.body.addEventListener('touchmove', DKDrag_DragMove, false);
    document.body.addEventListener('touchend', DKDrag_DragStop, false);
}

function DKDrag_DragMove(event, element) {
    if (!event) {
        event = window.event;
    }
    let x;
    let y;
    if (dk.iE()) {
        x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        x = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        y = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    if (element.style.left) {
        element.style.left = DKGui_Pos(DKDrag.objectX + x - DKDrag.mouseStartX);
    } else {
        element.style.right = DKGui_Pos(objectX + DKDrag.mouseStartX - x);
    }
    if (element.style.top) {
        element.style.top = DKGui_Pos(DKDrag.objectY + y - DKDrag.mouseStartY);
    } else {
        element.style.bottom = DKGui_Pos(DKDrag.objectY + DKDrag.mouseStartY - y);
    }

    //WindowRestrictions(id);

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

    if (document.createEvent) {
        element.dispatchEvent(moveevent);
    } else {
        element.fireEvent("on" + moveevent.eventType, moveevent);
    }
    ////////////////////////////////////////////////////////////
}

function DKDrag_DragStop(event) {
    document.body.onmousemove = function() {}
    document.body.onmouseup = function() {}
    document.body.removeEventListener('touchmove', DKDrag_DragMove, false);
    document.body.removeEventListener('touchend', DKDrag_DragStop, false);
}


function DKDrag_AddResizeHandle(element, resize_element) {
    if (!dk.iE() && dk.getBrowser() !== "RML") {
        element.style.setProperty("pointer-events", "all");
    }
    element.onmousedown = function(event) {
        DKDrag_ResizeStart(event, resize_element);
    }
    element.addEventListener('touchstart', function(event) {
        DKDrag_ResizeStart(event, resize_element);
    }, false);
    return true;
}

function DKDrag_RemoveResizeHandle(element) {
    if (!dk.iE()) {//element.style.setProperty("pointer-events","none");
    }
    element.onmousedown = 0;
    //element.removeEventListener('touchstart', function(event){ DragStart(event, drag);});
}

function DKDrag_ResizeStart(event, element) {
    if (!event) {
        event = window.event;
    }
    if (dk.iE()) {
        DKDrag.mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        DKDrag.mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        DKDrag.mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        DKDrag.mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    DKDrag.objectX = DKGui_GetWidthPx(element);
    DKDrag.objectY = DKGui_GetHeightPx(element);
    document.body.onmousemove = function(event) {
        DKDrag_ResizeMove(event, element);
    }
    document.body.onmouseup = function(event) {
        DKDrag_ResizeStop(event);
    }
    //document.body.addEventListener('touchmove', DKDrag_ResizeMove, false);
    //document.body.addEventListener('touchend', DKDrag_ResizeStop, false);
}

function DKDrag_ResizeMove(event, element) {
    if (!event) {
        event = window.event;
    }
    let x;
    let y;
    if (dk.iE()) {
        x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        x = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        y = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    if ((DKDrag.objectX + x - DKDrag.mouseStartX) > 1) {
        element.style.width = DKGui_Pos(DKDrag.objectX + x - DKDrag.mouseStartX);

    }
    if ((DKDrag.objectY + y - DKDrag.mouseStartY) > 1) {
        element.style.height = DKGui_Pos(DKDrag.objectY + y - DKDrag.mouseStartY);
    }

    //WindowRestrictions(id);
    //DKSendEvent(id, "resize");
}

function DKDrag_ResizeStop(event) {
    document.body.onmousemove = function() {}
    document.body.onmouseup = function() {}
    document.body.removeEventListener('touchmove', DKDrag_ResizeMove, false);
    document.body.removeEventListener('touchend', DKDrag_ResizeStop, false);
}
