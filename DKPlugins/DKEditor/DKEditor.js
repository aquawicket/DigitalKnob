////////////////////////
function DKEditor_init()()
{
	dk.create("DKEditor/DKEditor.css");
	dk.create("DKEditor/DKEditor.html");
	byId("DKEditor_edit").addEventListener("click", DKEditor_onevent);
	byId("DKEditor_edit").addEventListener("contextmenu", DKEditor_onevent);
	
	/*
	if(DK_GetBrowser() !== "RML"){
		DK_AddDragHandle("DKEditor/DKEditor.html", "DKEditor/DKEditor.html"); //FIXME - eats click events in Rocket
	}
	*/
	
	/*
	dk.create("DKTooltip/DKTooltip.js", function(){
		DKTooltip_Add("DKEditor_edit", "Admin tools");
	});
	*/
}

///////////////////////
function DKEditor_end()()
{
	byId("DKEditor_edit").removeEventListener("click", DKEditor_onevent);
	byId("DKEditor_edit").removeEventListener("contextmenu", DKEditor_onevent);
	dk.close("DKEditor/DKEditor.html");
	dk.close("DKEditor/DKEditor.css");
}

////////////////////////////////
function DKEditor_OnEvent(event)
{
	console.debug("DKEditor_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "DKEditor_edit"){
		dk.create("DKEditor/DKEditor_Menu.js", function(){
			DKMenu_ValidatePosition("DKEditor/DKEditor_Menu.html");
		});
	}
}