var clock_time;
var clock_date;
var second_flag = false;

/////////////////////
function Clock_Init()
{
	DKLog("Clock_Init()\n", DKDEBUG);
	DKCreate("DKGui/Clock.html,DKGui/Taskbar.html");
	DKAddEvent("GLOBAL", "second", Clock_OnEvent);
	Clock_Update();
}

////////////////////
function Clock_End()
{
	DKLog("Clock_End()\n", DKDEBUG);
	DKRemoveEvents(Clock_OnEvent);
	DKClose("DKGui/Clock.html");
}

/////////////////////////////
function Clock_OnEvent(event)
{
	DKLog("Clock_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Type(event, "second")){
		Clock_Update();
	}
}

///////////////////////
function Clock_Update()
{
	DKLog("Clock_Update()\n", DKDEBUG);
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