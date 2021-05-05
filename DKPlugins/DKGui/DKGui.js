"use strict";

dk.gui = new Object;

dk.gui.createElement = function dk_gui_createElement(parent, tag, id) {
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

dk.gui.getLeftPx = function dk_gui_getLeftPx(element) {
    if (!element)
        return 0;
    if (!element.style.left)
        return 0;
    if (element.style.left.indexOf("%") > -1)
        return parseInt(element.style.left) * window.innerWidth / 100;
    return parseInt(element.style.left);
}

dk.gui.getTopPx = function dk_gui_getTopPx(element) {
    if (!element)
        return 0;
    if (!element.style.top)
        return 0;
    if (element.style.top.indexOf("%") > -1)
        return parseInt(element.style.top) * window.innerHeight / 100;
    return parseInt(element.style.top);
}

dk.gui.getWidthPx = function dk_gui_getWidthPx(element) {
    if (!element)
        return 0;
    if (!element.style.width)
        return 0;
    if (element.style.width.indexOf("%") > -1)
        return parseInt(element.style.width) * window.innerWidth / 100;
    return parseInt(element.style.width);
}

dk.gui.getHeightPx = function dk_gui_getHeightPx(element) {
    if (!element)
        return 0;
    if (!element.style.height)
        return 0;
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
    button.id = id;
    button.innerHTML = id;
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
    button.id = id;
    button.src = src;
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

/*
dk.gui..confirmBox = function dk_gui_confirmBox(msg, callback) {
    const confirm = DKCreateWindow("DKConfirm", "200rem", "100rem");
    confirm.style.textAlign = "center";
    confirm.style.paddingTop = "20rem";
    const message = document.createElement("span");
    message.innerHTML = msg;
    confirm.appendChild(message);
    const no = DKCreateButton(confirm, "No", "50rem", "75rem", "", "", function() {
        document.body.removeChild(confirm);
    });
    const yes = DKCreateButton(confirm, "Yes", "50rem", "105rem", "", "", function() {
        callback && callback();
        document.body.removeChild(confirm);
    });
}
*/

dk.gui.randomRGB = function dk_gui_randomRGB(){
    var o = Math.round, r = Math.random, s = 255;
    return 'rgb(' + o(r()*s) + ',' + o(r()*s) + ',' + o(r()*s) + ')';
}