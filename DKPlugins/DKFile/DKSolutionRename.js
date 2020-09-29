DKSolutionRename_id = "";
DKSolutionRename_file = "";

////////////////////////////////
function DKSolutionRename_Init()
{
	DKCreate("DKFile/DKSolutionRename.html,DKSolutionMenu");
	window.addEventListener("mousedown", DKSolutionRename_OnEvent);
	byId("DKSolutionRename_box").addEventListener("keydown", DKSolutionRename_OnEvent);
	
	DKWidget_SetFocus("DKSolutionRename_box");
}

///////////////////////////////
function DKSolutionRename_End()
{
	window.removeEventListener("mousedown", DKSolutionRename_OnEvent);
	byId("DKSolutionRename_box").removeEventListener("keydown", DKSolutionRename_OnEvent);
	DKClose("DKFile/DKSolutionRename.html");
}

////////////////////////////////////////
function DKSolutionRename_OnEvent(event)
{
	console.debug("DKSolutionRename_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
	if(event.type == "keydown"){
		if(DK_GetValue(event) != 13){
			return;
		}
	}
	if(event.currentTarget == window){
		if(byId("DKFile/DKSolutionRename.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DKSolutionRename_Rename();
	DKClose("DKFile/DKSolutionRename.js");
}

///////////////////////////////////
function DKSolutionRename_SetId(id)
{
	DKSolutionRename_id = id;
}

///////////////////////////////////////
function DKSolutionRename_SetFile(file)
{
	DKSolutionRename_file = file;
}

//////////////////////////////////
function DKSolutionRename_Rename()
{
	var oldhtml = DKWidget_GetInnerHtml(DKSolutionRename_id);
	var oldvalue = DKWidget_GetValue(DKSolutionRename_id);
	var newhtml = DKWidget_GetValue("DKSolutionRename_box");
	var newvalue = oldvalue;
	newvalue = newvalue.replace(oldhtml, newhtml);
	//console.log("oldhtml = "+oldhtml+"\n");
	//console.log("oldvalue = "+oldvalue+"\n");
	//console.log("newhtml = "+newhtml+"\n");
	//console.log("newvalue = "+newvalue+"\n");
	
	if(DKFile_Rename(oldvalue, newvalue, true) == false){
		return; 
	}
	DKWidget_SetAttribute(DKSolutionRename_id, "value", newvalue);
	DKWidget_SetInnerHtml(DKSolutionRename_id, newhtml);
}