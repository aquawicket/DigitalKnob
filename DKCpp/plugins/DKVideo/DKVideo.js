dk.create("WEB/video-js/video-js.css");
dk.create("WEB/video-js/video.js");
dk.create("WEB/videojs-youtube-master/src/youtube.js");
var registered = 0;


function DKVideo(){}
dk.video = DKPlugin(DKVideo)	

dk.video.init = function dk_video_init(){
	videojs.options.flash.swf = "video-js/video-js.swf";
}

dk.video.queue = function dk_video_queue(id, src){
	var myPlayer;
	videojs(id).ready(function(){ myPlayer = this;});
	var type;
	if(src.indexOf(".flv") !== -1)
		type = "video/flv"; 
	if(src.indexOf(".mp4") !== -1)
		type = "video/mp4"; 
	if(src.indexOf("youtu") !== -1)
		type = "video/youtube"; 
	if(!type)
		console.error("DKVideo_Queue(): Cannot determine video type\n");
	myPlayer.src({"type":type, "src":src});
	console.log("Queued video: "+src+"\n");
}

dk.video.change = function dk_video_Change(id, src){
	var myPlayer;
	videojs(id).ready(function(){ myPlayer = this;});
	var type;
	if(src.indexOf(".flv") !== -1)
		type = "video/flv"; 
	if(src.indexOf(".mp4") !== -1)
		type = "video/mp4"; 
	if(src.indexOf("youtu") !== -1)
		type = "video/youtube"; 
	if(!type)
		console.log("console.error: DKVideo_Change(): Cannot determine video type\n");
	myPlayer.src({"type":type, "src":src});
	myPlayer.play();
	console.log("Playing video: "+src+"\n");
}

dk.video.registerEndVideo = function dk_video_registerEndVideo(id, Function){
	if(registered === 0){
		var myPlayer;
		videojs(id).ready(function(){ myPlayer = this;});
		myPlayer.on('ended', function(){
			Function();
		});
		registered = 1;
	}
}
