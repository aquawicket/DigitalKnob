var DKMessageBox_callback;

////////////////////////////
function DKMessageBox_Init()
{	
    /*
	DK_Create("DKGui/DKMessageBox.html");
	byId("DKMessageBoxOk").addEventListener("click", DKMessageBox_OnEvent);
	byId("DKMessageBoxCancel").addEventListener("click", DKMessageBox_OnEvent);
	*/
}

///////////////////////////
function DKMessageBox_End()
{
	byId("DKMessageBoxOk").removeEventListener("click", DKMessageBox_OnEvent);
	byId("DKMessageBoxCancel").removeEventListener("click", DKMessageBox_OnEvent);
	DK_Close("DKGui/DKMessageBox.html");
}

////////////////////////////////////
function DKMessageBox_OnEvent(event)
{	
	if(event.currentTarget.id === "DKMessageBoxOk"){
		if(DKMessageBox_callback){
			if(byId("DKMessageBoxInput").style.visibilty){ //TODO: review this 
				DKMessageBox_callback(byId("DKMessageBoxInput").value);
			}
			else{
				DKMessageBox_callback(true);
			}
		}
		DKFrame_Close("DKGui/DKMessageBox.html");
		return;
	}
	
	if(event.currentTarget.id === "DKMessageBoxCancel"){
		if(DKMessageBox_callback){
			DKMessageBox_callback(false);
		}
		DKFrame_Close("DKGui/DKMessageBox.html");
		return;
	}
}

//////////////////////////////////////
function DKMessageBox_Message(message)
{
	byId("DKMessageBoxText").innerHTML = message;
	byId("DKMessageBoxInput").style.display = "none";
	byId("DKMessageBoxCancel").style.display = "none";
	byId("DKMessageBoxText").style.display = "block";
	byId("DKMessageBoxText").style.visibility = "visible";
	byId("DKGui/DKMessageBox.html").style.display = "block";
	byId("DKGui/DKMessageBox.html").style.visibility = "visible";
}

////////////////////////////////////////////////
function DKMessageBox_Confirm(message, callback)
{
	//DKMessageBox_Init();
	DK_Create("DKGui/DKMessageBox.html");
	DKFrame_Html("DKGui/DKMessageBox.html");
	byId("DKMessageBoxOk").addEventListener("click", DKMessageBox_OnEvent);
	byId("DKMessageBoxCancel").addEventListener("click", DKMessageBox_OnEvent);

	byId("DKMessageBoxText").innerHTML = message;
	byId("DKMessageBoxInput").style.display = "none";
	byId("DKMessageBoxText").style.display = "block";
	byId("DKMessageBoxText").style.visibility = "visible";
	byId("DKMessageBoxCancel").style.display = "block";
	byId("DKMessageBoxCancel").style.visibility = "visible";
	byId("DKGui/DKMessageBox.html").style.display = "block";
	byId("DKGui/DKMessageBox.html").style.visibility = "visible";
	DKMessageBox_callback = callback;
}

/////////////////////////////////////////////////
function DKMessageBox_GetValue(message, callback)
{
	byId("DKMessageBoxText").innerHTML = message;
	byId("DKMessageBoxText").style.display = "block";
	byId("DKMessageBoxText").style.visibility = "visible";
	byId("DKMessageBoxInput").style.display = "block";
	byId("DKMessageBoxInput").style.visibility = "visible";
	byId("DKMessageBoxCancel").style.display = "block";
	byId("DKMessageBoxCancel").style.visibility = "visible";
	byId("DKGui/DKMessageBox.html").style.display = "block";
	byId("DKGui/DKMessageBox.html").style.visibility = "visible";
	DKMessageBox_callback = callback;
}