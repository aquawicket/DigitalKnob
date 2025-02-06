
function DKHandles_init(){
	dk.create("DKHandles");
	dk.create("DKHandles/DKHandles.html");
	document.addEventListener("click", DKHandles_onevent);
	document.addEventListener("DKHandles_WindowChanged", DKHandles_onevent);
	byId("refresh").addEventListener("click", DKHandles_onevent);
	byId("parent").addEventListener("click", DKHandles_onevent);
	byId("search").addEventListener("mousedown", DKHandles_onevent);
	byId("setvalue").addEventListener("click", DKHandles_onevent);
	byId("doclick").addEventListener("click", DKHandles_onevent);
	byId("Prev").addEventListener("click", DKHandles_onevent);
	byId("Next").addEventListener("click", DKHandles_onevent);
	byId("Highlight").addEventListener("click", DKHandles_onevent);
	DKHandles_UpdateWindowList();
	byId("search").ondragstart = function() { return false; };
}

function DKHandles_end(){
	document.removeEventListener("click", DKHandles_onevent);
	document.removeEventListener("DKHandles_WindowChanged", DKHandles_onevent);
	byId("refresh").removeEventListener("click", DKHandles_onevent);
	byId("parent").removeEventListener("click", DKHandles_onevent);
	byId("search").removeEventListener("mousedown", DKHandles_onevent);
	byId("setvalue").removeEventListener("click", DKHandles_onevent);
	byId("doclick").removeEventListener("click", DKHandles_onevent);
	byId("Prev").removeEventListener("click", DKHandles_onevent);
	byId("Next").removeEventListener("click", DKHandles_onevent);
	byId("Highlight").removeEventListener("click", DKHandles_onevent);
	dk.close("DKHandles/DKHandles.html");
}

function DKHandles_OnEvent(event){
	if(event.currentTarget === document){
		var handle = document.documentElement.innerHTML;
		DKHandles_UpdateProperties(handle);
    }
	if(event.currentTarget.id === "parent"){
		var handle = byId("parent").innerHTML;
		DKHandles_UpdateProperties(handle);
    }
	if(event.currentTarget.id === "refresh"){
		DKHandles_UpdateWindowList();
    }
	if(event.currentTarget.id === "search"){
		//console.log("search\n");
		byId("search").src = "DKHandles/win2.bmp";
		DKHandles_StartSearch();
    }
	if(event.currentTarget.id === "setvalue"){
		var value = DK_GetValue("SetValueBox");
		var currentHandle = DKHandles_CurrentHandle();
		DKHandles_SetValue(currentHandle, value);
    }
	if(event.currentTarget.id === "doclick"){
		var currentHandle = DKHandles_CurrentHandle();
		DKHandles_Click(currentHandle);
    }
	if(event.currentTarget.id === "Prev"){
		var currentHandle = DKHandles_CurrentHandle();
		var handle = DKHandles_PrevHandle(currentHandle);
		DKHandles_UpdateProperties(handle);
	}
	if(event.currentTarget.id === "Next"){
		var currentHandle = DKHandles_CurrentHandle();
		var handle = DKHandles_NextHandle(currentHandle);
		DKHandles_UpdateProperties(handle);
	}
	if(event.currentTarget.id === "Highlight"){
		DKHandles_ToggleHighlight();
	}
	if(event.currentTarget.id === "wintitle"){
		var handle = DKHandles_SetWindowHandle(DK_GetValue(DK_GetId(event)));
		DKHandles_UpdateProperties(handle);
	}
	if(event.type === "DKHandles_WindowChanged"){
		//console.log("DKHandles_WindowChanged\n");
		byId("search").src = "DKHandles/win1.bmp";
		var handle = DK_GetValue(event);
		DKHandles_UpdateProperties(handle);
	}
}

function DKHandles_UpdateWindowList(){
	byId("windows").innerHTML = "";
	var str = CPP_DKHandles_GetWindows();
	if(!str){ return; }
	//console.log("WINDOW LIST: "+str+"\n");
	var arry = str.split(",");
	arry.sort();
	
	//RemoveDuplicates(arry);
	for(var i=0; i<arry.length; i++){
		var element = DK_CreateElement(byId("windows"), "option", "wintitle");
		element.value = arry[i];
		element.style.whiteSpace = "nowrap";
		element.addEventListener("click", DKHandles_onevent);
		element.innerHTML = arry[i];
	}
}

function DKHandles_UpdateProperties(handle){
	byId("currentHandle").innerHTML = "Handle: "+handle;
	var win = DKHandles_GetWindow(handle);
	byId("window").innerHTML = win;
	var value = DKHandles_GetValue(handle);
	byId("value").value = value;
	var clas = DKHandles_GetClass(handle);
	byId("class").value = clas;
	var par = DKHandles_GetParent(handle);
	if(!par)
		byId("parent").innerHTML = "";
	else
		byId("parent").innerHTML = par;
	var index = DKHandles_GetIndex(handle);
	byId("index").value = index;
	var windowindex = DKHandles_GetWindowIndex(handle);
	byId("windowindex").value = windowindex;
	
	var top = DKHandles_GetTop(handle);
	byId("Handle_top").innerHTML = "Top: "+top;
	var left = DKHandles_GetLeft(handle);
	byId("Handle_left").innerHTML = "Left: "+left;
	var right = DKHandles_GetRight(handle);
	byId("Handle_right").innerHTML = "Right: "+right;
	var bottom = DKHandles_GetBottom(handle);
	byId("Handle_bottom").innerHTML = "Bottom: "+bottom;
}
