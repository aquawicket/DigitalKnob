
//////////////////////
function DKMenu_Init()
{
	
}

/////////////////////
function DKMenu_End()
{

}

//////////////////////////////
function DKMenu_OnEvent(event)
{

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