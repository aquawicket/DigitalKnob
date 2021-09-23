//"use strict"; FIXME: Duktape doesn't like "use strict" tags 


const MyApp = function() {};
const myapp = new MyApp;

myapp.loadFiles = function myapp_loadFiles() {
    console.debug("myapp.loadFiles")
	
    //DKPlugin("DK/DKTrace.js")//, "singleton")                //FIXME: Infinate loop on Duktape
	//DKPlugin("DK/DKErrorHandler.js")//, "singleton")         //FIXME: Infinate loop on Duktape
	//DKPlugin("DK/DKPhp.js")//, "singleton")                  //FIXME: Infinate loop on Duktape
    //DKPlugin("DK/DKJson.js", "singleton")                    //FIXME: SyntaxError: parse error (line 77)
	
	DKPlugin("DKFile/DKFile.js", "singleton")
    DKPlugin("DK/DKValidate.js", "singleton")
    DKPlugin("DK/DKTime.js", "singleton")
    DKPlugin("DK/DKMqtt.js")
    DKPlugin("DK/DKNotifications.js");
    DKPlugin("DKDebug/DKDebug.js", "singleton")
    
	//DKPlugin("DKAudio/DKAudio.js")                           //DKAudio compile now working yet
    DKPlugin("DKGui/DKConsole.js", "singleton")
    DKPlugin("DKGui/DKGui.js", "singleton")
    DKPlugin("DKGui/DKFrame.js")
    DKPlugin("DKGui/DKMenu.js")
    DKPlugin("DKGui/DKMessageBox.js")
    DKPlugin("DKGui/DKDrag.js")
    DKPlugin("DKGui/DKResize.js")
    DKPlugin("DKGui/DKClipboard.js", "singleton")
    DKPlugin("DKGui/DKTable.js")
    //DKPlugin("DKDevTools/DKDevToolsButton.js", "singleton")   //DKFile::FileToString(C:/Users/IK/digitalknob/DK/DKApps/DKSDLRmlUi/assets/DKDevTools/DKDevToolsButton.js) path does not exist!   This should work
    //DKPlugin("DKChart/DKChart.js")                            //DKFile::FileToString(C:/Users/IK/digitalknob/DK/DKApps/DKSDLRmlUi/assets/DKChart/DKChart.js) path does not exist!
    //DKPlugin("DKCodeMirror/DKCodeMirror.js")                  //DKFile::FileToString(C:/Users/IK/digitalknob/DK/DKApps/DKSDLRmlUi/assets/DKCodeMirror/DKCodeMirror.js) path does not exist!
}

myapp.loadApp = function myapp_loadApp() {
	console.debug("myapp.loadFiles")
	
    //dk.errorCatcher(myapp, "myapp")
    //dk.errorhandler.create()
    DKTime.prototype.create()
    //dk.php.call("GET", "DK/DK.php", "createSocket", console.debug);
    dk.audio.createSound("DKTasmota/PowerDown.mp3");
    //dk.create("TestCode/TestPlugin.js", function() {})
}

myapp.loadGui = function myapp_loadGui() {
	console.debug("myapp.loadFiles")
	
    DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%");
    console.debug("**** Tasmota device manager 0.1b ****");
    dk.time.createClock(document.body, "2rem");
    dk.time.setLatitudeLongitude(33.7312525, -117.3028688);
    myapp.createDeviceTable(document.body);
    const ctx = DKChart.prototype.create(document.body, "chart", "50%", "75%", "0rem", "0rem", "100%", "25%");
    
    DKDevToolsButton.prototype.create();
   
    dk.time.addUpdater(function() {
        !dk.time.lastHour && (dk.time.lastHour = dk.time.hour)
        if (dk.time.lastHour !== dk.time.hour) {
            dk.time.lastHour = dk.time.hour
            console.debug("new hour " + dk.time.hour);
            //alert("!!! CHECK PLANTS !!!");
            DKPlugin("DKGui/DKMessageBox.js", function() {
                DKMessageBox.prototype.createMessage("CHECK PLANTS!", function(instance, okclicked) {
                    if (instance) {
                        //console.debug("instance: %c" + instance, "color:orange;")
                        instance.html && (instance.html.style.backgroundColor = "red")
                    }
                });
            });
        }
    })
}

myapp.mainAppLoop = function myapp_mainAppLoop() {
	//console.debug("myapp.loadFiles")
	
    navigator.onLine ? byId("internet").src = "DKGui/online.png" : byId("internet").src = "DKGui/offline.png"
}

myapp.createButtons = function myapp_createButtons(parent) {
    dk.gui.createButton(document.body, "Scan Devices", "", "", "", "", "", "", myapp.scanDevices).style.position = "";
    dk.gui.createButton(document.body, "Update Devices", "", "", "", "", "", "", myapp.mainAppLoop).style.position = "";
    dk.gui.createButton(document.body, "Clear Devices", "", "", "", "", "", "", myapp.clearDevices).style.position = "";
    dk.gui.createButton(document.body, "Save Devices", "", "", "", "", "", "", myapp.saveDevices).style.position = "";

    const automation = dk.gui.createButton(document.body, "Automation", "", "", "", "", "", "", automation_onclick);
    automation.style.position = "";
    automation_update();
    function automation_onclick() {
        myapp.automate ? myapp.automate = false : myapp.automate = true;
        automation_update();
    }
    function automation_update() {
        myapp.automate ? automation.innerHTML = "Automate ON" : automation.innerHTML = "Automate OFF";
    }

    const internet = dk.gui.createImageButton(document.body, "internet", "", "2rem", "", "", "58rem", "", "19rem");
    navigator.onLine ? internet.src = "DKGui/online.png" : internet.src = "DKGui/offline.png";

    const volume = dk.gui.createImageButton(document.body, "", "DKAudio/volume_100.png", "2rem", "", "", "28rem", "", "19rem", volume_onclick);

    const preferences = dk.gui.createImageButton(document.body, "", "DKGui/options.png", "3rem", "", "", "3rem", "", "17rem", myapp.preferencesWindow);
}

myapp.preferencesWindow = function myapp_preferencesWindow() {
    const div = DKFrame.prototype.createNewWindow("Preferenes", "500rem", "400rem");
    if (!div)
        return;
    div.style.backgroundColor = "rgb(36,36,36)";
}

myapp.infoWindow = function myapp_infoWindow(device) {
    //const dkframe = DKPlugin(DKFrame)
    const div = document.createElement("div");
    //document.body.appendChild(div);
    
    div.style.width = "500rem";
    div.style.height = "400rem";
    
    div.style.fontSize = "12rem";
    div.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
    div.style.whiteSpace = "pre-wrap";
    div.style.boxSizing = "border-box";
    div.style.padding = "2rem";
    div.style.paddingLeft = "20rem";
    div.style.borderStyle = "solid";
    div.style.borderWidth = "1rem";
    div.style.borderTopWidth = "0rem";
    div.style.borderLeftWidth = "0rem";
    div.style.borderRightWidth = "0rem";
    div.style.backgroundColor = "rgb(50,50,50)";
    div.style.overflow = "auto";
    const jsonString = dk.json.prettyJson(JSON.stringify(device));
    const jsonSuper = dk.json.highlightJson(jsonString);
    div.innerHTML = jsonSuper;
    const dkframe = DKFrame.prototype.create(div)
    return dkframe;
}

myapp.settingsWindow = function myapp_settingsWindow(device) {
    const div = DKFrame.prototype.createNewWindow(device.Status.DeviceName + " Settings", "500rem", "400rem");
    if (!div)
        return;
    //TODO
}


myapp.updateScreen = function myapp_updateScreen(success, device, data) {
    required({
        success
    }, {
        device
    }, {
        data
    });

  
}

DUKTAPE && myapp.loadFiles();
