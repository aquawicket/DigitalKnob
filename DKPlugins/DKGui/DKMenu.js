"use strict";

let dkmenus = [];
let activeMenu = -1;
 
//////////////////////
function DKMenu_Init()
{
	
}

/////////////////////
function DKMenu_End()
{

}



function DKMenu_CreateInstance()
{
     const dkmenu = document.createElement("div");
     dkmenu.id = "id";
     dkmenu.innerHTML = "Item1";
     dkmenu.style.position = "absolute";
     dkmenu.style.padding = "0rem";
     dkmenu.style.backgroundColor = "rgb(0,0,0)";
     dkmenu.style.color = "white";
     dkmenu.style.fontColor = "white";
	 dkmenu.style.top = window.mouseY+"rem";
	 dkmenu.style.left = window.mouseX+"rem";
	 dkmenu.style.removeProperty("right");
     dkmenu.style.width = "150rem";
     dkmenu.style.height = "20rem";
     dkmenu.style.height = "20rem";
     dkmenu.style.cursor = "pointer";
     dkmenus.push(dkmenu);
     activeMenu = dkmenus.indexOf(dkmenu);
     document.body.appendChild(dkmenus[activeMenu]);
     var DKMenu_Close = function (){
         dkmenus[activeMenu].parentElement.removeChild(dkmenus[activeMenu]);
     	 document.removeEventListener("mousedown", DKMenu_Close, true);
     }
     document.addEventListener("mousedown", DKMenu_Close, true);
     


     return dkmenu;
}

/*
function menuClose(dkmenu)
{
	//const n = dkmenus.indexOf(dkmenu);
	//dkmenu.parentElement.removeChild(dkmenus[n]);
    //dkmenus.splice(n, 1);
    document.removeEventListener("mousedown", mClose, true);
}
*/

//////////////////////////////
function DKMenu_OnEvent(event)
{
	/*
	if(event.currentTarget.id === "DKNotepadMenu_Cut"){
		DKNotepadMenu_Cut();
		PreventDefault(event);
	}
	if(event.currentTarget.id === "DKNotepadMenu_Copy"){
		DKNotepadMenu_Copy();
	}
	if(event.currentTarget.id === "DKNotepadMenu_Paste"){
		DKNotepadMenu_Paste();
	}
	
	if(event.currentTarget === document){
		if(byId("DKNotepad/DKNotepadMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	DK_Close("DKGui/DKMenu.js");
	*/
}

////////////////////////////////////
function DKMenu_ValidatePosition(id)
{
	console.log("DKMenu_ValidatePosition("+id+")");
	if(!byId(id)){ 
	    console.error("DKMenu_ValidatePosition(id): "+id+" invalid");
	    return; 
	} 

	byId(id).style.top = window.mouseY+"px";
	byId(id).style.top = window.mouseY+"rem";
	byId(id).style.left = window.mouseX+"px";
	byId(id).style.left = window.mouseX+"rem";
	byId(id).style.removeProperty("right");
	
	//make sure menu is within window
	var win_width = Number(document.body.clientWidth);
	var win_height = Number(document.body.clientHeight);
	var top = Number(byId(id).offsetTop);
	var left = Number(byId(id).offsetLeft);
	var width = Number(byId(id).clientWidth);
	var height = Number(byId(id).clientHeight);
	
	//console.log("win_width = "+win_width+"\n");
	//console.log("win_height = "+win_height+"\n");
	//console.log("top = "+top+"\n");
	//console.log("left = "+left+"\n");
	//console.log("width = "+width+"\n");
	//console.log("height = "+height+"\n");
	
	/*
	if(top + height > win_height){
		top = win_height - height;
		console.log("new top = "+top+"\n");
		byId(id).style.top = top+"px";
	}
	if(left + width > win_width){
		console.log("new left = "+left+"\n");
		left = win_width - width;
		byId(id).style.left = left+"px";
	}
	*/
}