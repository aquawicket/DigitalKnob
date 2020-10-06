////////////////////////
function DKEditor_Init()
{
	DK_Create("DKEditor/DKEditor.css");
	DK_Create("DKEditor/DKEditor.html");
	byId("DKEditor_edit").addEventListener("click", DKEditor_OnEvent);
	byId("DKEditor_edit").addEventListener("contextmenu", DKEditor_OnEvent);
	
	/*
	if(DK_GetBrowser() !== "RML"){
		DKWidget_AddDragHandle("DKEditor/DKEditor.html", "DKEditor/DKEditor.html"); //FIXME - eats click events in Rocket
	}
	*/
	
	/*
	DK_Create("DKTooltip/DKTooltip.js", function(){
		DKTooltip_Add("DKEditor_edit", "Admin tools");
	});
	*/
}

///////////////////////
function DKEditor_End()
{
	byId("DKEditor_edit").removeEventListener("click", DKEditor_OnEvent);
	byId("DKEditor_edit").removeEventListener("contextmenu", DKEditor_OnEvent);
	DK_Close("DKEditor/DKEditor.html");
	DK_Close("DKEditor/DKEditor.css");
}

////////////////////////////////
function DKEditor_OnEvent(event)
{
	console.debug("DKEditor_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "DKEditor_edit"){
		DK_Create("DKEditor/DKEditor_Menu.js", function(){
			DKMenu_ValidatePosition("DKEditor/DKEditor_Menu.html");
		});
	}
}