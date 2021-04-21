"use strict";

dk.php = new Object;

//dk.php.call("GET", "/DK/DK.php", "Function", "args", "args", callback);
dk.php.call = function dk_php_call(httpMethod, phpPath, funcName) {
    //if (typeof phpPath !== "string")
    //    return error("phpPath invalid");
    !httpMethod && (httpMethod = "GET");
    !phpPath && (phpPath = "/DK/DK.php");
    if (typeof funcName !== "string")
        return error("funcName invalid");

    const jsonData = {
        func: funcName,
        args: []
    };
    for (let n = 3; arguments && n < arguments.length; n++) {
        if (typeof (arguments[n]) === "function") {
            continue;
        }
        let newArg = new Object;
        newArg[typeof (arguments[n])] = arguments[n];
        jsonData.args.push(newArg);
    }
    let path = "";
    if (location.protocol == "file:") {
        path = "http://127.0.0.1:8000"
    }
    const str = JSON.stringify(jsonData);
    const data = "x=" + encodeURIComponent(str);
    const url = path + phpPath + "?" + data;
    const args = arguments;
    dk.sendRequest(url, function dk_sendRequest_callback(success, url, rval) {
        if (!success)
            return error("dk.php.call request failed");
        var beforeLastLine = rval.substr(0, rval.lastIndexOf("\n") + 1);
        var lastLine = rval.substr(rval.lastIndexOf("\n") + 1);
        let rJson;
        try {
            rJson = JSON.parse(lastLine);
        } catch {
            return error(rval);
        }
        if (!rJson.status)
            return warn("We appear to have gotten JSON compatable data with no status key" + rval);
        if (rJson.status !== "success")
            return error(rJson.message);
        if (rJson.status === "success" && beforeLastLine !== "")
            // && rJson.message === null)
            console.log(beforeLastLine);
        //&& console.log("rJson.message === null"); 
        if (args && typeof (args[args.length - 1]) === "function")
            args[args.length - 1](rJson.message);
    }, httpMethod);

}

/*
dk.php.debugFunc = function dk_php_debugFunc(callback) {
    dk.php.callPhpFunc(arguments);
}

dk.php.getRemoteAddres = function dk_php_getRemoteAddress(callback) {
    dk.php.callPhpFunc(arguments);
}

dk.php.getRemoteUser = function dk_php_getRemoteUser(callback) {
    dk.php.callPhpFunc(arguments);
}

dk.php.getTime = function dk_php_getTime(callback) {
    dk.php.callPhpFunc(arguments);
}
*/

//dk.php.noCB = function dk_php_noCB(rVal) {}

/*
dk.php.callPhpFunc = function dk_php_callPhpFunc(args) {
    //const args = arguments;
    let func = dk.trace.getCurrentFunctionName(1);
    //const n = func.indexOf("_") + 1;
    //func = func.substring(n, func.length);
    let funcName = func.replace("Object.dk_php_", "");
    const jsonData = {
        func: funcName,
        args: []
    };
    for (let n = 0; args && n < args.length; n++) {
        //console.log(typeof args[n]);
        if (typeof args[n] === "function") {
            continue;
        }
        let newArg = new Object;
        newArg[typeof (args[n])] = args[n];
        jsonData.args.push(newArg);
    }
    let path = "";
    if (location.protocol == "file:") {
        path = "";
        path = "http://127.0.0.1:8000/"
    }
    const str = JSON.stringify(jsonData);
    //console.log("dk.php.callPhpFunc(): str = "+str);
    const data = "x=" + encodeURIComponent(str);
    //console.log("dk.php.callPhpFunc(): data = "+data);
    const url = path + "DK/DK.php?" + data;
    dk.sendRequest(url, function(success, url, rVal) {
        if (args && typeof (args[args.length - 1]) === "function") {
            args[args.length - 1](rVal);
        } else {//console.log(rVal);
        }
    }, "POST");
}
*/
