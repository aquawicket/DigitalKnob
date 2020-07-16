/*
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
*/

console.log("\n");
console.log("document = "+document);
console.log("document.documentElement = "+document.documentElement);
//console.log("document.documentElement.style = "+document.documentElement.style);

document.documentElement.style.color = "blue";

var div1 = document.createElement("div");
div1.innerHTML = "Test";
div1.style.color = "black";
console.log("div1 = "+div1);

console.log("\n");