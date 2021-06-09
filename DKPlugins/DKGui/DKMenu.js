"use strict";

function DKMenu(){}

DKMenu.prototype.init = function DKMenu_init() {
    dk.create("DKGui/DKMenu.css");
}

DKMenu.prototype.end = function DKMenu_end() {
    dk.close("DKGui/DKMenu.css");
}

DKMenu.prototype.create = function DKMenu_createInstance(parent) {

    const instance = new DKPlugin(DKMenu, "singleton");
    if(!instance)
        return false;
    let dkmenu = document.createElement("div");
    dkmenu.setAttribute("dk_menu", "menu");
    dkmenu.id = "id";
    dkmenu.style.top = window.mouseY + "rem";
    dkmenu.style.left = window.mouseX + "rem";
    dkmenu.style.removeProperty("right");
    if (parent)
        parent.appendChild(dkmenu);
    else
        document.body.appendChild(dkmenu);
    document.addEventListener('mousedown', function(event) {
        dkmenu.parentElement.removeChild(dkmenu);
        instance.close();
    }, {
        once: true
    });
    DKMenu.prototype.validatePosition(dkmenu);
    return dkmenu;
}

DKMenu.prototype.addItem = function DKMenu_addItem(menu, label, callback) {
    let dkmenuItem = document.createElement("div");
    dkmenuItem.setAttribute("dk_menu", "item");
    //These stles are now  done in DKMenu.css
    //dkmenuItem.style.backgroundColor = "rgb(20,20,20)";
    //dkmenuItem.style.color = "rgb(170,170,170)";
    //dkmenuItem.style.borderColor = "rgb(60,60,60)";
    /*
    dkmenuItem.onmouseover = function DKMenu_item_onmouseover() {
        //dkmenuItem.style.backgroundColor = "rgb(40,40,40)";
        //dkmenuItem.style.color = "rgb(255,255,255)";
    }
    */
    /*
    dkmenuItem.onmouseout = function DKMenu_item_onmouseout() {
        //dkmenuItem.style.backgroundColor = "rgb(20,20,20)";
        //dkmenuItem.style.color = "rgb(200,200,200)";
    }
    */
    dkmenuItem.innerHTML = label;
    dkmenuItem.class = "option";
    dkmenuItem.style.paddingTop = "2rem";
    dkmenuItem.style.paddingLeft = "4rem";
    dkmenuItem.style.cursor = "pointer";
    dkmenuItem.style.whiteSpace = "pre-wrap";
    dkmenuItem.style.boxSizing = "border-box";
    dkmenuItem.style.borderStyle = "solid";
    dkmenuItem.style.borderBottomWidth = "1rem";
    dkmenuItem.style.borderTopWidth = "0rem";
    dkmenuItem.style.borderLeftWidth = "0rem";
    dkmenuItem.style.borderRightWidth = "0rem";
    dkmenuItem.onmousedown = function onmousedown_callback(event) {
        callback && callback(event);
        //event.stopPropagation();
    }
    menu.appendChild(dkmenuItem);
    DKMenu.prototype.validatePosition(menu);
}

DKMenu.prototype.validatePosition = function DKMenu_validatePosition(menu) {
    if (!menu)
        return error("menu invalid");

    menu.style.top = window.mouseY + "px";
    menu.style.left = window.mouseX + "px";
    menu.style.removeProperty("right");

    //make sure menu is within window
    var win_width = Number(document.body.clientWidth);
    var win_height = Number(document.body.clientHeight);
    var top = Number(menu.offsetTop);
    var left = Number(menu.offsetLeft);
    var width = Number(menu.clientWidth);
    var height = Number(menu.clientHeight);

    if (top + height > win_height) {
        top = win_height - height;
        menu.style.top = top + "px";
    }
    if (left + width > win_width) {
        left = win_width - width;
        menu.style.left = left + "px";
    }
}
