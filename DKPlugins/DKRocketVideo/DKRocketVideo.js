/////////////////////////////
function DKRocketVideo_Init()
{
	DKCreate("DKRocketVideo/DKRocketVideo.html");
	DKAddEvent("DKRocketVideo_playpause", "click", DKRocketVideo_OnEvent);
	DKAddEvent("DKRocketVideo_position", "click", DKRocketVideo_OnEvent);
	DKAddEvent("DKRocketVideo_positiontrack", "click", DKRocketVideo_OnEvent);
	DKAddEvent("DKRocketVideo_speaker", "click", DKRocketVideo_OnEvent);
	DKAddEvent("DKRocketVideo_volume", "click", DKRocketVideo_OnEvent);
	DKAddEvent("DKRocketVideo_volumetrack", "click", DKRocketVideo_OnEvent);
}

////////////////////////////
function DKRocketVideo_End()
{
	DKClose("DKRocketVideo/DKRocketVideo.html");
}

/////////////////////////////////////
function DKRocketVideo_OnEvent(event)
{
	DKLog("DKRocketVideo_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event, "DKRocketVideo_playpause")){
		DKRocketVideo_playpause();
	}
	if(DK_Id(event, "DKRocketVideo_position")){
		DKRocketVideo_position();
	}
	if(DK_Id(event, "DKRocketVideo_positiontrack")){
		DKRocketVideo_positiontrack();
	}
	if(DK_Id(event, "DKRocketVideo_speaker", "click")){
		DKRocketVideo_speaker();
	}
	if(DK_Id(event, "DKRocketVideo_volume", "click")){
		DKRocketVideo_volume();
	}
	if(DK_Id(event, "DKRocketVideo_volumetrack", "click")){
		DKRocketVideo_volumetrack();
	}
}

//////////////////////////////////
function DKRocketVideo_playpause()
{
	//DKLog("DKRocketVideo_playpause() \n",DKDEBUG);
	
	//toggle play/pause
	var src = DKWidget_GetAttribute("DKRocketVideo_playpause", "src");
	//DKLog("DKRocketVideo_playpause(): src="+src+"\n", DKDEBUG);
	
	if(src.indexOf("play.png") != -1){
		DKWidget_SetAttribute("DKRocketVideo_playpause", "src", "DKRocketVideo/pause.png");
	}
	else{
		DKWidget_SetAttribute("DKRocketVideo_playpause", "src", "DKRocketVideo/play.png");
	}
}

/////////////////////////////////
function DKRocketVideo_position()
{
	//DKLog("DKRocketVideo_position() \n",DKDEBUG);
}

//////////////////////////////////////
function DKRocketVideo_positiontrack()
{
	//DKLog("DKRocketVideo_positiontrack() \n",DKDEBUG);
}

////////////////////////////////
function DKRocketVideo_speaker()
{
	//DKLog("DKRocketVideo_speaker() \n",DKDEBUG);
	
	//toggle volume/mute
	var src = DKWidget_GetAttribute("DKRocketVideo_speaker", "src");
	DKLog("DKRocketVideo_speaker(): src="+src+"\n", DKDEBUG);
	
	if(src.indexOf("mute.png") != -1){
		DKWidget_SetAttribute("DKRocketVideo_speaker", "src", "DKRocketVideo/volume3.png");
	}
	else{
		DKWidget_SetAttribute("DKRocketVideo_speaker", "src", "DKRocketVideo/mute.png");
	}
}

///////////////////////////////
function DKRocketVideo_volume()
{
	//DKLog("DKRocketVideo_volume() \n",DKDEBUG);
}

////////////////////////////////////
function DKRocketVideo_volumetrack()
{
	//DKLog("DKRocketVideo_volumetrack() \n",DKDEBUG);
}

