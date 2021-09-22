"use strict";

//**************************************
// TODO: start xconsole early and keep a backup of all messages to give to dk.console later..
// TODO: Create an easy TODO list check off/alarm/reminder type Plugin   check calander?
//**************************************

const MyApp = function() {};
const myapp = new MyApp;

myapp.loadFiles = function myapp_loadFiles() {
    //If you initiate any values here, they may fail.
    //This function should only load files, and make declarations, Not initiate variable values or make assignments.
    //myapp.loadApp()) will be called after this loads everything. This gives a chance to load assets without using a million callbacks.

    DKPlugin("DK/DKTrace.js")//, "singleton")
    DKPlugin("DK/DKErrorHandler.js", "singleton")
    DKPlugin("DK/DKPhp.js", "singleton")
    DKPlugin("DK/DKJson.js", "singleton")
    DKPlugin("DKFile/DKFile.js", "singleton")
    //DKPlugin("DK/DKValidate.js", "singleton")
    DKPlugin("DK/DKTime.js", "singleton")
    //DKPlugin("DK/DKMqtt.js")
    //DKPlugin("DK/DKNotifications.js");
    DKPlugin("DKDebug/DKDebug.js", "singleton")
    DKPlugin("DKAudio/DKAudio.js")
    DKPlugin("DKGui/DKConsole.js", "singleton")
    DKPlugin("DKGui/DKGui.js", "singleton")
    DKPlugin("DKGui/DKFrame.js")
    //DKPlugin("DKGui/DKMenu.js")
    DKPlugin("DKGui/DKMessageBox.js")
    DKPlugin("DKGui/DKDrag.js")
    //DKPlugin("DKGui/DKResize.js")
    DKPlugin("DKGui/DKClipboard.js", "singleton")
    DKPlugin("DKGui/DKTable.js")
    DKPlugin("DKDevTools/DKDevToolsButton.js", "singleton")
    DKPlugin("DKChart/DKChart.js")
    //DKPlugin("DKCodeMirror/DKCodeMirror.js")
    DKPlugin("DKTasmota/DKTasmota.js", "singleton")
    DKPlugin("DKTasmota/Automation.js")
    //DKPlugin("DKTasmota/VPDCalculator.js")
    DKPlugin("DKTasmota/Chart.js")

    dk.preloadImage("DKGui/loading.gif");
    dk.preloadImage("DKGui/restart.png");
    dk.preloadImage("DKGui/info.png");
    dk.preloadImage("DKGui/settings.png");
    dk.preloadImage("DKGui/console.png");
    dk.preloadImage("DKGui/chart.png");
    dk.preloadImage("DKGui/online.png");
    dk.preloadImage("DKGui/offline.png");
    dk.preloadImage("DKTasmota/automateOFF.png");
    dk.preloadImage("DKTasmota/automateON.png");
}

myapp.loadApp = function myapp_loadApp() {
    dk.errorCatcher(myapp, "myapp")
    dk.errorhandler.create()
    DKTime.prototype.create()
    //dk.php.call("GET", "DK/DK.php", "createSocket", console.log);
    dk.audio.createSound("DKTasmota/PowerDown.mp3");
    dk.tasmota.loadDevicesFromServer(function dk_tasmota_loadDevicesFromServer_callback() {
        if (location.protocol === "file:" || location.host.includes("127.0.0.1") || location.host.includes("localhost")) {
            myapp.server = true;
            myapp.automate = true;
        } else {
            myapp.client = true;
            myapp.automate = false;
        }
        myapp.loadGui();

        //Run app main loop every 60 seconds
        window.setInterval(myapp.mainAppLoop, 60000);
    });

    //dk.create("TestCode/TestPlugin.js", function() {})
}

myapp.loadGui = function myapp_loadGui() {
    DKConsole.prototype.create(document.body, "", "0rem", "0rem", "0rem", "100%", "25%");
    console.debug("**** Tasmota device manager 0.1b ****");
    myapp.server && (document.body.style.backgroundColor = "rgb(100,100,140)");
    myapp.client && (document.body.style.backgroundColor = "rgb(100,100,100)");
    myapp.createButtons(document.body);
    dk.time.createClock(document.body, "2rem");
    dk.time.setLatitudeLongitude(33.7312525, -117.3028688);
    myapp.createDeviceTable(document.body);
    const ctx = DKChart.prototype.create(document.body, "chart", "50%", "75%", "0rem", "0rem", "100%", "25%");
    if (!dk.tasmota.devices || !dk.tasmota.devices.length)
        console.info("dk.tasmota.devices empty");
    else
        for (let n = 0; n < dk.tasmota.devices.length; n++)
            myapp.addDeviceToTable(dk.tasmota.devices[n]);
    DKDevToolsButton.prototype.create();
    TasChart.prototype.create(ctx);

    dk.time.addUpdater(function() {
        !dk.time.lastHour && (dk.time.lastHour = dk.time.hour)
        if (dk.time.lastHour !== dk.time.hour) {
            dk.time.lastHour = dk.time.hour
            console.debug("new hour " + dk.time.hour);
            //alert("!!! CHECK PLANTS !!!");
            DKPlugin("DKGui/DKMessageBox.js", function() {
                DKMessageBox.prototype.createMessage("CHECK PLANTS!", function(instance, okclicked) {
                    if (instance) {
                        //console.log("instance: %c" + instance, "color:orange;")
                        instance.html && (instance.html.style.backgroundColor = "red")
                    }
                });
            });
        }
    })
}

myapp.mainAppLoop = function myapp_mainAppLoop() {
    navigator.onLine ? byId("internet").src = "DKGui/online.png" : byId("internet").src = "DKGui/offline.png"
    //dk.tasmota.loadDevicesFromServer();
    dk.tasmota.updateDevices("ALL", myapp.updateScreen)
    dk.automate && dk.automate()
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
    dk.audio.setVolume("DKTasmota/PowerDown.mp3", 0.5);
    function volume_onclick() {
        dk.audio.toggleMute("DKTasmota/PowerDown.mp3");
        if (dk.audio.muted)
            volume.src = "DKAudio/volume_0.png";
        else
            volume.src = "DKAudio/volume_100.png";
    }
    const preferences = dk.gui.createImageButton(document.body, "", "DKGui/options.png", "3rem", "", "", "3rem", "", "17rem", myapp.preferencesWindow);
}

myapp.createDeviceTable = function myapp_createDeviceTable(parent) {
    const deviceDiv = document.createElement("div");
    deviceDiv.style.position = "absolute";
    deviceDiv.style.top = "25rem";
    deviceDiv.style.left = "20rem";
    deviceDiv.style.width = "720rem";
    deviceDiv.style.height = "47.0%";
    deviceDiv.style.overflow = "auto";
    parent.appendChild(deviceDiv);

    dk.table = DKTable.prototype.create(deviceDiv, "deviceTable", "0rem", "", "0rem");

    //Create Header Row as a normal <tr>
    //const deviceHeader = dk.table.addColumn(dk.table.table, "HEADER", "device"); //FIXME
    const row = dk.table.addRow(dk.table.table, "HEADER", "device");
    row.style.backgroundColor = "rgb(50,50,50)";
    row.style.fontWeight = "bold";
    row.style.cursor = "pointer";
    const deviceCell = dk.table.getCellByName(dk.table.table, "HEADER", "device");
    deviceCell.innerHTML = "Devices (0)";
    deviceCell.style.width = "230rem";
    deviceCell.onclick = function HEADER_device_onclick() {
        dk.table.sort("deviceTable", "device");
        myapp.updateTableStyles();
    }

    dk.table.addColumn(dk.table.table, "power");
    const powerCell = dk.table.getCellByName(dk.table.table, "HEADER", "power");
    powerCell.innerHTML = "power";
    powerCell.style.width = "50rem";
    powerCell.style.textAlign = "center";
    powerCell.onclick = function HEADER_power_onclick() {
        dk.table.sort("deviceTable", "power");
        myapp.updateTableStyles();
    }

    dk.table.addColumn(dk.table.table, "data");
    const dataCell = dk.table.getCellByName(dk.table.table, "HEADER", "data");
    dataCell.innerHTML = "data";
    dataCell.style.width = "150rem";
    dataCell.style.textAlign = "center";
    dataCell.onclick = function HEADER_data_onclick() {
        dk.table.sort("deviceTable", "data");
        myapp.updateTableStyles();
    }

    dk.table.addColumn(dk.table.table, "automate");
    const automateCell = dk.table.getCellByName(dk.table.table, "HEADER", "automate");
    automateCell.innerHTML = "automate";
    automateCell.style.width = "50rem";
    automateCell.style.textAlign = "center";
    automateCell.onclick = function HEADER_automate_onclick() {
        dk.table.sort("deviceTable", "automate");
        myapp.updateTableStyles();
    }

    dk.table.addColumn(dk.table.table, "wifi");
    const wifiCell = dk.table.getCellByName(dk.table.table, "HEADER", "wifi");
    wifiCell.innerHTML = "wifi signal";
    wifiCell.style.width = "70rem";
    wifiCell.style.textAlign = "center";
    wifiCell.onclick = function HEADER_wifi_onclick() {
        dk.table.sort("deviceTable", "wifi");
        myapp.updateTableStyles();
    }

    dk.table.addColumn(dk.table.table, "options");
    const optionsCell = dk.table.getCellByName(dk.table.table, "HEADER", "options");
    optionsCell.innerHTML = "options";
    optionsCell.style.width = "120rem";
    optionsCell.style.textAlign = "center";
    optionsCell.onclick = function HEADER_options_onclick() {//console.log("HEADER_options_onclick");
    }
}

myapp.addDeviceToTable = function myapp_addDeviceToTable(device) {
    const table = byId("deviceTable");
    const row = dk.table.addRow(dk.table.table, device.ip);
    row.setAttribute("ip", device.ip);
    if (row.rowIndex % 2 == 0) {
        //even
        row.style.backgroundColor = "rgb(90,90,90)";
    } else {
        //odd
        row.style.backgroundColor = "rgb(60,60,60)";
    }

    const deviceCell = dk.table.getCellByName(dk.table.table, device.ip, "device");
    device.Status ? deviceCell.innerHTML = "<a>" + device.Status.DeviceName + "</a>" : deviceCell.innerHTML = "<a>" + device.ip + "</a>";
    deviceCell.style.cursor = "pointer";
    deviceCell.onclick = function deviceCell_onclick() {
        const deviceWindow = window.open("http://" + device.ip, device.ip, "_blank, width=500, height=700");
    }

    const powerCell = dk.table.getCellByName(dk.table.table, device.ip, "power");
    powerCell.style.textAlign = "center";
    powerCell.style.cursor = "pointer";
    powerCell.onclick = function powerCell_onclick() {
        powerCell.innerHTML = "";
        const loading = document.createElement("img");
        loading.src = "DKGui/loading.gif";
        loading.style.width = "15rem";
        loading.style.height = "15rem";
        powerCell.appendChild(loading);
        dk.tasmota.sendCommand(device.ip, "POWER Toggle", myapp.updateScreen);
    }

    const dataCell = dk.table.getCellByName(dk.table.table, device.ip, "data");
    dataCell.style.textAlign = "center";

    const automateCell = dk.table.getCellByName(dk.table.table, device.ip, "automate");
    automateCell.style.textAlign = "center";
    const auto = document.createElement("img");
    auto.id = device.ip + "automate";
    auto.setAttribute("title", "Automation");
    (device.user.automate === undefined) && (device.user.automate = false);
    device.user.automate ? auto.src = "DKTasmota/automateON.png" : auto.src = "DKTasmota/automateOFF.png";
    auto.style.width = "17rem";
    auto.style.cursor = "pointer";
    auto.style.paddingRight = "3rem";
    auto.style.paddingBottom = "2rem";
    auto.onclick = function auto_onclick() {
        device.user.automate ? device.user.automate = false : device.user.automate = true;
        device.user.automate ? auto.src = "DKTasmota/automateON.png" : auto.src = "DKTasmota/automateOFF.png";
        dk.tasmota.saveDevicesToServer(device.ip);
    }
    automateCell.appendChild(auto);

    const wifiCell = dk.table.getCellByName(dk.table.table, device.ip, "wifi");
    wifiCell.style.textAlign = "center";

    const optionsCell = dk.table.getCellByName(dk.table.table, device.ip, "options");
    optionsCell.innerHTML = "";
    optionsCell.style.textAlign = "center";

    //Device Restart
    const restart = dk.gui.createTag("img", optionsCell, {
        id: device.ip + "restart",
        title: "Restart Device",
        src: "DKGui/restart.png",
        style: {
            width: "12rem",
            height: "12rem",
            cursor: "pointer",
            paddingRight: "3rem",
            paddingBottom: "2rem",
        },
        onclick: function restart_onclick() {
            DKPlugin("DKGui/DKMessageBox.js", function() {
                DKMessageBox.prototype.createConfirm("Restart " + device.Status.DeviceName + "?", function dk_messagebox_createConfirm_callback(rval) {
                    if (rval) {
                        restart.src = "DKGui/loading.gif";
                        dk.tasmota.sendCommand(device.ip, "Restart 1", myapp.updateScreen);
                    }
                });
            });
        }
    });

    //Device Info
    const info = dk.gui.createTag("img", optionsCell, {
        title: "Device Info",
        src: "DKGui/info.png",
        style: {
            width: "12rem",
            height: "12rem",
            cursor: "pointer",
            paddingRight: "3rem",
            paddingBottom: "2rem"
        },
        onclick: function info_onclick() {
            myapp.infoWindow(device);
        }
    });

    //Device Settings
    const settings = dk.gui.createTag("img", optionsCell, {
        title: "Device Settings",
        src: "DKGui/settings.png",
        style: {
            height: "15rem",
            cursor: "pointer"
        },
        onclick: function settings_onclick() {
            myapp.settingsWindow(device);
        }
    });

    const dConsole = dk.gui.createTag("img", optionsCell, {
        title: "Device Console",
        src: "DKGui/console.png",
        style: {
            height: "15rem",
            paddingLeft: "3rem",
            cursor: "pointer"
        },
        onclick: function dConsole_onclick() {
            myapp.consoleWindow(device);
        }
    });

    const dChart = dk.gui.createTag("img", optionsCell, {
        id: device.ip + "dChart",
        title: "Device Chart",
        src: "DKGui/chart.png",
        style: {
            height: "15rem",
            marginLeft: "3rem",
            cursor: "pointer"
        },
        onclick: function dChart_onclick() {
            for (let n = 0; n < dk.tasmota.devices.length; n++) {
                if (dk.tasmota.devices[n].ip === device.ip)
                    byId(device.ip + "dChart").style.backgroundColor = dk.taschart.selectChart(device.ip);
                else
                    byId(dk.tasmota.devices[n].ip + "dChart").style.backgroundColor = "rgba(0,0,0,0.0)";
            }
        },
        oncontextmenu: function dChart_oncontextmenu(event) {
            event.preventDefault();
            const color = dk.taschart.toggleChart(device.ip);
            for (let n = 0; n < dk.tasmota.devices.length; n++) {
                if (dk.tasmota.devices[n].ip === device.ip) {
                    color && (byId(dk.tasmota.devices[n].ip + "dChart").style.backgroundColor = color);
                    !color && (byId(dk.tasmota.devices[n].ip + "dChart").style.backgroundColor = "rgba(0,0,0,0.0)");
                }
            }
        }
    });

    //Do some final processing
    const deviceHeader = dk.table.getCellByName(dk.table.table, "HEADER", "device");
    deviceHeader.innerHTML = "Devices (" + (table.rows.length - 1) + ")";
    dk.tasmota.updateDevices(device.ip, myapp.updateScreen);
    dk.table.sort("deviceTable", "device");
    myapp.updateTableStyles();
}

myapp.preferencesWindow = function myapp_preferencesWindow() {
    const div = DKFrame.prototype.createNewWindow("Preferenes", "500rem", "400rem");
    if (!div)
        return;
    div.style.backgroundColor = "rgb(36,36,36)";
}

myapp.infoWindow = function myapp_infoWindow(device) {
    //const div = DKFrame.prototype.createNewWindow(device.Status.DeviceName + " Info", "500rem", "400rem");
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
    dkframe.setTitle(device.Status.DeviceName)
    return dkframe;
}

myapp.settingsWindow = function myapp_settingsWindow(device) {
    const div = DKFrame.prototype.createNewWindow(device.Status.DeviceName + " Settings", "500rem", "400rem");
    if (!div)
        return;
    //TODO
}

myapp.consoleWindow = function myapp_consoleWindow(device) {
    const div = DKFrame.prototype.createNewWindow(device.Status.DeviceName + " Console", "500rem", "400rem");
    if (!div)
        return;
    div.style.backgroundColor = "rgb(50,50,50)";
    div.style.overflow = "auto";

    const output = document.createElement("div");
    output.style.position = "absolute";
    output.style.top = "10rem";
    output.style.left = "10rem";
    output.style.right = "10rem";
    output.style.bottom = "60rem";
    output.style.backgroundColor = "rgb(0,0,0)";
    div.appendChild(output);

    const link = document.createElement("a");
    link.innerHTML = "https://tasmota.github.io/docs/Commands/";
    link.style.position = "absolute";
    link.style.left = "10rem";
    link.style.bottom = "35rem";
    link.style.color = "rgb(200,200,200)";
    link.style.cursor = "pointer";
    link.onclick = function link_onclick() {
        const commandsWindow = window.open("https://tasmota.github.io/docs/Commands/", "_blank, width=500, height=700");
    }
    div.appendChild(link);

    //command box
    const input = document.createElement("input");
    input.type = "text";
    input.style.position = "absolute";
    input.style.left = "10rem";
    input.style.width = "90%";
    input.style.height = "22rem";
    //input.style.right = "10rem";
    input.style.bottom = "10rem";
    input.style.color = "rgb(255,255,255)";
    input.style.backgroundColor = "rgb(0,0,0)";
    input.onkeydown = function input_onkeydown() {
        const key = event.charCode || event.keyCode;
        if (key === 13) {
            //enter
            console.debug("Send command -> " + input.value);
            const command = encodeURIComponent(input.value).replace(";", "%3B");
            dk.tasmota.sendCommand(device.ip, command, function dk_tasmota_sendCommand_callback(success, device, data) {
                if (!success)
                    return error("success invalid");
                if (!device)
                    return error("device invalid");
                if (!data)
                    return error("data invalid");

                const msgDiv = document.createElement("div");
                msgDiv.style.width = "100%";
                msgDiv.style.fontSize = "12rem";
                msgDiv.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
                msgDiv.style.whiteSpace = "pre-wrap";
                msgDiv.style.boxSizing = "border-box";
                msgDiv.style.padding = "2rem";
                msgDiv.style.paddingLeft = "10rem";

                const msgText = document.createElement("span");
                msgText.innerHTML = data;
                msgText.style.color = "rgb(250,250,250)";

                output.appendChild(msgDiv);
                msgDiv.appendChild(msgText);
                output.scrollTop = output.scrollHeight;

                //Limit the number of stored lines
                if (output.childElementCount > 500)
                    output.removeChild(output.firstChild);
                input.value = "";
            });
        }
    }
    div.appendChild(input);
}

myapp.updateTableStyles = function myapp_updateTableStyles() {
    const table = byId("deviceTable");
    for (let n = 1; n < table.rows.length; n++) {
        const row = table.rows[n];
        if (row.rowIndex % 2 == 0) {
            //even
            row.style.backgroundColor = "rgb(90,90,90)";
        } else {
            //odd
            row.style.backgroundColor = "rgb(60,60,60)";
        }
    }
}

myapp.scanDevices = function myapp_scanDevices() {
    dk.tasmota.getDevices("192.168.1.", function dk_tasmota_getDevices_callback(ip, done) {
        if (ip && !dk.json.findPartialMatch(dk.tasmota.devices, 'ip', ip)) {
            const device = dk.tasmota.createDevice(ip);
            myapp.addDeviceToTable(device);
        }
        if (done) {
            dk.tasmota.saveDevicesToServer();
            dk.tasmota.saveDevicesToLocalStorage();
            console.log("\n");
            console.log("%c Scan Complete", "color:green;");
            console.log("%c (" + dk.tasmota.devices.length + ") Tasmota Devices found", "color:green;");
        }
    });
}

myapp.clearDevices = function myapp_clearDevices() {
    const table = byId("deviceTable");
    table.parentNode.remove(table);
    myapp.createDeviceTable(document.body);
    dk.removeFromLocalStorage("devices");
    dk.tasmota.devices = [];
}

myapp.saveDevices = function myapp_saveDevices() {
    dk.tasmota.saveDevicesToServer();
    dk.tasmota.saveDevicesToLocalStorage();
}

myapp.updateScreen = function myapp_updateScreen(success, device, data) {
    //DEBUG - used to test errors
    //dk.audio.play("DKTasmota/PowerDown.mp3");
    required({
        success
    }, {
        device
    }, {
        data
    });
    const table = byId("deviceTable");
    if (!table)
        return error("table invlid");
    const row = dk.table.getRowByName(dk.table.table, device.ip);
    if (!row)
        return error("row invalid");

    if (!success) {
        dk.audio.play("DKTasmota/PowerDown.mp3");
        row.style.backgroundColor = "red";
        console.log(device.ip + " did not respond");
        return false;
    }

    if (!device.Status)
        return error("device.Status invalid");
    //const jsonString = dk.json.prettyJson(data);
    //const jsonSuper = dk.json.highlightJson(jsonString);
    //console.log(jsonSuper);

    // UPDATE TABLE
    const deviceName = device.Status.DeviceName;
    if (deviceName) {
        const deviceCell = dk.table.getCellByName(dk.table.table, device.ip, "device");
        deviceCell.innerHTML = "<a title='" + device.ip + "'>" + deviceName + "</a>";
        dk.table.sort("deviceTable", "device");
        myapp.updateTableStyles();
    }

    const devicePower = device.StatusSTS.POWER;
    if (devicePower) {
        const powerCell = dk.table.getCellByName(dk.table.table, device.ip, "power");
        powerCell.innerHTML = "<a>" + devicePower + "</a>";
        if (devicePower === "ON") {
            row.cells[1].style.color = "rgb(0,180,0)";
            dk.taschart.updateDevice(device, "switch1", 100);
        } else {
            row.cells[1].style.color = "rgb(40,40,40)";
            dk.taschart.updateDevice(device, "switch1", 0);
        }
    }

    const dataCell = dk.table.getCellByName(dk.table.table, device.ip, "data");
    dataCell.innerHTML = "";
    if (device.StatusSNS && device.StatusSNS.DS18B20 && device.StatusSNS.DS18B20.Temperature)
        device.user.temperature = device.StatusSNS.DS18B20.Temperature
    if (device.StatusSNS && device.StatusSNS.SI7021 && device.StatusSNS.SI7021.Temperature)
        device.user.temperature = device.StatusSNS.SI7021.Temperature;
    if (device.user.temperature) {
        let tempDirection = " ";
        !device.user.temperatureTarget && (device.user.temperatureTarget = 77);
        !device.user.temperatureZone && (device.user.temperatureZone = 20);
        if (device.user.temperature > device.user.temperatureTarget) {
            tempDirection = "&#8593;"
        }
        if (device.user.temperature < device.user.temperatureTarget) {
            tempDirection = "&#8595;"
        }
        const tempText = "<a id='" + device.ip + "Temp'>" + device.user.temperature + " &#176;F" + tempDirection + "</a>";
        const tempTargetText = "<a id='" + device.ip + "TempTarg'> (" + device.user.temperatureTarget + "&#176;F)</a>";
        dataCell.innerHTML = dataCell.innerHTML + tempTargetText + " " + tempText + "<br>"

        const tempScale = 510;
        const tempDiff = (Math.abs(device.user.temperatureTarget - device.user.temperature) * 5)
        const tempNum = (tempDiff * tempScale / 100)
        const tempRed = tempNum.clamp(0, 255);
        const tempGreen = (510 - tempNum).clamp(0, 255);
        byId(device.ip + "Temp").style.color = "rgb(" + tempRed + "," + tempGreen + ",0)";
        byId(device.ip + "Temp").style.textAlign = "center";

        dk.taschart.updateDevice(device, "sensor1", device.user.temperature);
    }

    if (device.StatusSNS && device.StatusSNS.SI7021 && device.StatusSNS.SI7021.Humidity)
        device.user.humidity = device.StatusSNS.SI7021.Humidity;
    if (device.user.humidity) {
        let humDirection = " ";
        !device.user.humidityTarget && (device.user.humidityTarget = 50);
        !device.user.humidityZone && (device.user.humidityZone = 20);
        if (device.user.humidity > device.user.humidityTarget) {
            humDirection = "&#8593;"
        }
        if (device.user.humidity < device.user.humidityTarget) {
            humDirection = "&#8595;"
        }
        const humText = "<a id='" + device.ip + "RH'>" + device.user.humidity + " RH%" + humDirection + "</a>";
        const humTargetText = "<a id='" + device.ip + "humTarg'> (" + device.user.humidityTarget + "%)</a>";
        dataCell.innerHTML = dataCell.innerHTML + humTargetText + " " + humText + "<br>";

        const humScale = 510;
        const humDiff = (Math.abs(device.user.humidityTarget - device.user.humidity) * 5);
        const humNum = (humDiff * humScale / 100);
        const humRed = humNum.clamp(0, 255);
        const humGreen = (510 - humNum).clamp(0, 255);
        byId(device.ip + "RH").style.color = "rgb(" + humRed + "," + humGreen + ",0)";
        byId(device.ip + "RH").style.textAlilgn = "center";

        dk.taschart.updateDevice(device, "sensor2", device.user.humidity);
    }

    if (device.StatusSNS && device.StatusSNS.SI7021 && device.StatusSNS.SI7021.DewPoint)
        device.user.dewpoint = device.StatusSNS.SI7021.DewPoint;
    if (device.user.dewpoint) {
        const dewPointText = "<a id='" + device.ip + "DewP'>" + device.user.dewpoint + " DP &#176;F</a>";
        dataCell.innerHTML = dataCell.innerHTML + dewPointText;
        byId(device.ip + "DewP").style.color = "rgb(40,40,40)";
        byId(device.ip + "DewP").style.textAlign = "center";
        dk.taschart.updateDevice(device, "sensor3", device.user.dewpoint);
    }

    if (device.user.automate === true) {
        byId(device.ip + "automate").src = "DKTasmota/automateON.png";
    } else {
        byId(device.ip + "automate").src = "DKTasmota/automateOFF.png";
    }

    const deviceRssi = device.StatusSTS.Wifi.RSSI;
    if (deviceRssi) {
        const signal = deviceRssi;
        const scale = 510;
        const num = (signal * scale / 100);
        const green = num.clamp(0, 255);
        const red = (510 - num).clamp(0, 255);
        const wifiCell = dk.table.getCellByName(dk.table.table, device.ip, "wifi");
        wifiCell.innerHTML = signal + "%";
        wifiCell.style.color = "rgb(" + red + "," + green + ",0)";
    }

    (data !== '{"Restart":"Restarting"}') && (byId(device.ip + "restart").src = "DKGui/restart.png");
}

DUKTAPE && myapp.loadFiles();
