"use strict";

dk.frame = new Object;
dk.frame.frames = new Array;

dk.frame.Init = function dk_frame_Init() {}
dk.frame.End = function dk_frame_End() {}

dk.frame.createNewWindow = function dk_frame_createNewWindow(title, width, height){
    const div = document.createElement("div");
    div.id = title;
    //div.style.position = "absolute";
    div.style.width = width;
    div.style.height = height;
    div.style.overflow = "auto";
    //div.style.fontSize = "12rem";
    //div.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
    //div.style.whiteSpace = "pre-wrap";
    //div.style.boxSizing = "border-box";
    //div.style.padding = "2rem";
    //div.style.paddingLeft = "20rem";
    //div.style.borderStyle = "solid";
    //div.style.borderWidth = "1rem";
    //div.style.borderTopWidth = "0rem";
    //div.style.borderLeftWidth = "0rem";
    //div.style.borderRightWidth = "0rem";
    //div.style.backgroundColor = "rgb(36,36,36)";
    //document.body.appendChild(div);
    dk.frame.create(div);
    return div;
}

dk.frame.bringToFront = function dk_frame_bringToFront(frame) {
    frame = dk.frame.setCurrentFrame(frame);
    if (!frame)
        return false;
    (document.body.lastChild !== frame) && document.body.appendChild(frame);
}

dk.frame.close = function dk_frame_close(element) {
    if (!element || !element.parentNode)
        return error("element invalid");
    var frame = dk.frame.setCurrentFrame(element.parentNode);

    if (frame.content.id.includes(".html")) {
        var htmlfile = frame.content.id;
        var jsfile = htmlfile.replace(".html", ".js");
        jsfile && dk.close(jsfile);
        htmlfile && dk.close(htmlfile);
    }

    /*
    //TODO if the Frame contains an iFrame, we need to call DKCef_CloseBrowser(n) on the associated iFrame
    if (frame.content.id.includes("iframe_")) {
        var frameId = frame.content.id.replace("iframe_", "");
        for (var nn = 0; nn < DKCef_GetBrowsers(); nn++) {
            if (frameId === DKCef_GetBrowserId(nn))
                DKCef_CloseBrowser(nn);
        }
    }
    */

    if (frame === document.body)
        return warn("frame === document.body");
    frame.parentNode.removeChild(frame);
    var index = dk.frame.frames.indexOf(frame);
    if (index > -1)
        dk.frame.frames.splice(index, 1);
    return true;
}

dk.frame.closeAll = function dk_frame_closeAll() {
    for (var n = 0; n < dk.frame.frames.length; n++)
        dk.frame.close(dk.frame.frames[n].content);
    return true;
}

dk.frame.create = function dk_frame_create(element) {
    if (!element)
        return error("element invalid");
    if (!element.id)
        return error("element.id invalid");

    var title = dk.file.getFilename(element.id);
    title && (title = title.replace(".html", ""));

    var width = element.style.width;
    var height = element.style.height;
    !width.includes("%") && (width = parseInt(width));
    !height.includes("%") && (height = parseInt(height));
    //width = width.replace("rem", "");
    //height = height.replace("rem", "");

    let frame = dk.frame.createFrame(title, width, height);
    frame.content = element;
    frame.content.style.position = "absolute";
    frame.content.style.top = "21rem";
    frame.content.style.left = "0rem";
    frame.content.style.width = "100%";
    frame.content.style.bottom = "-1rem";
    frame.content.style.removeProperty("right");
    frame.content.style.removeProperty("height")
    frame.appendChild(frame.content);
    dk.frame.createResize(frame);
    //dk.frame.frames.push(frame);
    return frame;
}

dk.frame.createFrame = function dk_frame_createFrame(title, width, height) {
    if (typeof title !== "string")
        return error("title invalid\n");

    (width === "100%") && (width = window.innerWidth - 100);
    (height === "100%") && (height = window.innerHeight - 21 - 100);
    !width && (width = window.innerWidth / 2);
    !height && (height = window.innerHeight / 2);

    var newheight = parseFloat(height) + 21;
    var newtop = parseFloat((window.innerHeight / 2) - (newheight / 2) - 1);
    var newleft = parseFloat((window.innerWidth / 2) - (width / 2) - 1)
    let frame = dk.gui.createElement(document.body, "div", "dk_frame_box");
    //add the frame to an array list
    dk.frame.frames.push(frame);
    frame = dk.frame.setCurrentFrame(frame);
    if (!frame)
        return false;
    //See DKFrame.css for styling    
    frame.setAttribute("target","frame");
    frame.style.position = "absolute";
    frame.style.overflow = "hidden";
    frame.style.top = newtop + "px";
    frame.style.left = newleft + "px";
    frame.style.width = width + "rem";
    frame.style.height = newheight + "rem";
    (dk.getBrowser() !== "RML") && (frame.style.borderStyle = "solid");
    frame.style.minWidth = "62rem";
    frame.style.minHeight = "30rem";
    frame.onmousedown = function dk_frame_frame_onmousedown(event) {
        dk.frame.bringToFront(event.currentTarget);
    }

    //See DKFrame.css for styling
    frame.titlebar = dk.gui.createElement(frame, "div", "dk_frame_titlebar");
    frame.titlebar.setAttribute("target","titlebar");
    frame.titlebar.style.position = "absolute";
    frame.titlebar.style.width = "100%";
    frame.titlebar.style.height = "21rem";
    frame.titlebar.ondblclick = function dk_frame_titlebar_ondblclick(event) {
        dk.frame.maximize(event.currentTarget);
    }
    dk.drag.addDragHandle(frame.titlebar, frame);

    //See DKFrame.css for styling
    frame.titlebar.text = dk.gui.createElement(frame.titlebar, "div", "dk_frame_titlebartext");
    frame.titlebar.text.setAttribute("target","titlebartext");
    frame.titlebar.text.style.position = "absolute";
    frame.titlebar.text.style.width = "100%";
    frame.titlebar.text.style.height = "100%";
    frame.titlebar.text.style.cursor = "default";
    frame.titlebar.text.innerHTML = title;

    frame.reload = dk.gui.createElement(frame, "img", "dk_frame_reload");
    frame.reload.setAttribute("src", "DKGui/reload.png");
    frame.reload.style.position = "absolute";
    frame.reload.style.top = "1rem";
    frame.reload.style.right = "65rem";
    frame.reload.style.height = "18rem";
    frame.reload.onmousedown = function dk_frame_reload_onmousedown(event) {
        dk.frame.reload(event.currentTarget);
    }

    var minimize = dk.gui.createElement(frame, "img", "dk_frame_minimize");
    minimize.setAttribute("src", "DKGui/minimize.png");
    minimize.style.position = "absolute";
    minimize.style.top = "0rem";
    minimize.style.right = "42rem";
    minimize.style.height = "20rem;"
    minimize.onmousedown = function dk_frame_minimize_onmousedown(event) {
        dk.frame.minimize(event.currentTarget);
    }

    var maximize = dk.gui.createElement(frame, "img", "dk_frame_maximize");
    maximize.setAttribute("src", "DKGui/maximize.png");
    maximize.style.position = "absolute";
    maximize.style.top = "0rem";
    maximize.style.right = "21rem";
    maximize.style.height = "20rem";
    maximize.onmousedown = function dk_frame_maximize_onmousedown(event) {
        dk.frame.maximize(event.currentTarget);
    }

    var close = dk.gui.createElement(frame, "img", "dk_frame_close");
    close.setAttribute("src", "DKGui/close.png");
    close.style.position = "absolute";
    close.style.top = "0rem";
    close.style.right = "0rem";
    close.style.height = "20rem";
    close.onmousedown = function dk_frame_close_onmousedown(event) {
        event.stopPropagation();
        dk.frame.close(event.currentTarget);
    }
    return frame;
}

dk.frame.createResize = function dk_frame_createResize(frame) {
    frame = dk.frame.setCurrentFrame(frame);
    if (!frame)
        return false;
    frame.resizeImage = dk.gui.createElement(frame, "img", "dk_frame_resizeImage");
    frame.resizeImage.setAttribute("src", "DKGui/resize.png");
    frame.resizeImage.style.removeProperty("top");
    frame.resizeImage.style.position = "absolute";
    frame.resizeImage.style.right = "0rem";
    frame.resizeImage.style.bottom = "0rem";
    frame.resizeImage.style.width = "18rem";
    frame.resizeImage.style.height = "18rem";

    frame.resizeCorner = dk.gui.createElement(frame, "div", "dk_frame_resize_corner");
    frame.resizeCorner.style.removeProperty("top");
    frame.resizeCorner.style.position = "absolute";
    frame.resizeCorner.style.right = "0rem";
    frame.resizeCorner.style.bottom = "0rem";
    frame.resizeCorner.style.width = "16rem";
    frame.resizeCorner.style.height = "16rem";
    frame.resizeCorner.style.cursor = "nw-resize";
    dk.drag.addResizeHandle(frame.resizeCorner, frame);

    frame.resizeTop = dk.gui.createElement(frame, "div", "dk_frame_resize_top");
    frame.resizeTop.style.removeProperty("bottom");
    frame.resizeTop.style.removeProperty("width");
    frame.resizeTop.style.position = "absolute";
    frame.resizeTop.style.top = "0rem";
    frame.resizeTop.style.left = "0rem";
    frame.resizeTop.style.right = "0rem";
    frame.resizeTop.style.height = "3rem";
    frame.resizeTop.style.cursor = "n-resize";
    dk.drag.addResizeHandle(frame.resizeTop, frame);

    frame.resizeLeft = dk.gui.createElement(frame, "div", "dk_frame_resize_left");
    frame.resizeLeft.style.removeProperty("right");
    frame.resizeLeft.style.removeProperty("height");
    frame.resizeLeft.style.position = "absolute";
    frame.resizeLeft.style.top = "0rem";
    frame.resizeLeft.style.bottom = "0rem";
    frame.resizeLeft.style.left = "0rem";
    frame.resizeLeft.style.width = "3rem";
    frame.resizeLeft.style.cursor = "e-resize";
    dk.drag.addResizeHandle(frame.resizeLeft, frame);

    frame.resizeRight = dk.gui.createElement(frame, "div", "dk_frame_resize_right");
    frame.resizeRight.style.removeProperty("left");
    frame.resizeRight.style.removeProperty("height");
    frame.resizeRight.style.position = "absolute";
    frame.resizeRight.style.top = "0rem";
    frame.resizeRight.style.bottom = "16rem";
    frame.resizeRight.style.right = "0rem";
    frame.resizeRight.style.width = "3rem";
    frame.resizeRight.style.cursor = "e-resize";
    dk.drag.addResizeHandle(frame.resizeRight, frame);
    
    frame.resizeBottom = dk.gui.createElement(frame, "div", "dk_frame_resize_bottom");
    frame.resizeBottom.style.removeProperty("top");
    frame.resizeBottom.style.removeProperty("width");
    frame.resizeBottom.style.position = "absolute";
    frame.resizeBottom.style.bottom = "0rem";
    frame.resizeBottom.style.left = "0rem";
    frame.resizeBottom.style.right = "16rem";
    frame.resizeBottom.style.height = "3rem";
    frame.resizeBottom.style.cursor = "n-resize";
    dk.drag.addResizeHandle(frame.resizeBottom, frame);

    return frame.resize;
}

dk.frame.maximize = function dk_frame_maximize(element) {
    if (!element || !element.parentNode)
        return error("element invalid");
    var frame = dk.frame.setCurrentFrame(element.parentNode);
    if (!frame)
        return false;
    var top = frame.style.top;
    var bottom = frame.style.bottom;
    var left = frame.style.left;
    var right = frame.style.right;
    if (top === "0rem" && bottom === "0rem" && left === "0rem" && right === "0rem" || top === "0px" && bottom === "0px" && left === "0px" && right === "0px") {
        dk.frame.restoreSize(frame);
        frame.content.style.width = parseInt(frame.style.width) + "rem";
        frame.content.style.height = parseInt(frame.style.height) - 21 + "rem";
    } else {
        dk.frame.storeSize(frame);
        frame.style.top = "0rem";
        frame.style.left = "0rem";
        frame.style.right = "0rem";
        frame.style.bottom = "0rem";
        frame.style.removeProperty("width");
        frame.style.removeProperty("height");
        frame.content.style.width = "100%";
        frame.content.style.height = "100%";
    }
}

dk.frame.minimize = function dk_frame_minimize(element) {
    if (!element || !element.parentNode)
        return error("element invalid");
    var frame = dk.frame.setCurrentFrame(element.parentNode);
    if (!frame)
        return error("frame invalid");
    //TODO
}

//FIXME - there is some work to be done here
dk.frame.reload = function dk_frame_reload(element) {
    if (!element || !element.id || !element.parentNode)
        return error("element invalid");
    var frame = dk.frame.setCurrentFrame(element.parentNode);
    if (!frame || !frame.content)
        return "frame invalid";
    const jsfile = frame.content.id.replace(".html", ".js");
    if (!jsfile)
        return error("jsfile invalid");
    const htmlfile = frame.content.id.replace(".js", ".html");
    if (!htmlfile)
        return error("htmlfile invalid");

    dk.frame.close(frame.content);
    dk.create(jsfile, function() {
        dk.frame.create(byId(htmlfile));
    });
}

dk.frame.setCurrentFrame = function dk_frame_setCurrentFrame(frame) {
    for (let n = 0; n < dk.frame.frames.length; n++) {
        if (dk.frame.frames[n] === frame) {
            return dk.frame.frames[n];
        }
    }
    return error("dk.frame.frames[n] invalid");
}

dk.frame.setTitle = function dk_frame_setTitle(element, title) {
    if (!element || !element.parentNode)
        return error("element invalid\n");
    if (typeof title !== "string")
        return error("title invalid\n");

    var frame = dk.frame.setCurrentFrame(element.parentNode);
    !frame.titlebar && (frame.titlebar = frame.firstChild);
    !frame.titlebar.text && (frame.titlebar.text = frame.titlebar.firstChild);
    frame.titlebar.text && (frame.titlebar.text.innerHTML = title);
    return true;
}

dk.frame.storeSize = function dk_frame_storeSize(frame) {
    var frame = dk.frame.setCurrentFrame(frame);
    if (!frame)
        return false;
    frame.top = frame.style.top;
    frame.bottom = frame.style.bottom;
    frame.left = frame.style.left;
    frame.right = frame.style.right;
    frame.width = frame.style.width;
    frame.height = frame.style.height;
    return true;
}

dk.frame.restoreSize = function dk_frame_restoreSize(frame) {
    var frame = dk.frame.setCurrentFrame(frame);
    if (!frame)
        return false;
    frame.style.top = frame.top;
    frame.style.bottom = frame.bottom;
    frame.style.left = frame.left;
    frame.style.right = frame.right;
    frame.style.width = frame.width;
    frame.style.height = frame.height;
    return true;
}

/*
dk.frame.iFrame = function dk_frame_Iframe(title, url, width, height) {
    if (typeof title !== "string")
        return error("title invalid\n");
    if (typeof url !== "string")
        return error("url invalid\n");

    var frame = dk.frame.createFrame(byId(title), width, height);
    var iframe = DKGui_CreateElement(frame, "iframe", title);
    iframe.src = url;
    // This will call DKRocketToRML::PostProcess() again
    iframe.width = "100%";
    iframe.height = "100%";
    iframe.style.borderWidth = "0rem";
    iframe.style.position = "absolute";
    iframe.style.top = "21rem";
    iframe.style.left = "0rem";
    iframe.style.width = "100%";
    iframe.style.bottom = "0rem";
    iframe.style.removeProperty("height");
    iframe.style.removeProperty("right");
    frame.addEventListener("mousedown", dk.frame.onevent);

    dk.frame.createResize(frame);

    //var currentBrowser = DKCef_GetCurrentBrowser();
    //DKCef_SetUrl(currentBrowser, url);
    //dk.frame.createResize(frame);
    //DKCef_SetFocus();
    return iframe;
}
*/