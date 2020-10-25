//BROWSER

DKAudio_lastVolume = 0.0;

///////////////////////
function DKAudio_Init()
{
	DK_Create("DKAudio");
}

//////////////////////
function DKAudio_End()
{
	
}

/////////////////////////////
function DKAudio_Resume(file)
{ 
	var x = byId("audio");
    x.play(); 
}

////////////////////////////
function DKAudio_Pause(file)
{ 
	var x = byId("audio");
	x.pause(); 
}

////////////////////////////////
function DKAudio_PlaySound(file)
{ 
	var x = byId("audio");
    x.play(); 
}

////////////////////////////////
function DKAudio_OpenMusic(file)
{ 
	var audio = DK_CreateElement(document.body, "audio", "audio");
	var source = DK_CreateElement(byId(audio), "source", "source");
	byId(source).type = "audio/ogg";
	byId(source).src = file;
	byId("audio").ontimeupdate = function(){ DKAudio_TimeUpdate() };
	byId("audio").onended = function(){ DKAudio_Ended() };
}

///////////////////////////////
function DKAudio_SetVolume(num)
{
	byId("audio").volume = parseFloat(num / 128);
}

////////////////////////////
function DKAudio_GetVolume()
{
	return byId("audio").volume * 128;
}

///////////////////////
function DKAudio_Mute()
{
	DKAudio_lastVolume = DKAudio_GetVolume();
	DKAudio_SetVolume(0);
}

/////////////////////////
function DKAudio_UnMute()
{
	DKAudio_SetVolume(DKAudio_lastVolume);
}

/////////////////////////////////
function DKAudio_SetTime(seconds)
{
	byId("audio").currentTime = seconds;
}

/////////////////////////////
function DKAudio_TimeUpdate()
{
	DKSendEvent("window", "timeupdate");
}

////////////////////////
function DKAudio_Ended()
{
	DKSendEvent("window", "ended");
}

//////////////////////////
function DKAudio_GetTime()
{
	return byId("audio").currentTime;
}

//////////////////////////////
function DKAudio_GetDuration()
{
	return byId("audio").duration;
}