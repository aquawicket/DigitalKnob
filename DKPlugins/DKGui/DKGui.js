"use strict";

dk.gui = new DKGui();

function DKGui() {
    return DKPlugin.call(this, arguments);
}

DKGui.prototype.createElement = function DKGui_createElement(parent, tag, id, top, bottom, left, right, width, height, onclick) {
    var ele = document.createElement(tag);
    ele.id = dk.getAvailableId(id);
    parent.appendChild(ele);
    //This is not working on IE
    return ele;
}

DKGui.prototype.createElementBefore = function DKGui_createElementBefore(parent, tag, id) {
    var ele = document.createElement(tag);
    ele.id = dk.getAvailableId(id);
    parent.parentNode.insertBefore(ele, parent);
    return ele;
}

DKGui.prototype.createTag = function DKGui_createTag(tag, parent, props, callback) {
    !props && (props = {});
    const style = props.style;
    style && delete props.style;
    const element = Object.assign(document.createElement(tag), props);
    style && Object.assign(element.style, style);
    //for(let attr in props)
    //    element.setAttribute("dk", "");
    parent.appendChild(element);
    callback && callback(element);
    return element;
}

DKGui.prototype.getLeftPx = function DKGui_getLeftPx(element) {
    if (!element || !element.style.left)
        return error("element.style.left invalid");
    if (element.style.left.indexOf("%") > -1)
        return parseInt(element.style.left) * window.innerWidth / 100;
    return parseInt(element.style.left);
}

DKGui.prototype.getTopPx = function DKGui_getTopPx(element) {
    if (!element || !element.style.top)
        return error("element.style.top invalid");
    if (element.style.top.indexOf("%") > -1)
        return parseInt(element.style.top) * window.innerHeight / 100;
    return parseInt(element.style.top);
}

DKGui.prototype.getWidthPx = function DKGui_getWidthPx(element) {
    if (!element || !element.style.width)
        return error("element.style.width invalid");
    if (element.style.width.indexOf("%") > -1)
        return parseInt(element.style.width) * window.innerWidth / 100;
    return parseInt(element.style.width);
}

DKGui.prototype.getHeightPx = function DKGui_getHeightPx(element) {
    if (!element || !element.style.height)
        return error("element.style.height invalid");
    if (element.style.height.includes("%"))
        return parseInt(element.style.height) * window.innerHeight / 100;
    return parseInt(element.style.height);
}

DKGui.prototype.pos = function DKGui_pos(position) {
    if (position === '')
        return position;
    if (typeof position === 'string') {
        if (position.search('rem') !== -1) {
            if (dk.iE() && dk.iE() < 9)
                position = position.replace("rem", "px");
            return position;
        }
        if (position.search('px') !== -1)
            return position;
        if (position.search('%') !== -1)
            return position;
        if (position.search('auto') !== -1)
            return position;
        if (dk.iE() && dk.iE() < 9)
            return position + 'px';
        else
            return position + 'rem';
    }
    if (typeof position === 'number') {
        if (dk.iE() && dk.iE() < 9)
            return position + 'px';
        else
            return position + 'rem';
    }

    return error("Pos() ERROR");
}

DKGui.prototype.createButton = function DKGui_createButton(parent, id, top, bottom, left, right, width, height, onclick) {
    const button = document.createElement("button");
    button.setAttribute("dk_gui", "button");
    id && (button.id = id);
    id && (button.innerHTML = id);
    button.style.position = "absolute";
    top && (button.style.top = top);
    bottom && (button.style.bottom = bottom);
    left && (button.style.left = left);
    right && (button.style.right = right);
    width && (button.style.width = width);
    height && (button.style.height = height);
    //button.style.padding = "0rem";
    button.style.cursor = "pointer";
    onclick && (button.onclick = onclick);
    parent.appendChild(button);
    return button;
}

DKGui.prototype.createImageButton = function DKGui_createImageButton(parent, id, src, top, bottom, left, right, width, height, onclick) {
    const button = document.createElement("img");
    button.setAttribute("dk_gui", "img_button");
    button.src = src;
    button.style.position = "absolute";
    button.style.cursor = "pointer";
    //button.style.padding = "0rem";
    id && (button.id = id);
    top && (button.style.top = top);
    bottom && (button.style.bottom = bottom);
    left && (button.style.left = left);
    right && (button.style.right = right);
    width && (button.style.width = width);
    height && (button.style.height = height);
    onclick && (button.onclick = onclick);
    parent.appendChild(button);
    return button;
}

DKGui.prototype.createImage = function DKGui_createImage(parent, id, src, top, bottom, left, right, width, height) {
    return dk.gui.createImageButton(parent, id, src, top, bottom, left, right, width, height);
}

//TODO  //https://github.com/juggle/resize-observer
//TODO:  make this a CustomEvent
//https://stackoverflow.com/a/48718956/688352
DKGui.prototype.addResizeHandler = function DKGui_addResizeHandler(element, callback) {
    var observer = new MutationObserver(function(mutations) {
        callback && callback();
    }
    );
    observer.observe(element, {
        attributes: true
    });
}

DKGui.prototype.randomRGB = function DKGui_randomRGB() {
    var o = Math.round
      , r = Math.random
      , s = 255;
    return 'rgb(' + o(r() * s) + ',' + o(r() * s) + ',' + o(r() * s) + ')';
}
