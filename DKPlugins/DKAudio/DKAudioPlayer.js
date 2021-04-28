var DKAudioPlayer_file = "";

/////////////////////////////
function DKAudioPlayer_init()()()
{
	dk.create("DKAudio");
	dk.create("DKAudio/DKAudioPlayer.html");
	window.addEventListener("timeupdate", DKAudioPlayer_onevent);
	window.addEventListener("ended", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_playpause").addEventListener("click", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_position").addEventListener("input", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_speaker").addEventListener("click", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_volume").addEventListener("input", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_volume").value = "128";
}

////////////////////////////
function DKAudioPlayer_end()()
{
	window.removeEventListener("timeupdate", DKAudioPlayer_onevent);
	window.removeEventListener("ended", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_playpause").removeEventListener("click", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_position").removeEventListener("input", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_speaker").removeEventListener("click", DKAudioPlayer_onevent);
	byId("DKAudioPlayer_volume").removeEventListener("input", DKAudioPlayer_onevent);
	dk.close("DKAudio/DKAudioPlayer.html");
}

/////////////////////////////////////
function DKAudioPlayer_OnEvent(event)
{
	//console.log("DKAudioPlayer_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id === "DKAudioPlayer_playpause"){
		DKAudioPlayer_playpause();
	}
	if(event.currentTarget.id === "DKAudioPlayer_position"){
		DKAudioPlayer_SetTime(byId("DKAudioPlayer_position").value);
	}
	if(event.currentTarget.id === "DKAudioPlayer_speaker"){
		DKAudioPlayer_speaker();
	}
	if(event.currentTarget.id === "DKAudioPlayer_volume"){
		var volume = byId("DKAudioPlayer_volume").value;
		DKAudio_SetVolume(parseInt(volume));
		DKAudioPlayer_UpdateVolume(parseInt(volume));
	}
	if(event.type === "finnished"){
		byId("DKAudioPlayer_playpause").src = "DKAudio/play.png";
	}
	if(event.type === "timeupdate"){
		DKAudioPlayer_TimeUpdate();
	}
}

/////////////////////////////////
function DKAudioPlayer_Open(file)
{
	DKAudioPlayer_file = file;
	DKAudio_OpenMusic(file);
	byId("DKAudioPlayer_position").value = "0";
}

//////////////////////////////////
function DKAudioPlayer_playpause()
{
	var src = byId("DKAudioPlayer_playpause").src;
	if(src.indexOf("play.png") !== -1){
		byId("DKAudioPlayer_playpause").src = "DKAudio/pause.png";
		DKAudio_Resume(DKAudioPlayer_file);
	}
	else{
		byId("DKAudioPlayer_playpause").src = "DKAudio/play.png";
		DKAudio_Pause(DKAudioPlayer_file);
	}
}

/////////////////////////////////////
function DKAudioPlayer_SetTime(value)
{
	var time = (value * DKAudio_GetDuration() / 1000);
	console.log("time = "+time+"\n");
	DKAudio_SetTime(time);
}

///////////////////////////////////
function DKAudioPlayer_TimeUpdate()
{
	var time = DKAudio_GetTime() / DKAudio_GetDuration() * 1000;
	byId("DKAudioPlayer_position").value = time;
	
	var minute = "0";
	minute += ":";
	var second = parseInt(DKAudio_GetTime());//("0" + DK_GetValue(event)).slice (-2);
	byId("DKAudioPlayer_time").innerHTML = minute+second;
}

////////////////////////////////
function DKAudioPlayer_speaker()
{
	var src = byId("DKAudioPlayer_speaker").src;
	if(src.indexOf("mute.png") !== -1){
		DKAudio_UnMute();
		DKAudioPlayer_UpdateVolume(DKAudio_GetVolume());
	}
	else{
		byId("DKAudioPlayer_speaker").src = "DKAudio/mute.png";
		DKAudio_Mute();
	}
	
	console.log("DKAudio_GetVolume() = "+DKAudio_GetVolume()+"\n");
	byId("DKAudioPlayer_volume").value = DKAudio_GetVolume();
}

///////////////////////////////////////////
function DKAudioPlayer_UpdateVolume(volume)
{
	var num = parseInt(volume);
	if(num < 1){
		byId("DKAudioPlayer_speaker").src = "DKAudio/mute.png";
	}
	if(num > 0 && num < 42){
		byId("DKAudioPlayer_speaker").src = "DKAudio/volume1.png";
	}
	if(num > 42 && num < 84){
		byId("DKAudioPlayer_speaker").src = "DKAudio/volume2.png";
	}
	if(num > 84){
		byId("DKAudioPlayer_speaker").src = "DKAudio/volume3.png";
	}
}