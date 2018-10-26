//BROWSER

DKCreate("WEB/video-js/video-js.css");
DKCreate("WEB/video-js/video.js");
DKCreate("WEB/videojs-youtube-master/src/youtube.js");
var registered = 0;
	
///////////////////////
function DKVideo_Init()
{
	DKDEBUGFUNC();
	videojs.options.flash.swf = "video-js/video-js.swf";
}

////////////////////////////////
function DKVideo_Queue(id, src)
{
	DKDEBUGFUNC(is, src);
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
		DKINFO("DKERROR: DKVideo_Queue(): Cannot determine video type\n");
	}
	
	myPlayer.src({"type":type, "src":src});
	DKINFO("Queued video: "+src+"\n");
}

////////////////////////////////
function DKVideo_Change(id, src)
{
	DKDEBUGFUNC(is, src);
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
		DKINFO("DKERROR: DKVideo_Change(): Cannot determine video type\n");
	}
	
	myPlayer.src({"type":type, "src":src});
	myPlayer.play();
	DKINFO("Playing video: "+src+"\n");
}

///////////////////////////////////////////////
function DKVideo_RegisterEndVideo(id, Function)
{	
	DKDEBUGFUNC(is, Function);
	if(registered == 0){
		var myPlayer;
		videojs(id).ready(function(){ myPlayer = this;});
		myPlayer.on('ended', function(){
			Function();
		});
		registered = 1;
	}
}