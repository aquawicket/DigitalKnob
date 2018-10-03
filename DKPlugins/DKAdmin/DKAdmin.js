///////////////////////
function DKAdmin_Init()
{
	//DKLog("DKAdmin_Init()\n");
	
	DKCreate("DKAdmin/DKAdmin.html");
	DKAddEvent("GLOBAL", "second", DKAdmin_OnEvent);
	//DKAddEvent("DKAdmin/DKAdmin.html", "click", DKAdmin_OnEvent);
}

//////////////////////
function DKAdmin_End()
{
	//DKLog("DKAdmin_End()\n");
	
	DKRemoveEvents(DKAdmin_OnEvent);
	DKClose("DKAdmin/DKAdmin.html");
}

///////////////////////////////
function DKAdmin_OnEvent(event)
{
	//DKLog("DKAdmin_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "second")){
		DKAdmin_Update();
	}
}

/////////////////////////
function DKAdmin_Update()
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
	DKWidget_SetInnerHtml("DKAdmin_time", "TIME: "+datetime);
	
	//Frames Per Second
	var fps = DK_GetFps();
	DKWidget_SetInnerHtml("DKAdmin_fps", "FPS: "+fps);
	
	//CPU used by app
	var cpu = DK_CpuUsedByApp();
	DKWidget_SetInnerHtml("DKAdmin_cpu", "CPU: "+cpu+"%");
	
	//RAM used by app
	var ram = DK_PhysicalMemoryUsedByApp();
	DKWidget_SetInnerHtml("DKAdmin_ram", "RAM: "+ram+"MB");
	
	//Virtual Memory used by app
	var swap = DK_VirtualMemoryUsedByApp();
	DKWidget_SetInnerHtml("DKAdmin_swap", "SWAP: "+swap+"MB");
	
	//CPU used total
	var cpu = DK_CpuUsed();
	DKWidget_SetInnerHtml("DKAdmin_totalcpu", "TOTAL CPU: "+cpu+"%");
	
	//RAM used total
	var ram = DK_PhysicalMemoryUsed();
	DKWidget_SetInnerHtml("DKAdmin_totalram", "TOTAL RAM: "+ram+"MB");
	
	//Virtual Memory used total
	var swap = DK_VirtualMemoryUsed();
	DKWidget_SetInnerHtml("DKAdmin_totalswap", "TOTAL SWAP: "+swap+"MB");
	
	//System RAM
	var ram = DK_PhysicalMemory();
	DKWidget_SetInnerHtml("DKAdmin_systemram", "SYSTEM RAM: "+ram+"MB");
	
	//System Virtual Memory
	var swap = DK_VirtualMemory();
	DKWidget_SetInnerHtml("DKAdmin_systemswap", "SYSTEM SWAP: "+swap+"MB");
	
	//Ticks
	var ticks = DK_GetTicks();
	DKWidget_SetInnerHtml("DKAdmin_ticks", "TICKS: "+ticks);
	
	//Frames
	var frames = DK_GetFrames();
	DKWidget_SetInnerHtml("DKAdmin_frames", "FRAMES: "+frames);
}