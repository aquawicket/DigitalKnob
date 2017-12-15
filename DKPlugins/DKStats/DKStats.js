///////////////////////
function DKStats_Init()
{
	//DKLog("DKStats_Init()\n");
	
	DKCreate("DKStats/DKStats.html");
	DKAddEvent("GLOBAL", "second", DKStats_OnEvent);
	//DKAddEvent("DKStats/DKStats.html", "click", DKStats_OnEvent);
}

//////////////////////
function DKStats_End()
{
	//DKLog("DKStats_End()\n");
	
	DKRemoveEvents(DKStats_OnEvent);
	DKClose("DKStats/DKStats.html");
}

///////////////////////////////
function DKStats_OnEvent(event)
{
	//DKLog("DKStats_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "second")){
		DKStats_Update();
	}
}

/////////////////////////
function DKStats_Update()
{
	//TIME
	var currentdate = new Date(); 
	var datetime = ('00'+(currentdate.getMonth()+1)).slice(-2) + "/"
                + ('00'+currentdate.getDate()).slice(-2) + "/" 
                + currentdate.getFullYear() + " "  
                + currentdate.getHours() + ":"  
                + ('00'+currentdate.getMinutes()).slice(-2) + ":" 
                + ('00'+currentdate.getSeconds()).slice(-2);
	DKWidget_SetInnerHtml("DKStats_time", "TIME: "+datetime);
				
	//CPU%
	var cpu = DK_CpuUsedByApp();
	DKWidget_SetInnerHtml("DKStats_cpu", "CPU: "+cpu+"%");
	
	//RAM usage
	var ram = DK_PhysicalMemoryUsedByApp();
	DKWidget_SetInnerHtml("DKStats_ram", "RAM: "+ram+"MB");
}

('00'+n).slice(-2);