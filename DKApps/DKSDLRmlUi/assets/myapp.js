//loaders
dk.create("DKAssets/DKAssets.js");
dk.create("DK/DKPlugin.js");
dk.create("DK/DKErrorHandler.js");


//dk.create("DK/DK.css");
dk.create("DK/DKPhp.js");
dk.create("DK/DKTrace.js");
dk.create("DK/DKJson.js");
dk.create("DK/DKValidate.js");
dk.create("DK/sun.js");
dk.create("DK/DKClock.js");
//dk.create("DK/DKMqtt.js"); 
dk.create("DK/DKNotifications.js");

//dk.file
dk.create("DKFile/DKFile.js");
//dk.create("DKFile/DKSolution.js");

//dk.audio
//dk.create("DKAudio/DKAudio.js");

//dk.debug
dk.create("DKDebug/DKDebug.js");

//dk.gui
dk.create("DKGui/DKGui.js");
//dk.create("DKGui/DKFrame.css");
dk.create("DKGui/DKFrame.js");
//dk.create("DKGui/DKMenu.js");
dk.create("DKGui/DKMessageBox.js");
dk.create("DKGui/DKDrag.js");
dk.create("DKGui/DKResize.js");
dk.create("DKGui/DKClipboard.js");
//dk.create("DKGui/DKTable.css");
dk.create("DKGui/DKTable.js");
//dk.create("DKGui/DKConsole.css");
dk.create("DKGui/DKConsole.js");

//dk.create("DKDevTools/DKDevTools.js");


//dk.create("DKChart/DKChart.js");
//dk.create("DKCodeMirror/DKCodeMirror.js");




//creators
//dk.errorhandler.create();


//Inline elements
let div = document.createElement("div");
div.style.position = "absolute";
div.style.top = "100px";
div.style.left = "100px";
div.style.width = "100px";
div.style.height = "100px";
div.style.backgroundColor = "rgb(100,100,100)";
document.body.appendChild(div);

let span = document.createElement("span");
span.innerHTML = "Text";
div.appendChild(span);