
/////////////////////////////
function DKEditor_Notes_Init()
{
	//DKCreate("DKEditor/DKEditor_Notes.html");
	DKCreate("DKNotepad/DKNotepad.js", function(){
		DKFrame_Widget("DKNotepad.html");
		DKNotepad_Open(DKAssets_LocalAssets()+"/notes.txt");
	});
}

////////////////////////////
function DKEditor_Notes_End()
{
	//DKClose("DKEditor/DKEditor_Notes.html");
}

/////////////////////////////////////
function DKEditor_Notes_OnEvent(event)
{
	DKLog("DKEditor_Notes_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}