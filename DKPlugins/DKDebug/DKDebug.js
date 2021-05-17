"use strict";

dk.debug = new DKPlugin("dk_debug");

//Error-first callbacks
dk.firstFunc = function dk_firstFunc(str1, str2, callback) {
    console.debug("dk.firstFunc(" + str1 + "," + str2 + ")");
    return dk.secondFunc(str1, str2, function dk_secondFunc_callback(err, result) {
        console.debug("dk.secondFuncCallback(" + err + "," + result + ")");
        if (err) {
            console.error(err.name + " " + err.message);
            return callback(err);
        }
        console.log("the result was " + result);
        return callback(null, result);
    });
    return error("Don't use return without callback");
}
dk.secondFunc = function dk_secondFunc(str1, str2, dk_secondFunc_callback) {
    console.debug("dk.secondFunc(" + str1 + "," + str2 + ")");
    dk.thirdFunc(str1, str2, function dk_thirdFunc_callback(err, result) {
        console.debug("dk.thirdFuncCallback(" + err + "," + result + ")");
        if (err) {
            throw err;
            console.log("dk.secondFunc(): got an error, passing it along");
            return dk_secondFunc_callback(err);
        }
        return dk_secondFunc_callback(null, result);
    });
}
dk.thirdFunc = function dk_thirdFunc(str1, str2, dk_thirdFunc_callback) {
    console.debug("dk.thirdFunc(" + str1 + "," + str2 + ")");
    if (str1 !== str2)
        return dk_thirdFunc_callback(new Error("The strings must match"));
    return dk_thirdFunc_callback(null, (str1 + str2));
}

/*
function err(str) { 
    try { throw new Error(str); } 
    catch(e) { 
        window.lastError = e;
        throw(e);
     };
    //console.log(window.lastError.stack);
}
*/

const require2 = function require2(variable) {
    console.log(variable);
    //if(variable === undefined)
}

const testFunc = function testFunc(needed) {
    require2(needed);
    //console.log(needed);
}

////////////////////////////////////
///  A Convienient Debug Function
///////////////////////////////////
dk.debug.debugFunc = function dk_debug_debugFunc() {
    //console.log("dk.debug.debugFunc");

    testFunc("abc");
    testFunc(123);
    testFunc(true);
    testFunc(false);
    testFunc("This should be seen last");
    testFunc();
    testFunc("SHOULD NOT SEE THIS");

    //theTHins = 100 / 0;
    //err("test error");
    /*
    dk.file.fileToString("/DKInputTest/DKInput.js", function(code){
        dk.testSyntax(code);
    })
    */

    /*
    dk.firstFunc("Don", "Donie", function dk_firstFunc_callback(err, data){
        if(err)
            return error("dk.firstFunc failed");
        console.log("data = "+data);
    });
    */

    //const rtn = dk.file.makeDir("Test", "","", function dk_file_makeDir_callback(result){ console.debug(result); } );

    /*
    //Object by dot path experament
    const OBJ = function OBJ(dotPath) {
        const objstrings = dotPath.split(".");
        console.debug("OBJ(" + dotPath + ")");
        console.debug(objstrings.length + " suspected objects in the path");

        const objs = [window];
        for (let n = 0; n < objstrings.length; n++) {
            //objs.push()
            objs.push(objs[n][objstrings[n]]);
            if (objs[n + 1] === undefined) {
                let errmsg = "";
                for (let nn = 0; nn < n + 1; nn++) {
                    if (nn === n)
                        errmsg += "(";
                    errmsg += objstrings[nn];
                    if (nn === n)
                        errmsg += ")";
                    if (nn < n)
                        errmsg += ".";
                }
                console.log("Error: " + errmsg + " is " + objs[n + 1]);
                return false;
            }
        }
        return objs[objs.length - 1] || true;
    }
    //OBJ("dk.clock.html.style").color = "rgb(0,0,0)";
    OBJ("dk.clock.html2.style.color") && (dk.clock.html.style.color = "rgb(200,0,200)");
    */

    //const clock_face = window['dk']['clock']['html']['innerHTML'];
    //console.log(clock_face);

    /*
    //A typical DKWidget might look something like this. 
    const myObject = new DKWidget("singleton");
    if (!myObject.ok)
        return;

    const myDiv = document.createElement("div");
    myDiv.id = "MyWidget";
    myDiv.style.width = "200px";
    myDiv.style.height = "200px";
    myDiv.style.backgroundColor = "rgb(50,50,50)";

    const text = document.createElement("span");
    text.innerHTML = "some content"
    text.style.position = "absolute";
    text.style.bottom = "60px";
    text.style.right = "70px";
    text.style.color = "rgb(0,0,0)";
    myDiv.appendChild(text);

    myObject.setElement(myDiv);
    dk.frame.create(myObject);
    */

    /*
    dk.console.log("dk.console.log test");
    dk.console.info("dk.console.info test");
    dk.console.debug("dk.console.debug test");
    dk.console.trace("dk.console.trace test");
    dk.console.warn("dk.console.warn test");
    dk.console.error("dk.console.error test");
    console.log("console.log test");
    console.info("console.info test");
    console.debug("console.debug test");
    console.trace("console.trace test", "arg2");
    console.warn("console.warn test");
    console.error("console.error test");
    */

    //Test if a url exists. Can use straight ajax,"thows console error if url does not exist", or php.
    /*
    const usePhp = 1;
    dk.file.urlExists(".", function dk_file_urlExists_callback(rval){
        if(rval)
            console.log("path exists");
        else
            console.log("path does not exist");
    }, usePhp);
    */

    //dk.php.call('GET', "/DKFile/DKFile.php", "DirectoryContents", ".", console.log);

    /*
    let address = "aquawicket@hotmail.com";
    let subject = "Test PHP email";
    let msg = "testing if php mail sending is still successful";
    dk.php.call('GET',"/DK/DK.php", "sendEmail", address, subject, msg, console.log);
    */

    /*
    let path = ".";
    dk.php.call('GET','/DKFile/DKFile.php', 'IsDirectory', path, console.log);
    */

    /*
    let path = ".";
    dk.php.call('GET','/DKFile/DKFile.php', 'IsDirectory', path, function dk_php_call_callback(rval){
        rval && console.debug("true");
        !rval && console.debug("false");
    });
    */

    /*
    let path = "";
    dk.php.call('GET','/DKFile/DKFile.php', 'GetAbsolutePath', path, console.log);
    */

    /*
    let path = "../DK/../";
    dk.php.call('GET','/DKFile/DKFile.php', 'GetRelativePath', path, console.log);
    */

    /*
    let path = ".";
    dk.php.call('GET','/DKFile/DKFile.php', 'PathExists', path, function dk_php_call_callback(rval){
        rval && console.debug("true");
        !rval && console.debug("false");
    });
    */

    /*
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'PHP_SELF', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'GATEWAY_INTERFACE', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SERVER_ADDR', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SERVER_NAME', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SERVER_SOFTWARE', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SERVER_PROTOCOL', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REQUEST_METHOD', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REQUEST_TIME', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REQUEST_TIME_FLOAT', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'QUERY_STRING', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'DOCUMENT_ROOT', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTP_ACCEPT', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTP_ACCEPT_CHARSET', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTP_ACCEPT_ENCODING', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTP_ACCEPT_LANGUAGE', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTP_CONNECTION', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTP_HOST', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTP_REFERER', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTP_USER_AGENT', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'HTTPS', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REMOTE_ADDR', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REMOTE_HOST', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REMOTE_PORT', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REMOTE_USER', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REDIRECT_REMOTE_USER', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SCRIPT_FILENAME', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SERVER_ADMIN', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SERVER_PORT', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SERVER_SIGNATURE', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'PATH_TRANSLATED', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SCRIPT_NAME', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'SCRIPT_URI', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'REQUEST_URI', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'PHP_AUTH_DIGEST', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'PHP_AUTH_USER', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'PHP_AUTH_PW', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'AUTH_TYPE', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'PATH_INFO', console.log);
    dk.php.call('GET','/DKFile/DKFile.php', 'GetServerInfo', 'ORIG_PATH_INFO', console.log);
    */

    //dk.php.call("/DKFile/DKFile.php", "PathExists", "/", function dk_php_call_callback(rval){
    //    rval && console.log(rval);
    //});

    /*
    var varName = "testABC";
    if(dk.validate.isValidVarName(varName)){
        console.log(varName+" is a valid variable name");
    }else{
        console.log(varName+" is NOT a valid variable name");
    }
    */

    /*
    dk.php.call("GET", "/DK/DK.php", "debugFunc", "one", "two", "three", function dk_php_call_callback(rval) {
        console.log(rval);
    });
    */

    //console.log("Multiple styles: %cred %corange", "color: red", "color: orange", "Additional unformatted message");
    //dk.codemirror.Create();

    //throw new Error( 'No worries. Just testing...' );
    /*
    if(1){
        return error("testing errors");
    }
    */

    /*
    dk.php.call("Debug_Func", "one", "two", "three", function dk_php_call_callback(rval){
        console.log(rval);
    });
    */

    /*
    dk.php.debugFunc("one", "two", "three", function dk_php_debugFunc_callback(rval) {
        console.log(rval);
    });
    */

    /*
    dk.php.getRemoteAddress(function dk_php_getRemoteAddress_callback(rval) {
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
    dk.frame.create(test);
    */

    /*
    var result =  1+11+8*9+2/14*8-4;
    console.log("it's "+result+" ...  computers never lie");
    */

    /*
    dk.gui.confirmBox("do this?", function dk_gui_confirmBox(){
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
    DKDrag_AddResizeHandler(resizableDiv, function DKDrag_AddResizeHandler_callback(){
        console.info("resized: x:"+resizableDiv.style.width+" y:"+resizableDiv.style.height);
    });
    //only works on window object
    resizableDiv.onresize = function resizableDiv_onresize_callback() {
        console.info("resized: x:" + resizableDiv.style.width + " y:" + resizableDiv.style.height);
    }
    */

    /*
    //Update time on all Tasmota devices
    const dateInMilliseconds = GetDateInMilliseconds();
    for (let n = 0; n < devices.length; n++) {
        const cmnd = "timezone -7";
        const url = "http://" + devices[n].ip + "/cm?cmnd=" + encodeURIComponent(cmnd).replace(";", "%3B");
        DK_SendRequest("GET", url, function DK_SendRequest_callback(success, url, data) {//console.log("DK_SendRequest("+success+","+url+","+data+")");
        });

        cmnd = "time 4 " + dateInMilliseconds;
        url = "http://" + devices[n].ip + "/cm?cmnd=" + encodeURIComponent(cmnd).replace(";", "%3B");
        DK_SendRequest("GET", url, function DK_SendRequest_callback(success, url, data) {
            console.log("DK_SendRequest(" + success + "," + url + "," + data + ")");
        });
    }
    */

    /*
    //Get time from all Tasmota devices
    for (let n = 0; n < devices.length; n++) {
        const cmnd = "time";
        const url = "http://" + devices[n].ip + "/cm?cmnd=" + encodeURIComponent(cmnd).replace(";", "%3B");
        DK_SendRequest("GET", url, function DK_SendRequest_callback(success, url, data) {
            //console.log("DK_SendRequest("+success+","+url+","+data+")");
            console.log("" + data + "");
        });
    }
    */

    /*
    DKCreateFramedWindow("testWindow", 300, 300);
    */

    /*
    // Test console
    console.log("console.log Test");
    console.log("console.log Test");
    console_log("console_log Test");
    */

    /*
    //Test PHP functions
    dk.php.stringToFile("test.txt", "Appended string\n", "FILE_APPEND", function dk_php_stringToFile_callback(rVal) {
        console.log("characters written: " + rVal);
    });
    dk.php.getTime(function dk_php_getTime_callback(rVal) {
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
    const onDataReceived = function onDataReceived(input) {
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
/////////////////////////////////////////////

dk.debug.init = function dk_debug_init() {
    dk.debug.keyHistory = new Array;
    document.addEventListener("keydown", dk.debug.onevent);
    //DKPlugin.prototype.init.call(this);
}

dk.debug.end = function dk_debug_end() {
    document.removeEventListener("keydown", dk.debug.onevent);
}

dk.debug.onevent = function dk_debug_onevent(event) {
    //console.debug("dk.debug.onevent("+event.code+" "+JSON.stringify(event)+")");
    if (event.type === "keydown") {
        dk.debug.logKey(event.code);
        dk.debug.checkKeys();
    }

    if (event.type === "keydown" && event.code === "F12") {
        if (dk.hasCPP()) {
            if (typeof dkcef.showDevTools === 'function') {
                dkcef.showDevTools(0);
            }
            if (typeof dkrml.debuggerOn === 'function') {
                dkrml.debuggerOn();
            }
        }
    }
}

dk.debug.logKey = function dk_debug_logKey(code) {
    if (dk.debug.keyHistory.length > 20) {
        dk.debug.keyHistory.shift();
    }
    dk.debug.keyHistory[dk.debug.keyHistory.length] = code;
}

dk.debug.checkKeys = function dk_debug_checkKeys() {
    let string = "";
    for (let n = 0; n < dk.debug.keyHistory.length; n++) {
        string += dk.debug.keyToChar(dk.debug.keyHistory[n]);
    }

    //check for commands
    if (string.includes("dkreload")) {
        console.log("*** dk.debug.reload() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.refresh();
    }
    if (string.includes("dkpush")) {
        console.log("*** dk.debug.pushDKFiles() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.pushDKFiles();
    }
    if (string.includes("dkpull")) {
        console.log("*** dk.debug.pullDKFiles() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.pullDKFiles();
    }
    if (string.includes("dkclear")) {
        console.log("*** dk.debug.clearConsole() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.clearConsole();
    }
    if (string.includes("dkinfo")) {
        console.log("*** dk.debug.printInfo() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.printInfo();
    }
    if (string.includes("dkconsole")) {
        console.log("*** dk.debug.showConsole() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.showConsole();
    }
    if (string.includes("dksource")) {
        console.log("*** dk.debug.getSource() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.getSource();
    }
    if (string.includes("dkcrashcpp")) {
        console.log("*** dk.debug.crashCPP() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.crashCPP();
    }
    if (string.includes("dkcrashjs")) {
        console.log("*** dk.debug.crashJS() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.crashJS();
    }
    if (string.includes("dkeditor")) {
        console.log("*** dk.debug.editor() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.editor();
    }
    if (string.includes("dkdebug")) {
        console.log("*** dk.debug.debugger() ***");
        dk.debug.keyHistory.length = 0;
        dk.debug.debugger();
    }
}

dk.debug.keyToChar = function dk_debug_keyToChar(key) {
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

dk.debug.reload = function dk_debug_reload() {
    window.location.reload(true);
}

dk.debug.pushDKFiles = function dk_debug_pushDKFiles() {
    //This is the pure js method
    dk.file.pushDKAssets(function dk_php_pushDKAssetsCallback(rval) {
        console.log(rval);
        console.log("done copying assets");
    });

    /*
    //This is the js->cpp method
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
        console.log("dk.debug.PushDKFiles() variable temp is invalid");
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
    */
}

dk.debug.pullDKFiles = function dk_debug_pullDKFiles() {
    //This is the pure js method
    dk.file.pullDKAssets(function dk_php_pullDKAssetsCallback(rval) {
        console.log(rval);
        console.log("done copying assets");
    });
}

dk.debug.clearConsole = function dk_debug_clearConsole() {
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

dk.debug.printInfo = function dk_debug_printInfo() {
    console.log("\n");
    console.log("**** DKOBJECTS ****");
    var objects = dk.getObjects();
    var arry = objects.split(",");
    for (var n = 0; n < arry.length; n++) {
        if (!arry[n]) {
            continue;
        }
        console.log(arry[n]);
    }
    console.log("\n");

    console.log("**** DKEVENTS ****");
    var events = dk.getEvents();
    var arry = events.split(",");
    for (var n = 0; n < arry.length; n++) {
        if (!arry[n]) {
            continue;
        }
        console.log(arry[n]);
    }
    console.log("\n");

    console.log("**** DKEVENTS ****");
    var events = dk.getFunctions();
    var arry = events.split(",");
    for (var n = 0; n < arry.length; n++) {
        if (!arry[n])
            continue;
        console.log(arry[n]);
    }
    console.log("\n");
}

dk.debug.function = function dk_debug_showConsole() {
    dk.showConsole();
}

dk.debug.getSource = function dk_debug_getSource() {
    dk.create("DKWidgetJS");
    var source = document.documentElement.outerHTML;
    var assets = CPP_DKAssets_LocalAssets();

    if (dk.getBrowser() === "RML") {
        CPP_DKFile_StringToFile(source, assets + "RmlUi_Source.html");
    } else {
        CPP_DKFile_StringToFile(source, assets + "Browser_Source.html");
    }
}

dk.debug.crashCPP = function dk_debug_crashCPP() {
    console.log("dk.debug.crashCPP()");
    CPP_DK_Crash();
}

dk.debug.crashJS = function dk_debug_crashJS() {
    console.log("dk.debug.crashJS()");
    throw new Error('CRASH TEST');
}

dk.debug.editor = function dk_debug_editor() {
    dk.create("DKEditor/DKEditor.js", function dk_create_callback() {});
}

dk.debug.debugger = function dk_debug_debugger() {
    if (dk.getBrowser() === "RML" || dk.getJSEngine() === "Duktape") {
        dkrml.debuggerToggle();
    }
    if (dk.getBrowser() === "CEF") {
        dkcef.showDevTools(0);
    }
}
