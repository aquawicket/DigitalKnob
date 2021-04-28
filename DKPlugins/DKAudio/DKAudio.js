"use strict";
//https://developer.mozilla.org/en-US/docs/Web/API/HTMLAudioElement

dk.audio = new Object;

dk.audio.init = function dk_audio_init()() {
    dk.create("DKAudio");
    dk.audio.lastValume = 0.0;
}

dk.audio.end = function dk_audio_end() {
}

dk.audio.preloadAudio = function dk_preloadAudio(src) {
    const audio = new Audio();
    audio.src = src;
}

dk.audio.createSound = function dk_audio_createSound(src) {
    const audio = document.createElement("audio");
    audio.id = src;
    audio.src = src;
    audio.setAttribute("preload", "auto");
    audio.setAttribute("controls", "none");
    audio.style.display = "none";
    document.body.appendChild(audio);
}

dk.audio.resume = function dk_audio_resume(src) {
    const audio = byId(src);
    audio.play();
}

dk.audio.pause = function dk_audio_pause(src) {
    const audio = byId(src);
    audio.pause();
}

//https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/play
dk.audio.play = async function dk_audio_play(src) {
    try {
        const audio = byId(src);
        await audio.play();
    } catch (errMsg) {
        console.warn(errMsg);
    }
}

dk.audio.stop = function dk_audio_stop(src) {
    const audio = byId(src);
    audio.stop();
}

dk.audio.openMusic = function dk_audio_openMusic(src) {
    const audio = dk.gui.createElement(document.body, "audio", "audio");
    const source = dk.gui.createElement(audio, "source", "source");
    source.type = "audio/ogg";
    source.src = src;
    audio.ontimeupdate = function() {
        dk.audio.timeUpdate()
    }
    audio.onended = function() {
        dk.audio.ended()
    }
}

dk.audio.getVolume = function dk_audio_getVolume(src) {
    const audio = byId(src);
    return audio.volume;
}

dk.audio.setVolume = function dk_audio_setVolume(src, volume) {
    const audio = byId(src);
    if (!audio)
        return error("audio invalid");
    audio.volume = volume;
}

dk.audio.mute = function dk_audio_mute(src) {
    dk.audio.lastVolume = dk.audio.getVolume(src);
    dk.audio.setVolume(src, 0);
}

dk.audio.unmute = function dk_audio_unmute(src) {
    dk.audio.setVolume(src, dk.audio.lastVolume);
}

dk.audio.setTime = function dk_audio_setTime(src, seconds) {
    byId(src).currentTime = seconds;
}

dk.audio.timeUpdate = function dk_audio_timeUpdate() {
    //DKSendEvent("window", "timeupdate");
}

dk.audio.ended = function dk_audio_ended() {
    //DKSendEvent("window", "ended");
}

dk.audio.getTime = function dk_audio_getTime(src) {
    return byId(src).currentTime;
}

dk.audio.getDuration = function dk_audio_getDuration(src) {
    return byId(src).duration;
}
