"use strict";
//https://developer.mozilla.org/en-US/docs/Web/API/HTMLAudioElement


let DKAudio_lastVolume = 0.0;

function DKAudio_Init()
{
	DK_Create("DKAudio");
}

function DKAudio_End()
{
	
}

function DKAudio_PreLoadAudio(src) {
    const audio = new Audio();
    audio.src = src;
}

function DKAudio_CreateSound(src) {
    const audio = document.createElement("audio");
    audio.id = src;
    audio.src = src;
    audio.setAttribute("preload", "auto");
    audio.setAttribute("controls", "none");
    audio.style.display = "none";
    document.body.appendChild(audio);
}

function DKAudio_Resume(src)
{ 
	const audio = byId(src);
    audio.play(); 
}

function DKAudio_Pause(src)
{ 
	const audio = byId(src);
	audio.pause(); 
}

//https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/play
async function DKAudio_Play(src) {
    //try {
    const audio = byId(src);
    await audio.play();
    //} catch(errMsg) {
    //    dkconsole.error(errMsg);
    //}
}

function DKAudio_Stop(src) {
    const audio = byId(src);
    audio.stop();
}

function DKAudio_OpenMusic(src)
{ 
	const audio = DK_CreateElement(document.body, "audio", "audio");
	const source = DK_CreateElement(audio, "source", "source");
	source.type = "audio/ogg";
	source.src = src;
	audio.ontimeupdate = function(){ DKAudio_TimeUpdate() };
	audio.onended = function(){ DKAudio_Ended() };
}

function DKAudio_GetVolume(src) {
    const audio = byId(src);
    return audio.volume;
}

function DKAudio_SetVolume(src, volume) {
    const audio = byId(src);
    if(!audio){
    	dkconsole.error("audio invalid");
    }
    audio.volume = volume;
}

function DKAudio_Mute(src)
{
	DKAudio_lastVolume = DKAudio_GetVolume(src);
	DKAudio_SetVolume(src, 0);
}

function DKAudio_UnMute(src)
{
	DKAudio_SetVolume(src, DKAudio_lastVolume);
}

function DKAudio_SetTime(src, seconds)
{
	byId(src).currentTime = seconds;
}

function DKAudio_TimeUpdate()
{
	DKSendEvent("window", "timeupdate");
}

function DKAudio_Ended()
{
	DKSendEvent("window", "ended");
}

function DKAudio_GetTime(src)
{
	return byId(src).currentTime;
}


function DKAudio_GetDuration(src)
{
	return byId(src).duration;
}
