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

//////////////////////////////////
function DKRocketAudio_playpause()
{
	DKLog("DKRocketAudio_playpause() \n",DKDEBUG);
}

/////////////////////////////////
function DKRocketAudio_position()
{
	DKLog("DKRocketAudio_position() \n",DKDEBUG);
}

//////////////////////////////////////
function DKRocketAudio_positiontrack()
{
	DKLog("DKRocketAudio_positiontrack() \n",DKDEBUG);
}

////////////////////////////////
function DKRocketAudio_speaker()
{
	DKLog("DKRocketAudio_speaker() \n",DKDEBUG);
}

///////////////////////////////
function DKRocketAudio_volume()
{
	DKLog("DKRocketAudio_volume() \n",DKDEBUG);
}

////////////////////////////////////
function DKRocketAudio_volumetrack()
{
	DKLog("DKRocketAudio_volumetrack() \n",DKDEBUG);
}

