var DKRocketAudio_file = "";

/////////////////////////////
function DKRocketAudio_Init()
{
	DKCreate("DKRocketAudio/DKRocketAudio.html");
	DKAddEvent("DKRocketAudio_playpause", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_position", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_speaker", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_volume", "change", DKRocketAudio_OnEvent);
}

////////////////////////////
function DKRocketAudio_End()
{
	DKClose("DKRocketAudio/DKRocketAudio.html");
	DKClose("DKAudio");
}

/////////////////////////////////////
function DKRocketAudio_OnEvent(event)
{
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
}

/////////////////////////////////
function DKRocketAudio_Open(file)
{
	DKCreate("DKAudio");
	//DKAudio_PlaySound(file);
	DKRocketAudio_file = file;
	DKAudio_PlayMusic(file);
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
	
	//toggle volume/mute
	var src = DKWidget_GetAttribute("DKRocketAudio_speaker", "src");
	//DKLog("DKRocketAudio_speaker(): src="+src+"\n", DKDEBUG);
	
	if(src.indexOf("mute.png") != -1){
		//DKRocketAudio_volume(DKAudio_GetVolume());
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/volume3.png");
		DKAudio_UnMute();
	}
	else{
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/mute.png");
		DKAudio_Mute();
	}
}

/////////////////////////////////////
function DKRocketAudio_volume(volume)
{
	DKLog("DKRocketAudio_volume("+volume+") \n",DKDEBUG);
	DKAudio_SetVolume(parseInt(volume));
}


