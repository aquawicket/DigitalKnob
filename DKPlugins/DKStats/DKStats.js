///////////////////////
function DKStats_Init()
{
	DK_Create("DKStats/DKStats.html");
	window.addEventListener("second", DKStats_OnEvent);
	//byId("DKStats/DKStats.html").addEventListener("click", DKStats_OnEvent);
	DKStats_Update();
}

//////////////////////
function DKStats_End()
{
	window.removeEventListener("second", DKStats_OnEvent);
	//byId("DKStats/DKStats.html").removeEventListener("click", DKStats_OnEvent);
	DKClose("DKStats/DKStats.html");
}

///////////////////////////////
function DKStats_OnEvent(event)
{
	if(event.type === "second"){
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
	byId("DKStats_time").innerHTML = "TIME: "+datetime;
	
	//Frames Per Second
	var fps = DKCPP_DKDuktape_GetFps();
	byId("DKStats_fps").innerHTML = "FPS: "+fps;
	
	//CPU used by app
	var cpu = DKCPP_DKDuktape_CpuUsedByApp();
	byId("DKStats_cpu").innerHTML = "CPU: "+cpu+"%";
	
	//RAM used by app
	var ram = DKCPP_DKDuktape_PhysicalMemoryUsedByApp();
	byId("DKStats_ram").innerHTML = "RAM: "+ram+"MB";
	
	//Virtual Memory used by app
	var swap = DKCPP_DKDuktape_VirtualMemoryUsedByApp();
	byId("DKStats_swap").innerHTML = "SWAP: "+swap+"MB";
	
	//CPU used total
	var cpu = DKCPP_DKDuktape_CpuUsed();
	byId("DKStats_totalcpu").innerHTML = "TOTAL CPU: "+cpu+"%";
	
	//RAM used total
	var ram = DKCPP_DKDuktape_PhysicalMemoryUsed();
	byId("DKStats_totalram").innerHTML = "TOTAL RAM: "+ram+"MB";
	
	//Virtual Memory used total
	var swap = DKCPP_DKDuktape_VirtualMemoryUsed();
	byId("DKStats_totalswap").innerHTML = "TOTAL SWAP: "+swap+"MB";
	
	//System RAM
	var ram = DKCPP_DKDuktape_PhysicalMemory();
	byId("DKStats_systemram").innerHTML = "SYSTEM RAM: "+ram+"MB";
	
	//System Virtual Memory
	var swap = DKCPP_DKDuktape_VirtualMemory();
	byId("DKStats_systemswap").innerHTML = "SYSTEM SWAP: "+swap+"MB";
	
	//Ticks
	var ticks = DKCPP_DKDuktape_GetTicks();
	byId("DKStats_ticks").innerHTML = "TICKS: "+ticks;
	
	//Frames
	var frames = DKCPP_DKDuktape_GetFrames();
	byId("DKStats_frames").innerHTML = "FRAMES: "+frames;
}