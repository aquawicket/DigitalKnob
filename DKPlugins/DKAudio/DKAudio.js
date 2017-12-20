//BROWSER

DKAudio_lastVolume = 0.0;

///////////////////////
function DKAudio_Init()
{
	//DKLog("DKAudio_Init()\n", DKINFO);
}

//////////////////////
function DKAudio_End()
{
	//DKLog("DKAudio_End()\n", DKINFO);
}

/////////////////////////////
function DKAudio_Resume(file)
{ 
	//DKLog("DKAudio_Resume()\n", DKINFO);
	
	var x = document.getElementById("audio");
    x.play(); 
}

////////////////////////////
function DKAudio_Pause(file)
{ 
	//DKLog("DKAudio_Pause()\n", DKINFO);

	var x = document.getElementById("audio");
	x.pause(); 
}

////////////////////////////////
function DKAudio_PlaySound(file)
{ 
	//DKLog("DKAudio_PlaySound()\n", DKINFO);

	var x = document.getElementById("audio");
    x.play(); 
}

////////////////////////////////
function DKAudio_OpenMusic(file)
{ 
	//DKLog("DKAudio_OpenMusic("+file+")\n", DKINFO);
	
	var audio = DKWidget_CreateElement("body", "audio", "audio");
	var source = DKWidget_CreateElement(audio, "source", "source");
	DKWidget_SetAttribute(source, "type", "audio/ogg");
	DKWidget_SetAttribute(source, "src", file);
	document.getElementById("audio").ontimeupdate = function(){ DKAudio_TimeUpdate() };
	document.getElementById("audio").onended = function(){ DKAudio_Ended() };
}

///////////////////////////////
function DKAudio_SetVolume(num)
{
	//DKLog("DKAudio_SetVolume("+num+")\n", DKINFO);
	
	document.getElementById("audio").volume = parseFloat(num / 128);
}

////////////////////////////
function DKAudio_GetVolume()
{
	//DKLog("DKAudio_GetVolume()\n", DKINFO);
	
	return document.getElementById("audio").volume * 128;
}

///////////////////////
function DKAudio_Mute()
{
	//DKLog("DKAudio_Mute()\n", DKINFO);
	
	DKAudio_lastVolume = DKAudio_GetVolume();
	DKAudio_SetVolume(0);
}

/////////////////////////
function DKAudio_UnMute()
{
	//DKLog("DKAudio_UnMute()\n", DKINFO);
	
	DKAudio_SetVolume(DKAudio_lastVolume);
}

/////////////////////////////////
function DKAudio_SetTime(seconds)
{
	//DKLog("DKAudio_SetTime("+seconds+")\n", DKINFO);
	
	document.getElementById("audio").currentTime = seconds;
}

/////////////////////////////
function DKAudio_TimeUpdate()
{
	//DKLog("DKAudio_TimeUpdate()\n", DKINFO);
	
	DKSendEvent("GLOBAL", "timeupdate");
}

////////////////////////
function DKAudio_Ended()
{
	//DKLog("DKAudio_Ended()\n", DKINFO);
	
	DKSendEvent("GLOBAL", "ended");
}

//////////////////////////
function DKAudio_GetTime()
{
	//DKLog("DKAudio_GetTime()\n", DKINFO);
	
	return document.getElementById("audio").currentTime;
}

//////////////////////////////
function DKAudio_GetDuration()
{
	//DKLog("DKAudio_GetDuration()\n", DKINFO);
	
	return document.getElementById("audio").duration;
}