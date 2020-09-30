var DKAudioPlayer_file = "";

/////////////////////////////
function DKAudioPlayer_Init()
{
	DKCreate("DKAudio");
	DKCreate("DKAudio/DKAudioPlayer.html");
	window.addEventListener("timeupdate", DKAudioPlayer_OnEvent);
	window.addEventListener("ended", DKAudioPlayer_OnEvent);
	byId("DKAudioPlayer_playpause").addEventListener("click", DKAudioPlayer_OnEvent);
	byId("DKAudioPlayer_position").addEventListener("input", DKAudioPlayer_OnEvent);
	byId("DKAudioPlayer_speaker").addEventListener("click", DKAudioPlayer_OnEvent);
	byId("DKAudioPlayer_volume").addEventListener("input", DKAudioPlayer_OnEvent);
	DKWidget_SetValue("DKAudioPlayer_volume", "128");
}

////////////////////////////
function DKAudioPlayer_End()
{
	window.removeEventListener("timeupdate", DKAudioPlayer_OnEvent);
	window.removeEventListener("ended", DKAudioPlayer_OnEvent);
	byId("DKAudioPlayer_playpause").removeEventListener("click", DKAudioPlayer_OnEvent);
	byId("DKAudioPlayer_position").removeEventListener("input", DKAudioPlayer_OnEvent);
	byId("DKAudioPlayer_speaker").removeEventListener("click", DKAudioPlayer_OnEvent);
	byId("DKAudioPlayer_volume").removeEventListener("input", DKAudioPlayer_OnEvent);
	DKClose("DKAudio/DKAudioPlayer.html");
}

/////////////////////////////////////
function DKAudioPlayer_OnEvent(event)
{
	//console.lof("DKAudioPlayer_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id == "DKAudioPlayer_playpause"){
		DKAudioPlayer_playpause();
	}
	if(event.currentTarget.id == "DKAudioPlayer_position"){
		DKAudioPlayer_SetTime(DKWidget_GetValue("DKAudioPlayer_position"));
	}
	if(event.currentTarget.id == "DKAudioPlayer_speaker"){
		DKAudioPlayer_speaker();
	}
	if(event.currentTarget.id == "DKAudioPlayer_volume"){
		var volume = DKWidget_GetValue("DKAudioPlayer_volume");
		DKAudio_SetVolume(parseInt(volume));
		DKAudioPlayer_UpdateVolume(parseInt(volume));
	}
	if(event.type == "finnished"){
		byId("DKAudioPlayer_playpause").src = "DKAudio/play.png";
	}
	if(event.type == "timeupdate"){
		DKAudioPlayer_TimeUpdate();
	}
}

/////////////////////////////////
function DKAudioPlayer_Open(file)
{
	DKAudioPlayer_file = file;
	DKAudio_OpenMusic(file);
	DKWidget_SetValue("DKAudioPlayer_position", "0");
}

//////////////////////////////////
function DKAudioPlayer_playpause()
{
	var src = byId("DKAudioPlayer_playpause").src;
	if(src.indexOf("play.png") != -1){
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
	console.lof("time = "+time+"\n");
	DKAudio_SetTime(time);
}

///////////////////////////////////
function DKAudioPlayer_TimeUpdate()
{
	var time = DKAudio_GetTime() / DKAudio_GetDuration() * 1000;
	DKWidget_SetValue("DKAudioPlayer_position", time);
	
	var minute = "0";
	minute += ":";
	var second = parseInt(DKAudio_GetTime());//("0" + DK_GetValue(event)).slice (-2);
	DKWidget_SetValue("DKAudioPlayer_time", minute+second);
}

////////////////////////////////
function DKAudioPlayer_speaker()
{
	var src = byId("DKAudioPlayer_speaker").src;
	if(src.indexOf("mute.png") != -1){
		DKAudio_UnMute();
		DKAudioPlayer_UpdateVolume(DKAudio_GetVolume());
	}
	else{
		byId("DKAudioPlayer_speaker").src = "DKAudio/mute.png";
		DKAudio_Mute();
	}
	
	console.lof("DKAudio_GetVolume() = "+DKAudio_GetVolume()+"\n");
	DKWidget_SetValue("DKAudioPlayer_volume", DKAudio_GetVolume());
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