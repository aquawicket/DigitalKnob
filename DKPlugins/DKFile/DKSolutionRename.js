DKSolutionRename_id = "";
DKSolutionRename_file = "";

//////////////////////////////
function DKSolutionRename_Init()
{
	DKCreate("DKFile/DKSolutionRename.html,DKSolutionMenu");
	DKAddEvent("GLOBAL", "mousedown", DKSolutionRename_OnEvent);
	DKAddEvent("DKSolutionRename_box", "keydown", DKSolutionRename_OnEvent);
}

/////////////////////////////
function DKSolutionRename_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKSolutionRename_OnEvent);
	DKRemoveEvents(DKSolutionRename_OnEvent);
	DKClose("DKFile/DKSolutionRename.html");
}

//////////////////////////////////////
function DKSolutionRename_OnEvent(event)
{
	//DKLog("DKSolutionRename_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "keydown")){
		if(DK_GetValue(event) != 13){
			return;
		}
	}
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKSolutionRename.html")){
			return;
		}
	}
	DKSolutionRename_Rename();
	DKClose("DKFile/DKSolutionRename.js");
}

///////////////////////////////////
function DKSolutionRename_SetId(id)
{
	DKLog("DKSolutionRename_SetId("+id+")\n");
	DKSolutionRename_id = id;
}

///////////////////////////////////////
function DKSolutionRename_SetFile(file)
{
	DKLog("DKSolutionRename_SetFile("+file+")\n");
	DKSolutionRename_file = file;
}

//////////////////////////////////
function DKSolutionRename_Rename()
{
	DKLog("DKSolutionRename_Rename()\n");
	var oldhtml = DKWidget_GetInnerHtml(DKSolutionRename_id);
	var oldvalue = DKWidget_GetValue(DKSolutionRename_id);
	var newhtml = DKWidget_GetValue("DKSolutionRename_box");
	var newvalue = oldvalue;
	newvalue = newvalue.replace(oldhtml, newhtml);
	DKLog("oldhtml = "+oldhtml+"\n");
	DKLog("oldvalue = "+oldvalue+"\n");
	DKLog("newhtml = "+newhtml+"\n");
	DKLog("newvalue = "+newvalue+"\n");
	
	if(DKFile_Rename(oldvalue, newvalue, true) == false){
		return; 
	}
	DKWidget_SetAttribute(DKSolutionRename_id, "value", newvalue);
	DKWidget_SetInnerHtml(DKSolutionRename_id, newhtml);
}
