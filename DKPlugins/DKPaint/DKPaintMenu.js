///////////////////////////
function DKPaintMenu_Init()
{
	dk.create("DKPaint/DKPaintMenu.html");
	document.addEventListener("mousedown", DKPaintMenu_onevent);
	byId("DKPaintMenu_Cut").addEventListener("click", DKPaintMenu_onevent);
	byId("DKPaintMenu_Copy").addEventListener("click", DKPaintMenu_onevent);
	byId("DKPaintMenu_Paste").addEventListener("click", DKPaintMenu_onevent);
}

//////////////////////////
function DKPaintMenu_End()
{
	document.removeEventListener("mousedown", DKPaintMenu_onevent);
	byId("DKPaintMenu_Cut").removeEventListener("click", DKPaintMenu_onevent);
	byId("DKPaintMenu_Copy").removeEventListener("click", DKPaintMenu_onevent);
	byId("DKPaintMenu_Paste").removeEventListener("click", DKPaintMenu_onevent);
	dk.close("DKPaint/DKPaintMenu.html");
}

///////////////////////////////////
function DKPaintMenu_OnEvent(event)
{
	if(event.currentTarget.id === "DKPaintMenu_Cut"){
		DKPaintMenu_Cut();
	}
	if(event.currentTarget.id === "DKPaintMenu_Copy"){
		DKPaintMenu_Copy();
	}
	if(event.currentTarget.id === "DKPaintMenu_Paste"){
		DKPaintMenu_Paste();
	}
	
	if(event.currentTarget === document){
		if(byId("DKPaint/DKPaintMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	dk.close("DKPaintMenu.js");
}

//////////////////////////
function DKPaintMenu_Cut()
{

}

///////////////////////////
function DKPaintMenu_Copy()
{
	
}

////////////////////////////
function DKPaintMenu_Paste()
{
	
}