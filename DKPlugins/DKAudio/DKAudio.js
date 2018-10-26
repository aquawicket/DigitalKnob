//BROWSER

DKAudio_lastVolume = 0.0;

///////////////////////
function DKAudio_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKAudio");
}

//////////////////////
function DKAudio_End()
{
	DKDEBUGFUNC();
}

/////////////////////////////
function DKAudio_Resume(file)
{ 
	DKDEBUGFUNC(file);
	var x = document.getElementById("audio");
    x.play(); 
}

////////////////////////////
function DKAudio_Pause(file)
{ 
	DKDEBUGFUNC(file);
	var x = document.getElementById("audio");
	x.pause(); 
}

////////////////////////////////
function DKAudio_PlaySound(file)
{ 
	DKDEBUGFUNC(file);
	var x = document.getElementById("audio");
    x.play(); 
}

////////////////////////////////
function DKAudio_OpenMusic(file)
{ 
	DKDEBUGFUNC(file);
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
	DKDEBUGFUNC(num);
	document.getElementById("audio").volume = parseFloat(num / 128);
}

////////////////////////////
function DKAudio_GetVolume()
{
	DKDEBUGFUNC();
	return document.getElementById("audio").volume * 128;
}

///////////////////////
function DKAudio_Mute()
{
	DKDEBUGFUNC();
	DKAudio_lastVolume = DKAudio_GetVolume();
	DKAudio_SetVolume(0);
}

/////////////////////////
function DKAudio_UnMute()
{
	DKDEBUGFUNC();
	DKAudio_SetVolume(DKAudio_lastVolume);
}

/////////////////////////////////
function DKAudio_SetTime(seconds)
{
	DKDEBUGFUNC(seconds);
	document.getElementById("audio").currentTime = seconds;
}

/////////////////////////////
function DKAudio_TimeUpdate()
{
	DKDEBUGFUNC();
	DKSendEvent("GLOBAL", "timeupdate");
}

////////////////////////
function DKAudio_Ended()
{
	DKDEBUGFUNC();
	DKSendEvent("GLOBAL", "ended");
}

//////////////////////////
function DKAudio_GetTime()
{
	DKDEBUGFUNC();
	return document.getElementById("audio").currentTime;
}

//////////////////////////////
function DKAudio_GetDuration()
{
	DKDEBUGFUNC();
	return document.getElementById("audio").duration;
}