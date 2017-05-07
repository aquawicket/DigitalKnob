///////////////////////////////
function DKThreadPoolDlg_Init()
{
	DKCreate("DKThreadPool");
	
	if(!DKValid("DKWidgetJS,DKWidgetJS0")){ return; }
	DKCreate("DKThread/DKThreadPoolDlg.html"); 
	DKAddEvent("DKThreadPoolDlg.html", "Update", DKThreadPoolDlg_OnEvent);
}

//////////////////////////////
function DKThreadPoolDlg_End()
{
	DKRemoveEvent("DKThreadPoolDlg.html", "Update", DKThreadPoolDlg_OnEvent);
	DKClose("DKThreadPoolDlg.html");
}

///////////////////////////////////////
function DKThreadPoolDlg_OnEvent(event)
{
	DKLog("DKThreadPoolDlg_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "Update")){
		DKThreadPoolDlg_OnUpdate();
	}
}

///////////////////////////////////
function DKThreadPoolDlg_OnUpdate()
{
	if(!DKValid("DKWidgetJS,DKWidgetJS0")){ return; }
	DKLog("Update DKThreadPool \n");
	DKWidget_SetInnerHtml("DKThreadPoolDlg.html", "");

	var name = DKThread_GetThreadNames();
	var names = name.split(",");
	if(names[0]){
		DKWidget_Show("DKThreadPoolDlg.html");
	}
	else{
		DKWidget_Hide("DKThreadPoolDlg.html");
	}
	for(var i=0; i<names.length; ++i){
		var div = DKWidget_CreateElement("DKThreadPoolDlg.html", "div", "Thread");
		DKWidget_SetProperty(div, "width", "100%");
		DKWidget_SetProperty(div, "height", "20rem");
		DKWidget_SetProperty(div, "white-space", "nowrap");

		if(i == 0){
			DKWidget_SetInnerHtml(div, "<img id=\"DKThreadWorking\" style=\"display:inline;\" src=\"DKThread/working.gif\"></img>"+names[i]);
		}
		else{
			DKWidget_SetInnerHtml(div, names[i]);
		}
	}
}