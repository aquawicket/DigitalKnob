"use strict";

dk.gui = new DKPlugin("dk_gui");

dk.gui.createElement = function dk_gui_createElement(parent, tag, id, top, bottom, left, right, width, height, onclick) {
    var ele = document.createElement(tag);
    ele.id = dk.getAvailableId(id);
    parent.appendChild(ele);
    //This is not working on IE
    return ele;
}

dk.gui.createElementBefore = function dk_gui_createElementBefore(parent, tag, id) {
    var ele = document.createElement(tag);
    ele.id = dk.getAvailableId(id);
    parent.parentNode.insertBefore(ele, parent);
    return ele;
}

dk.gui.createTag = function dk_gui_createTag(tag, parent, props) {
    !props && (props = {});
    const style = props.style;
    style && delete props.style;
    const element = Object.assign(document.createElement(tag), props);
    style && Object.assign(element.style, style);
    //for(let attr in props)
    //    element.setAttribute("dk", "");
    parent.appendChild(element);
    return element;
}

dk.gui.getLeftPx = function dk_gui_getLeftPx(element) {
    if (!element || !element.style.left)
        return error("element.style.left invalid");
    if (element.style.left.indexOf("%") > -1)
        return parseInt(element.style.left) * window.innerWidth / 100;
    return parseInt(element.style.left);
}

dk.gui.getTopPx = function dk_gui_getTopPx(element) {
    if (!element || !element.style.top)
        return error("element.style.top invalid");
    if (element.style.top.indexOf("%") > -1)
        return parseInt(element.style.top) * window.innerHeight / 100;
    return parseInt(element.style.top);
}

dk.gui.getWidthPx = function dk_gui_getWidthPx(element) {
    if (!element || !element.style.width)
        return error("element.style.width invalid");
    if (element.style.width.indexOf("%") > -1)
        return parseInt(element.style.width) * window.innerWidth / 100;
    return parseInt(element.style.width);
}

dk.gui.getHeightPx = function dk_gui_getHeightPx(element) {
    if (!element || !element.style.height)
        return error("element.style.height invalid");
    if (element.style.height.includes("%"))
        return parseInt(element.style.height) * window.innerHeight / 100;
    return parseInt(element.style.height);
}

dk.gui.pos = function dk_gui_pos(position) {
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

dk.gui.createButton = function dk_gui_createButton(parent, id, top, bottom, left, right, width, height, onclick) {
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

dk.gui.createImageButton = function dk_gui_createImageButton(parent, id, src, top, bottom, left, right, width, height, onclick) {
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

dk.gui.createImage = function dk_gui_createImage(parent, id, src, top, bottom, left, right, width, height) {
    return dk.gui.createImageButton(parent, id, src, top, bottom, left, right, width, height);
}

//TODO  //https://github.com/juggle/resize-observer
//TODO:  make this a CustomEvent
//https://stackoverflow.com/a/48718956/688352
dk.gui.addResizeHandler = function dk_gui_addResizeHandler(element, callback) {
    var observer = new MutationObserver(function(mutations) {
        callback && callback();
    }
    );
    observer.observe(element, {
        attributes: true
    });
}

dk.gui.randomRGB = function dk_gui_randomRGB(){
    var o = Math.round, r = Math.random, s = 255;
    return 'rgb(' + o(r()*s) + ',' + o(r()*s) + ',' + o(r()*s) + ')';
}