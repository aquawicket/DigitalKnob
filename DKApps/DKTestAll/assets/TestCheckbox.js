function New_Init()
{
	DKCreate("New.html");
	DKAddEvent("Button", "click", New_OnEvent);
}

function New_OnEvent(event)
{
	//DKLog("SHIT!\n", DKERROR);
	var safe = false;
	if(document.getElementById("Checkbox").checked == true){
		var safe = true;
	}

	
	if(safe == true){
		DKWidget_SetProperty("Button", "background-color", "rgb(0,0,100)");
		DKWidget_SetInnerHtml("Button", "safe");
		return;
	}

	DKWidget_SetProperty("Button", "background-color", "rgb(100,0,0)");
	DKWidget_SetInnerHtml("Button", "BOOM!!!");

}