var sizes = [];

const dkframe = new Object;
dkframe.frames = new Array;


dkframe.Init = function DKFrame_Init() {}
dkframe.End = function DKFrame_End() {}

dkframe.onevent = function DKFrame_OnEvent(event) {
    if (event.type === "mousedown") {
        dkframe.bringToFront();
    }
    if (event.type === "dblclick") {
        var titlebar = event.currentTarget.parentNode;
        dkframe.maximizeButton(titlebar);
    }
    if (event.currentTarget.id && event.currentTarget.id.includes("DKFrame_reload")) {
        dkframe.reload(event.currentTarget);
    }
    if (event.currentTarget.id && event.currentTarget.id.includes("DKFrame_minimize")) {
        dkframe.minimizeButton(event.currentTarget);
    }
    if (event.currentTarget.id && event.currentTarget.id.includes("DKFrame_maximize")) {
       dkframe.MaximizeButton(event.currentTarget);
    }
    if (event.currentTarget.id && event.currentTarget.id.includes("DKFrame_close")) {
        dkframe.closeButton(event.currentTarget);
    }

    // FIXME - does not always fire
    if (event.type === "DKFrame_resize") {
        var frame = byId(event.currentTarget.id);
        if (!frame)
            return error("frame invalid");

        var child = frame.childNodes[4];
        byId(child.id).style.width = parseInt(byId(frame.id).style.width) + "rem";
        byId(child.id).style.height = parseInt(byId(frame.id).style.height) - 21 + "rem";
    }
}

dkframe.create = function DKFrame_Create(element) {
    if (!element)
        return error("element invalid\n");

    var title = DKFile_GetFilename(element.id);
    title && (title = title.replace(".html", ""));

    //stop if frame already exsists, multiple windows not ready yet.
    //if(DK_ElementExists(title+"_frame")){
    //	return warn("frame already exists\n");
    //}

    var width = element.style.width;
    var height = element.style.height;
    width = width.replace("px", "");
    height = height.replace("px", "");
    width = width.replace("rem", "");
    height = height.replace("rem", "");

    var frame = dkframe.createFrame(title, width, height);
    frame.appendChild(element);
    element.style.position = "absolute";
    element.style.top = "21rem";
    element.style.left = "0rem";
    element.style.width = "100%";
    element.style.bottom = "-1rem";
    element.style.removeProperty("right");
    element.style.removeProperty("height");

    dkframe.createResize(frame);
    return frame;
}

dkframe.setTitle = function DKFrame_SetTitle(element, title) {
    if (typeof element !== "object")
        return error("element invalid\n");
    if (typeof title !== "string")
        return error("title invalid\n");

    var frame = element.parentNode
    var titlebar = frame.firstChild;
    var titlebartext = titlebar.firstChild;
    titlebartext.innerHTML = title;
    return true;
}

dkframe.iFrame = function DKFrame_Iframe(title, url, width, height) {
    if (typeof title !== "string")
        return error("title invalid\n");
    if (typeof url !== "string")
        return error("url invalid\n");

    var frame = dkframe.createFrame(byId(title), width, height);
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
    frame.addEventListener("mousedown", dkframe.onevent);

    dkframe.createResize(frame);

    //var currentBrowser = DKCef_GetCurrentBrowser();
    //DKCef_SetUrl(currentBrowser, url);
    //dkframe.createResize(frame);
    //DKCef_SetFocus();
    return iframe;
}

dkframe.createFrame = function DKFrame_CreateFrame(title, width, height) {
    if (typeof title !== "string")
        return error("title invalid\n");
        
    (width === "100%") && (width = window.innerWidth - 100);
    (height === "100%") && (height = window.innerHeight - 21 - 100);
    !width && (width = window.innerWidth / 2);
    !height && (height = window.innerHeight / 2);
    
    var newheight = parseFloat(height) + 21;
    var newtop = parseFloat((window.innerHeight / 2) - (newheight / 2) - 1);
    var newleft = parseFloat((window.innerWidth / 2) - (width / 2) - 1)
    var frame = DKGui_CreateElement(document.body, "div", "DKFrame_frame");
    frame.style.position = "absolute";
    frame.style.overflow = "hidden";
    frame.style.top = newtop.toString() + "px";
    frame.style.left = newleft.toString() + "px";
    frame.style.width = width.toString() + "rem";
    frame.style.height = newheight.toString() + "rem";
    frame.style.backgroundColor = "rgb(150,150,150)";
    frame.style.borderColor = "rgb(0,0,0)";
    (DK_GetBrowser() !== "RML") && (frame.style.borderStyle = "solid");
    frame.style.borderWidth = "1rem";
    frame.style.minWidth = "62rem";
    frame.style.minHeight = "30rem";
    frame.addEventListener("mousedown", dkframe.onevent);

    var titlebar = DKGui_CreateElement(frame, "div", "DKFrame_titlebar");
    titlebar.style.position = "absolute";
    titlebar.style.width = "100%";
    titlebar.style.height = "21rem";
    titlebar.style.backgroundColor = "rgb(200,200,200)";

    var titlebartext = DKGui_CreateElement(titlebar, "div", "DKFrame_titlebartext");
    titlebartext.style.position = "absolute";
    titlebartext.style.width = "100%";
    titlebartext.style.height = "100%";
    titlebartext.style.paddingTop = "2rem";
    titlebartext.style.paddingLeft = "4rem";
    titlebartext.style.fontSize = "15rem";
    titlebartext.style.fontWeight = "bold";
    titlebartext.style.color = "rgb(25,25,25)";
    titlebartext.innerHTML = title;
    DKDrag_AddDragHandle(titlebartext, frame);
    titlebartext.ondblclick = function DKFrame_titlebartext_ondblclick(event){
        dkframe.maximize(event.currentTarget);
    };

    var reload = DKGui_CreateElement(frame, "img", "DKFrame_reload");
    reload.setAttribute("src", "DKGui/reload.png");
    reload.style.position = "absolute";
    reload.style.top = "1rem";
    reload.style.right = "65rem";
    reload.style.height = "18rem";
    reload.onmousedown = function DKFrame_reload_onmousedown(event){
        dkframe.reload(event.currentTarget);
    };

    var minimize = DKGui_CreateElement(frame, "img", "DKFrame_minimize");
    minimize.setAttribute("src", "DKGui/minimize.png");
    minimize.style.position = "absolute";
    minimize.style.top = "0rem";
    minimize.style.right = "42rem";
    minimize.style.height = "20rem;"
    minimize.onmousedown = function DKFrame_minimize_onmousedown(event){
        dkframe.minimize(event.currentTarget);
    };

    var maximize = DKGui_CreateElement(frame, "img", "DKFrame_maximize");
    maximize.setAttribute("src", "DKGui/maximize.png");
    maximize.style.position = "absolute";
    maximize.style.top = "0rem";
    maximize.style.right = "21rem";
    maximize.style.height = "20rem";
    maximize.onmousedown = function DKFrame_maximize_onmousedown(event){
        dkframe.maximize(event.currentTarget);
    };

    var close = DKGui_CreateElement(frame, "img", "DKFrame_close");
    close.setAttribute("src", "DKGui/close.png");
    close.style.position = "absolute";
    close.style.top = "0rem";
    close.style.right = "0rem";
    close.style.height = "20rem";
    close.onmousedown = function DKFrame_close_onmousedown(event){
        dkframe.close(event.currentTarget);
    };

    return frame;
}

dkframe.createResize = function DKFrame_CreateResize(frame) {
    var resize = DKGui_CreateElement(frame, "div", "DKFrame_resize");
    resize.style.removeProperty("top");
    resize.style.position = "absolute";
    resize.style.right = "0rem";
    resize.style.bottom = "0rem";
    resize.style.width = "16rem";
    resize.style.height = "16rem";

    var resizeImage = DKGui_CreateElement(resize, "img", "DKFrame_resizeImage");
    resizeImage.setAttribute("src", "DKGui/resize.png");
    resizeImage.style.position = "absolute";
    resizeImage.style.top = "0rem";
    resizeImage.style.right = "0rem";
    DKDrag_AddResizeHandle(resizeImage, frame);

    return resize;
}

dkframe.bringToFront = function DKFrame_BringToFront() {
    //FIXME: breaks mouse events on some elements
    return warn("FIXME");
    var element = document.elementFromPoint(window.mouseX, window.mouseY);
    if (!element)
        return error("element invalid");
    let frame = byId("DKFrame_frame");
    if (frame && frame.contains(element)) {
        (document.body.lastchild !== frame) && document.body.appendChild(frame);
        return true;
    }
    for (var n = 0; n < 100; n++) {
        frame = byId("DKFrame_frame" + n.toString());
        if (!frame)
            continue;
        if (frame.contains(element)) {
            (document.body.lastChild !== frame) && document.body.appendChild(frame);
            return true;
        }
    }
}

dkframe.minimize = function DKFrame_Minimize(element) {//TODO
}

dkframe.maximize = function DKFrame_Maximize(element) {
    var frame = element.parentNode;
    var top = frame.style.top;
    var bottom = frame.style.bottom;
    var left = frame.style.left;
    var right = frame.style.right;
    var elements = DK_GetElements(frame);
    var arry = elements.split(",");
    if (top === "0rem" && bottom === "0rem" && left === "0rem" && right === "0rem" || top === "0px" && bottom === "0px" && left === "0px" && right === "0px") {
        dkframe.restoreSize(frame);
        byId(arry[5]).style.width = parseInt(frame.style.width) + "rem";
        byId(arry[5]).style.height = parseInt(frame.style.height) - 21 + "rem";
    } else {
        dkframe.storeSize(frame);
        frame.style.top = "0rem";
        frame.style.left = "0rem";
        frame.style.right = "0rem";
        frame.style.bottom = "0rem";
        frame.style.removeProperty("width");
        frame.style.removeProperty("height");
        byId(arry[5]).style.width = "100%";
        byId(arry[5]).style.height = "100%";
    }
}

dkframe.close = function DKFrame_Close(element) {
    if (!element) {
        return error("element is invalid");
    }
    var frame = element.parentNode;
    var childrenStr = DK_GetElements(frame);
    var children = childrenStr.split(",");
    for (var n = children.length - 1; n > 0; n--) {
        if (children[n].indexOf(".html") > -1) {
            var file = children[n];
            var jsfile = file.replace(".html", ".js");
            jsfile && DK_Close(jsfile);
            var htmlfile = file.replace(".js", ".html");
            htmlfile && DK_Close(htmlfile);
        }
        /*
        //TODO if the Frame contains an iFrame, we need to call DKCef_CloseBrowser(n) on the associated iFrame
        if (children[n].indexOf("iframe_") > -1) {
            console.log("dkframe.close(" + id + "): we found a cef iframe (" + children[n] + ") to close\n");
            var frameId = children[n].replace("iframe_", "");
            for (var b = 0; b < DKCef_GetBrowsers(); b++) {
                //console.log("frameId = "+frameId+"\n");
                //console.log("DKCef_GetBrowserId("+b+") = "+DKCef_GetBrowserId(b)+"\n");
                if (frameId === DKCef_GetBrowserId(b)) {
                    DKCef_CloseBrowser(b);
                }
            }
        }
        */
    }

    if (frame === document.body) {
        return warn("frame === body");
    }

    //remove frame events 
    var index = frame.id.replace("DKFrame_frame", "");
    byId("DKFrame_frame" + index).removeEventListener("mousedown", dkframe.onevent);
    byId("DKFrame_close" + index).removeEventListener("click", dkframe.onevent);
    byId("DKFrame_maximize" + index).removeEventListener("click", dkframe.onevent);
    byId("DKFrame_minimize" + index).removeEventListener("click", dkframe.onevent);
    byId("DKFrame_reload" + index).removeEventListener("click", dkframe.onevent);
    byId("DKFrame_titlebartext" + index).removeEventListener("dblclick", dkframe.onevent);
    byId("DKFrame_frame" + index).removeEventListener("resize", dkframe.onevent);
    frame.parentNode.removeChild(frame);
}

dkframe.storeSize = function DKFrame_StoreSize(element) {
    var top = element.style.top;
    var bottom = element.style.bottom;
    var left = element.style.left;
    var right = element.style.right;
    var width = element.style.width;
    var height = element.style.height;

    for (var n = 0; n < sizes.length; n++) {
        if (sizes[n].indexOf(id) > -1) {
            sizes[n] = element.id + ":" + top + ":" + bottom + ":" + left + ":" + right + ":" + width + ":" + height;
            return true;
        }
    }
    sizes.push(element.id + ":" + top + ":" + bottom + ":" + left + ":" + right + ":" + width + ":" + height);
}

dkframe.restoreSize = function DKFrame_RestoreSize(element) {
    for (var n = 0; n < sizes.length; n++) {
        if (sizes[n].indexOf(element.id) > -1) {
            var arry = sizes[n].split(":");
            element.style.top = arry[1];
            element.style.bottom = arry[2];
            element.style.left = arry[3];
            element.style.right = arry[4];
            element.style.width = arry[5];
            element.style.height = arry[6];
            return true;
        }
    }
}

dkframe.closeAll = function DKFrame_CloseAll() {
    var children = DK_GetElements(document.body);
    var arry = children.split(",");
    for (var n = 0; n < arry.length; n++) {
        if (arry[n].indexOf("DKFrame_frame") > -1) {
            byId(arry[n]).parentNode.removeChild(byId(arry[n]));
        }
    }
}

dkframe.reload = function DKFrame_Reload(element) {
    var saved_id = element.id;
    var jsfile;
    var htmlfile;

    var frame = element.parentNode;
    var childrenStr = DK_GetElements(frame);
    var children = childrenStr.split(",");
    for (var n = children.length - 1; n > 0; n--) {
        if (children[n].indexOf(".html") > -1) {
            var file = children[n];
            jsfile = file.replace(".html", ".js");
            htmlfile = file.replace(".js", ".html");
        }
    }

    if(!jsfile)
        return error("jsfile invalid");
    if(!htmlfile)
        return error("htmlfile invalid");
    const htmlElement = byId(htmlfile);
    if(!htmlElement){
        return error("htmlElement invalid");
    }

    dkframe.close(htmlElement);
    DK_Create(jsfile, function() {
        dkframe.create(byId(htmlfile));
    });
}
