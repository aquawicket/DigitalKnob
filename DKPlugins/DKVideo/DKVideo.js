//BROWSER

DKCreate("WEB/video-js/video-js.css");
DKCreate("DKJavascript,WEB/video-js/video.js");
DKCreate("DKJavascript,WEB/videojs-youtube-master/src/youtube.js");
var registered = 0;
	
///////////////////////
function DKVideo_Init()
{
	videojs.options.flash.swf = "video-js/video-js.swf";
}

////////////////////////////////
function DKVideo_Queue(id, src)
{
	var myPlayer;
	videojs(id).ready(function(){ myPlayer = this;});
	
	var type;
	if(src.indexOf(".flv") != -1){ 
		type = "video/flv"; 
	}
	if(src.indexOf(".mp4") != -1){ 
		type = "video/mp4"; 
	}
	if(src.indexOf("youtu") != -1){ 
		type = "video/youtube"; 
	}
	
	if(!type){
		DKLog("DKERROR: DKVideo_Queue(): Cannot determine video type.");
	}
	
	myPlayer.src({"type":type, "src":src});
	DKLog("Queued video: "+src);
}

////////////////////////////////
function DKVideo_Change(id, src)
{
	var myPlayer;
	videojs(id).ready(function(){ myPlayer = this;});
	
	var type;
	if(src.indexOf(".flv") != -1){ 
		type = "video/flv"; 
	}
	if(src.indexOf(".mp4") != -1){ 
		type = "video/mp4"; 
	}
	if(src.indexOf("youtu") != -1){ 
		type = "video/youtube"; 
	}
	
	if(!type){
		DKLog("DKERROR: DKVideo_Change(): Cannot determine video type.");
	}
	
	myPlayer.src({"type":type, "src":src});
	myPlayer.play();
	DKLog("Playing video: "+src);
}

///////////////////////////////////////////////
function DKVideo_RegisterEndVideo(id, Function)
{	
	if(registered == 0){
		var myPlayer;
		videojs(id).ready(function(){ myPlayer = this;});
		myPlayer.on('ended', function(){
			Function();
		});
		registered = 1;
	}
}