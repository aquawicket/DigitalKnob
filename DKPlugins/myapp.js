dk.create("DK/DK.css", function(){
dk.create("DKFile/DKFile.js", function(){
dk.create("DKAssets/DKAssets.js", function(){
dk.create("DKWindow/DKWindow.js", function(){
dk.create("DKWidget/DKWidget.js", function(){
dk.create("DKGui/DKFrame.js", function(){
dk.create("DKGui/DKMenu.js", function(){
dk.create("DKOS/DKOS.js", function(){
dk.create("DKDebug/DKDebug.js", function(){
	
	window.resizeTo(window.screen.width/2, window.screen.height-60);
	window.moveTo(window.screen.width/2, 30);
	//DKRml_DebuggerOn();
	
	dk.create("DKNotepad/DKNotepad.js", function(){
		DKFrame_Html("DKNotepad/DKNotepad.html");
		DKNotepad_Open("DK/todo.txt");
	});
	
	/*
	dk.create("DKInputTest/DKInput.js", function(){
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