"use strict";

dk.frame = new Object;
dk.frame.frames = new Array;

dk.frame.Init = function dk_frame_Init() {}
dk.frame.End = function dk_frame_End() {}

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
    for (var n = 0; n < dk.frame.frames.length; n++) {
        dk.frame.close(dk.frame.frames[n].content);
    }
    return true;
}

dk.frame.create = function dk_frame_create(element) {
    if (!element)
        return error("element invalid");
    if (!element.id)
        return error("element.id invalid");

    var title = DKFile_GetFilename(element.id);
    title && (title = title.replace(".html", ""));

    //stop if frame already exsists, multiple windows not ready yet.
    //if(DK_ElementExists(title+"_frame")){
    //	return warn("frame already exists\n");
    //}

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
    let frame = DKGui_CreateElement(document.body, "div", "dk_frame_frame");
    dk.frame.frames.push(frame);
    frame = dk.frame.setCurrentFrame(frame);
    if (!frame)
        return false;

    frame.style.position = "absolute";
    frame.style.overflow = "hidden";
    frame.style.top = newtop + "px";
    frame.style.left = newleft + "px";
    frame.style.width = width + "rem";
    frame.style.height = newheight + "rem";
    frame.style.backgroundColor = "rgb(150,150,150)";
    frame.style.borderColor = "rgb(0,0,0)";
    (dk.getBrowser() !== "RML") && (frame.style.borderStyle = "solid");
    frame.style.borderWidth = "1rem";
    frame.style.minWidth = "62rem";
    frame.style.minHeight = "30rem";
    frame.onmousedown = function dk_frame_frame_onmousedown(event) {
        dk.frame.bringToFront(event.currentTarget);
    }

    frame.titlebar = DKGui_CreateElement(frame, "div", "dk_frame_titlebar");
    frame.titlebar.style.position = "absolute";
    frame.titlebar.style.width = "100%";
    frame.titlebar.style.height = "21rem";
    frame.titlebar.style.backgroundColor = "rgb(200,200,200)";
    frame.titlebar.ondblclick = function dk_frame_titlebar_ondblclick(event) {
        dk.frame.maximize(event.currentTarget);
    }
    ;
    DKDrag_AddDragHandle(frame.titlebar, frame);

    frame.titlebar.text = DKGui_CreateElement(frame.titlebar, "div", "dk_frame_titlebartext");
    frame.titlebar.text.style.position = "absolute";
    frame.titlebar.text.style.width = "100%";
    frame.titlebar.text.style.height = "100%";
    frame.titlebar.text.style.paddingTop = "2rem";
    frame.titlebar.text.style.paddingLeft = "4rem";
    frame.titlebar.text.style.fontSize = "15rem";
    frame.titlebar.text.style.fontWeight = "bold";
    frame.titlebar.text.style.color = "rgb(25,25,25)";
    frame.titlebar.text.style.cursor = "default";
    frame.titlebar.text.innerHTML = title;

    frame.reload = DKGui_CreateElement(frame, "img", "dk_frame_reload");
    frame.reload.setAttribute("src", "DKGui/reload.png");
    frame.reload.style.position = "absolute";
    frame.reload.style.top = "1rem";
    frame.reload.style.right = "65rem";
    frame.reload.style.height = "18rem";
    frame.reload.onmousedown = function dk_frame_reload_onmousedown(event) {
        dk.frame.reload(event.currentTarget);
    }

    var minimize = DKGui_CreateElement(frame, "img", "dk_frame_minimize");
    minimize.setAttribute("src", "DKGui/minimize.png");
    minimize.style.position = "absolute";
    minimize.style.top = "0rem";
    minimize.style.right = "42rem";
    minimize.style.height = "20rem;"
    minimize.onmousedown = function dk_frame_minimize_onmousedown(event) {
        dk.frame.minimize(event.currentTarget);
    }

    var maximize = DKGui_CreateElement(frame, "img", "dk_frame_maximize");
    maximize.setAttribute("src", "DKGui/maximize.png");
    maximize.style.position = "absolute";
    maximize.style.top = "0rem";
    maximize.style.right = "21rem";
    maximize.style.height = "20rem";
    maximize.onmousedown = function dk_frame_maximize_onmousedown(event) {
        dk.frame.maximize(event.currentTarget);
    }

    var close = DKGui_CreateElement(frame, "img", "dk_frame_close");
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
    frame.resize = DKGui_CreateElement(frame, "div", "dk_frame_resize");
    frame.resize.style.removeProperty("top");
    frame.resize.style.position = "absolute";
    frame.resize.style.right = "0rem";
    frame.resize.style.bottom = "0rem";
    frame.resize.style.width = "16rem";
    frame.resize.style.height = "16rem";

    frame.resizeImage = DKGui_CreateElement(frame.resize, "img", "dk_frame_resizeImage");
    frame.resizeImage.setAttribute("src", "DKGui/resize.png");
    frame.resizeImage.style.position = "absolute";
    frame.resizeImage.style.top = "0rem";
    frame.resizeImage.style.right = "0rem";
    DKDrag_AddResizeHandle(frame.resizeImage, frame);
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
        return false;
    //TODO
}

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
