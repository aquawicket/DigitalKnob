var DKAudioPlayer_file = "";

/////////////////////////////
function DKAudioPlayer_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKAudio");
	DKCreate("DKAudio/DKAudioPlayer.html");
	DKAddEvent("DKAudioPlayer_playpause", "click", DKAudioPlayer_OnEvent);
	DKAddEvent("DKAudioPlayer_position", "input", DKAudioPlayer_OnEvent);
	DKAddEvent("DKAudioPlayer_speaker", "click", DKAudioPlayer_OnEvent);
	DKAddEvent("DKAudioPlayer_volume", "input", DKAudioPlayer_OnEvent);
	DKAddEvent("GLOBAL", "ended", DKAudioPlayer_OnEvent);
	DKAddEvent("GLOBAL", "timeupdate", DKAudioPlayer_OnEvent);
	DKWidget_SetValue("DKAudioPlayer_volume", "128");
}

////////////////////////////
function DKAudioPlayer_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKAudioPlayer_OnEvent);
	DKClose("DKAudio/DKAudioPlayer.html");
}

/////////////////////////////////////
function DKAudioPlayer_OnEvent(event)
{
	DKDEBUGFUNC(event);
	//DKINFO("DKAudioPlayer_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "DKAudioPlayer_playpause")){
		DKAudioPlayer_playpause();
	}
	if(DK_Id(event, "DKAudioPlayer_position")){
		DKAudioPlayer_SetTime(DKWidget_GetValue("DKAudioPlayer_position"));
	}
	if(DK_Id(event, "DKAudioPlayer_speaker")){
		DKAudioPlayer_speaker();
	}
	if(DK_Id(event, "DKAudioPlayer_volume")){
		var volume = DKWidget_GetValue("DKAudioPlayer_volume");
		DKAudio_SetVolume(parseInt(volume));
		DKAudioPlayer_UpdateVolume(parseInt(volume));
	}
	if(DK_Type(event, "finnished")){
		DKWidget_SetAttribute("DKAudioPlayer_playpause", "src", "DKAudio/play.png");
	}
	if(DK_Type(event, "timeupdate")){
		DKAudioPlayer_TimeUpdate();
	}
}

/////////////////////////////////
function DKAudioPlayer_Open(file)
{
	DKDEBUGFUNC(file);
	DKAudioPlayer_file = file;
	DKAudio_OpenMusic(file);
	DKWidget_SetValue("DKAudioPlayer_position", "0");
}

//////////////////////////////////
function DKAudioPlayer_playpause()
{
	DKDEBUGFUNC();
	var src = DKWidget_GetAttribute("DKAudioPlayer_playpause", "src");
	if(src.indexOf("play.png") != -1){
		DKWidget_SetAttribute("DKAudioPlayer_playpause", "src", "DKAudio/pause.png");
		DKAudio_Resume(DKAudioPlayer_file);
	}
	else{
		DKWidget_SetAttribute("DKAudioPlayer_playpause", "src", "DKAudio/play.png");
		DKAudio_Pause(DKAudioPlayer_file);
	}
}

/////////////////////////////////////
function DKAudioPlayer_SetTime(value)
{
	DKDEBUGFUNC(value);
	var time = (value * DKAudio_GetDuration() / 1000);
	DKINFO("time = "+time+"\n");
	DKAudio_SetTime(time);
}

///////////////////////////////////
function DKAudioPlayer_TimeUpdate()
{
	DKDEBUGFUNC();
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
	DKDEBUGFUNC();
	var src = DKWidget_GetAttribute("DKAudioPlayer_speaker", "src");
	if(src.indexOf("mute.png") != -1){
		DKAudio_UnMute();
		DKAudioPlayer_UpdateVolume(DKAudio_GetVolume());
	}
	else{
		DKWidget_SetAttribute("DKAudioPlayer_speaker", "src", "DKAudio/mute.png");
		DKAudio_Mute();
	}
	
	DKINFO("DKAudio_GetVolume() = "+DKAudio_GetVolume()+"\n");
	DKWidget_SetValue("DKAudioPlayer_volume", DKAudio_GetVolume());
}

///////////////////////////////////////////
function DKAudioPlayer_UpdateVolume(volume)
{
	DKDEBUGFUNC(volume);
	var num = parseInt(volume);
	if(num < 1){
		DKWidget_SetAttribute("DKAudioPlayer_speaker", "src", "DKAudio/mute.png");
	}
	if(num > 0 && num < 42){
		DKWidget_SetAttribute("DKAudioPlayer_speaker", "src", "DKAudio/volume1.png");
	}
	if(num > 42 && num < 84){
		DKWidget_SetAttribute("DKAudioPlayer_speaker", "src", "DKAudio/volume2.png");
	}
	if(num > 84){
		DKWidget_SetAttribute("DKAudioPlayer_speaker", "src", "DKAudio/volume3.png");
	}
}