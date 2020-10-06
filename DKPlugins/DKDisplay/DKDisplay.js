/////////////////////////
function DKDisplay_Init()
{
	DK_Create("DKDisplay/DKDisplay.html");
	byId("DKDisplay_Button").addEventListener("click", DKDisplay_OnEvent);
	//window.addEventListener("second", DKDisplay_OnEvent);
	//byId("DKDisplay/DKDisplay.html").addEventListener("click", DKDisplay_OnEvent);
}

////////////////////////
function DKDisplay_End()
{
	byId("DKDisplay_Button").removeEventListener("click", DKDisplay_OnEvent);
	//window.removeEventListener("second", DKDisplay_OnEvent);
	//byId("DKDisplay/DKDisplay.html").removeEventListener("click", DKDisplay_OnEvent);
	DK_Close("DKDisplay/DKDisplay.html");
}

/////////////////////////////////
function DKDisplay_OnEvent(event)
{
	console.log("DKDisplay_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "DKDisplay_Button"){
		DK_TurnOffMonitor();
	}
		
	//if(event.type === "second"){
	//	//tick
	//}
}