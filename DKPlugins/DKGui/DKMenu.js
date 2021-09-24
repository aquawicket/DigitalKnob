//"use strict";

function DKMenu(){}

DKMenu.prototype.init = function DKMenu_init(callback) {
    dk.create("DKGui/DKMenu.css", function() {
        callback && callback()
    });
}

DKMenu.prototype.end = function DKMenu_end() {
    dk.close("DKGui/DKMenu.css");
}

DKMenu.prototype.create = function DKMenu_create(parent) {
    const dkmenu = new DKPlugin(DKMenu);
    dkmenu.div = document.createElement("div");
    dkmenu.div.setAttribute("dk_menu", "menu");
    dkmenu.div.style.top = window.mouseY + "rem";
    dkmenu.div.style.left = window.mouseX + "rem";
    dkmenu.div.style.removeProperty("right");
    if (parent)
        parent.appendChild(dkmenu.div);
    else
        document.body.appendChild(dkmenu.div);
    document.addEventListener('mousedown', function(event) {
        dkmenu.close();
    }, {
        once: true
    });
    dkmenu.validatePosition();
    return dkmenu;
}

DKMenu.prototype.close = function DLMenu_close() {
    //this.div.parentElement.removeChild(this.div);
    delete this.div;
}

DKMenu.prototype.addItem = function DKMenu_addItem(label, callback) {
    this.div.dkmenuItem = document.createElement("div");
    this.div.dkmenuItem.setAttribute("dk_menu", "item");
    this.div.dkmenuItem.innerHTML = label;
    this.div.dkmenuItem.class = "option";
    this.div.dkmenuItem.style.paddingTop = "2rem";
    this.div.dkmenuItem.style.paddingLeft = "4rem";
    this.div.dkmenuItem.style.cursor = "pointer";
    this.div.dkmenuItem.style.whiteSpace = "pre-wrap";
    this.div.dkmenuItem.style.boxSizing = "border-box";
    this.div.dkmenuItem.style.borderStyle = "solid";
    this.div.dkmenuItem.style.borderBottomWidth = "1rem";
    this.div.dkmenuItem.style.borderTopWidth = "0rem";
    this.div.dkmenuItem.style.borderLeftWidth = "0rem";
    this.div.dkmenuItem.style.borderRightWidth = "0rem";
    this.div.dkmenuItem.onmousedown = function onmousedown_callback() {
        callback && callback();
        //event.stopPropagation();
    }
    this.div.appendChild(this.div.dkmenuItem);
    this.validatePosition(this);
}

DKMenu.prototype.validatePosition = function DKMenu_validatePosition() {
    this.div.style.top = window.mouseY + "px";
    this.div.style.left = window.mouseX + "px";
    this.div.style.removeProperty("right");

    //make sure menu is within window
    var win_width = Number(document.body.clientWidth);
    var win_height = Number(document.body.clientHeight);
    var top = Number(this.div.offsetTop);
    var left = Number(this.div.offsetLeft);
    var width = Number(this.div.clientWidth);
    var height = Number(this.div.clientHeight);

    if (top + height > win_height) {
        top = win_height - height;
        this.div.style.top = top + "px";
    }
    if (left + width > win_width) {
        left = win_width - width;
        this.div.style.left = left + "px";
    }
}
