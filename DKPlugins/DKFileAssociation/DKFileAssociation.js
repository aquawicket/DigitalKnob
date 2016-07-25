/////////////////////////////////
function DKFileAssociation_Init()
{
	//DKCreate("DKFileAssociation/DKFileAssociation.html");
	//DKAddEvent("DKFileAssociation_item", "click", DKFileAssociation_OnEvent);
}

////////////////////////////////
function DKFileAssociation_End()
{
	//DKClose("DKFileAssociation/DKFileAssociation.html");
}

////////////////////////////////////////
function DKFileAssociation_OnEvent(event)
{
	//if(DK_Id(event,"DKFileAssociation_item")){ }	
}

function DKFileAssociation_Open(file)
{
	if(file.indexOf(".js") > -1){
		DKCreate(file);
		var file = file.replace(".js",".html");
		file = DKFile_GetFilename(file);
		DKFrame_Widget(file);
		return;
	}
	if(file.indexOf(".html") > -1){
		DKCreate(file);
		file = DKFile_GetFilename(file);
		DKFrame_Widget(file);
		return;
	}
	else{
		TaskbarMenu_OpenFileInFrame("DKNotepad/DKNotepad.js");		
		var local_assets = DKAssets_GetDataPath();			
		DKSendEvent("DKNotepad.html", "SetFile", local_assets+file);
	}
}