DKSolutionRename_id = "";
DKSolutionRename_file = "";

//////////////////////////////
function DKSolutionRename_Init()
{
	DKCreate("DKBuild/DKSolutionRename.html,DKSolutionMenu");
	DKAddEvent("GLOBAL", "mousedown", DKSolutionRename_OnEvent);
	DKAddEvent("DKSolutionRename_box", "keydown", DKSolutionRename_OnEvent);
}

/////////////////////////////
function DKSolutionRename_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKSolutionRename_OnEvent);
	DKRemoveEvent("DKSolutionRename_box", "keydown", DKSolutionRename_OnEvent);
	DKClose("DKSolutionRename.html");
}

//////////////////////////////////////
function DKSolutionRename_OnEvent(event)
{
	DKLog("DKSolutionRename_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "keydown")){
		if(DKWidget_GetValue(event) != 13){
			return;
		}
	}
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKSolutionRename.html")){
			return;
		}
	}
	DKSolutionRename_Rename();
	DKClose("DKSolutionRename.js");
}

///////////////////////////////////
function DKSolutionRename_SetId(id)
{
	DKLog("DKSolutionRename_SetId("+id+")\n", DKINFO);
	DKSolutionRename_id = id;
}

///////////////////////////////////////
function DKSolutionRename_SetFile(file)
{
	DKLog("DKSolutionRename_SetFile("+file+")\n", DKINFO);
	DKSolutionRename_file = file;
}

//////////////////////////////////
function DKSolutionRename_Rename()
{
	DKLog("DKSolutionRename_Rename()\n", DKINFO);
	var oldhtml = DKWidget_GetInnerHtml(DKSolutionRename_id);
	var oldvalue = DKWidget_GetValue(DKSolutionRename_id);
	var newhtml = DKWidget_GetValue("DKSolutionRename_box");
	var newvalue = oldvalue;
	newvalue = newvalue.replace(oldhtml, newhtml);
	DKLog("oldhtml = "+oldhtml+"\n", DKINFO);
	DKLog("oldvalue = "+oldvalue+"\n", DKINFO);
	DKLog("newhtml = "+newhtml+"\n", DKINFO);
	DKLog("newvalue = "+newvalue+"\n", DKINFO);
	
	if(!DKFile_Rename(oldvalue, newvalue, true)){
		return; 
	}
	DKWidget_SetAttribute(DKSolutionRename_id, "value", newvalue);
	DKWidget_SetInnerHtml(DKSolutionRename_id, newhtml);
}
