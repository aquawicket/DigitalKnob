DKSolutionRename_id = "";
DKSolutionRename_file = "";

////////////////////////////////
function DKSolutionRename_Init()
{
	DK_Create("DKFile/DKSolutionRename.html,DKSolutionMenu");
	window.addEventListener("mousedown", DKSolutionRename_OnEvent);
	byId("DKSolutionRename_box").addEventListener("keydown", DKSolutionRename_OnEvent);
	byId("DKSolutionRename_box").focus();
}

///////////////////////////////
function DKSolutionRename_End()
{
	window.removeEventListener("mousedown", DKSolutionRename_OnEvent);
	byId("DKSolutionRename_box").removeEventListener("keydown", DKSolutionRename_OnEvent);
	DK_Close("DKFile/DKSolutionRename.html");
}

////////////////////////////////////////
function DKSolutionRename_OnEvent(event)
{
	console.debug("DKSolutionRename_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
	if(event.type === "keydown"){
		if(DK_GetValue(event) !== 13){
			return;
		}
	}
	if(event.currentTarget === window){
		if(byId("DKFile/DKSolutionRename.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	DKSolutionRename_Rename();
	DK_Close("DKFile/DKSolutionRename.js");
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
	var oldhtml = byId(DKSolutionRename_id).innerHTML;
	var oldvalue = byId(DKSolutionRename_id).value;
	var newhtml = byId("DKSolutionRename_box").value;
	var newvalue = oldvalue;
	newvalue = newvalue.replace(oldhtml, newhtml);
	//console.log("oldhtml = "+oldhtml+"\n");
	//console.log("oldvalue = "+oldvalue+"\n");
	//console.log("newhtml = "+newhtml+"\n");
	//console.log("newvalue = "+newvalue+"\n");
	
	if(DKFile_Rename(oldvalue, newvalue, true) === false){
		return; 
	}
	byId(DKSolutionRename_id).value = newvalue;
	byId(DKSolutionRename_id).innerHTML = newhtml;
}