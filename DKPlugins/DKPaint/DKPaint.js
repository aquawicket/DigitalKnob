var currentFile;

///////////////////////
function DKPaint_Init()
{
	DK_Create("DKPaint/DKPaint.css");
	DK_Create("DKPaint/DKPaint.html");
	//byId("DKPaint_Save").addEventListener("click", DKPaint_OnEvent);
	byId("DKPaint/DKPaint.html").addEventListener("contextmenu", DKPaint_OnEvent);
	byId("DKPaint_File").addEventListener("click", DKPaint_OnEvent);
	byId("DKPaint/DKPaint.html").addEventListener("OpenFile", DKPaint_OnEvent);
}

//////////////////////
function DKPaint_End()
{
	//byId("DKPaint_Save").removeEventListener("click", DKPaint_OnEvent);
	byId("DKPaint/DKPaint.html").removeEventListener("contextmenu", DKPaint_OnEvent);
	byId("DKPaint_File").removeEventListener("click", DKPaint_OnEvent);
	byId("DKPaint/DKPaint.html").removeEventListener("OpenFile", DKPaint_OnEvent);
	DK_Close("DKPaint/DKPaint.html");
	DK_Close("DKPaint/DKPaint.css");
}

///////////////////////////////
function DKPaint_OnEvent(event)
{
	if(event.currentTarget.id === "DKPaint_Save"){
		//DKNotepad_Save();
	}
	if(event.type === "contextmenu"){
		DK_Create("DKPaint/DKPaintMenu.js", function(){});
	}
	if(event.currentTarget.id === "DKPaint_File"){
		DK_Create("DKPaint/DKPaintFile.js", function(){});
	}
	if(event.type === "OpenFile"){
		var file = DK_GetValue(event);
		//console.log(("OpenFile: "+file+"\n");
		DKPaint_Open(file)
	}
}

///////////////////////
function DKPaint_Save()
{
	var text = byId("DKPaint_Text").value;
}

///////////////////////////
function DKPaint_Open(file)
{
	file = file.replace(absolutepath, "");
	currentFile = file;
	
	byId("DKPaint_content").innerHTML = "";
	if(file.includes(".pdf") || file.includes(".PDF")){
		byId("DKPaint_content").innerHTML = "<embed id=\"DKPaint_Embed\" width=\"100%\" height=\"100%\" type='application/pdf' src=\""+file+"\"></embed>";
		byId("DKPaint_content").style.overflowY = "none";
	}
	else if(file.includes(".tif")){
		DKPaint_LoadTif(file);
		byId("DKPaint_content").style.overflowY = "auto";
	}
	else{
		byId("DKPaint_content").innerHTML = "<img id=\"DKPaint_Image\" src="+file+"></img>";
		byId("DKPaint_content").style.overflowY = "auto";
	}
}

//////////////////////////////////
function DKPaint_LoadTif(filename)
{
	DK_Create("http://code.jquery.com/jquery-1.10.1.min.js", function(){
	DK_Create("DKPaint/tiff.min.js", function(){
		var xhr = new XMLHttpRequest();
		xhr.open('GET', filename);
		xhr.responseType = 'arraybuffer';
		xhr.onload = function(e){
			var buffer = xhr.response;
			var tiff = new Tiff({buffer: buffer});
			var canvas = tiff.toCanvas();
			var width = tiff.width();
			var height = tiff.height();
			if(canvas){
				byId("DKPaint_content").append(canvas);
			}
		};
		xhr.send();
	
	});
	});
}