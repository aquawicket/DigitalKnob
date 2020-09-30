var clock_time;
var clock_date;
var second_flag = false;

/////////////////////
function Clock_Init()
{
	DKCreate("DKOS/Clock.html,DKOS/Taskbar.html");
	window.addEventListener("second", Clock_OnEvent);
	Clock_Update();
}

////////////////////
function Clock_End()
{
	window.removeEventListener("second", Clock_OnEvent);
	DKClose("DKOS/Clock.html");
}

/////////////////////////////
function Clock_OnEvent(event)
{
	if(DK_Type(event, "second")){
		Clock_Update();
	}
}

///////////////////////
function Clock_Update()
{
	if(second_flag){
		byId("time").style.color = "rgb(255,255,255)";
		second_flag = false;
	}
	else{
		byId("time").style.color = "rgb(220,220,220)";
		second_flag = true;
	}
	if(DK_GetTime() !== clock_time){
		clock_time = DK_GetTime();
		byId("time").innerHTML = clock_time;
	}
	if(DK_GetDate() !== clock_date){
		clock_date = DK_GetDate();
		byId("date").innerHTML = clock_date;
	}
}