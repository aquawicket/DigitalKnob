"use strict";
//https://developer.mozilla.org/en-US/docs/Web/API/HTMLAudioElement

function DKAudio_PreLoadAudio(url) {
    const audio = new Audio();
    audio.src = url;
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

function DKAudio_PauseSound(src) {
    const ele = byId(src);
    ele.pause();
}

//https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/play
async function DKAudio_PlaySound(src) {
    //try {
    const ele = byId(src);
    await ele.play();
    //} catch(errMsg) {
    //    console.error(errMsg);
    //}
}

function DKAudio_StopSound(src) {
    const ele = byId(src);
    ele.stop();
}

function DKAudio_GetVolume(src) {
    const ele = byId(src);
    return ele.volume;
}

function DKAudio_SetVolume(src, volume) {
    const ele = byId(src);
    ele.volume = volume;
}
