/////////////////////////////
function DKRocketVideo_Init()
{
	DK_Create("DKRocketVideo/DKRocketVideo.html");
	byId("DKRocketVideo_playpause").addEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_position").addEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_positiontrack").addEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_speaker").addEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_volume").addEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_volumetrack").addEventListener("click", DKRocketVideo_OnEvent);
}

////////////////////////////
function DKRocketVideo_End()
{
	byId("DKRocketVideo_playpause").removeEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_position").removeEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_positiontrack").removeEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_speaker").removeEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_volume").removeEventListener("click", DKRocketVideo_OnEvent);
	byId("DKRocketVideo_volumetrack").removeEventListener("click", DKRocketVideo_OnEvent);
	DKClose("DKRocketVideo/DKRocketVideo.html");
}

/////////////////////////////////////
function DKRocketVideo_OnEvent(event)
{
	if(event.currentTarget.id === "DKRocketVideo_playpause"){
		DKRocketVideo_playpause();
	}
	if(event.currentTarget.id === "DKRocketVideo_position"){
		DKRocketVideo_position();
	}
	if(event.currentTarget.id === "DKRocketVideo_positiontrack"){
		DKRocketVideo_positiontrack();
	}
	if(event.currentTarget.id === "DKRocketVideo_speaker"){
		DKRocketVideo_speaker();
	}
	if(event.currentTarget.id === "DKRocketVideo_volume"){
		DKRocketVideo_volume();
	}
	if(event.currentTarget.id === "DKRocketVideo_volumetrack"){
		DKRocketVideo_volumetrack();
	}
}

//////////////////////////////////
function DKRocketVideo_playpause()
{
	//toggle play/pause
	var src = byId("DKRocketVideo_playpause").src;
	//console.log(("DKRocketVideo_playpause(): src="+src+"\n");
	
	if(src.indexOf("play.png") !== -1){
		byId("DKRocketVideo_playpause").src = "DKRocketVideo/pause.png";
	}
	else{
		byId("DKRocketVideo_playpause").src = "DKRocketVideo/play.png";
	}
}

/////////////////////////////////
function DKRocketVideo_position()
{

}

//////////////////////////////////////
function DKRocketVideo_positiontrack()
{
	
}

////////////////////////////////
function DKRocketVideo_speaker()
{
	//toggle volume/mute
	var src = byId("DKRocketVideo_speaker").src;
	console.log(("DKRocketVideo_speaker(): src="+src+"\n");
	
	if(src.indexOf("mute.png") !== -1){
		byId("DKRocketVideo_speaker").src = "DKRocketVideo/volume3.png";
	}
	else{
		byId("DKRocketVideo_speaker").src = "DKRocketVideo/mute.png";
	}
}

///////////////////////////////
function DKRocketVideo_volume()
{

}

////////////////////////////////////
function DKRocketVideo_volumetrack()
{
	
}