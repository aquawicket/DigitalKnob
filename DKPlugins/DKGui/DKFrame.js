"use strict";

function DKFrame() {}
DKFrame.prototype.init = function DKFrame_init() {
    dk.create("DKGui/DKFrame.css");
}
DKFrame.prototype.end = function DKFrame_end() {
    //dk.close("DKGui/DKFrame.css");
}

DKFrame.prototype.create = function DKFrame_create(obj) {
    let id = "Generic Frame";
    let element = null;

    for (let key in obj) {
        if (obj[key]instanceof HTMLElement) {
            obj.id && (id = obj.id);
            element = obj[key];

            //if (element.panel)
            //    break;
            if (element.id && element.id.includes(".html"))
                break;
        }
    }

    //HTMLElement
    if (obj instanceof HTMLElement)
        element = obj;

    let instance = null;
    if (obj.klassName === "DKFrame")
        instance = obj;
    else
        instance = DKPlugin(DKFrame)

    obj.dkplugin && (instance.dkplugin = obj);
    obj.dkframe = instance;

    var width = element.style.width;
    var height = element.style.height;
    !width.includes("%") && (width = parseInt(width));
    !height.includes("%") && (height = parseInt(height));

    const frame = instance.createFrame("New Window", width, height);
    instance.frame = frame;

    frame.content = element;
    frame.content.setAttribute("dk_frame", "content");
    frame.content.style = {
        position: "absolute",
        top: "21rem",
        bottom: "0rem",
        left: "0rem",
        right: "0rem",
        width: "unset",
        height: "unset"
    }
    frame.appendChild(frame.content);
    frame.resize = DKResize.prototype.createBox(frame);
    return instance;
}

DKFrame.prototype.createFrame = function DKFrame_createFrame(title, width, height) {
    const instance = this;
    if (typeof title !== "string")
        return error("title invalid\n");
    const scale = 200;
    (width === "100%") && (width = window.innerWidth - scale);
    (height === "100%") && (height = window.innerHeight - 21 - scale);
    !width && (width = window.innerWidth / 2);
    !height && (height = window.innerHeight / 2);

    var newheight = parseFloat(height) + 21;
    var newtop = parseFloat((window.innerHeight / 2) - (newheight / 2) - 1);
    var newleft = parseFloat((window.innerWidth / 2) - (width / 2) - 1)
    let frame = dk.gui.createElement(document.body, "div", "dk_frame_box");
    this.frame = frame;

    //See DKFrame.css for styling    
    frame.setAttribute("dk_frame", "frame");
    frame.style.top = newtop + "px";
    frame.style.left = newleft + "px";
    frame.style.width = width + "rem";
    frame.style.height = newheight + "rem";
    frame.onmousedown = function DKFrame_frame_onmousedown(event) {
        (document.body.lastChild !== frame) && (frame.mousedown_target = event.target);
        instance.bringToFront(event.currentTarget);
    }
    frame.onmouseup = function DKFrame_frame_onmouseup(event) {
        (frame.mousedown_target == event.target) && event.target.click();
        frame.mousedown_target = null;
    }

    //See DKFrame.css for styling
    frame.titlebar = dk.gui.createElement(frame, "div", "dk_frame_titlebar");
    frame.titlebar.setAttribute("dk_frame", "titlebar");
    frame.titlebar.ondblclick = function DKFrame_titlebar_ondblclick(event) {
        event.stopPropagation();
        instance.maximize();
    }
    dk.drag.addHandle(frame.titlebar, frame);

    frame.titlebaricon = dk.gui.createElement(frame.titlebar, "img", "dk_frame_titlebaricon");
    frame.titlebaricon.src = "DKGui/window.png";
    frame.titlebaricon.setAttribute("dk_frame", "titlebaricon");

    //See DKFrame.css for styling
    frame.titlebartext = dk.gui.createElement(frame.titlebar, "div", "dk_frame_titlebartext");
    frame.titlebartext.setAttribute("dk_frame", "titlebartext");
    frame.titlebartext.innerHTML = title;

    frame.reload = dk.gui.createElement(frame.titlebar, "img", "dk_frame_reload");
    frame.reload.setAttribute("dk_frame", "reload");
    frame.reload.setAttribute("src", "DKGui/reload.png");
    frame.reload.onmousedown = function DKFrame_reload_onmousedown(event) {
        event.stopPropagation();
        instance.reload();
    }

    frame.minimize = dk.gui.createElement(frame.titlebar, "img", "dk_frame_minimize");
    frame.minimize.setAttribute("dk_frame", "minimize");
    frame.minimize.setAttribute("src", "DKGui/minimize.png");
    frame.minimize.onmousedown = function DKFrame_minimize_onmousedown(event) {
        event.stopPropagation();
        instance.minimize();
    }

    frame.maximize = dk.gui.createElement(frame.titlebar, "img", "dk_frame_maximize");
    frame.maximize.setAttribute("dk_frame", "maximize");
    frame.maximize.setAttribute("src", "DKGui/maximize.png");
    frame.maximize.onmousedown = function DKFrame_maximize_onmousedown(event) {
        event.stopPropagation();
        instance.maximize();
    }

    frame.close = dk.gui.createElement(frame.titlebar, "img", "dk_frame_close");
    frame.close.setAttribute("dk_frame", "close");
    frame.close.setAttribute("src", "DKGui/close.png");
    frame.close.onmousedown = function DKFrame_close_onmousedown(event) {
        event.stopPropagation();
        instance.dkplugin.close();
        instance.close();
    }
    return frame;
}

DKFrame.prototype.bringToFront = function DKFrame_bringToFront(frame) {
    (document.body.lastChild !== frame) && document.body.appendChild(frame);
}

DKFrame.prototype.maximize = function DKFrame_maximize() {
    if (this.frame.maximized) {
        this.restoreSize(this.frame);
        this.frame.content.style.width = parseInt(this.frame.style.width) + "rem";
        this.frame.content.style.height = parseInt(this.frame.style.height) - 21 + "rem";
        this.frame.maximized = false;
    } else {
        this.storeSize(this.frame);
        this.frame.style.top = "0rem";
        this.frame.style.left = "0rem";
        this.frame.style.right = "0rem";
        this.frame.style.bottom = "0rem";
        this.frame.style.removeProperty("width");
        this.frame.style.removeProperty("height");
        this.frame.content.style.width = "100%";
        this.frame.content.style.height = "100%";
        this.frame.maximized = true;
    }
}

DKFrame.prototype.minimize = function DKFrame_minimize() {
    var top = this.frame.style.top;
    var bottom = this.frame.style.bottom;
    var left = this.frame.style.left;
    var right = this.frame.style.right;
    if (!this.frame.minimized) {
        this.storeSize(this.frame);
        this.frame.style.left = "0rem";
        this.frame.style.bottom = "0rem";
        this.frame.style.width = this.frame.titlebartext.offsetWidth;
        this.frame.style.height = "20rem";
        this.frame.style.removeProperty("top");
        this.frame.style.removeProperty("right");
        //this.frame.content.style.width = "100%";
        //this.frame.content.style.height = "100%";
        this.frame.reload.style.visibility = "hidden";
        this.frame.minimize.style.visibility = "hidden";
        this.frame.maximize.style.visibility = "hidden";
        this.frame.close.style.visibility = "hidden";
        this.frame.resize.image.style.visibility = "hidden";
        this.frame.resize.corner.style.visibility = "hidden";
        const instance = this;
        this.frame.titlebar.onclick = function DKFrame_titlebar_onclick(event) {
            event.stopPropagation();
            instance.minimize(instance.frame.minimize);
        }
        this.frame.minimized = true;
    } else {
        this.restoreSize(this.frame);
        this.frame.reload.style.visibility = "visible";
        this.frame.minimize.style.visibility = "visible";
        this.frame.maximize.style.visibility = "visible";
        this.frame.close.style.visibility = "visible";
        this.frame.resize.image.style.visibility = "visible";
        this.frame.resize.corner.style.visibility = "visible";
        this.frame.titlebar.onclick = null;
        this.frame.minimized = false;
    }
}

DKFrame.prototype.reload = function DKFrame_reload() {
    console.log("DKFrame.prototype.reload()");
    const url = this.dkplugin.prototype.url
    this.dkplugin.close();
    this.frame.parentNode.removeChild(this.frame);
    DKPlugin.prototype.close.call(this);

    //open everything back up
    const instance = this;
    DKPlugin(url, function() {
        instance.dkplugin.create();
    });
    return true;
}

DKFrame.prototype.setTitle = function DKFrame_setTitle(title) {
    this.frame.titlebartext.innerHTML = title;
    return true;
}

DKFrame.prototype.setIcon = function DKFrame_setIcon(url) {
    this.frame.titlebaricon.src = url;
    return true;
}

DKFrame.prototype.storeSize = function DKFrame_storeSize(frame) {
    frame.top = frame.style.top;
    frame.bottom = frame.style.bottom;
    frame.left = frame.style.left;
    frame.right = frame.style.right;
    frame.width = frame.style.width;
    frame.height = frame.style.height;
    return true;
}

DKFrame.prototype.restoreSize = function DKFrame_restoreSize(frame) {
    frame.style.top = frame.top;
    frame.style.bottom = frame.bottom;
    frame.style.left = frame.left;
    frame.style.right = frame.right;
    frame.style.width = frame.width;
    frame.style.height = frame.height;
    return true;
}

DKFrame.prototype.createNewWindow = function DKFrame_createNewWindow(title, width, height, url) {
    const instance = DKPlugin(DKFrame, title)
    //if (!instance.ok) {
    //    instance.frame && DKFrame.prototype.bringToFront(instance.frame);
    //    return false;
    //}
    url && instance.dkplugin.prototype.url
    instance.div = document.createElement("div")
    instance.div.id = title + ".html"
    instance.div.style.width = width
    instance.div.style.height = height
    instance.div.style.overflow = "auto"
    instance.div.style.backgroundColor = "grey"
    this.create(instance)
    return instance.div
}

/*
DKFrame.prototype.iFrame = function DKFrame_Iframe(title, url, width, height) {
    if (typeof title !== "string")
        return error("title invalid\n");
    if (typeof url !== "string")
        return error("url invalid\n");

    var frame = this.createFrame(byId(title), width, height);
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
    frame.onmousedown = this.onevent;

    this.createResize(frame);

    //var currentBrowser = DKCef_GetCurrentBrowser();
    //DKCef_SetUrl(currentBrowser, url);
    //this.createResize(frame);
    //DKCef_SetFocus();
    return iframe;
}
*/
