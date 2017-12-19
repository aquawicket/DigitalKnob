var DKAudioPlayer_file = "";

/////////////////////////////
function DKAudioPlayer_Init()
{
	DKCreate("DKAudio");
	DKCreate("DKAudio/DKAudio.js", function(){});
	DKCreate("DKAudio/DKAudioPlayer.html");
	DKAddEvent("DKAudioPlayer_playpause", "click", DKAudioPlayer_OnEvent);
	DKAddEvent("DKAudioPlayer_position", "click", DKAudioPlayer_OnEvent);
	DKAddEvent("DKAudioPlayer_speaker", "click", DKAudioPlayer_OnEvent);
	DKAddEvent("DKAudioPlayer_volume", "change", DKAudioPlayer_OnEvent);
	DKAddEvent("DKAudio", "finnished", DKAudioPlayer_OnEvent);
	DKAddEvent("DKAudio", "position", DKAudioPlayer_OnEvent);
	
	DKWidget_SetValue("DKAudioPlayer_volume","128");
}

////////////////////////////
function DKAudioPlayer_End()
{
	DKRemoveEvents(DKAudioPlayer_OnEvent);
	DKClose("DKAudio/DKAudioPlayer.html");
	DKClose("DKAudio");
}

/////////////////////////////////////
function DKAudioPlayer_OnEvent(event)
{
	DKLog("DKAudioPlayer_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "DKAudioPlayer_playpause")){
		DKAudioPlayer_playpause();
	}
	if(DK_Id(event, "DKAudioPlayer_position")){
		DKAudioPlayer_position();
	}
	if(DK_Id(event, "DKAudioPlayer_speaker")){
		DKAudioPlayer_speaker();
	}
	if(DK_Id(event, "DKAudioPlayer_volume")){
		var volume = DKWidget_GetValue("DKAudioPlayer_volume");
		DKAudioPlayer_volume(volume);
	}
	if(DK_Type(event, "finnished")){
		DKWidget_SetAttribute("DKAudioPlayer_playpause", "src", "DKAudio/play.png");
	}
	if(DK_Type(event, "position")){
		//DKLog("position = "+DK_GetValue(event)+"\n");
		var minute = "0:";
		var second = ("0" + DK_GetValue(event)).slice (-2);
		DKWidget_SetValue("DKAudioPlayer_time", minute+second);
	}
}

/////////////////////////////////
function DKAudioPlayer_Open(file)
{
	//DKAudio_PlaySound(file);
	DKAudioPlayer_file = file;
	DKAudio_OpenMusic(file);
}

//////////////////////////////////
function DKAudioPlayer_playpause()
{
	//DKLog("DKAudioPlayer_playpause() \n");
	
	//toggle play/pause
	var src = DKWidget_GetAttribute("DKAudioPlayer_playpause", "src");
	//DKLog("DKAudioPlayer_playpause(): src="+src+"\n");
	
	if(src.indexOf("play.png") != -1){
		DKWidget_SetAttribute("DKAudioPlayer_playpause", "src", "DKAudio/pause.png");
		DKAudio_Resume(DKAudioPlayer_file);
	}
	else{
		DKWidget_SetAttribute("DKAudioPlayer_playpause", "src", "DKAudio/play.png");
		DKAudio_Pause(DKAudioPlayer_file);
	}
}

/////////////////////////////////
function DKAudioPlayer_position()
{
	DKLog("DKAudioPlayer_position() \n");
}

////////////////////////////////
function DKAudioPlayer_speaker()
{
	//DKLog("DKAudioPlayer_speaker() \n");	
	var src = DKWidget_GetAttribute("DKAudioPlayer_speaker", "src");
	//DKLog("DKAudioPlayer_speaker(): src="+src+"\n");
	
	if(src.indexOf("mute.png") != -1){
		DKAudio_UnMute();
		DKAudioPlayer_volume(DKAudio_GetVolume());
	}
	else{
		DKWidget_SetAttribute("DKAudioPlayer_speaker", "src", "DKAudio/mute.png");
		DKAudio_Mute();
	}
}

/////////////////////////////////////
function DKAudioPlayer_volume(volume)
{
	//DKLog("DKAudioPlayer_volume("+volume+") \n");
	var num = parseInt(volume);
	DKAudio_SetVolume(num);
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


