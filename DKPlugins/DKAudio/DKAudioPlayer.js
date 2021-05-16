"use strict";

dk.audioplayer = new DKPlugin("dk_audioplayer");
dk.audioplayer.file = "";

dk.audioplayer.init = function dk_auudioplayer_init() {
    dk.create("DKAudio");
    dk.create("DKAudio/DKAudioPlayer.html");
    window.addEventListener("timeupdate", dk.audioplayer.onevent);
    window.addEventListener("ended", dk.audioplayer.onevent);
    byId("DKAudioPlayer_playpause").addEventListener("click", dk.audioplayer.onevent);
    byId("DKAudioPlayer_position").addEventListener("input", dk.audioplayer.onevent);
    byId("DKAudioPlayer_speaker").addEventListener("click", dk.audioplayer.onevent);
    byId("DKAudioPlayer_volume").addEventListener("input", dk.audioplayer.onevent);
    byId("DKAudioPlayer_volume").value = "128";
}

dk.audioplayer.end = function dk_audioplayer_end() {
    window.removeEventListener("timeupdate", dk.audioplayer.onevent);
    window.removeEventListener("ended", dk.audioplayer.onevent);
    byId("DKAudioPlayer_playpause").removeEventListener("click", dk.audioplayer.onevent);
    byId("DKAudioPlayer_position").removeEventListener("input", dk.audioplayer.onevent);
    byId("DKAudioPlayer_speaker").removeEventListener("click", dk.audioplayer.onevent);
    byId("DKAudioPlayer_volume").removeEventListener("input", dk.audioplayer.onevent);
    dk.close("DKAudio/DKAudioPlayer.html");
}

dk.audioplayer.onevent = function dk_audioplayer_onevent(event) {
    //console.log("dk.audioplayer.onevent("+event.currentTarget.id+","+event.type+","+event.value+")\n");

    if (event.currentTarget.id === "DKAudioPlayer_playpause") {
        dk.audioplayer.playpause();
    }
    if (event.currentTarget.id === "DKAudioPlayer_position") {
        dk.audioplayer.settime(byId("DKAudioPlayer_position").value);
    }
    if (event.currentTarget.id === "DKAudioPlayer_speaker") {
        dk.audioplayer.speaker();
    }
    if (event.currentTarget.id === "DKAudioPlayer_volume") {
        var volume = byId("DKAudioPlayer_volume").value;
        dk.audio.setvolume(parseInt(volume));
        dk.audioplayer.updatevolume(parseInt(volume));
    }
    if (event.type === "finnished") {
        byId("DKAudioPlayer_playpause").src = "DKAudio/play.png";
    }
    if (event.type === "timeupdate") {
        dk.audioplayer.TimeUpdate();
    }
}

dk.audioplayer.open = function dk_audioplayer_open(file) {
    dk.audioplayer.file = file;
    dk.audio.openMusic(file);
    byId("DKAudioPlayer_position").value = "0";
}

dk.audioplayer.playpause = function dk_audioplayer_playpause() {
    var src = byId("DKAudioPlayer_playpause").src;
    if (src.indexOf("play.png") !== -1) {
        byId("DKAudioPlayer_playpause").src = "DKAudio/pause.png";
        dk.audio.Resume(dk.audioplayer.file);
    } else {
        byId("DKAudioPlayer_playpause").src = "DKAudio/play.png";
        dk.audio.Pause(dk.audioplayer.file);
    }
}

dk.audioplayer.settime = function dk_audioplayer_settime(value) {
    var time = (value * dk.audio.GetDuration() / 1000);
    console.log("time = " + time + "\n");
    dk.audio.SetTime(time);
}

dk.audioplayer.timeupdate = function dk_audioplayer_timeupdate() {
    var time = dk.audio.GetTime() / dk.audio.GetDuration() * 1000;
    byId("DKAudioPlayer_position").value = time;

    var minute = "0";
    minute += ":";
    var second = parseInt(dk.audio.GetTime());
    //("0" + DK_GetValue(event)).slice (-2);
    byId("DKAudioPlayer_time").innerHTML = minute + second;
}

dk.audioplayer.speaker = function dk_audioplayer_speaker() {
    var src = byId("DKAudioPlayer_speaker").src;
    if (src.indexOf("mute.png") !== -1) {
        dk.audio.mute();
        dk.audioplayer.updatevolume(dk.audio.getvolume());
    } else {
        byId("DKAudioPlayer_speaker").src = "DKAudio/mute.png";
        dk.audio.mute();
    }

    console.log("dk.audio.GetVolume() = " + dk.audio.getvolume() + "\n");
    byId("DKAudioPlayer_volume").value = dk.audio.getvolume();
}

dk.audioplayer.updatevolume = function dk_audioplayer_updatevolume(volume) {
    var num = parseInt(volume);
    if (num < 1)
        byId("DKAudioPlayer_speaker").src = "DKAudio/mute.png";
    if (num > 0 && num < 42)
        byId("DKAudioPlayer_speaker").src = "DKAudio/volume1.png";
    if (num > 42 && num < 84)
        byId("DKAudioPlayer_speaker").src = "DKAudio/volume2.png";
    if (num > 84)
        byId("DKAudioPlayer_speaker").src = "DKAudio/volume3.png";
}
