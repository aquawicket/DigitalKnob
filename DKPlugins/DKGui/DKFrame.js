var sizes = [];

///////////////////////
function DKFrame_Init()
{
	DKDEBUGFUNC();
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
		var frame = byId(DK_GetId(event));
		if(!frame){ 
			//DKERROR("DKFrame_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+"): frame invalid\n");
			return; 
		}
		var child = frame.childNodes[4];
		byId(child.id).style.width = parseInt(DKWidget_GetProperty(frame.id, "width")) + "rem";
		byId(child.id).style.height = parseInt(DKWidget_GetProperty(frame.id, "height")) - 21 + "rem";
	}
}

///////////////////////////
function DKFrame_Widget(id)
{
	DKDEBUGFUNC(id);
	console.log("DKFrame_Widget("+id+")");
	if(!byId(id)){
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
	
	var width = byId(id).style.width;
	var height = byId(id).style.height;
	//DKINFO("DKFrame_Widget("+id+"): width="+width+" , height="+height+"\n");

	width = width.replace("px", "");
	height = height.replace("px", "");
	width = width.replace("rem", "");
	height = height.replace("rem", "");
	
	var frame = DKFrame_CreateFrame(title, width, height);
	DKWidget_AppendChild(frame, id);
	byId(id).style.position = "absolute";
	byId(id).style.top = "21rem";
	byId(id).style.left = "0rem";
	byId(id).style.width = "100%";
	byId(id).style.bottom = "-1rem";
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
	//var frame = DKWidget_GetParent(id);
	var frame = byId(id).parentNode.id
	//var titlebar = DKWidget_GetFirstChild(frame);
	var titlebar = byId(frame).firstChild.id;
	//var titlebartext = DKWidget_GetFirstChild(titlebar);
	var titlebartext = byId(titlebar).firstChild.id;
	byId(titlebartext).innerHTML = title;
}

//////////////////////////////////////////////////
function DKFrame_Iframe(title, url, width, height)
{
	DKDEBUGFUNC(title, url, width, height);
	var frame = DKFrame_CreateFrame(byId(title), width, height);
	var iframe = DKWidget_CreateElement(byId(frame), "iframe", title);
	DKWidget_SetAttribute(iframe, "src", url); // This will call DKRocketToRML::PostProcess() again
	DKWidget_SetAttribute(iframe, "width", "100%");
	DKWidget_SetAttribute(iframe, "height", "100%");
	byId(iframe).style.borderWidth = "0rem";
	byId(iframe).style.position = "absolute";
	byId(iframe).style.top = "21rem";
	byId(iframe).style.left = "0rem";
	byId(iframe).style.width = "100%";
	byId(iframe).style.botttom = "0rem";
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
	
	var frame = DKWidget_CreateElement(document.body, "div", "DKFrame_frame");
	byId(frame).style.position = "absolute";
	byId(frame).style.overflow = "hidden";
	byId(frame).style.top = newtop.toString()+"px";
	byId(frame).style.left = newleft.toString()+"px";
	byId(frame).style.width = width.toString()+"rem";
	byId(frame).style.height = newheight.toString()+"rem";
	byId(frame).style.backgroundColor = "rgb(150,150,150)";
	byId(frame).style.borderColor = "rgb(0,0,0)";
	if(DK_GetBrowser() != "RML"){
		byId(frame).style.borderStyle = "solid";
	}
	byId(frame).style.borderWidth = "1rem";
	byId(frame).style.minWidth = "62rem";
	byId(frame).style.minHeight = "30rem";
	DKAddEvent(frame, "mousedown", DKFrame_OnEvent);
	
	//DKINFO("DKFrame_Widget("+id+"): frame top="+newtop.toString()+"\n");
	//DKINFO("DKFrame_Widget("+id+"): frame left="+newleft.toString()+"\n");
	//DKINFO("DKFrame_Widget("+id+"): frame width="+width+"\n");
	//DKINFO("DKFrame_Widget("+id+"): frame height="+newheight.toString()+"\n");
	
	var titlebar = DKWidget_CreateElement(byId(frame), "div", "DKFrame_titlebar");
	byId(titlebar).style.position = "absolute";
	byId(titlebar).style.width = "100%";
	byId(titlebar).style.height = "21rem";
	byId(titlebar).style.backgroundColor = "rgb(200,200,200)";
	
	var titlebartext = DKWidget_CreateElement(byId(titlebar), "div", "DKFrame_titlebartext");
	byId(titlebartext).style.position = "absolute";
	byId(titlebartext).style.width = "100%";
	byId(titlebartext).style.height = "100%";
	byId(titlebartext).style.color = "rgb(25,25,25)";
	byId(titlebartext).innerHTML = title;
	DKWidget_AddDragHandle(titlebartext, frame);
	DKAddEvent(titlebartext, "dblclick", DKFrame_OnEvent);
	
	var reload = DKWidget_CreateElement(byId(frame), "img", "DKFrame_reload");
	byId(reload).setAttribute("src", "DKGui/reload.png");
	byId(reload).style.position = "absolute";
	byId(reload).style.top = "1rem";
	byId(reload).style.right = "65rem";
	byId(reload).style.height = "18rem";
	DKAddEvent(reload, "click", DKFrame_OnEvent);
	
	var minimize = DKWidget_CreateElement(byId(frame), "img", "DKFrame_minimize");
	byId(minimize).setAttribute("src", "DKGui/minimize.png");
	byId(minimize).style.position = "absolute";
	byId(minimize).style.top = "0rem";
	byId(minimize).style.right = "42rem";
	byId(minimize).style.height = "20rem;"
	DKAddEvent(minimize, "click", DKFrame_OnEvent);
	
	var maximize = DKWidget_CreateElement(byId(frame), "img", "DKFrame_maximize");
	byId(maximize).setAttribute("src", "DKGui/maximize.png");
	byId(maximize).style.position = "absolute";
	byId(maximize).style.top = "0rem";
	byId(maximize).style.right = "21rem";
	byId(maximize).style.height = "20rem";
	DKAddEvent(maximize, "click", DKFrame_OnEvent);
	
	var close = DKWidget_CreateElement(byId(frame), "img", "DKFrame_close");
	byId(close).setAttribute("src", "DKGui/close.png");
	byId(close).style.position = "absolute";
	byId(close).style.top = "0rem";
	byId(close).style.right = "0rem";
	byId(close).style.height = "20rem";
	DKAddEvent(close, "click", DKFrame_OnEvent);
	
	return frame;
}

////////////////////////////////////
function DKFrame_CreateResize(frame)
{
	DKDEBUGFUNC(frame);
	var resize = DKWidget_CreateElement(byId(frame), "div", "DKFrame_resize");
	//byId(resize).style.backgroundImage = "url(\"DKGui/resize.png\")";
	DKWidget_RemoveProperty(resize, "top");
	byId(resize).style.position = "absolute";
	byId(resize).style.right = "0rem";
	byId(resize).style.bottom = "0rem";
	byId(resize).style.width = "16rem";
	byId(resize).style.height = "16rem";
	//DKWidget_AddResizeHandle(resize, frame);
	//DKAddEvent(frame, "resize", DKFrame_OnEvent);  //FIXME - does not fire.
	
	var resizeImage = DKWidget_CreateElement(byId(resize), "img", "DKFrame_resizeImage");
	byId(resizeImage).setAttribute("src", "DKGui/resize.png");
	byId(resizeImage).style.position = "absolute";
	byId(resizeImage).style.top = "0rem";
	byId(resizeImage).style.right = "0rem";
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
		document.body.id = "body"; //TEMPORARY FIX
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
	var frame = byId(id).parentNode.id;
	var top = byId(frame).style.top;
	var bottom = byId(frame).style.bottom;
	var left = byId(frame).style.left;
	var right = byId(frame).style.right;
	if(top == "0rem" && bottom == "0rem" && left == "0rem" && right == "0rem" ||
		top == "0px" && bottom == "0px" && left == "0px" && right == "0px" ){
		DKFrame_RestoreSize(frame);
		
		var elements = DKWidget_GetElements(frame);
		var arry = elements.split(",");
		byId(arry[5]).style.width = parseInt(DKWidget_GetProperty(frame, "width")) + "rem";
		byId(arry[5]).style.height = parseInt(DKWidget_GetProperty(frame, "height")) - 21 + "rem";
	}
	else{
		DKFrame_StoreSize(frame);
		byId(frame).style.top = "0rem";
		byId(frame).style.left = "0rem";
		byId(frame).style.right = "0rem";
		byId(frame).style.bottom = "0rem";
		DKWidget_RemoveProperty(frame, "width");
		DKWidget_RemoveProperty(frame, "height");
		
		var elements = DKWidget_GetElements(frame);
		var arry = elements.split(",");
		byId(arry[5]).style.width = "100%";
		byId(arry[5]).style.height = "100%";
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
	//var frame = DKWidget_GetParent(id);
	var frame = byId(id).parentNode.id;
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
	if(frame == "body" || frame == document.body){
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
	var top = byId(id).style.top;
	var bottom = byId(id).style.bottom;
	var left = byId(id).style.left;
	var right = byId(id).style.right;
	var width = byId(id).style.width;
	var height = byId(id).style.height;
	
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
			byId(id).style.top = arry[1];
			byId(id).style.bottom = arry[2];
			byId(id).style.left = arry[3];
			byId(id).style.right = arry[4];
			byId(id).style.width = arry[5];
			byId(id).style.height = arry[6];
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