var clock_time;
var clock_date;
var second_flag = false;

/////////////////////
function Clock_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKOS/Clock.html,DKOS/Taskbar.html");
	DKAddEvent("window", "second", Clock_OnEvent);
	Clock_Update();
}

////////////////////
function Clock_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(Clock_OnEvent);
	DKClose("DKOS/Clock.html");
}

/////////////////////////////
function Clock_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Type(event, "second")){
		Clock_Update();
	}
}

///////////////////////
function Clock_Update()
{
	DKDEBUGFUNC();
	if(second_flag){
		DKWidget_SetProperty("time", "color", "rgb(255,255,255)");
		second_flag = false;
	}
	else{
		DKWidget_SetProperty("time", "color", "rgb(220,220,220)");
		second_flag = true;
	}
	if(DK_GetTime() != clock_time){
		clock_time = DK_GetTime();
		DKWidget_SetInnerHtml("time", clock_time);
	}
	if(DK_GetDate() != clock_date){
		clock_date = DK_GetDate();
		DKWidget_SetInnerHtml("date", clock_date);
	}
}