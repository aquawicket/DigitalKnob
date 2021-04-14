"use strict";

//let dkmenus = [];
//let activeMenu;

//////////////////////
function DKMenu_Init() {}

/////////////////////
function DKMenu_End() {}

function DKMenu_CreateInstance() {
    let dkmenu = document.createElement("div");
    dkmenu.id = "id";
    //dkmenu.innerHTML = "Item1";
    dkmenu.style.position = "absolute";
    dkmenu.style.padding = "0rem";
    dkmenu.style.top = window.mouseY + "rem";
    dkmenu.style.left = window.mouseX + "rem";
    dkmenu.style.removeProperty("right");
    dkmenu.style.width = "150rem";
    dkmenu.style.height = "18rem";
    document.body.appendChild(dkmenu);
    document.addEventListener('mousedown', function() {
        dkmenu.parentElement.removeChild(dkmenu);
    }, {
        once: true
    });
    DKMenu_ValidatePosition(dkmenu);
    return dkmenu;
}

function DKMenu_AddItem(menu, label, callback) {
    let dkmenuItem = document.createElement("div");
    dkmenuItem.innerHTML = label;
    dkmenuItem.class = "option";
    dkmenuItem.style.backgroundColor = "rgb(20,20,20)";
    dkmenuItem.style.color = "rgb(170,170,170)";
    dkmenuItem.style.paddingTop = "2rem";
    dkmenuItem.style.paddingLeft = "4rem";
    dkmenuItem.style.cursor = "pointer";
    dkmenuItem.onmousedown = callback;
    dkmenuItem.onmouseover = function(){
    	dkmenuItem.style.backgroundColor = "rgb(40,40,40)";
    	dkmenuItem.style.color = "rgb(255,255,255)";
    };
    dkmenuItem.onmouseout = function(){
    	dkmenuItem.style.backgroundColor = "rgb(20,20,20)";
    	dkmenuItem.style.color = "rgb(200,200,200)";
    };
    menu.appendChild(dkmenuItem);
    DKMenu_ValidatePosition(menu);
}

function DKMenu_ValidatePosition(menu) {
    if (!menu)
        return error("menu invalid");

    menu.style.top = window.mouseY + "px";
    menu.style.top = window.mouseY + "rem";
    menu.style.left = window.mouseX + "px";
    menu.style.left = window.mouseX + "rem";
    menu.style.removeProperty("right");

    //make sure menu is within window
    var win_width = Number(document.body.clientWidth);
    var win_height = Number(document.body.clientHeight);
    var top = Number(menu.offsetTop);
    var left = Number(menu.offsetLeft);
    var width = Number(menu.clientWidth);
    var height = Number(menu.clientHeight);

    /*
    console.debug("win_width = "+win_width+"\n");
    console.debug("win_height = "+win_height+"\n");
    console.debug("top = "+top+"\n");
    console.debug("left = "+left+"\n");
    console.debug("width = "+width+"\n");
    console.debug("height = "+height+"\n");
    */
    
    if(top + height > win_height){
		top = win_height - height;
		menu.style.top = top+"rem";
		//console.debug("new top = "+top+"\n");
	}
	if(left + width > win_width){
		left = win_width - width;
		menu.style.left = left+"rem";
		//console.debug("new left = "+left+"\n");
	}
}
