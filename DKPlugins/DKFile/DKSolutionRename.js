DKSolutionRename_id = "";
DKSolutionRename_file = "";

////////////////////////////////
function DKSolutionRename_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKFile/DKSolutionRename.html,DKSolutionMenu");
	DKAddEvent("window", "mousedown", DKSolutionRename_OnEvent);
	DKAddEvent("DKSolutionRename_box", "keydown", DKSolutionRename_OnEvent);
	
	DKWidget_SetFocus("DKSolutionRename_box");
}

///////////////////////////////
function DKSolutionRename_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKSolutionRename_OnEvent);
	DKClose("DKFile/DKSolutionRename.html");
}

////////////////////////////////////////
function DKSolutionRename_OnEvent(event)
{
	DKDEBUGFUNC(event);
	DKDEBUG("DKSolutionRename_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
	if(event.type == "keydown"){
		if(DK_GetValue(event) != 13){
			return;
		}
	}
	if(event.currentTarget == window){
		if()byId("DKFile/DKSolutionRename.html").contains(DKWidget_GetHoverElement())){
			return;
		}
	}
	DKSolutionRename_Rename();
	DKClose("DKFile/DKSolutionRename.js");
}

///////////////////////////////////
function DKSolutionRename_SetId(id)
{
	DKDEBUGFUNC(id);
	DKSolutionRename_id = id;
}

///////////////////////////////////////
function DKSolutionRename_SetFile(file)
{
	DKDEBUGFUNC(file);
	DKSolutionRename_file = file;
}

//////////////////////////////////
function DKSolutionRename_Rename()
{
	DKDEBUGFUNC();
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