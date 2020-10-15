//////////////////////////////////
function DKNotepadShortcuts_Init()
{
	document.addEventListener("keydown", DKNotepadShortcuts_OnEvent);
}

/////////////////////////////////
function DKNotepadShortcuts_End()
{
	document.removeEventListener("keydown", DKNotepadShortcuts_OnEvent);
}

//////////////////////////////////////////
function DKNotepadShortcuts_OnEvent(event)
{
	console.warn("DKNotepadShortcuts_OnEvent(): event.type:"+event.type);
}