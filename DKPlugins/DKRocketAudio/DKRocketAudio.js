/////////////////////////////
function DKRocketAudio_Init()
{
	DKCreate("DKRocketAudio/DKRocketAudio.html");
	DKAddEvent("DKRocketAudio_playpause", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_position", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_positiontrack", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_speaker", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_volume", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_volumetrack", "click", DKRocketAudio_OnEvent);
}

////////////////////////////
function DKRocketAudio_End()
{
	DKClose("DKRocketAudio/DKRocketAudio.html");
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
	if(DK_Id(event, "DKRocketAudio_positiontrack")){
		DKRocketAudio_positiontrack();
	}
	if(DK_Id(event, "DKRocketAudio_speaker", "click")){
		DKRocketAudio_speaker();
	}
	if(DK_Id(event, "DKRocketAudio_volume", "click")){
		DKRocketAudio_volume();
	}
	if(DK_Id(event, "DKRocketAudio_volumetrack", "click")){
		DKRocketAudio_volumetrack();
	}
}

/////////////////////////////////
function DKRocketAudio_Open(file)
{
	DKCreate("DKAudio");
	//DKAudio_PlaySound(file);
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
		DKAudio_Resume(file);
	}
	else{
		DKWidget_SetAttribute("DKRocketAudio_playpause", "src", "DKRocketAudio/play.png");
		DKAudio_Pause(file);
	}
}

/////////////////////////////////
function DKRocketAudio_position()
{
	//DKLog("DKRocketAudio_position() \n",DKDEBUG);
}

//////////////////////////////////////
function DKRocketAudio_positiontrack()
{
	//DKLog("DKRocketAudio_positiontrack() \n",DKDEBUG);
}

////////////////////////////////
function DKRocketAudio_speaker()
{
	//DKLog("DKRocketAudio_speaker() \n",DKDEBUG);
	
	//toggle volume/mute
	var src = DKWidget_GetAttribute("DKRocketAudio_speaker", "src");
	DKLog("DKRocketAudio_speaker(): src="+src+"\n", DKDEBUG);
	
	if(src.indexOf("mute.png") != -1){
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/volume3.png");
	}
	else{
		DKWidget_SetAttribute("DKRocketAudio_speaker", "src", "DKRocketAudio/mute.png");
	}
}

///////////////////////////////
function DKRocketAudio_volume()
{
	//DKLog("DKRocketAudio_volume() \n",DKDEBUG);
}

////////////////////////////////////
function DKRocketAudio_volumetrack()
{
	//DKLog("DKRocketAudio_volumetrack() \n",DKDEBUG);
}

