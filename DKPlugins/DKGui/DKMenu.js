"use strict";

DKMenu.prototype = Object.create(DKPlugin.prototype);
function DKMenu(identifier) {
    return DKPlugin.call(this, identifier);
}
dk.menu = new DKMenu("DKMenu");

dk.menu.init = function dk_menu_init() {}

dk.menu.end = function dk_menu_end() {}

dk.menu.init = function dk_menu_init(){
    dk.create("DKGui/DKMenu.css");
}

dk.menu.createInstance = function dk_menu_createInstance(parent) {

    let dkmenu = document.createElement("div");
    dkmenu.setAttribute("dk_menu","menu");
    //These stles can be found in DKMenu.css
    //dkmenu.style.boxSizing = "border-box";
    //dkmenu.style.borderColor = "rgb(60,60,60)";
    dkmenu.id = "id";
    dkmenu.style.top = window.mouseY + "rem";
    dkmenu.style.left = window.mouseX + "rem";
    dkmenu.style.removeProperty("right");
    /*
    dkmenu.style.position = "absolute";
    dkmenu.style.padding = "0rem";
    dkmenu.style.width = "150rem";
    dkmenu.style.minHeight = "18rem";
    dkmenu.style.borderStyle = "solid";
    dkmenu.style.borderWidth = "1rem";
    dkmenu.style.borderTopWidth = "1rem";
    dkmenu.style.borderLeftWidth = "1rem";
    dkmenu.style.borderRightWidth = "1rem";
    dkmenu.style.borderBottomWidth = "0rem";
    */
    if(parent){
        parent.appendChild(dkmenu);
    }else{
        document.body.appendChild(dkmenu);
    }
    document.addEventListener('mousedown', function(event) {
        dkmenu.parentElement.removeChild(dkmenu);
    }, {
        once: true
    });
    dk.menu.validatePosition(dkmenu);
    return dkmenu;
}

dk.menu.addItem = function dk_menu_addItem(menu, label, callback) {
    let dkmenuItem = document.createElement("div");
    dkmenuItem.setAttribute("dk_menu","item");
    //These stles are now  done in DKMenu.css
    //dkmenuItem.style.backgroundColor = "rgb(20,20,20)";
    //dkmenuItem.style.color = "rgb(170,170,170)";
    //dkmenuItem.style.borderColor = "rgb(60,60,60)";
    /*
    dkmenuItem.onmouseover = function dk_menu_item_onmouseover() {
        //dkmenuItem.style.backgroundColor = "rgb(40,40,40)";
        //dkmenuItem.style.color = "rgb(255,255,255)";
    }
    */
    /*
    dkmenuItem.onmouseout = function dk_menu_item_onmouseout() {
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
    dkmenuItem.onmousedown = function onmousedown_callback(event){
        callback && callback(event);
        //event.stopPropagation();
    }
    menu.appendChild(dkmenuItem);
    dk.menu.validatePosition(menu);
}

dk.menu.validatePosition = function dk_menu_validatePosition(menu) {
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
