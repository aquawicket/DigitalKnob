/////////////////////////////
function DKRocketAudio_Init()
{
	DKCreate("DKRocketAudio/DKRocketAudio.html");
	DKAddEvent("DKRocketAudio_playpause", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_position", "click", DKRocketAudio_OnEvent);
	DKAddEvent("DKRocketAudio_positiontrack", "click", DKRocketAudio_OnEvent);
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
		DKLog("DKRocketAudio_OnEvent(): DKRocketAudio_playpause\n",DKDEBUG);
	}
	if(DK_Id(event, "DKRocketAudio_position")){
		DKLog("DKRocketAudio_OnEvent(): DKRocketAudio_position\n",DKDEBUG);
	}
	if(DK_Id(event, "DKRocketAudio_positiontrack")){
		DKLog("DKRocketAudio_OnEvent(): DKRocketAudio_positiontrack\n",DKDEBUG);
	}
	if(DK_Id(event, "DKRocketAudio_volume", "click")){
		DKLog("DKRocketAudio_OnEvent(): DKRocketAudio_volume\n",DKDEBUG);
	}
	if(DK_Id(event, "DKRocketAudio_volumetrack", "click")){
		DKLog("DKRocketAudio_OnEvent(): DKRocketAudio_volumetrack\n",DKDEBUG);
	}
}