var sizes = [];

///////////////////////
function DKFrame_Init()
{
	
}

//////////////////////
function DKFrame_End()
{

}

///////////////////////////////
function DKFrame_OnEvent(event)
{
	if(event.type === "mousedown"){
		DKFrame_BringToFront();
		//setTimeout( function(){ DKFrame_BringToFront(); }, 1000);
	}
	if(event.type === "dblclick"){
		var id = event.currentTarget.id;
		var titlebar = byId(id).parentNode;
		DKFrame_MaximizeButton(titlebar.id);
	}
	if(event.currentTarget.id && event.currentTarget.id.includes("DKFrame_reload")){
		DKFrame_Reload(event.currentTarget.id);
	}
	if(event.currentTarget.id && event.currentTarget.id.includes("DKFrame_minimize")){
		DKFrame_MinimizeButton(event.currentTarget.id);
	}
	if(event.currentTarget.id && event.currentTarget.id.includes("DKFrame_maximize")){
		DKFrame_MaximizeButton(event.currentTarget.id);
	}
	if(event.currentTarget.id && event.currentTarget.id.includes("DKFrame_close")){
		DKFrame_CloseButton(event.currentTarget.id);
	}
	
	// FIXME - does not always fire
	if(event.type === "DKFrame_resize"){
		var frame = byId(event.currentTarget.id);
		if(!frame){ 
			//console.error("DKFrame_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+"): frame invalid\n");
			return; 
		}
		var child = frame.childNodes[4];
		byId(child.id).style.width = parseInt(byId(frame.id).style.width) + "rem";
		byId(child.id).style.height = parseInt(byId(frame.id).style.height) - 21 + "rem";
	}
}

///////////////////////////
function DKFrame_Html(id)
{
	//console.log("DKFrame_Html("+id+")");
	if(!byId(id)){
		console.error("DKFrame_Html("+id+"): element does not exist\n");
		return false;
	}
	
	var title = DKFile_GetFilename(id);
	title = title.replace(".html", "");
	
	//stop if frame already exsists, multiple windows not ready yet.
	//FIXME
	//if(DKWidget_ElementExists(title+"_frame")){
	//	console.warn("DKFrame_Html("+id+"): frame already exists\n");
	//	return;
	//}
	
	var width = byId(id).style.width;
	var height = byId(id).style.height;
	//console.log("DKFrame_Html("+id+"): width="+width+" , height="+height+"\n");

	width = width.replace("px", "");
	height = height.replace("px", "");
	width = width.replace("rem", "");
	height = height.replace("rem", "");
	
	var frame = DKFrame_CreateFrame(title, width, height);
	DKWidget_AppendChild(frame, id);
	//byId(frame).appendChild(byId(frame));
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
	var frame = DKFrame_CreateFrame(byId(title), width, height);
	var iframe = DKWidget_CreateElement(byId(frame), "iframe", title);
	byId(iframe).src = url; // This will call DKRocketToRML::PostProcess() again
	byId(iframe).width = "100%";
	byId(iframe).height = "100%";
	byId(iframe).style.borderWidth = "0rem";
	byId(iframe).style.position = "absolute";
	byId(iframe).style.top = "21rem";
	byId(iframe).style.left = "0rem";
	byId(iframe).style.width = "100%";
	byId(iframe).style.bottom = "0rem";
	DKWidget_RemoveProperty(iframe, "height");
	DKWidget_RemoveProperty(iframe, "right");
	byId(frame).addEventListener("mousedown", DKFrame_OnEvent);
	
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
	if(width === "100%"){ width = window.innerWidth-100; }
	if(height === "100%"){ height = window.innerHeight-21-100; }
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
	if(DK_GetBrowser() !== "RML"){
		byId(frame).style.borderStyle = "solid";
	}
	byId(frame).style.borderWidth = "1rem";
	byId(frame).style.minWidth = "62rem";
	byId(frame).style.minHeight = "30rem";
	byId(frame).addEventListener("mousedown", DKFrame_OnEvent);
	
	//console.log("DKFrame_Html("+id+"): frame top="+newtop.toString()+"\n");
	//console.log("DKFrame_Html("+id+"): frame left="+newleft.toString()+"\n");
	//console.log("DKFrame_Html("+id+"): frame width="+width+"\n");
	//console.log("DKFrame_Html("+id+"): frame height="+newheight.toString()+"\n");
	
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
	byId(titlebartext).addEventListener("dblclick", DKFrame_OnEvent);
	
	var reload = DKWidget_CreateElement(byId(frame), "img", "DKFrame_reload");
	byId(reload).setAttribute("src", "DKGui/reload.png");
	byId(reload).style.position = "absolute";
	byId(reload).style.top = "1rem";
	byId(reload).style.right = "65rem";
	byId(reload).style.height = "18rem";
	byId(reload).addEventListener("click", DKFrame_OnEvent);
	
	var minimize = DKWidget_CreateElement(byId(frame), "img", "DKFrame_minimize");
	byId(minimize).setAttribute("src", "DKGui/minimize.png");
	byId(minimize).style.position = "absolute";
	byId(minimize).style.top = "0rem";
	byId(minimize).style.right = "42rem";
	byId(minimize).style.height = "20rem;"
	byId(minimize).addEventListener("click", DKFrame_OnEvent);
	
	var maximize = DKWidget_CreateElement(byId(frame), "img", "DKFrame_maximize");
	byId(maximize).setAttribute("src", "DKGui/maximize.png");
	byId(maximize).style.position = "absolute";
	byId(maximize).style.top = "0rem";
	byId(maximize).style.right = "21rem";
	byId(maximize).style.height = "20rem";
	byId(maximize).addEventListener("click", DKFrame_OnEvent);
	
	var close = DKWidget_CreateElement(byId(frame), "img", "DKFrame_close");
	byId(close).setAttribute("src", "DKGui/close.png");
	byId(close).style.position = "absolute";
	byId(close).style.top = "0rem";
	byId(close).style.right = "0rem";
	byId(close).style.height = "20rem";
	byId(close).addEventListener("click", DKFrame_OnEvent);
	
	return frame;
}

////////////////////////////////////
function DKFrame_CreateResize(frame)
{
	var resize = DKWidget_CreateElement(byId(frame), "div", "DKFrame_resize");
	//byId(resize).style.backgroundImage = "url(\"DKGui/resize.png\")";
	DKWidget_RemoveProperty(resize, "top");
	byId(resize).style.position = "absolute";
	byId(resize).style.right = "0rem";
	byId(resize).style.bottom = "0rem";
	byId(resize).style.width = "16rem";
	byId(resize).style.height = "16rem";
	//DKWidget_AddResizeHandle(resize, frame);
	//byId(frame).addEventListener("resize", DKFrame_OnEvent);  //FIXME - does not fire.
	
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
	var ele = DKWidget_GetHoverElement();
	if(!ele){ return; }
	
	if(byId("DKFrame_frame") && byId("DKFrame_frame").contains(ele)){
		//document.body.id = "body"; //TEMPORARY FIX
		//if(DKWidget_GetLastChild("body") !== "DKFrame_frame"){
		if(document.body.lastchild !== byId("DKFrame_frame")){	
			DKWidget_AppendChild("body", "DKFrame_frame");
			return;
		}
	}
	for(var i=0; i<100; i++){
		var frame = "DKFrame_frame"+i.toString();
		if(!byId(frame)){ continue; }
		if(byId(frame).contains(ele)){
		//if(DKWidget_GetLastChild("body") !== frame){
		if(document.body.lastChild !== byId(frame)){
				DKWidget_AppendChild("body", frame);
				return;
			}
		}
	}
}

///////////////////////////////////
function DKFrame_MinimizeButton(id)
{
	//TODO
	//var frame = DKWidget_GetParent(id);
}

///////////////////////////////////
function DKFrame_MaximizeButton(id)
{
	var frame = byId(id).parentNode.id;
	var top = byId(frame).style.top;
	var bottom = byId(frame).style.bottom;
	var left = byId(frame).style.left;
	var right = byId(frame).style.right;
	if(top === "0rem" && bottom === "0rem" && left === "0rem" && right === "0rem" ||
		top === "0px" && bottom === "0px" && left === "0px" && right === "0px" ){
		DKFrame_RestoreSize(frame);
		
		var elements = DK_GetElements(byId(frame));
		var arry = elements.split(",");
		byId(arry[5]).style.width = parseInt(byId(frame).style.width) + "rem";
		byId(arry[5]).style.height = parseInt(byId(frame).style.height) - 21 + "rem";
	}
	else{
		DKFrame_StoreSize(frame);
		byId(frame).style.top = "0rem";
		byId(frame).style.left = "0rem";
		byId(frame).style.right = "0rem";
		byId(frame).style.bottom = "0rem";
		DKWidget_RemoveProperty(frame, "width");
		DKWidget_RemoveProperty(frame, "height");
		
		var elements = DK_GetElements(byId(frame));
		var arry = elements.split(",");
		byId(arry[5]).style.width = "100%";
		byId(arry[5]).style.height = "100%";
	}
}

////////////////////////////////
function DKFrame_CloseButton(id)
{
	DKFrame_Close(id);
}

//////////////////////////
function DKFrame_Close(id)
{
	//TODO if the Frame contains an iFrame, we need to call DKCef_CloseBrowser(n) on the associated iFrame
	//var frame = DKWidget_GetParent(id);
	if(!byId(id)){
		console.error("byId("+id+") is invalid");
	}
	var frame = byId(id).parentNode.id;
	//console.log("DKFrame_Close("+id+"): frame = "+frame+"\n");
	var children = DK_GetElements(byId(frame));
	var arry = children.split(",");
	for(var i=arry.length-1; i>0; i--){
		//console.log("DKFrame_Close("+id+"): arry["+i+"] = "+arry[i]+"\n");
		if(arry[i].indexOf(".html") > -1){
			var file = DKWidget_GetFile(arry[i]);
			if(!file){ file = arry[i];}
			var jsfile = file.replace(".html", ".js");
			//console.log("DK_Close("+jsfile+")\n");
			DK_Close(jsfile);
			var htmlfile = file.replace(".js", ".html");
			DK_Close(htmlfile);
		}
		if(arry[i].indexOf("iframe_") > -1){
			console.log("DKFrame_Close("+id+"): we found a cef iframe ("+arry[i]+") to close\n");
			var frameId = arry[i].replace("iframe_","");
			for(var b=0; b<DKCef_GetBrowsers(); b++){
				//console.log("frameId = "+frameId+"\n");
				//console.log("DKCef_GetBrowserId("+b+") = "+DKCef_GetBrowserId(b)+"\n");
				if(frameId === DKCef_GetBrowserId(b)){
					//console.log("We Know Which One To Close:\n");
					DKCef_CloseBrowser(b);
				}
			}
		}
	}
	
	//console.log("DKFrame_Close("+id+"): frame="+frame+"\n");
	if(frame === "body" || frame === document.body){
		return;
	}
	
	//remove frame events 
	var num = frame.replace("DKFrame_frame","");
	byId("DKFrame_frame"+num).removeEventListener("mousedown", DKFrame_OnEvent);
	byId("DKFrame_close"+num).removeEventListener("click", DKFrame_OnEvent);
	byId("DKFrame_maximize"+num).removeEventListener("click", DKFrame_OnEvent);
	byId("DKFrame_minimize"+num).removeEventListener("click", DKFrame_OnEvent);
	byId("DKFrame_reload"+num).removeEventListener("click", DKFrame_OnEvent);
	byId("DKFrame_titlebartext"+num).removeEventListener("dblclick", DKFrame_OnEvent);
	byId("DKFrame_frame"+num).removeEventListener("resize", DKFrame_OnEvent);
	
	DKWidget_RemoveElement(frame);
}

//////////////////////////////
function DKFrame_StoreSize(id)
{
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
	var children = DK_GetElements(document.body);
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
	console.log("TODO: refresh the frame data. html, javascript and css all reloaded\n");
	
	console.log("id = "+id+"\n");
	var saved_id = id; 
	console.log("saved_id = "+saved_id+"\n");
	var jsfile;
	var htmlfile;
	
	//var frame = DKWidget_GetParent(id);
	var frame = byId(id).parentNode.id;
	var children = DK_GetElements(byId(frame));
	var arry = children.split(",");
	for(var i=arry.length-1; i>0; i--){
		if(arry[i].indexOf(".html") > -1){
			var file = DKWidget_GetFile(arry[i]);
			if(!file){ file = arry[i];}
			jsfile = file.replace(".html", ".js");
			htmlfile = file.replace(".js", ".html");
		}
	}
	
	console.log("jsfile = "+jsfile+"\n");
	console.log("htmlfile = "+htmlfile+"\n");
	
	DKFrame_Close(id);
	DK_Create(jsfile, function(){
		DKFrame_Html(htmlfile);
	});
}