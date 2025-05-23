//"use strict";

function DKFrame(){}

DKFrame.prototype.init = function DKFrame_init(){
    dk.create("DKGui/DKFrame.css");
}
DKFrame.prototype.end = function DKFrame_end(){
	//dk.close("DKGui/DKFrame.css");
}

DKFrame.prototype.create = function DKFrame_create(obj){
    //dk.dumpVariable(obj);

    var instance;
    var type;
    var element;
    if (obj && obj instanceof DKFrame)
        type = "DKFrame"
    else if (obj && obj instanceof HTMLElement){
        type = "HTMLElement"
        element = obj;
    } 
	else if (obj && obj instanceof DKPlugin)
        type = "DKPlugin"
    else if (obj && obj.dkplugin)
        type = "DKPlugin"
    else if (obj && typeof obj === "string")
        type = "string"
    else if (obj && obj.constructor.name)
        type = obj.constructor.name
    else
        return error("Could not determine argument type")

    console.debug("DKFrame.prototype.create(" + type + ")")

    instance = DKPlugin(DKFrame)

    if (obj instanceof HTMLElement)
        element = obj;
    else {
        for (var key in obj){
            if (obj[key]instanceof HTMLElement){
                element = obj[key];
                if (element.id && element.id.includes(".html"))
                    break;
            }
        }
    }

    obj.dkplugin && (instance.dkplugin = obj);
    obj.dkframe = instance;

    var width = element.style.width;
    var height = element.style.height;
    !width.includes("%") && (width = parseInt(width));
    !height.includes("%") && (height = parseInt(height));

    instance.frame = instance.createFrame("New Window", width, height);
    instance.frame.content = element;
    Object.assign(instance.frame.content, {
        position: "absolute",
        top: "21rem",
        bottom: "0rem",
        left: "0rem",
        right: "0rem",
        width: "unset",
        height: "unset"
    })
	instance.frame.content.setAttribute("id", "dk_frame_content");
    instance.frame.content.setAttribute("dk_frame", "content");
    instance.frame.appendChild(instance.frame.content);
	DKPlugin("DKGui/DKResize.js", function(DKClass){
		if(!DKClass)
			return error("DKClass invalid")
		console.log("DKClass = "+DKClass)
		
		//if(!DKClass.prototype)
		//	return error("DKClass.prototype invalid")
        
		//instance.resize = DKClass.prototype.createBox(instance.frame);
		this.resize = null
    })
    return instance;
}

DKFrame.prototype.close = function DKFrame_close(){
    this.resize && this.resize.close && this.resize.close();
    this.dkplugin && this.dkplugin.close && this.dkplugin.close();
}

DKFrame.prototype.createFrame = function DKFrame_createFrame(title, width, height){
    var instance = this;
    if (typeof title !== "string")
        return error("title invalid\n");
    var scale = 200;
    (width === "100%") && (width = window.innerWidth - scale);
    (height === "100%") && (height = window.innerHeight - 21 - scale);
    !width && (width = window.innerWidth / 2);
    !height && (height = window.innerHeight / 2);

    var newheight = parseFloat(height) + 21;
    var newtop = parseFloat((window.innerHeight / 2) - (newheight / 2) - 1);
    var newleft = parseFloat((window.innerWidth / 2) - (width / 2) - 1)
    var frame = dk.gui.createElement(document.body, "div", "dk_frame_box");
    this.frame = frame;

    //See DKFrame.css for styling
	frame.setAttribute("id", "dk_frame_frame");
    frame.setAttribute("dk_frame", "frame");
    frame.style.position = "absolute";
	frame.style.top = newtop + "px";
    frame.style.left = newleft + "px";
    frame.style.width = width + "rem";
    frame.style.height = newheight + "rem";
    frame.onmousedown = function DKFrame_frame_onmousedown(event){
        (document.body.lastChild !== frame) && (frame.mousedown_target = event.target);
        instance.bringToFront(event.currentTarget);
    }
    frame.onmouseup = function DKFrame_frame_onmouseup(event){
        (frame.mousedown_target == event.target) && event.target.click();
        frame.mousedown_target = null;
    }

    //See DKFrame.css for styling
    frame.titlebar = dk.gui.createElement(frame, "div", "dk_frame_titlebar");
	frame.titlebar.setAttribute("id", "dk_frame_titlebar");
    frame.titlebar.setAttribute("dk_frame", "titlebar");
    frame.titlebar.ondblclick = function DKFrame_titlebar_ondblclick(event){
        event.stopPropagation();
        instance.maximize();
    }
    dk.drag.addHandle(frame.titlebar, frame);

    //frame.titlebaricon = dk.gui.createElement(frame.titlebar, "img", "dk_frame_titlebaricon");
    //frame.titlebaricon.src = "DKGui/window.png";
    //frame.titlebaricon.setAttribute("dk_frame", "titlebaricon");

    //See DKFrame.css for styling
    frame.titlebartext = dk.gui.createElement(frame.titlebar, "div", "dk_frame_titlebartext");
	frame.titlebartext.setAttribute("id", "dk_frame_titlebartext");
    frame.titlebartext.setAttribute("dk_frame", "titlebartext");
    frame.titlebartext.innerHTML = title;

    frame.reload = dk.gui.createElement(frame.titlebar, "img", "dk_frame_reload");
	frame.reload.setAttribute("id", "dk_frame_reload");
    frame.reload.setAttribute("dk_frame", "reload");
    frame.reload.setAttribute("src", "DKGui/reload.png");
    frame.reload.onmousedown = function DKFrame_reload_onmousedown(event){
        event.stopPropagation();
        instance.reload();
    }

    frame.minimize = dk.gui.createElement(frame.titlebar, "img", "dk_frame_minimize");
	frame.minimize.setAttribute("id", "dk_frame_minimize");
    frame.minimize.setAttribute("dk_frame", "minimize");
    frame.minimize.setAttribute("src", "DKGui/minimize.png");
    frame.minimize.onmousedown = function DKFrame_minimize_onmousedown(event){
        event.stopPropagation();
        instance.minimize();
    }

    frame.maximize = dk.gui.createElement(frame.titlebar, "img", "dk_frame_maximize");
	frame.maximize.setAttribute("id", "dk_frame_maximize");
    frame.maximize.setAttribute("dk_frame", "maximize");
    frame.maximize.setAttribute("src", "DKGui/maximize.png");
    frame.maximize.onmousedown = function DKFrame_maximize_onmousedown(event){
        event.stopPropagation();
        instance.maximize();
    }

    frame.close = dk.gui.createElement(frame.titlebar, "img", "dk_frame_close");
	frame.close.setAttribute("id", "dk_frame_close");
    frame.close.setAttribute("dk_frame", "close");
    frame.close.setAttribute("src", "DKGui/close.png");
    frame.close.onmousedown = function DKFrame_close_onmousedown(event){
        event.stopPropagation();
        instance.close();
    }
    return frame;
}

DKFrame.prototype.bringToFront = function DKFrame_bringToFront(frame){
    (document.body.lastChild !== frame) && document.body.appendChild(frame);
}

DKFrame.prototype.maximize = function DKFrame_maximize(){
    if (this.frame.maximized){
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

DKFrame.prototype.minimize = function DKFrame_minimize(){
    var top = this.frame.style.top;
    var bottom = this.frame.style.bottom;
    var left = this.frame.style.left;
    var right = this.frame.style.right;
    if (!this.frame.minimized){
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
        var instance = this;
        this.frame.titlebar.onclick = function DKFrame_titlebar_onclick(event){
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

DKFrame.prototype.reload = function DKFrame_reload(){
    console.log("DKFrame.prototype.reload()");
    var url = this.dkplugin.prototype.url
    this.dkplugin.close();
    this.frame.parentNode.removeChild(this.frame);
    DKPlugin.prototype.close.call(this);

    //open everything back up
    var instance = this;
    DKPlugin(url, function(){
        instance.dkplugin.create();
    });
    return true;
}

DKFrame.prototype.setTitle = function DKFrame_setTitle(title){
    this.frame.titlebartext.innerHTML = title;
    return true;
}

DKFrame.prototype.setIcon = function DKFrame_setIcon(url){
    this.frame.titlebaricon.src = url;
    return true;
}

DKFrame.prototype.storeSize = function DKFrame_storeSize(frame){
    frame.top = frame.style.top;
    frame.bottom = frame.style.bottom;
    frame.left = frame.style.left;
    frame.right = frame.style.right;
    frame.width = frame.style.width;
    frame.height = frame.style.height;
    return true;
}

DKFrame.prototype.restoreSize = function DKFrame_restoreSize(frame){
    frame.style.top = frame.top;
    frame.style.bottom = frame.bottom;
    frame.style.left = frame.left;
    frame.style.right = frame.right;
    frame.style.width = frame.width;
    frame.style.height = frame.height;
    return true;
}

DKFrame.prototype.createNewWindow = function DKFrame_createNewWindow(title, width, height, url){
    var instance = DKPlugin(DKFrame, title)
    //if (!instance.ok){
    //    instance.frame && DKFrame.prototype.bringToFront(instance.frame);
    //    return false;
    //}
    url && instance.dkplugin.prototype.url
    instance.div = document.createElement("div")
    instance.div.id = title + ".html"
    instance.div.style.width = width
    instance.div.style.height = height
    instance.div.style.overflow = "auto"
    //instance.div.style.backgroundColor = "grey"
    this.create(instance)
    return instance.div
}

/*
DKFrame.prototype.iFrame = function DKFrame_Iframe(title, url, width, height){
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

    //var currentBrowser = CPP_DKCef_GetCurrentBrowser();
    //CPP_DKCef_SetUrl(currentBrowser, url);
    //this.createResize(frame);
    //CPP_DKCef_SetFocus();
    return iframe;
}
*/
