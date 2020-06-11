// browser app script, called from index.html

DKCreate("DK/DK.css", function(){
DKCreate("DKFile/DKFile.js", function(){
DKCreate("DKWidget/DKWidget.js", function(){
DKCreate("DKGui/DKFrame.js", function(){
DKCreate("DKColorPicker/DKColorPicker.js", function(){
	DKFrame_Widget("DKColorPicker/DKColorPicker.html");
});
});
});
});
});
//DKCreate("DKNotepad/DKNotepad.js", function(){});