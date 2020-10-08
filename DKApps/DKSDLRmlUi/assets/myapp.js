DK_Create("DK/DK.css", function(){
DK_Create("DKFile/DKFile.js", function(){
DK_Create("DKAssets/DKAssets.js", function(){
DK_Create("DKWindow/DKWindow.js", function(){
DK_Create("DKWidget/DKWidget.js", function(){
DK_Create("DKGui/DKFrame.js", function(){
DK_Create("DKGui/DKMenu.js", function(){
DK_Create("DKOS/DKOS.js", function(){
DK_Create("DKDebug/DKDebug.js", function(){
	
	window.resizeTo(window.screen.width/2, window.screen.height-60);
	window.moveTo(window.screen.width/2, 30);
	//DKRml_DebuggerOn();
	
	DK_Create("DKNotepad/DKNotepad.js", function(){
		DKFrame_Html("DKNotepad/DKNotepad.html");
		DKNotepad_Open("todo.txt");
	});
	
	/*
	DK_Create("DKInputTest/DKInput.js", function(){
		DKFrame_Html("DKInputTest/DKInput.html");
	});
	*/
	//window.location.href = "DKWebtest/index.html";
	
});
});
});
});
});
});
});
});
});