function DKRmlVideo_init(){
	dk.create("DKRmlVideo/DKRmlVideo.html");
	byId("DKRmlVideo_playpause").addEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_position").addEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_positiontrack").addEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_speaker").addEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_volume").addEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_volumetrack").addEventListener("click", DKRmlVideo_onevent);
}

function DKRmlVideo_end(){
	byId("DKRmlVideo_playpause").removeEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_position").removeEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_positiontrack").removeEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_speaker").removeEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_volume").removeEventListener("click", DKRmlVideo_onevent);
	byId("DKRmlVideo_volumetrack").removeEventListener("click", DKRmlVideo_onevent);
	dk.close("DKRmlVideo/DKRmlVideo.html");
}

function DKRmlVideo_OnEvent(event){
	if(event.currentTarget.id === "DKRmlVideo_playpause"){
		DKRmlVideo_playpause();
	}
	if(event.currentTarget.id === "DKRmlVideo_position"){
		DKRmlVideo_position();
	}
	if(event.currentTarget.id === "DKRmlVideo_positiontrack"){
		DKRmlVideo_positiontrack();
	}
	if(event.currentTarget.id === "DKRmlVideo_speaker"){
		DKRmlVideo_speaker();
	}
	if(event.currentTarget.id === "DKRmlVideo_volume"){
		DKRmlVideo_volume();
	}
	if(event.currentTarget.id === "DKRmlVideo_volumetrack"){
		DKRmlVideo_volumetrack();
	}
}

function DKRmlVideo_playpause(){
	//toggle play/pause
	var src = byId("DKRmlVideo_playpause").src;
	//console.log(("DKRmlVideo_playpause(): src="+src+"\n");
	
	if(src.indexOf("play.png") !== -1){
		byId("DKRmlVideo_playpause").src = "DKRmlVideo/pause.png";
	}
	else{
		byId("DKRmlVideo_playpause").src = "DKRmlVideo/play.png";
	}
}

function DKRmlVideo_position(){

}

function DKRmlVideo_positiontrack(){
	
}

function DKRmlVideo_speaker(){
	//toggle volume/mute
	var src = byId("DKRmlVideo_speaker").src;
	console.log(("DKRmlVideo_speaker(): src="+src+"\n");
	
	if(src.indexOf("mute.png") !== -1){
		byId("DKRmlVideo_speaker").src = "DKRmlVideo/volume3.png";
	}
	else{
		byId("DKRmlVideo_speaker").src = "DKRmlVideo/mute.png";
	}
}

function DKRmlVideo_volume(){

}

function DKRmlVideo_volumetrack(){
	
}