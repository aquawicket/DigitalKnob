var devmode = false;
var stored_element = "body";
var ignorelist = "";
var storedMouseX;
var storedMouseY;

////////////////////////
function DKEditor_Init()
{
	DKCreate("DKDev/DKEditor.html");

	DKAddEvent("body", "contextmenu", DKEditor_OnEvent);
	DKAddEvent("body", "click", DKEditor_OnEvent);
	DKAddEvent("GLOBAL", "SaveHtmlFiles", DKEditor_OnEvent);
	DKAddEvent("GLOBAL", "OpenFile", DKEditor_OnEvent);
	DKAddEvent("GLOBAL", "FileChoice", DKEditor_OnEvent);
	
	ignorelist += "DKEditor.html,";
	ignorelist += "DKMenuRight.html,";
	
	DKEditor_CreateBox();
	DKEditor_HideBox();	
}

///////////////////////
function DKEditor_End()
{
	DKRemoveEvent("body", "contextmenu", DKEditor_OnEvent);
	DKRemoveEvent("body", "click", DKEditor_OnEvent);
	DKRemoveEvent("GLOBAL", "SaveHtmlFiles", DKEditor_OnEvent);
	DKRemoveEvent("GLOBAL", "OpenFile", DKEditor_OnEvent);
	DKRemoveEvent("GLOBAL", "FileChoice", DKEditor_OnEvent);
	DKClose("DKDev/DKEditor.html");
}

//////////////////////
function DKEditor_On()
{
	DKLog("DKEditor_On \n", DKDEBUG);
	DKEditor_AddDragHandles("body");
	DKEditor_ApplyBox(stored_element);
	devmode = true;
}

///////////////////////
function DKEditor_Off()
{
	DKLog("DKEditor_Off \n", DKDEBUG);
	DKEditor_RemoveDragHandles("body");
	DKEditor_HideBox();
	devmode = false;
}

////////////////////////////
function DKEditor_Ignore(id)
{
	//DKLog("DKEditor_Ignore("+id+") \n", DKDEBUG);
	var arry = ignorelist.split(",");
	for(var i=0; i<arry.length; i++){
		if(DKWidget_IsChildOf(id, arry[i])){return true;}
	}
	return false;
}

////////////////////////////////
function DKEditor_OnEvent(event)
{
	if(devmode == false){ return; }
	//DKLog("DKEditor_OnEvent("+DKWidget_GetType(event)+","+DK_GetId(event)+") \n", DKDEBUG);
	
	var target = DK_GetId(event);
	if(DKEditor_Ignore(target)){ return; }
	
	if(DK_Type(event, "mousedown")){
		var target = DK_GetId(event);
		if(DKWidget_IsChildOf(target, "DKC-EditorRootMenu")){return;}
		if(DKWidget_IsChildOf(target, "DKC-EditorMenu")){return;}
		DKEditor_SelectElement(target);
		return;
	}

	if(DK_Type(event, "contextmenu")){
		var target = DK_GetId(event);
		if(DKWidget_IsChildOf(target, "DKC-EditorMenu")){return;}
		if(DKWidget_IsChildOf(target, "DKC-EditorRootMenu")){return;}
		if(target == "DevModeButton"){return;}
		//DKEditor_SelectElement(target);
		mouseX = DKWidget_GetMouseWindowX();
		mouseY = DKWidget_GetMouseWindowY();

		storedMouseX = DKWidget_GetMouseElementX(stored_element);
		storedMouseY = DKWidget_GetMouseElementY(stored_element);
		if(target == "body"){
			DKWidget_SetProperty("DKC-EditorRootMenu", "top", String(mouseY)+"px");
			DKWidget_SetProperty("DKC-EditorRootMenu", "left", String(mouseX)+"px");
			DKWidget_Show("DKC-EditorRootMenu");
			return;
		}

		DKWidget_SetProperty("DKC-EditorMenu", "top", String(mouseY)+"px");
		DKWidget_SetProperty("DKC-EditorMenu", "left", String(mouseX)+"px");
		DKWidget_Show("DKC-EditorMenu");
		return;
	}
	if(DK_Type(event, "Clear")){
		DKEditor_ClearEditor();
	}
	if(DK_Type(event, "SaveHtmlFiles")){
		DKEditor_SaveHtmlFile(stored_element);
	}
	if(DK_Type(event, "OpenFile")){
		var value = DKWidget_GetValue(event);
		DKLog("OpenFile: "+value+" \n", DKDEBUG)
		DKEditor_OpenFile(value);
	}
	if(DK_Type(event, "FileChoice")){
		var value = DKWidget_GetValue(event);
		DKLog("FileChoice: "+value+"\n", DKDEBUG);
	}
}

/////////////////////////////
function DKEditor_CreateBox()
{
	if(DKWidget_ElementExists("DKC-DKEditorBox")){ return; }
	//Control box
	var box = DKWidget_CreateElement("body", "div", "DKC-DKEditorBox");
	DKWidget_SetProperty(box, "position", "absolute");
	DKWidget_SetProperty(box, "top", "-1px"); //-1 for border
	DKWidget_SetProperty(box, "left", "-1px"); //-1 for border
	DKWidget_SetProperty(box, "width", "100%");
	DKWidget_SetProperty(box, "height", "100%");
	DKWidget_SetProperty(box, "border-style", "solid");
	DKWidget_SetProperty(box, "border-color", "red");
	DKWidget_SetProperty(box, "border-width", "1px");

	//resize dot
	//var resizeImg = DKWidget_CreateElement(box, "img", "DKC-DKResizeImg");
	//DKWidget_SetAttribute(resizeImg, "src", "resize2.png");
	//DKWidget_SetProperty(resizeImg, "position", "absolute");
	//DKWidget_SetProperty(resizeImg, "right", "-9px");
	//DKWidget_SetProperty(resizeImg, "bottom", "0px");

	//resize handler
	//var resize = DKWidget_CreateElement(resizeImg, "handle", "DKC-DKResize");
	//DKWidget_SetProperty(resize, "position", "absolute");
	//DKWidget_SetProperty(resize, "width", "100%");
	//DKWidget_SetProperty(resize, "height", "100%");
}

///////////////////////////
function DKEditor_HideBox()
{
	DKWidget_PrependChild("body", "DKC-DKEditorBox");
	DKWidget_SetProperty("DKC-DKEditorBox", "visibility", "hidden");
}

//////////////////////////////
function DKEditor_ApplyBox(id)
{
	DKWidget_PrependChild(id, "DKC-DKEditorBox");
	DKWidget_SetProperty("DKC-DKEditorBox", "visibility", "visible");
}

////////////////////////////////////////
function DKEditor_SelectElement(element)
{
	//DKLog("DKEditor_SelectElement("+element+") \n", DKDEBUG);
	if(!element){
		DKLog("DKEditor_SelectElement(): element invalid", DKERROR);
		return;
	}

	stored_element = element;
	if(stored_element != "body"){
		DKEditor_ApplyBox(stored_element);
	}
	else{
		DKEditor_HideBox();
	}

	//DKLog("stored_element: "+stored_element+"\n", DKDEBUG);
	DKCreate("DKDev/DKMenuRightEdit.js");
	DKSendEvent("DKMenuRightEdit.html", "SetElement", stored_element);
	DKSendEvent("DKMenuRight.html", "SetPanel", "Edit");	
}

////////////////////////////////////
function DKEditor_AddDragHandles(id)
{
	//DKLog("DKEditor_AddDragHandles("+id+") \n", DKDEBUG);
	//RemoveDragHandles(id); //clear any drags first
	var elements = DKWidget_GetElements(id);
	var list = elements.split(",");
	list.unshift(id); //add the root element to the beginning
	//DKLog("AddDragHandles: "+list.toString()+"\n", DKDEBUG);
	
	for(var t=0; t<list.length; t++){
		if(!list[t]){ continue; }
		if(list[t] == "body"){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKC-DKEditorBox")){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKC-EditorRootMenu")){ continue; }
		if(DKWidget_IsChildOf(list[t], "DKC-EditorMenu")){ continue; }
		if(DKEditor_Ignore(list[t])){ continue; }	
		
		if(DKWidget_AddDragHandle(list[t], list[t])){
			DKLog("DKWidget_AddDragHandle("+list[t]+","+list[t]+") \n", DKDEBUG);
			DKAddEvent(list[t], "mousedown", DKEditor_OnEvent);
			DKAddEvent(list[t], "contextmenu", DKEditor_OnEvent);
		}
	}
	
	return true;
}

///////////////////////////////////////
function DKEditor_RemoveDragHandles(id)
{
	DKLog("DKEditor_RemoveDragHandles() \n", DKDEBUG);
	var elements = DKWidget_GetElements(id);
	var list = elements.split(",");
	
	for(var i=0; i<list.length; i++){
		if(DKEditor_Ignore(list[i])){ continue; }		
		
		//C++ (rocket)
		var tag = DKWidget_GetTagName(list[i]);
		if(tag == "handle"){
			DKWidget_RemoveElement(list[i]);
		}
		
		//JS
		DKWidget_RemoveDragHandle(list[i]);
	}
	
	return true;
}

///////////////////////////////
function DKEditor_ClearEditor()
{
	var list = DKWidget_GetElements("body");
	var elements = list.split(",");
	for(var i=0; i<elements.length; i++){
		if(elements[i].indexOf(".html") != -1){                 
			DKWidget_RemoveElement(elements[i]);
		}
	}

	return true;
}


///////////////////////
function DKEditor_Cut()
{
	DKLog("DKEditor::Cut() \n", DKDEBUG);
	DKEditor_HideBox();   //FIXME: HideBox() will cause a crash when we later Remove an element
	//PrependChild("body", "DKC-DKEditorBox");

	//var temp_ele = stored_element;
	var el = DKWidget_GetElements(stored_element);
	var list = el.split(","); 
	for(var i=0; i<list.length; i++){
		DKWidget_RemoveDragHandle(list[i]);
	}

	var string = DKWidget_GetOuterHtml(stored_element);
	DK_SetClipboard(string);

	//FIXME - C++ crashes after this (dirty layout stuff)
	//DKEditor_SelectElement("body");
	DKWidget_RemoveElement(stored_element);
	//DKEditor_SelectElement("body"); //crash
	stored_element = "body";
	return true;
}

////////////////////////
function DKEditor_Copy()
{
	DKLog("DKEditor::Copy() \n", DKDEBUG);
	DKEditor_HideBox();

	var el = DKWidget_GetElements(stored_element);
	var list = el.split(","); 
	for(var i=0; i<list.length; i++){
		DKWidget_RemoveDragHandle(list[i]);
	}

	var string = DKWidget_GetOuterHtml(stored_element);
	
	DK_SetClipboard(string);
	DKEditor_AddDragHandles(stored_element);
	DKEditor_ApplyBox(stored_element); //re-apply box outline 
	return false;
}

/////////////////////////
function DKEditor_Paste()
{
	DKLog("DKEditor::Paste() \n", DKDEBUG);

	var string = DK_GetClipboard();
	if(!string){ return false; }
	
	DKLog("\n\n"+string+"\n\n", DKDEBUG);
	//replace id's with available id's
	var place = 0;
	var n = string.indexOf("id=", place);
	while(n != -1){
		place = string.indexOf("\"",n+4);
		var res = string.substring(n+4, place);
		var new_id = DKWidget_GetAvailableId(res);
		string = string.replace("id=\""+res+"\"", "id=\""+new_id+"\"");
		DKLog("Paste: renamed "+res+" to "+new_id+"\n", DKDEBUG);
		n = string.indexOf("id=", place);
	}
	DKLog("\n\n"+string+"\n\n", DKDEBUG);
	
	//Parse the sting into an element
	var temp = DKWidget_CreateElement("body", "temp", "temporary");
	DKWidget_SetInnerHtml(temp, string);
	
	var id = DKWidget_GetFirstChild(temp);
	//DKWidget_SetAttribute(DKWidget_GetFirstChild(temp), "id", id);
	
	DKWidget_SetProperty(id, "position", "absolute");
	DKWidget_SetProperty(id, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(id, "left", String(storedMouseX)+"px");
	
	DKWidget_AppendChild(stored_element, id);
	DKWidget_RemoveElement(temp);
	
	DKEditor_AddDragHandles(id);
	DKEditor_SelectElement(id);
	return true;
}


///////////////////////////
function DKEditor_NewPage()
{
	DKLog("DKEditor_NewPage() \n", DKDEBUG);
	
	var id = DKWidget_GetAvailableId("NewFrame.html");
	
	DKCreate(id+","+stored_element);
	DKEditor_AddDragHandles(id);
	DKEditor_SelectElement(id);
	return true;
}


//////////////////////////
function DKEditor_NewDiv()
{
	var element = DKWidget_CreateElement(stored_element, "div", "Div");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKWidget_SetProperty(element, "width", "100px");
	DKWidget_SetProperty(element, "height", "100px");
	DKWidget_SetProperty(element, "background-color", "blue");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

///////////////////////////
function DKEditor_NewText()
{
	var element = DKWidget_CreateElement(stored_element, "div", "Text");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKWidget_SetProperty(element, "width", "50px");
	DKWidget_SetProperty(element, "height", "18px");
	DKWidget_SetInnerHtml(element, "Text");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

/////////////////////////////
function DKEditor_NewButton()
{
	var element = DKWidget_CreateElement(stored_element, "button", "Button");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKWidget_SetProperty(element, "width", "50px");
	DKWidget_SetProperty(element, "height", "22px");
	DKWidget_SetInnerHtml(element, "Button");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

////////////////////////////////
function DKEditor_NewImage(file)
{
	DKLog("DKEditor_NewImage("+file+") \n", DKDEBUG);
	var element = DKWidget_CreateElement(stored_element, "img", "Image");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetAttribute(element, "src", file);
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

//////////////////////////////
function DKEditor_NewTextbox()
{
	var element = DKWidget_CreateElement(stored_element, "input", "Textbox");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetAttribute(element, "type", "text");
	DKWidget_SetAttribute(element, "value", "test");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

///////////////////////////////
function DKEditor_NewTextarea()
{
	var element = DKWidget_CreateElement(stored_element, "textarea", "Textarea");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

///////////////////////////////
function DKEditor_NewDropdown()
{
	var element = DKWidget_CreateElement(stored_element, "select", "Dropdown");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

/////////////////////////////
function DKEditor_NewCheckbox()
{
	var element = DKWidget_CreateElement(stored_element, "input", "Checkbox");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetAttribute(element, "type", "checkbox");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

//////////////////////////////////
function DKEditor_NewRadioButton()
{
	var element = DKWidget_CreateElement(stored_element, "input", "RadioButton");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetAttribute(element, "type", "radio");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

/////////////////////////////
function DKEditor_NewiFrame()
{
	var element = DKWidget_CreateElement(stored_element, "iframe", "DKCefFrame");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKWidget_SetProperty(element, "width", "200px");
	DKWidget_SetProperty(element, "height", "200px");
	DKWidget_SetProperty(element, "display", "block");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return false;
}

//////////////////////////////
function DKEditor_NewVSlider()
{
	var element = DKWidget_CreateElement(stored_element, "input", "VSlider");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetAttribute(element, "type", "range");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

//////////////////////////////
function DKEditor_NewHSlider()
{
	var element = DKWidget_CreateElement(stored_element, "input", "HSlider");
	DKWidget_RemoveAttribute(element, "nosave");
	DKWidget_SetAttribute(element, "type", "range");
	DKWidget_SetProperty(element, "position", "absolute");
	DKWidget_SetProperty(element, "top", String(storedMouseY)+"px");
	DKWidget_SetProperty(element, "left", String(storedMouseX)+"px");
	DKEditor_AddDragHandles(element);
	DKEditor_SelectElement(element);
	return true;
}

//////////////////////////////////
function DKEditor_SaveHtmlFile(id)
{
	DKLog("DKEditor_SaveHtmlFile("+id+") \n", DKDEBUG);
	var file = DKWidget_GetFile(id);
	if(file.indexOf(".html") == -1){
		DKLog("DKEditor_SaveHtmlFile("+id+") Invalid .html file\n", DKERROR);
		return false; 
	}
	//if(DKEditor_Ignore(file)){ continue; }
	DKEditor_RemoveDragHandles(file);
	DKEditor_HideBox();
	var parent = DKWidget_GetParent(file);
	var list = DKWidget_GetElements(parent);
	var arry2 = list.split(",");
	arry2.unshift(file);
	for(var b=0; b<arry2.length; b++){
		DKLog("DKEditor_SaveHtmlFile("+id+"), Processing element("+arry2[b]+"). \n", DKINFO);
		if(DKWidget_GetAttribute(arry2[b], "nosave")){
			DKWidget_RemoveElement(arry2[b]); //remove nosave nodes
			continue;
		}
		if(DKWidget_GetAttribute(arry2[b], "nosave_value")){
			DKLog("DKEditor_SaveHtmlFile("+id+"), nosave_value detected. \n", DKINFO);
			DKWidget_RemoveAttribute(arry2[b], "value"); //remove value attributes
		}
		if(!DKWidget_GetAttribute(arry2[b], "value")){
			DKWidget_RemoveAttribute(arry2[b], "value"); //remove value attributes
		}
		if(DKWidget_GetProperty(arry2[b], "overflow-x") == "visible"){
			DKWidget_RemoveProperty(arry2[b], "overflow-x"); //remove redundant property 
		}
		if(DKWidget_GetProperty(arry2[b], "overflow-y") == "visible"){
			DKWidget_RemoveProperty(arry2[b], "overflow-y"); //remove redundant property 
		}

		//FIXME - not working
		//if(DKWidget_GetProperty(arry2[b], "color") == DKWidget_GetProperty(DKWidget_GetParent(arry2[b]), "color")){
		//	DKWidget_RemoveProperty(arry2[b], "color"); //remove redundant property 
		//}
	}
		
	DKLog("Saving: "+file+"\n", DKINFO);
	var data = DKWidget_GetOuterHtml(file);
	if(data){
		var path = DKAssets_GetDataPath();
		DKFile_StringToFile(data, path+DKWidget_GetFile(file));
	}
	
	DKEditor_AddDragHandles(file);
	DKEditor_ApplyBox(stored_element);	 //replace box
}

////////////////////////////////
function DKEditor_OpenFile(path)
{
	//DKLog("DKEditor_OpenWidget("+path+") \n", DKDEBUG);
	if(path.indexOf(".") == -1 ){ return false; }
	if(path.indexOf(".html") != -1 ){ 
		//DKSendEvent("DKMessage.html", "GetInput", "GLOBAL,FileChoice,FileCHoice"); // To -> DKFileDialog
		//return;
		DKEditor_OpenHtml(path); return true; 
	}
	if(path.indexOf(".js") != -1 ){ DKEditor_OpenJS(path); return true; }
	if(path.indexOf(".png") != -1 ){ DKEditor_OpenImage(path); return true; }
	if(path.indexOf(".bmp") != -1 ){ DKEditor_OpenImage(path); return true; }
	if(path.indexOf(".gif") != -1 ){ DKEditor_OpenImage(path); return true; }
	if(path.indexOf(".jpeg") != -1 ){ DKEditor_OpenImage(path); return true; }
	if(path.indexOf(".jpg") != -1 ){ DKEditor_OpenImage(path); return true; }
	if(path.indexOf(".tiff") != -1 ){ DKEditor_OpenImage(path); return true; }
	if(path.indexOf(".tif") != -1 ){ DKEditor_OpenImage(path); return true; }
	if(path.indexOf(".osgt") != -1 ){ DKEditor_OpenModel(path); return true; }
	if(path.indexOf(".osg") != -1 ){ DKEditor_OpenModel(path); return true; }
	if(path.indexOf(".wav") != -1 ){ DKEditor_OpenAudio(path); return true; }
	if(path.indexOf(".mp3") != -1 ){ DKEditor_OpenAudio(path); return true; }
	if(path.indexOf(".avi") != -1 ){ DKEditor_OpenVideo(path); return true; }
	if(path.indexOf(".mkv") != -1 ){ DKEditor_OpenVideo(path); return true; }
	if(path.indexOf(".mp4") != -1 ){ DKEditor_OpenVideo(path); return true; }
	DKEditor_OpenText(path); return true;
}

////////////////////////////////
function DKEditor_OpenHtml(path)
{
	//DKLog("DKEditor_OpenHtml("+path+") \n", DKDEBUG);
	var id = DKFile_GetFilename(path);
	DKCreate(path);
	DKEditor_AddDragHandles(id);
	DKEditor_SelectElement(id);
	return;
	
	//TODO - to use files outside of the data directory, we need to append the datapath
	//var the_path = path.replace(id, "");
	//DKLog("DKWidget_AppendDataPath("+the_path+") \n", DKDEBUG);
	//AppendDataPath(the_path);

	var filedata = DKFile_FileToString(path);
	if(!filedata){ return false; }
	//if(!HtmlToRml(filedata)){ return false; }

	//Parse the sting into an element
	var temp = DKWidget_CreateElement("body", "temp", "temporary");
	DKWidget_SetInnerHtml(temp, filedata);

	//if(DKWidget_GetNumChildren(temp) == 0){
	//	DKLog("Error loading path: "+id+": could not create node. \n", DKERROR);
	//	return false;
	//}

	//Make sure there is only 1 child
	//if(DKWidget_GetNumChildren(temp) > 1){
	//	DKLog("Error loading path: "+id+" has more than one root node.\n", DKERROR);
	//	return false;
	//}

	DKLog("temp: "+temp+"\n", DKDEBUG);
	var element = DKWidget_GetFirstChild(temp);
	DKLog("element = "+element+"\n", DKDEBUG);
	//DKElement* element = temp->GetFirstChild();
	//DKWidget_SetAttribute(element, "id", id);
	
	DKWidget_AppendChild("body", element);
	DKWidget_RemoveElement("temporary");
	//Show(id);
	DKEditor_AddDragHandles(id);
	DKEditor_SelectElement(id);
}

//////////////////////////////
function DKEditor_OpenJS(path)
{
	var id = DKFile_GetFilename(path);
	DKCreate(path);
}

////////////////////////////////
function DKEditor_OpenText(path)
{
	DKWidget_Toggle("DKNotepad.html");
	DKCreate("DKNotepad/DKNotepad.js");
	DKNotepad_LoadFile(path);
}

/////////////////////////////////
function DKEditor_OpenImage(path)
{
	DKEditor_NewImage(path);
}

/////////////////////////////////
function DKEditor_OpenModel(path)
{
	DKCreate("DKOSGManipulator,,DKOSGWindow");
	DKCreate("DKOSGModel,,DKWindow,"+path);
}

/////////////////////////////////
function DKEditor_OpenAudio(path)
{
	DKLog("DKEditor_OpenAudio("+path+") \n");
	//var file = DKFile_GetFilename(path);
	DKCreate("DKAudio");
	DKAudio_Play(path);
	
	//DKCreate("DKOSGAudio,"+file+",DKOSGWindow,"+path);
	//DKOSGAudio_Play("DKOSGAudio,"+file);
	
	//DKCreate("DKSDLAudio,"+file+",DKSDLWindow,"+path);
	//DKSDLAudio_Play("DKSDLAudio,"+file);
}

/////////////////////////////////
function DKEditor_OpenVideo(path)
{
	DKCreate("DKOSGManipulator,,DKOSGWindow");
	DKOSGVideo_Play(path);
	//DKCreate("DKOSGVideo,,DKOSGWindow,"+path);
}