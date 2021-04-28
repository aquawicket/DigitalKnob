/////////////////////////
function DKDisplay_init()
{
	dk.create("DKDisplay/DKDisplay.html");
	byId("DKDisplay_Button").addEventListener("click", DKDisplay_onevent);
	//window.addEventListener("second", DKDisplay_onevent);
	//byId("DKDisplay/DKDisplay.html").addEventListener("click", DKDisplay_onevent);
}

////////////////////////
function DKDisplay_end()()
{
	byId("DKDisplay_Button").removeEventListener("click", DKDisplay_onevent);
	//window.removeEventListener("second", DKDisplay_onevent);
	//byId("DKDisplay/DKDisplay.html").removeEventListener("click", DKDisplay_onevent);
	dk.close("DKDisplay/DKDisplay.html");
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