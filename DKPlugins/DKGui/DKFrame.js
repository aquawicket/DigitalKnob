console.log("Loading DKFrame.js");

var sizes = [];

///////////////////////
function DKFrame_Init()
{
	DKDEBUGFUNC();
	document.body.id = "body"; //FIXME - remove this requirement
}

//////////////////////
function DKFrame_End()
{
	DKDEBUGFUNC();
}

///////////////////////////////
function DKFrame_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Type(event, "mousedown")){
		DKFrame_BringToFront();
		//setTimeout( function(){ DKFrame_BringToFront(); }, 1000);
	}
	if(DK_Type(event, "dblclick")){
		var id = DK_GetId(event);
		var titlebar = DKWidget_GetParent(id);
		DKFrame_MaximizeButton(titlebar);
	}
	if(DK_IdLike(event, "DKFrame_reload")){
		DKFrame_Reload(DK_GetId(event));
	}
	if(DK_IdLike(event, "DKFrame_minimize")){
		DKFrame_MinimizeButton(DK_GetId(event));
	}
	if(DK_IdLike(event, "DKFrame_maximize")){
		DKFrame_MaximizeButton(DK_GetId(event));
	}
	if(DK_IdLike(event, "DKFrame_close")){
		DKFrame_CloseButton(DK_GetId(event));
	}
	
	// FIXME - does not always fire
	if(DK_Type(event, "DKFrame_resize")){
		var frame = document.getElementById(DK_GetId(event));
		if(!frame){ 
			//DKERROR("DKFrame_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+"): frame invalid\n");
			return; 
		}
		var child = frame.childNodes[4];
		DKWidget_SetProperty(child.id, "width", parseInt(DKWidget_GetProperty(frame.id, "width")) + "rem");
		DKWidget_SetProperty(child.id, "height", parseInt(DKWidget_GetProperty(frame.id, "height")) - 21 + "rem");
	}
}

///////////////////////////
function DKFrame_Widget(id)
{
	DKDEBUGFUNC(id);
	console.log("DKFrame_Widget("+id+")");
	if(!DKWidget_ElementExists(id)){
		console.error("DKFrame_Widget("+id+"): element does not exist\n");
		return false;
	}
	
	var title = DKFile_GetFilename(id);
	title = title.replace(".html", "");
	
	//stop if frame already exsists, multiple windows not ready yet.
	//FIXME
	//if(DKWidget_ElementExists(title+"_frame")){
	//	DKWARN("DKFrame_Widget("+id+"): frame already exists\n");
	//	return;
	//}
	
	var width = DKWidget_GetProperty(id, "width");
	var height = DKWidget_GetProperty(id, "height");
	//DKINFO("DKFrame_Widget("+id+"): width="+width+" , height="+height+"\n");

	width = width.replace("px", "");
	height = height.replace("px", "");
	width = width.replace("rem", "");
	height = height.replace("rem", "");
	
	var frame = DKFrame_CreateFrame(title, width, height);
	DKWidget_AppendChild(frame, id);
	DKWidget_SetProperty(id, "position", "absolute");
	DKWidget_SetProperty(id, "top", "21rem");
	DKWidget_SetProperty(id, "left", "0rem");
	DKWidget_SetProperty(id, "width", "100%");
	DKWidget_SetProperty(id, "bottom", "-1rem");
	DKWidget_RemoveProperty(id, "right");
	DKWidget_RemoveProperty(id, "height");
	
	DKFrame_CreateResize(frame);
	return frame;
}

////////////////////////////////////
function DKFrame_SetTitle(id, title)
{
	DKDEBUGFUNC(id, title);
	//TODO - add protection	
	var frame = DKWidget_GetParent(id);
	var titlebar = DKWidget_GetFirstChild(frame);
	var titlebartext = DKWidget_GetFirstChild(titlebar);
	DKWidget_SetInnerHtml(titlebartext, title);
}

//////////////////////////////////////////////////
function DKFrame_Iframe(title, url, width, height)
{
	DKDEBUGFUNC(title, url, width, height);
	var frame = DKFrame_CreateFrame(title, width, height);
	var iframe = DKWidget_CreateElement(frame, "iframe", title);
	DKWidget_SetAttribute(iframe, "src", url); // This will call DKRocketToRML::PostProcess() again
	DKWidget_SetAttribute(iframe, "width", "100%");
	DKWidget_SetAttribute(iframe, "height", "100%");
	DKWidget_SetProperty(iframe, "border-width", "0rem");
	DKWidget_SetProperty(iframe, "position", "absolute");
	DKWidget_SetProperty(iframe, "top", "21rem");
	DKWidget_SetProperty(iframe, "left", "0rem");
	DKWidget_SetProperty(iframe, "width", "100%");
	DKWidget_SetProperty(iframe, "bottom", "0rem");
	DKWidget_RemoveProperty(iframe, "height");
	DKWidget_RemoveProperty(iframe, "right");
	DKAddEvent(frame, "mousedown", DKFrame_OnEvent);
	
	DKFrame_CreateResize(frame);
	
	//var currentBrowser = DKCef_GetCurrentBrowser();
	//DKCef_SetUrl(currentBrowser, url);
	//DKFrame_CreateResize(frame);
	//DKCef_SetFocus();
	return iframe;
}

//////////////////////////////////////////////////
function DKFrame_CreateFrame(title, width, height)
{
	DKDEBUGFUNC(title, width, height);
	if(width == "100%"){ width = window.innerWidth-100; }
	if(height == "100%"){ height = window.innerHeight-21-100; }
	if(!width){ width = window.innerWidth / 2; }
	if(!height){ height = window.innerHeight / 2; }
	var newheight = parseFloat(height)+21;
	var newtop = parseFloat((window.innerHeight / 2) - (newheight / 2) - 1);
	var newleft = parseFloat((window.innerWidth / 2) - (width / 2) - 1);
	
	var frame = DKWidget_CreateElement("body", "div", "DKFrame_frame");
	document.getElementById(frame).style.position = "absolute";
	document.getElementById(frame).style.overflow = "hidden";
	document.getElementById(frame).style.top = newtop.toString()+"px";
	document.getElementById(frame).style.left = newleft.toString()+"px";
	document.getElementById(frame).style.width = width.toString()+"rem";
	document.getElementById(frame).style.height = newheight.toString()+"rem";
	document.getElementById(frame).style.backgroundColor = "rgb(150,150,150)";
	document.getElementById(frame).style.borderColor = "rgb(0,0,0)";
	if(DK_GetBrowser() != "RML"){
		document.getElementById(frame).style.borderStyle = "solid";
	}
	document.getElementById(frame).style.borderWidth = "1rem";
	document.getElementById(frame).style.minWidth = "62rem";
	document.getElementById(frame).style.minHeight = "30rem";
	DKAddEvent(frame, "mousedown", DKFrame_OnEvent);
	
	//DKINFO("DKFrame_Widget("+id+"): frame top="+newtop.toString()+"\n");
	//DKINFO("DKFrame_Widget("+id+"): frame left="+newleft.toString()+"\n");
	//DKINFO("DKFrame_Widget("+id+"): frame width="+width+"\n");
	//DKINFO("DKFrame_Widget("+id+"): frame height="+newheight.toString()+"\n");
	
	var titlebar = DKWidget_CreateElement(frame, "div", "DKFrame_titlebar");
	DKWidget_SetProperty(titlebar, "position", "absolute");
	DKWidget_SetProperty(titlebar, "width", "100%");
	DKWidget_SetProperty(titlebar, "height", "21rem");
	DKWidget_SetProperty(titlebar, "background-color", "rgb(200,200,200)");
	
	var titlebartext = DKWidget_CreateElement(titlebar, "div", "DKFrame_titlebartext");
	DKWidget_SetProperty(titlebartext, "position", "absolute");
	DKWidget_SetProperty(titlebartext, "width", "100%");
	DKWidget_SetProperty(titlebartext, "height", "100%");
	DKWidget_SetProperty(titlebartext, "color", "rgb(25,25,25)");
	DKWidget_SetInnerHtml(titlebartext, title);	
	DKWidget_AddDragHandle(titlebartext, frame);
	DKAddEvent(titlebartext, "dblclick", DKFrame_OnEvent);
	
	var reload = DKWidget_CreateElement(frame, "img", "DKFrame_reload");
	DKWidget_SetAttribute(reload, "src", "DKGui/reload.png");
	DKWidget_SetProperty(reload, "position", "absolute");
	DKWidget_SetProperty(reload, "top", "1rem");
	DKWidget_SetProperty(reload, "right", "65rem");
	DKWidget_SetProperty(reload, "height", "18rem");
	DKAddEvent(reload, "click", DKFrame_OnEvent);
	
	var minimize = DKWidget_CreateElement(frame, "img", "DKFrame_minimize");
	DKWidget_SetAttribute(minimize, "src", "DKGui/minimize.png");
	DKWidget_SetProperty(minimize, "position", "absolute");
	DKWidget_SetProperty(minimize, "top", "0rem");
	DKWidget_SetProperty(minimize, "right", "42rem");
	DKWidget_SetProperty(minimize, "height", "20rem");
	DKAddEvent(minimize, "click", DKFrame_OnEvent);
	
	var maximize = DKWidget_CreateElement(frame, "img", "DKFrame_maximize");
	DKWidget_SetAttribute(maximize, "src", "DKGui/maximize.png");
	DKWidget_SetProperty(maximize, "position", "absolute");
	DKWidget_SetProperty(maximize, "top", "0rem");
	DKWidget_SetProperty(maximize, "right", "21rem");
	DKWidget_SetProperty(maximize, "height", "20rem");
	DKAddEvent(maximize, "click", DKFrame_OnEvent);
	
	var close = DKWidget_CreateElement(frame, "img", "DKFrame_close");
	DKWidget_SetAttribute(close, "src", "DKGui/close.png");
	DKWidget_SetProperty(close, "position", "absolute");
	DKWidget_SetProperty(close, "top", "0rem");
	DKWidget_SetProperty(close, "right", "0rem");
	DKWidget_SetProperty(close, "height", "20rem");
	DKAddEvent(close, "click", DKFrame_OnEvent);
	
	return frame;
}

////////////////////////////////////
function DKFrame_CreateResize(frame)
{
	DKDEBUGFUNC(frame);
	var resize = DKWidget_CreateElement(frame, "div", "DKFrame_resize");
	//DKWidget_SetProperty(resize, "background-image", "url(\"DKGui/resize.png\")");
	DKWidget_RemoveProperty(resize, "top");
	DKWidget_SetProperty(resize, "position", "absolute");
	DKWidget_SetProperty(resize, "right", "0rem");
	DKWidget_SetProperty(resize, "bottom", "0rem");
	DKWidget_SetProperty(resize, "width", "16rem");
	DKWidget_SetProperty(resize, "height", "16rem");
	//DKWidget_AddResizeHandle(resize, frame);
	//DKAddEvent(frame, "resize", DKFrame_OnEvent);  //FIXME - does not fire.
	
	var resizeImage = DKWidget_CreateElement(resize, "img", "DKFrame_resizeImage");
	DKWidget_SetAttribute(resizeImage, "src", "DKGui/resize.png");
	DKWidget_SetProperty(resizeImage, "position", "absolute");
	DKWidget_SetProperty(resizeImage, "top", "0rem");
	DKWidget_SetProperty(resizeImage, "right", "0rem");
	DKWidget_AddResizeHandle(resizeImage, frame);
	
	return resize;
}

///////////////////////////////
function DKFrame_BringToFront()
{
	DKDEBUGFUNC();
	var id = DKWidget_GetHoverElement();
	if(!id){ return; }
	
	if(DKWidget_IsChildOf(id, "DKFrame_frame")){
		if(DKWidget_GetLastChild("body") != "DKFrame_frame"){
			DKWidget_AppendChild("body", "DKFrame_frame");
			return;
		}
	}
	for(var i=0; i<100; i++){
		var frame = "DKFrame_frame"+i.toString();
		if(DKWidget_IsChildOf(id, frame)){
			if(DKWidget_GetLastChild("body") != frame){
				DKWidget_AppendChild("body", frame);
				return;
			}
		}
	}
}

///////////////////////////////////
function DKFrame_MinimizeButton(id)
{
	DKDEBUGFUNC(id);
	//TODO
	//var frame = DKWidget_GetParent(id);
}

///////////////////////////////////
function DKFrame_MaximizeButton(id)
{
	DKDEBUGFUNC(id);
	var frame = DKWidget_GetParent(id);
	var top = DKWidget_GetProperty(frame, "top");
	var bottom = DKWidget_GetProperty(frame, "bottom");
	var left = DKWidget_GetProperty(frame, "left");
	var right = DKWidget_GetProperty(frame, "right");
	if(top == "0rem" && bottom == "0rem" && left == "0rem" && right == "0rem" ||
		top == "0px" && bottom == "0px" && left == "0px" && right == "0px" ){
		DKFrame_RestoreSize(frame);
		
		var elements = DKWidget_GetElements(frame);
		var arry = elements.split(",");
		DKWidget_SetProperty(arry[5], "width", parseInt(DKWidget_GetProperty(frame, "width")) + "rem");
		DKWidget_SetProperty(arry[5], "height", parseInt(DKWidget_GetProperty(frame, "height")) - 21 + "rem");
	}
	else{
		DKFrame_StoreSize(frame);
		DKWidget_SetProperty(frame, "top", "0rem");
		DKWidget_SetProperty(frame, "left", "0rem");
		DKWidget_SetProperty(frame, "right", "0rem");
		DKWidget_SetProperty(frame, "bottom", "0rem");
		DKWidget_RemoveProperty(frame, "width");
		DKWidget_RemoveProperty(frame, "height");
		
		var elements = DKWidget_GetElements(frame);
		var arry = elements.split(",");
		DKWidget_SetProperty(arry[5], "width", "100%");
		DKWidget_SetProperty(arry[5], "height", "100%");
	}
}

////////////////////////////////
function DKFrame_CloseButton(id)
{
	DKDEBUGFUNC(id);
	DKFrame_Close(id);
}

//////////////////////////
function DKFrame_Close(id)
{
	DKDEBUGFUNC(id);	
	//TODO if the Frame contains an iFrame, we need to call DKCef_CloseBrowser(n) on the associated iFrame
		var frame = DKWidget_GetParent(id);
	//DKINFO("DKFrame_Close("+id+"): frame = "+frame+"\n");
	var children = DKWidget_GetElements(frame);
	var arry = children.split(",");
	for(var i=arry.length-1; i>0; i--){
		//DKINFO("DKFrame_Close("+id+"): arry["+i+"] = "+arry[i]+"\n");
		if(arry[i].indexOf(".html") > -1){
			var file = DKWidget_GetFile(arry[i]);
			if(!file){ file = arry[i];}
			var jsfile = file.replace(".html", ".js");
			//DKINFO("DKClose("+jsfile+")\n");
			DKClose(jsfile);
			var htmlfile = file.replace(".js", ".html");
			DKClose(htmlfile);
		}
		if(arry[i].indexOf("iframe_") > -1){
			DKINFO("DKFrame_Close("+id+"): we found a cef iframe ("+arry[i]+") to close\n");
			var frameId = arry[i].replace("iframe_","");
			for(var b=0; b<DKCef_GetBrowsers(); b++){
				//DKINFO("frameId = "+frameId+"\n");
				//DKINFO("DKCef_GetBrowserId("+b+") = "+DKCef_GetBrowserId(b)+"\n");
				if(frameId == DKCef_GetBrowserId(b)){
					//DKINFO("We Know Which One To Close:\n");
					DKCef_CloseBrowser(b);
				}
			}
		}
	}
	
	//DKINFO("DKFrame_Close("+id+"): frame="+frame+"\n");
	if(frame == "body"){
		return;
	}
	
	//remove frame events 
	var num = frame.replace("DKFrame_frame","");
	DKRemoveEvent("DKFrame_frame"+num, "mousedown", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_close"+num, "click", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_maximize"+num, "click", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_minimize"+num, "click", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_reload"+num, "click", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_titlebartext"+num, "dblclick", DKFrame_OnEvent);
	DKRemoveEvent("DKFrame_frame"+num, "resize", DKFrame_OnEvent);
	
	DKWidget_RemoveElement(frame);
}

//////////////////////////////
function DKFrame_StoreSize(id)
{
	DKDEBUGFUNC(id);
	var top = DKWidget_GetProperty(id, "top");
	var bottom = DKWidget_GetProperty(id, "bottom");
	var left = DKWidget_GetProperty(id, "left");
	var right = DKWidget_GetProperty(id, "right");
	var width = DKWidget_GetProperty(id, "width");
	var height = DKWidget_GetProperty(id, "height");
	
	for(var i=0; i<sizes.length; i++){
		if(sizes[i].indexOf(id) > -1){
			sizes[i] = id+":"+top+":"+bottom+":"+left+":"+right+":"+width+":"+height;
			return;
		}
	}
	sizes.push(id+":"+top+":"+bottom+":"+left+":"+right+":"+width+":"+height);
}

////////////////////////////////
function DKFrame_RestoreSize(id)
{
	DKDEBUGFUNC(id);
	for(var i=0; i<sizes.length; i++){
		if(sizes[i].indexOf(id) > -1){
			var arry = sizes[i].split(":");
			DKWidget_SetProperty(id, "top", arry[1]);
			DKWidget_SetProperty(id, "bottom", arry[2]);
			DKWidget_SetProperty(id, "left", arry[3]);
			DKWidget_SetProperty(id, "right", arry[4]);
			DKWidget_SetProperty(id, "width", arry[5]);
			DKWidget_SetProperty(id, "height", arry[6]);
			return;
		}
	}
}

///////////////////////////
function DKFrame_CloseAll()
{
	DKDEBUGFUNC();
	var children = DKWidget_GetElements("body");
	var arry = children.split(",");
	for(var i=0; i<arry.length; i++){
		if(arry[i].indexOf("DKFrame_frame") > -1){
			DKWidget_RemoveElement(arry[i]);
		}
	}
}

///////////////////////////
function DKFrame_Reload(id)
{
	DKDEBUGFUNC(id);
	DKINFO("TODO: refresh the frame data. html, javascript and css all reloaded\n");
	
	DKINFO("id = "+id+"\n");
	var saved_id = id; 
	DKINFO("saved_id = "+saved_id+"\n");
	var jsfile;
	var htmlfile;
	
	var frame = DKWidget_GetParent(id);
	var children = DKWidget_GetElements(frame);
	var arry = children.split(",");
	for(var i=arry.length-1; i>0; i--){
		if(arry[i].indexOf(".html") > -1){
			var file = DKWidget_GetFile(arry[i]);
			if(!file){ file = arry[i];}
			jsfile = file.replace(".html", ".js");
			htmlfile = file.replace(".js", ".html");
		}
	}
	
	DKINFO("jsfile = "+jsfile+"\n");
	DKINFO("htmlfile = "+htmlfile+"\n");
	
	DKFrame_Close(id);
	DKCreate(jsfile, function(){
		DKFrame_Widget(htmlfile);
	});
}