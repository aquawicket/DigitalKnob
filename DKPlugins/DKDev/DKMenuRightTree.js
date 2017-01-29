///////////////////////////////
function DKMenuRightTree_Init()
{
	DKCreate("DKDev/DKMenuRightTree.html,DKMenuRight.html");
	DKAddEvent("DKMenuRightTree.html", "UpdateTree", DKMenuRightTree_OnEvent);
	DKMenuRightTree_UpdateTree();
}

//////////////////////////////
function DKMenuRightTree_End()
{
	DKRemoveEvent("DKMenuRightTree.html", "UpdateTree", DKMenuRightTree_OnEvent);
	DKClose("DKMenuRightTree.html");
}

///////////////////////////////////////
function DKMenuRightTree_OnEvent(event)
{
	DKLog("DKMenuRightTree_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event,"UpdateTree")){
		DKMenuRightTree_UpdateTree();
	}
	if(DK_Id(event,"PlusImage")){
		DKLog("PlusImage clicked \n", DKINFO);
	}
}

/////////////////////////////////////
function DKMenuRightTree_UpdateTree()
{
	var element = [];
	element.push("Editor.html");
	//elements.push_back("Test2");
	//elements.push_back("Test3");
	
	for(i=0; i < element.length; ++i){
		var id = DKWidget_CreateElement("DKMenuRightTree.html", "div", "TreeDiv"+i);
		DKWidget_SetProperty(id, "position", "absolute");
		DKWidget_SetProperty(id, "top", "10rem");
		DKWidget_SetProperty(id, "left", "10rem");
		DKWidget_SetProperty(id, "width", "100rem");
		DKWidget_SetProperty(id, "height", "20rem");
		DKWidget_SetProperty(id, "color", "rgb(200,200,200)");
		var string = "<img id=\"PlusImage\" style=\"display:inline;position:relative;\" src=\"DKDev/plus.png\"></img> "+element[i];	
		DKWidget_SetInnerHtml(id, string);
		DKAddEvent("PlusImage", "click", DKMenuRightTree_OnEvent);
	}
}
