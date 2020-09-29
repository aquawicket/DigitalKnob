///////////////////////
function DKStats_Init()
{
	DKCreate("DKStats/DKStats.html");
	DKAddEvent("window", "second", DKStats_OnEvent);
	//DKAddEvent("DKStats/DKStats.html", "click", DKStats_OnEvent);
}

//////////////////////
function DKStats_End()
{
	DKRemoveEvents(DKStats_OnEvent);
	DKClose("DKStats/DKStats.html");
}

///////////////////////////////
function DKStats_OnEvent(event)
{
	if(DK_Type(event, "second")){
		DKStats_Update();
	}
}

/////////////////////////
function DKStats_Update()
{
	//TIME
	var currentdate = new Date(); 
	var hours = currentdate.getHours();
	if(hours > 12){ hours = hours - 12; } // Standard time
	var datetime = ('00'+(currentdate.getMonth()+1)).slice(-2) + "/"
                + ('00'+currentdate.getDate()).slice(-2) + "/" 
                + currentdate.getFullYear() + " "  
                + hours + ":"  
                + ('00'+currentdate.getMinutes()).slice(-2) + ":" 
                + ('00'+currentdate.getSeconds()).slice(-2);
	DKWidget_SetInnerHtml("DKStats_time", "TIME: "+datetime);
	
	//Frames Per Second
	var fps = DK_GetFps();
	DKWidget_SetInnerHtml("DKStats_fps", "FPS: "+fps);
	
	//CPU used by app
	var cpu = DK_CpuUsedByApp();
	DKWidget_SetInnerHtml("DKStats_cpu", "CPU: "+cpu+"%");
	
	//RAM used by app
	var ram = DK_PhysicalMemoryUsedByApp();
	DKWidget_SetInnerHtml("DKStats_ram", "RAM: "+ram+"MB");
	
	//Virtual Memory used by app
	var swap = DK_VirtualMemoryUsedByApp();
	DKWidget_SetInnerHtml("DKStats_swap", "SWAP: "+swap+"MB");
	
	//CPU used total
	var cpu = DK_CpuUsed();
	DKWidget_SetInnerHtml("DKStats_totalcpu", "TOTAL CPU: "+cpu+"%");
	
	//RAM used total
	var ram = DK_PhysicalMemoryUsed();
	DKWidget_SetInnerHtml("DKStats_totalram", "TOTAL RAM: "+ram+"MB");
	
	//Virtual Memory used total
	var swap = DK_VirtualMemoryUsed();
	DKWidget_SetInnerHtml("DKStats_totalswap", "TOTAL SWAP: "+swap+"MB");
	
	//System RAM
	var ram = DK_PhysicalMemory();
	DKWidget_SetInnerHtml("DKStats_systemram", "SYSTEM RAM: "+ram+"MB");
	
	//System Virtual Memory
	var swap = DK_VirtualMemory();
	DKWidget_SetInnerHtml("DKStats_systemswap", "SYSTEM SWAP: "+swap+"MB");
	
	//Ticks
	var ticks = DK_GetTicks();
	DKWidget_SetInnerHtml("DKStats_ticks", "TICKS: "+ticks);
	
	//Frames
	var frames = DK_GetFrames();
	DKWidget_SetInnerHtml("DKStats_frames", "FRAMES: "+frames);
}