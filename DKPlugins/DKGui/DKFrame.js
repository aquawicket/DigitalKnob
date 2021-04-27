"use strict";

dk.frame = new Object;
dk.frame.frames = new Array;

dk.frame.Init = function dk_frame_Init() {}
dk.frame.End = function dk_frame_End() {}


dk.frame.create = function dk_frame_create(obj) {
    if (!obj)
        return error("obj invalid");
    let element;
    if (obj instanceof DKWidget) {
        element = obj.getElement();
    } else {
        console.warn("dk.frame.create(): obj is not a instance of DKWidget. It is recommended to dirive from a new DKWidget instance")
        element = obj;
        if (!element.id)
            return error("element.id invalid");
    }

    var title = dk.file.getFilename(element.id);
    title && (title = title.replace(".html", ""));

    var width = element.style.width;
    var height = element.style.height;
    !width.includes("%") && (width = parseInt(width));
    !height.includes("%") && (height = parseInt(height));
    //width = width.replace("rem", "");
    //height = height.replace("rem", "");

    let frame = dk.frame.createFrame(title, width, height);
    if (obj instanceof DKWidget)
        frame.contentInstance = obj;
    frame.content = element;
    frame.content.setAttribute("dk_frame", "content");
    frame.appendChild(frame.content);
    frame.resize = dk.resize.create(frame);
    return this;
}

dk.frame.close = function dk_frame_close(obj) {
    console.debug("dk.frame.close() called");
    //Remove the contents of the frame
    if (!obj)
        return error("obj invalid");

    var frame = this.getFrame(obj);
    if (!frame)
        return error("frame invalid");

    if (frame && frame.contentInstance && frame.contentInstance instanceof DKWidget) {
        console.debug("dk.frame.close(): frame.contentInstance is an instanceof DKWidget");
        frame.contentInstance.close();
    } else if (frame.content && frame.content.id && frame.content.id.includes(".html")) {
        console.debug("dk.frame.close(): obj seems to be a plugin sill closing by filename ");
        var htmlfile = frame.content.id;
        var jsfile = htmlfile.replace(".html", ".js");
        jsfile && dk.close(jsfile);
        htmlfile && dk.close(htmlfile);
    } else {
        console.info("Not a dkplugin, just some javascript html. we can just close the frame.")
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

    //Remove the frame and it's instance
    //console.debug("closing the frame");
    if (frame === document.body)
        return warn("frame === document.body");
    frame.parentNode && frame.parentNode.removeChild(frame);
    var index = dk.frame.frames.indexOf(frame);
    if (index > -1)
        dk.frame.frames.splice(index, 1);
    return true;
}

dk.frame.getFrame = function dk_frame_getFrame(obj) {
    if (!obj)
        return error("obj invalid");
    let element;
    if (obj instanceof DKWidget) {
        element = obj.getElement();
    }else{
        element = obj;
    }
    while (element && element !== document) {
        for (let n = 0; n < dk.frame.frames.length; n++) {
            if (dk.frame.frames[n] === element)
                return dk.frame.frames[n];
        }
        element = element.parentElement;
    }
    return error("dk.frame.frames[n] invalid");
}

dk.frame.closeAll = function dk_frame_closeAll() {
    for (var n = 0; n < dk.frame.frames.length; n++)
        dk.frame.close(dk.frame.frames[n].content);
    return true;
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
    frame = dk.frame.getFrame(frame);
    if (!frame)
        return error("frame invalid");

    //See DKFrame.css for styling    
    frame.setAttribute("dk_frame", "frame");
    frame.style.top = newtop + "px";
    frame.style.left = newleft + "px";
    frame.style.width = width + "rem";
    frame.style.height = newheight + "rem";
    frame.onmousedown = function dk_frame_frame_onmousedown(event) {
        (document.body.lastChild !== frame) && (frame.mousedown_target = event.target);
        dk.frame.bringToFront(event.currentTarget);
    }
    frame.onmouseup = function dk_frame_frame_onmouseup(event) {
        (frame.mousedown_target == event.target) && event.target.click();
        frame.mousedown_target = null;
    }

    //See DKFrame.css for styling
    frame.titlebar = dk.gui.createElement(frame, "div", "dk_frame_titlebar");
    frame.titlebar.setAttribute("dk_frame", "titlebar");
    frame.titlebar.ondblclick = function dk_frame_titlebar_ondblclick(event) {
        event.stopPropagation();
        dk.frame.maximize(event.currentTarget);
    }
    dk.drag.addHandle(frame.titlebar, frame);

    frame.titlebaricon = dk.gui.createElement(frame.titlebar, "img", "dk_frame_titlebaricon");
    frame.titlebaricon.setAttribute("dk_frame", "titlebaricon");

    //See DKFrame.css for styling
    frame.titlebartext = dk.gui.createElement(frame.titlebar, "div", "dk_frame_titlebartext");
    frame.titlebartext.setAttribute("dk_frame", "titlebartext");
    frame.titlebartext.innerHTML = title;

    frame.reload = dk.gui.createElement(frame.titlebar, "img", "dk_frame_reload");
    frame.reload.setAttribute("dk_frame", "reload");
    frame.reload.setAttribute("src", "DKGui/reload.png");
    frame.reload.onmousedown = function dk_frame_reload_onmousedown(event) {
        event.stopPropagation();
        dk.frame.reload(event.currentTarget);
    }

    frame.minimize = dk.gui.createElement(frame.titlebar, "img", "dk_frame_minimize");
    frame.minimize.setAttribute("dk_frame", "minimize");
    frame.minimize.setAttribute("src", "DKGui/minimize.png");
    frame.minimize.onmousedown = function dk_frame_minimize_onmousedown(event) {
        event.stopPropagation();
        dk.frame.minimize(event.currentTarget);
    }

    frame.maximize = dk.gui.createElement(frame.titlebar, "img", "dk_frame_maximize");
    frame.maximize.setAttribute("dk_frame", "maximize");
    frame.maximize.setAttribute("src", "DKGui/maximize.png");
    frame.maximize.onmousedown = function dk_frame_maximize_onmousedown(event) {
        event.stopPropagation();
        dk.frame.maximize(event.currentTarget);
    }

    frame.close = dk.gui.createElement(frame.titlebar, "img", "dk_frame_close");
    frame.close.setAttribute("dk_frame", "close");
    frame.close.setAttribute("src", "DKGui/close.png");
    frame.close.onmousedown = function dk_frame_close_onmousedown(event) {
        event.stopPropagation();
        dk.frame.close(event.currentTarget);
    }
    return frame;
}

dk.frame.bringToFront = function dk_frame_bringToFront(frame) {
    frame = dk.frame.getFrame(frame);
    if (!frame)
        return false;
    (document.body.lastChild !== frame) && document.body.appendChild(frame);
}

dk.frame.maximize = function dk_frame_maximize(obj) {
    if (!obj)
        return error("obj invalid");
    const frame = dk.frame.getFrame(obj);
    if (!frame)
        return error("frame invalid");
    if (frame.maximized) {
        dk.frame.restoreSize(frame);
        frame.content.style.width = parseInt(frame.style.width) + "rem";
        frame.content.style.height = parseInt(frame.style.height) - 21 + "rem";
        frame.maximized = false;
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
        frame.maximized = true;
    }
}

dk.frame.minimize = function dk_frame_minimize(obj) {
    if (!obj)
        return error("obj invalid");
    var frame = dk.frame.getFrame(obj);
    if (!frame)
        return error("frame invalid");
    var top = frame.style.top;
    var bottom = frame.style.bottom;
    var left = frame.style.left;
    var right = frame.style.right;
    if (!frame.minimized) {
        dk.frame.storeSize(frame);
        frame.style.left = "0rem";
        frame.style.bottom = "0rem";
        frame.style.width = frame.titlebartext.offsetWidth;
        frame.style.height = "20rem";
        frame.style.removeProperty("top");
        frame.style.removeProperty("right");
        //frame.content.style.width = "100%";
        //frame.content.style.height = "100%";
        frame.reload.style.visibility = "hidden";
        frame.minimize.style.visibility = "hidden";
        frame.maximize.style.visibility = "hidden";
        frame.close.style.visibility = "hidden";
        frame.resize.image.style.visibility = "hidden";
        frame.resize.corner.style.visibility = "hidden";
        frame.titlebar.onclick = function dk_frame_titlebar_onclick(event) {
            event.stopPropagation();
            dk.frame.minimize(frame.minimize);
        }
        frame.minimized = true;
    } else {
        dk.frame.restoreSize(frame);
        frame.reload.style.visibility = "visible";
        frame.minimize.style.visibility = "visible";
        frame.maximize.style.visibility = "visible";
        frame.close.style.visibility = "visible";
        frame.resize.image.style.visibility = "visible";
        frame.resize.corner.style.visibility = "visible";
        frame.titlebar.onclick = null;
        frame.minimized = false;
    }
}

dk.frame.reload = function dk_frame_reload(obj) {
    if (!obj)
        return error("obj invalid");
    var frame = dk.frame.getFrame(obj);
    if (!frame)
        return "frame invalid";
    
    console.debug("FIXME: more work to be down to complete dk.frame.reload()");
    return false;

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

dk.frame.setTitle = function dk_frame_setTitle(obj, title) {
    if (!obj)
        return error("obj invalid");
    if (!title)
        return error("title invalid");
    var frame = dk.frame.getFrame(obj);
    if (!frame)
        return error("frame invalid");
    frame.titlebartext && (frame.titlebartext.innerHTML = title);
    return true;
}

dk.frame.storeSize = function dk_frame_storeSize(frame) {
    var frame = dk.frame.getFrame(frame);
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
    var frame = dk.frame.getFrame(frame);
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
dk.frame.createNewWindow = function dk_frame_createNewWindow(title, width, height) {
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
*/

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
    frame.onmousedown = dk.frame.onevent;

    dk.frame.createResize(frame);

    //var currentBrowser = DKCef_GetCurrentBrowser();
    //DKCef_SetUrl(currentBrowser, url);
    //dk.frame.createResize(frame);
    //DKCef_SetFocus();
    return iframe;
}
*/
