///////////////////////////////
function DKThreadPoolDlg_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKThreadPool");
	//if(!DKValid("DKWidgetJS,DKWidgetJS0")){ return; }  //FIXME: This was here for a reason.
	DKCreate("DKThread/DKThreadPoolDlg.html"); 
	//DKAddEvent("DKThreadPoolDlg.html", "Update", DKThreadPoolDlg_OnEvent);
	byId("DKThread/DKThreadPoolDlg.html").addEventListener("Update", DKThreadPoolDlg_OnEvent);
}

//////////////////////////////
function DKThreadPoolDlg_End()
{
	DKDEBUGFUNC();
	//DKRemoveEvents(DKThreadPoolDlg_OnEvent);
	DKClose("DKThread/DKThreadPoolDlg.html");
}

///////////////////////////////////////
function DKThreadPoolDlg_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Type(event, "Update")){
		DKThreadPoolDlg_OnUpdate();
	}
}

///////////////////////////////////
function DKThreadPoolDlg_OnUpdate()
{
	DKDEBUGFUNC();
	if(!DKValid("DKWidgetJS,DKWidgetJS0")){ return; }
	console.log("Update DKThreadPool\n");
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