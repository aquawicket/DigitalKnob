var DKRocketAudio_file = "";

/////////////////////////////
function DKRocketAudio_Init()
{
	DKCreate("DKAudio");
	DKCreate("DKRocketAudio/DKRocketAudio.html");
	DKAddEvent("DKRocketAudio_playpause", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_position", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_speaker", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_volume", "change", DKRocketAudio_OnEvent);
	DKAddEvent("DKAudio", "finnished", DKRocketAudio_OnEvent);
	DKAddEvent("DKAudio", "position", DKRocketAudio_OnEvent);
	
	DKWidget_SetValue("DKRocketAudio_volume","128");
}

////////////////////////////
function DKRocketAudio_End()
{
	DKRemoveEvent("DKRocketAudio_playpause", "click", DKRocketAudio_OnEvent);
	DKRemoveEvent("DKRocketAudio_position", "click", DKRocketAudio_OnEvent);
	DKRemoveEvent("DKRocketAudio_speaker", "click", DKRocketAudio_OnEvent);
	DKRemoveEvent("DKRocketAudio_volume", "change", DKRocketAudio_OnEvent);
	DKRemoveEvent("DKAudio", "finnished", DKRocketAudio_OnEvent);
	DKRemoveEvent("DKAudio", "position", DKRocketAudio_OnEvent);
	DKClose("DKRocketAudio.html");
	DKClose("DKAudio");
}

/////////////////////////////////////
function DKRocketAudio_OnEvent(event)
{
	DKLog("DKRocketAudio_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event, "DKRocketAudio_playpause")){
		DKRocketAudio_playpause();
	}
	if(DK_Id(event, "DKRocketAudio_position")){
		DKRocketAudio_position();
	}
	if(DK_Id(event, "DKRocketAudio_speaker")){
		DKRocketAudio_speaker();
	}
	if(DK_Id(event, "DKRocketAudio_volume")){
		var volume = DKWidget_GetValue("DKRocketAudio_volume");
		DKRocketAudio_volume(volume);
	}
	if(DK_Type(event, "finnished")){
		DKWidget_SetAttribute("DKRocketAudio_playpause", "src", "DKRocketAudio/play.png");
	}
	if(DK_Type(event, "position")){
		//DKLog("position = "+DK_GetValue(event)+"\n");
		var minute = "0:";
		var second = ("0" + DK_GetValue(event)).slice (-2);
		DKWidget_SetValue("DKRocketAudio_time", minute+second);
	}
}

/////////////////////////////////
function DKRocketAudio_Open(file)
{
	//DKAudio_PlaySound(file);
	DKRocketAudio_file = file;
	DKAudio_OpenMusic(file);
}

//////////////////////////////////
function DKRocketAudio_playpause()
{
	//DKLog("DKRocketAudio_playpause() \n",DKDEBUG);
	
	//toggle play/pause
	var src = DKWidget_GetAttribute("DKRocketAudio_playpause", "src");
	//DKLog("DKRocketAudio_playpause(): src="+src+"\n", DKDEBUG);
	
	if(src.indexOf("play.png") != -1){
		DKWidget_SetAttribute("DKRocketAudio_playpause", "src", "DKRocketAudio/pause.png");
		DKAudio_Resume(DKRocketAudio_file);
	}
	else{
		DKWidget_SetAttribute("DKRocketAudio_playpause", "src", "DKRocketAudio/play.png");
		DKAudio_Pause(DKRocketAudio_file);
	}
}

/////////////////////////////////
function DKRocketAudio_position()
{
	DKLog("DKRocketAudio_position() \n",DKDEBUG);
}

////////////////////////////////
function DKRocketAudio_speaker()
{
	//DKLog("DKRocketAudio_speaker() \n",DKDEBUG);	
	var src = DKWidget_GetAttribute("DKRocketAudio_speaker", "src");
	//DKLog("DKRocketAudio_speaker(): src="+src+"\n", DKDEBUG);
	
	if(src.indexOf("mute.png") != -1){
		DKAudio_UnMute();
		DKRocketAudio_volume(DKAudio_GetVolume());
	}
	else{
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/mute.png");
		DKAudio_Mute();
	}
}

/////////////////////////////////////
function DKRocketAudio_volume(volume)
{
	//DKLog("DKRocketAudio_volume("+volume+") \n",DKDEBUG);
	var num = parseInt(volume);
	DKAudio_SetVolume(num);
	if(num < 1){
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/mute.png");
	}
	if(num > 0 && num < 42){
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/volume1.png");
	}
	if(num > 42 && num < 84){
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/volume2.png");
	}
	if(num > 84){
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/volume3.png");
	}
}


