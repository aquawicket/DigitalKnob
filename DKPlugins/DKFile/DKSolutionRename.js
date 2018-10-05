DKSolutionRename_id = "";
DKSolutionRename_file = "";

////////////////////////////////
function DKSolutionRename_Init()
{
	DKLog("DKSolutionRename_Init()\n", DKDEBUG);
	DKCreate("DKFile/DKSolutionRename.html,DKSolutionMenu");
	DKAddEvent("GLOBAL", "mousedown", DKSolutionRename_OnEvent);
	DKAddEvent("DKSolutionRename_box", "keydown", DKSolutionRename_OnEvent);
	
	DKWidget_SetFocus("DKSolutionRename_box");
}

///////////////////////////////
function DKSolutionRename_End()
{
	DKLog("DKSolutionRename_End()\n", DKDEBUG);
	DKRemoveEvents(DKSolutionRename_OnEvent);
	DKClose("DKFile/DKSolutionRename.html");
}

////////////////////////////////////////
function DKSolutionRename_OnEvent(event)
{
	DKLog("DKSolutionRename_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Type(event, "keydown")){
		if(DK_GetValue(event) != 13){
			return;
		}
	}
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKFile/DKSolutionRename.html")){
			return;
		}
	}
	DKSolutionRename_Rename();
	DKClose("DKFile/DKSolutionRename.js");
}

///////////////////////////////////
function DKSolutionRename_SetId(id)
{
	DKLog("DKSolutionRename_SetId("+id+")\n", DKDEBUG);
	DKSolutionRename_id = id;
}

///////////////////////////////////////
function DKSolutionRename_SetFile(file)
{
	DKLog("DKSolutionRename_SetFile("+file+")\n", DKDEBUG);
	DKSolutionRename_file = file;
}

//////////////////////////////////
function DKSolutionRename_Rename()
{
	DKLog("DKSolutionRename_Rename()\n", DKDEBUG);
	var oldhtml = DKWidget_GetInnerHtml(DKSolutionRename_id);
	var oldvalue = DKWidget_GetValue(DKSolutionRename_id);
	var newhtml = DKWidget_GetValue("DKSolutionRename_box");
	var newvalue = oldvalue;
	newvalue = newvalue.replace(oldhtml, newhtml);
	//DKLog("oldhtml = "+oldhtml+"\n");
	//DKLog("oldvalue = "+oldvalue+"\n");
	//DKLog("newhtml = "+newhtml+"\n");
	//DKLog("newvalue = "+newvalue+"\n");
	
	if(DKFile_Rename(oldvalue, newvalue, true) == false){
		return; 
	}
	DKWidget_SetAttribute(DKSolutionRename_id, "value", newvalue);
	DKWidget_SetInnerHtml(DKSolutionRename_id, newhtml);
}