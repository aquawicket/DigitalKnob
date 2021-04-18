"use strict";

const dkdebug = new Object;
dkdebug.keyHistory = new Array;

////////////////////////////////////
///  A Convienient Debug Function
///////////////////////////////////
dkdebug.debug = function dkdebug_debug() {
    console.log("dkdebug.debug");

    //console.log("Multiple styles: %cred %corange", "color: red", "color: orange", "Additional unformatted message");
    //dkcodemirror.Create();
    
    //throw new Error( 'No worries. Just testing...' );
    /*
    if(1){
        return error("testing errors");
    }
    */
    
    /*
    DKPhp_Call("Debug_Func", "one", "two", "three", function(rval){
        console.log(rval);
    });
    */
    

    //HP_Debug_Func("one", "two", "three", function(rval) {
    //    console.log(rval);
    //});
    

    /*
    PHP_GetRemoteAddress(function(rval) {
        console.log(rval);
    });
    */

    /*
    const test = document.createElement("div");
    test.id = "test";
    test.style.width = "300rem";
    test.style.height = "300rem";
    test.style.backgroundColor = "rgb(0,0,0)";
    document.body.appendChild(test);
    DKFrame_Html("test");
    */

    //var result =  1+11+8*9+2/14*8-4;
    //console.log("it's "+result+" ...  computers never lie");

    /*
    DKGui_ConfirmBox("do this?", function(){
        console.log("confirm callback");
    });
    */

    /*
    const resizableDiv = document.createElement("div");
    resizableDiv.style.width = "5rem";
    resizableDiv.style.height = "5rem";
    resizableDiv.style.resize = "both";
    resizableDiv.style.overflow = "auto";
    resizableDiv.style.border = "solid 2rem blue";
    document.body.appendChild(resizableDiv);
    DKDrag_AddResizeHandler(resizableDiv, function(){
        console.info("resized: x:"+resizableDiv.style.width+" y:"+resizableDiv.style.height);
    });
    //only works on window object
    //resizableDiv.onresize = function() {
    //    console.info("resized: x:" + resizableDiv.style.width + " y:" + resizableDiv.style.height);
    //}
    */

    /*
    //Update time on all devices
    const dateInMilliseconds = GetDateInMilliseconds();
    for (let n = 0; n < devices.length; n++) {
        const cmnd = "timezone -7";
        const url = "http://" + devices[n].ip + "/cm?cmnd=" + encodeURIComponent(cmnd).replace(";", "%3B");
        DK_SendRequest(url, function(success, url, data) {//console.log("DK_SendRequest("+success+","+url+","+data+")");
        });

        cmnd = "time 4 " + dateInMilliseconds;
        url = "http://" + devices[n].ip + "/cm?cmnd=" + encodeURIComponent(cmnd).replace(";", "%3B");
        DK_SendRequest(url, function(success, url, data) {
            console.log("DK_SendRequest(" + success + "," + url + "," + data + ")");
        });
    }
    */

    /*
    //Get time from all devices
    for (let n = 0; n < devices.length; n++) {
        const cmnd = "time";
        const url = "http://" + devices[n].ip + "/cm?cmnd=" + encodeURIComponent(cmnd).replace(";", "%3B");
        DK_SendRequest(url, function(success, url, data) {
            //console.log("DK_SendRequest("+success+","+url+","+data+")");
            console.log("" + data + "");
        });
    }
    */

    //DKCreateFramedWindow("testWindow", 300, 300);

    /*
    // Test console
    console.log("console.log Test");
    console.log("console.log Test");
    console_log("console_log Test");
    */

    /*
    //Test PHP functions
    PHP_StringToFile("test.txt", "Appended string\n", "FILE_APPEND", function(rVal) {
        console.log("characters written: " + rVal);
    });
    PHP_GetTime(function(rVal) {
        console.log(rVal);
    });
    */

    /*
    //FindObject() Test
    const keyName = 'lastName'
    const obj = {
        firstName: 'allan',
        lastName: 'smith'
    }
    FindObject(obj, keyName, "smith");
    const keyName2 = 'ip';
    FindObject(devices, keyName2, "test");
    */

    /*
    //Test only pushing new values to objects
    const data1 = {
        a: 1,
        b: 2,
        c: 3
    };
    const data2 = {
        a: 1,
        bb: 2,
        c: 3,
        e: "temp",
        f: null
    };

    let myData = [];
    const onDataReceived = function(input) {
        if (myData.length) {
            for (let value in input) {
                let skipUndefineds = (myData.length - 1);
                while (skipUndefineds && !myData[skipUndefineds][value]) {
                    skipUndefineds--;
                }
                if (myData[skipUndefineds][value] === input[value]) {
                    //This variable is the same value as it's last occurence, there is no need to store it"
                    //Let's just remove it before we save the object to save space"
                    delete input[value];
                }
            }
        }
        myData.push(input);
    }
    */
}


dkdebug.init = function dkdebug_init() {
    document.addEventListener("keydown", dkdebug.onevent);
}

dkdebug.end = function dkdebug_end() {
    document.removeEventListener("keydown", dkdebug.onevent);
}

dkdebug.onevent = function dkdebug_onevent(event) {
    if (event.type === "keydown") {
        console.log("keydowwn");
        dkdebug_logKey(event.code);
        dkdebug_checkKeys();
    }

    if (event.type === "keydown" && event.code === "F12") {
        if (typeof dkcef.showDevTools === 'function') {
            dkcef.showDevTools(0);
        }
        if (typeof dkrml.debuggerOn === 'function') {
            dkrml.debuggerOn();
        }
    }
}

dkdebug.logKey = function dkdebug_logKey(code) {
    if (dkdebug.keyHistory.length > 20) {
        dkdebug.keyHistory.shift();
    }
    dkdebug.keyHistory[dkdebug.keyHistory.length] = code;
}

dkdebug.checkKeys = function dkdebug_checkKeys() {
    var string;
    for (var n = 0; n < dkdebug.keyHistory.length; n++) {
        string += dkdebug_keyToChar(dkdebug.keyHistory[n]);
    }

    //check for commands
    if (string.indexOf("dkreload") !== -1) {
        console.log("*** dkdebug_Refresh() ***");
        dkdebug_refresh();
        dkdebug.keyHistory = [];
    }
    if (string.indexOf("dkpush") !== -1) {
        console.log("*** dkdebug.pushDKFiles() ***");
        dkdebug_pushDKFiles();
        dkdebug.keyHistory = [];
    }
    if (string.indexOf("dkclear") !== -1) {
        console.log("*** dkdebug.clearConsole() ***");
        dkdebug_clearConsole();
        dkdebug.keyHistory = [];
    }
    if (string.indexOf("console.log") !== -1) {
        console.log("*** dkdebug.printInfo() ***");
        dkdebug_printInfo();
        dkdebug.keyHistory = [];
    }
    if (string.indexOf("dkconsole") !== -1) {
        console.log("*** dkdebug.shoeConsole() ***");
        dkdebug_showConsole();
        dkdebug.keyHistory = [];
    }
    if (string.indexOf("dksource") !== -1) {
        console.log("*** dkdebug.getSource() ***");
        dkdebug_getSource();
        dkdebug.keyHistory = [];
    }
    if (string.indexOf("dkcrash") !== -1) {
        console.log("*** dkdebug.crash() ***");
        dkdebug_crash();
        dkdebug.keyHistory = [];
    }
    if (string.indexOf("dkeditor") !== -1) {
        console.log("*** dkdebug.editor() ***");
        dkdebug_editor();
        dkdebug.keyHistory = [];
    }
    if (string.indexOf("dkdebug") !== -1) {
        console.log("*** dkdebug.debugger() ***");
        dkdebug_debugger();
        dkdebug.keyHistory = [];
    }
}

dkdebug.keyToChar = function dkdebug_keyToChar(key) {
    if (key === "KeyA")
        return "a"
    if (key === "KeyB")
        return "b"
    if (key === "KeyC")
        return "c"
    if (key === "KeyD")
        return "d"
    if (key === "KeyE")
        return "e"
    if (key === "KeyF")
        return "f"
    if (key === "KeyG")
        return "g"
    if (key === "KeyH")
        return "h"
    if (key === "KeyI")
        return "i"
    if (key === "KeyJ")
        return "j"
    if (key === "KeyK")
        return "k"
    if (key === "KeyL")
        return "l"
    if (key === "KeyM")
        return "m"
    if (key === "KeyN")
        return "n"
    if (key === "KeyO")
        return "o"
    if (key === "KeyP")
        return "p"
    if (key === "KeyQ")
        return "q"
    if (key === "KeyR")
        return "r"
    if (key === "KeyS")
        return "s"
    if (key === "KeyT")
        return "t"
    if (key === "KeyU")
        return "u"
    if (key === "KeyV")
        return "v"
    if (key === "KeyW")
        return "w"
    if (key === "KeyX")
        return "x"
    if (key === "KeyY")
        return "y"
    if (key === "KeyZ")
        return "z"
    return false;
}

dkdebug.reload = function dkdebug_reload() {
    window.location.reload(true);
}

dkdebug.refresh = function dkdebug_refresh() {
    window.location.reload(true);
}

dkdebug.pushDkFiles = function dkdebug_pushDKFiles() {
    var assets = CPP_DKAssets_LocalAssets();
    if (!assets) {
        console.error("assets is invalid");
        return false;
    }
    console.log("assets = " + assets);
    var search = assets;
    while (!CPP_DKFile_Exists(search + "/DK/DKPlugins")) {
        var n = search.lastIndexOf("/");
        if (n === -1) {
            return error("could not locate a DKPlugins folder");
        }
        search = search.substring(0, n);
        console.log(search + "");
    }
    DKPATH = search;
    if (!CPP_DKFile_Exists(DKPATH)) {
        return error("Could not find search");
    }
    var temp = CPP_DKFile_DirectoryContents(DKPATH);
    if (!temp) {
        console.log("dkdebug_PushDKFiles() variable temp is invalid");
        return false;
    }
    var folders = temp.split(",");
    var plugin_folders = [];
    plugin_folders.push(DKPATH + "/DK/DKPlugins");
    for (var n = 0; n < folders.length; n++) {
        if (CPP_DKFile_Exists(DKPATH + "/" + folders[n] + "/DKPlugins"))
            plugin_folders.push(DKPATH + "/" + folders[n] + "/DKPlugins");
    }
    for (var n = 0; n < plugin_folders.length; n++) {
        plugin_folders[n] = CPP_DKFile_GetAbsolutePath(plugin_folders[n]);
    }
    var temp = CPP_DKFile_DirectoryContents(assets);
    if (!temp) {
        return error("temp is invalid");
    }
    var folders = temp.split(",");
    for (var n = 0; n < folders.length; n++) {
        for (var nn = 0; nn < plugin_folders.length; nn++) {
            if (CPP_DKFile_Exists(plugin_folders[nn] + "/" + folders[n])) {
                CPP_DKFile_CopyFolder(assets + "/" + folders[n], plugin_folders[nn] + "/" + folders[n], true, true);
            }
        }
    }
}

dkdebug.clearConsole = function dkdebug_clearConsole() {
    var api;
    if (typeof console === 'undefined')
        return error("console invalid");
    if (typeof console._commandLineAPI !== 'undefined') {
        api = console._commandLineAPI;
        //chrome
    } else if (typeof console._inspectorCommandLineAPI !== 'undefined') {
        api = console._inspectorCommandLineAPI;
        //Safari
    } else if (typeof console.clear !== 'undefined') {
        api = console;
    }
    api.clear();
}

dkdebug.printInfo = function dkdebug_printInfo() {
    console.log("\n");
    console.log("**** DKOBJECTS ****");
    var objects = DK_GetObjects();
    var arry = objects.split(",");
    for (var n = 0; n < arry.length; n++) {
        if (!arry[n]) {
            continue;
        }
        console.log(arry[n]);
    }
    console.log("\n");

    console.log("**** DKEVENTS ****");
    var events = DK_GetEvents();
    var arry = events.split(",");
    for (var n = 0; n < arry.length; n++) {
        if (!arry[n]) {
            continue;
        }
        console.log(arry[n]);
    }
    console.log("\n");

    console.log("**** DKEVENTS ****");
    var events = DK_GetFunctions();
    var arry = events.split(",");
    for (var n = 0; n < arry.length; n++) {
        if (!arry[n])
            continue;
        console.log(arry[n]);
    }
    console.log("\n");
}

dkdebug.function = function dkdebug_showConsole() {
    DK_ShowConsole();
}

dkdebug.getSource = function dkdebug_getSource() {
    DK_Create("DKWidgetJS");
    var source = document.documentElement.outerHTML;
    var assets = CPP_DKAssets_LocalAssets();

    if (DK_GetBrowser() === "RML") {
        CPP_DKFile_StringToFile(source, assets + "Rocket_Source.html");
    } else {
        CPP_DKFile_StringToFile(source, assets + "Browser_Source.html");
    }
}

dkdebug.crashCPP = function dkdebug_crashCPP() {
    CPP_DKDuktape_Crash();
}

dkdebug.crashJS = function dkdebug_crashJS() {
    throw new Error('CRASH TEST');
}

dkdebug.editor = function dkdebug_editor() {
    DK_Create("DKEditor/DKEditor.js", function() {});
}

dkdebug.debugger = function dkdebug_debugger() {
    if (DK_GetBrowser() === "RML" || DK_GetJSEngine() === "Duktape") {
        dkrml.debuggerToggle();
    }
    if (DK_GetBrowser() === "CEF") {
        dkcef.showDevTools(0);
    }
}
