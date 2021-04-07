"use strict";

function DK_AttachDrags(id) {
    var parent = byId(id);
    if (!parent) {
        return false;
    }
    var elements = parent.getElementsByTagName('*');
    for (var i = 0; i < elements.length; i++) {
        var x = elements[i];

        if (!DK_IE() && DK_GetBrowser() !== "RML") {
            x.style.setProperty("pointer-events", "all");
        }

        if (x.getAttribute("drag") !== null) {
            //Drag events
            var mov_tar = x.getAttribute("drag");
            x.onmousedown = function(event) {
                DragStart(event, mov_tar);
            }
        }
        if (x.getAttribute("resize") !== null) {
            //Resize events
            var res_tar = x.getAttribute("resize");
            x.onmousedown = function(event) {
                ResizeStart(event, res_tar);
            }
        }
    }
}

////////////////////////////////////////
function DK_AddDragHandle(element, drag) {
    if (!DK_IE() && DK_GetBrowser() !== "RML") {
        element.style.setProperty("pointer-events", "all");
    }
    element.onmousedown = function(event) {
        DragStart(event, drag);
    }
    element.addEventListener('touchstart', function(event) {
        DragStart(event, drag);
    }, false);
    return true;
}

////////////////////////////////////////////
function DK_AddResizeHandle(element, resize) {
    if (!DK_IE() && DK_GetBrowser() !== "RML") {
        element.style.setProperty("pointer-events", "all");
    }
    element.onmousedown = function(event) {
        ResizeStart(event, resize);
    }
    element.addEventListener('touchstart', function(event) {
        ResizeStart(event, resize);
    }, false);
    return true;
}

////////////////////////////////
function DK_RemoveDragHandle(id) {
    if (!id) {
        return;
    }
    var element = byId(id);
    if (!DK_IE()) {//element.style.setProperty("pointer-events","none");
    }
    element.onmousedown = 0;
    //element.removeEventListener('touchstart', function(event){ DragStart(event, drag);});
}

//////////////////////////////////
function DragStart(event, element) {
    if (!event) {
        event = window.event;
    }
    if (DK_IE()) {
        mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    objectX = GetLeftPx(element);
    objectY = GetTopPx(element);
    document.body.onmousemove = function(event) {
        DragMove(event, element);
    }
    document.body.onmouseup = function(event) {
        DragStop(event);
    }
    document.body.addEventListener('touchmove', DragMove, false);
    document.body.addEventListener('touchend', DragStop, false);
}

/////////////////////////////////
function DragMove(event, element) {
    if (!event) {
        event = window.event;
    }
    let x;
    let y;
    if (DK_IE()) {
        x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        x = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        y = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    if (element.style.left) {
        element.style.left = Pos(objectX + x - mouseStartX);
    } else {
        element.style.right = Pos(objectX + mouseStartX - x);
    }
    if (element.style.top) {
        element.style.top = Pos(objectY + y - mouseStartY);
    } else {
        element.style.bottom = Pos(objectY + mouseStartY - y);
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

////////////////////////
function DragStop(event) {
    document.body.onmousemove = function() {}
    ;
    document.body.onmouseup = function() {}
    ;
    document.body.removeEventListener('touchmove', DragMove, false);
    document.body.removeEventListener('touchend', DragStop, false);
}

////////////////////////////////////
function ResizeStart(event, element) {
    if (!event) {
        event = window.event;
    }
    if (DK_IE()) {
        mouseStartX = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        mouseStartY = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        mouseStartX = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        mouseStartY = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    objectX = GetWidthPx(element);
    objectY = GetHeightPx(element);
    document.body.onmousemove = function(event) {
        ResizeMove(event, element);
    }
    document.body.onmouseup = function(event) {
        ResizeStop(event);
    }
    document.body.addEventListener('touchmove', ResizeMove, false);
    document.body.addEventListener('touchend', ResizeStop, false);
}

///////////////////////////////////
function ResizeMove(event, element) {
    if (!event) {
        event = window.event;
    }
    let x;
    let y;
    if (DK_IE()) {
        x = event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
        y = event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
    } else {
        x = event.clientX + window.scrollX || parseInt(event.changedTouches[0].clientX);
        y = event.clientY + window.scrollY || parseInt(event.changedTouches[0].clientY);
    }
    if ((objectX + x - mouseStartX) > 1) {
        element.style.width = Pos(objectX + x - mouseStartX);

    }
    if ((objectY + y - mouseStartY) > 1) {
        element.style.height = Pos(objectY + y - mouseStartY);
    }

    //WindowRestrictions(id);
    //DKSendEvent(id, "resize");
}

///////////////////////
function ResizeStop(id) {
    document.body.onmousemove = function() {}
    ;
    document.body.onmouseup = function() {}
    ;
    document.body.removeEventListener('touchmove', ResizeMove, false);
    document.body.removeEventListener('touchend', ResizeStop, false);
}