"use strict";
//https://developer.mozilla.org/en-US/docs/Web/API/HTMLAudioElement

function DKAudio(){}
dk.audio = new DKPlugin(DKAudio)//, "singleton")


DKAudio.prototype.init = function DKAudio_init(callback) {
    dk.create("DKAudio");
    dk.audio.lastValume = 0.0;
    callback && callback(true);
}

DKAudio.prototype.end = function DKAudio_end() {}

DKAudio.prototype.preloadAudio = function dk_preloadAudio(src) {
    const audio = new Audio();
    audio.src = src;
}

DKAudio.prototype.createSound = function DKAudio_createSound(src) {
    const audio = document.createElement("audio");
    audio.id = src;
    audio.src = src;
    audio.setAttribute("preload", "auto");
    audio.setAttribute("controls", "none");
    audio.style.display = "none";
    document.body.appendChild(audio);
}

DKAudio.prototype.resume = function DKAudio_resume(src) {
    const audio = byId(src);
    audio.play();
}

DKAudio.prototype.pause = function DKAudio_pause(src) {
    const audio = byId(src);
    audio.pause();
}

//https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/play
//FIXME: async/await unavailble to Duktape yet
if (DUKTAPE !== true) {
    DKAudio.prototype.play = async function DKAudio_play(src) {
        const audio = byId(src);
        await audio.play();
    }
}

DKAudio.prototype.stop = function DKAudio_stop(src) {
    const audio = byId(src);
    audio.stop();
}

DKAudio.prototype.openMusic = function DKAudio_openMusic(src) {
    const audio = dk.gui.createElement(document.body, "audio", "audio");
    const source = dk.gui.createElement(audio, "source", "source");
    source.type = "audio/ogg";
    source.src = src;
    audio.ontimeupdate = function audio_ontimeupdate() {
        dk.audio.timeUpdate()
    }
    audio.onended = function audio_onended() {
        dk.audio.ended()
    }
}

DKAudio.prototype.getVolume = function DKAudio_getVolume(src) {
    const audio = byId(src);
    return audio.volume;
}

DKAudio.prototype.setVolume = function DKAudio_setVolume(src, volume) {
    const audio = byId(src);
    if (!audio)
        return error("audio invalid");
    audio.volume = volume;
}

DKAudio.prototype.toggleMute = function DKAudio_toggleMute(src) {
    if (dk.audio.muted)
        dk.audio.unmute(src);
    else
        dk.audio.mute(src);
}

DKAudio.prototype.mute = function DKAudio_mute(src) {
    dk.audio.lastVolume = dk.audio.getVolume(src);
    dk.audio.setVolume(src, 0);
    dk.audio.muted = true;
}

DKAudio.prototype.unmute = function DKAudio_unmute(src) {
    dk.audio.setVolume(src, dk.audio.lastVolume);
    dk.audio.muted = false;
}

DKAudio.prototype.setTime = function DKAudio_setTime(src, seconds) {
    byId(src).currentTime = seconds;
}

DKAudio.prototype.timeUpdate = function DKAudio_timeUpdate() {//DKSendEvent("window", "timeupdate");
}

DKAudio.prototype.ended = function DKAudio_ended() {//DKSendEvent("window", "ended");
}

DKAudio.prototype.getTime = function DKAudio_getTime(src) {
    return byId(src).currentTime;
}

DKAudio.prototype.getDuration = function DKAudio_getDuration(src) {
    return byId(src).duration;
}

