"use strict";

dk.php = new DKPlugin("dk_php");

//dk.php.call("GET", "/DK/DK.php", "Function", "args", "args", dk_php_callback);
dk.php.call = function dk_php_call(httpMethod, phpPath, funcName) {
    const args = arguments;
    let dk_php_callback = null;
    if (args && typeof (args[args.length - 1]) === "function")
       dk_php_callback = args[args.length - 1];

    const allowed = ["DK.js", "DKFile.js", "DKDebug.js"];
    const callerFilename = dk.trace && dk.trace.getFilename();
    if (!allowed.includes(callerFilename))
        return error("PHP Permission Denied for " + callerFilename, dk_php_callback);

    if (!phpPath)
        return error("phpPath invalid", dk_php_callback);
    !httpMethod && (httpMethod = "GET");
    if (typeof funcName !== "string")
        return error("funcName invalid", dk_php_callback);

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
    if (location.protocol == "file:") 
        path = "http://"+dk.localIP+":"+dk.port+"/";
    const str = JSON.stringify(jsonData);
    const data = "x=" + encodeURIComponent(str);
    const url = dk.file.validatepath(path + phpPath) + "?" + data;
    const php_error = function php_error(msg, dk_php_callback){ 
        return error(msg, dk_php_callback);
    }
  
    dk.sendRequest(url, function dk_sendRequest_callback(success, url, rval) {

        //rval && console.debug(rval);
        if (!success)
            return error("dk.php.call request failed, is php server running?", dk_php_callback);
        const beforeLastLine = rval.substr(0, rval.lastIndexOf("\n") + 1);
        if (beforeLastLine !== "" && beforeLastLine !== "\n")
            console.log(beforeLastLine);
        const lastLine = rval.substr(rval.lastIndexOf("\n") + 1);
        let rJson;
        try {
            rJson = JSON.parse(lastLine);
        } catch (e) {
            !rval && (rval = e.message);
            return error(rval, dk_php_callback);
        }
        if (!rJson.status)
            return warn("We appear to have gotten JSON compatable data with no status key" + rval, dk_php_callback);
        if (rJson.status !== "success")
            return php_error(rJson.message, dk_php_callback);
        //if (rJson.status === "success" && beforeLastLine !== "" && beforeLastLine !== "\n")
        //    console.log(beforeLastLine);

        dk_php_callback && dk_php_callback(rJson.message);
    }, httpMethod);
}

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
        path = "http://"+dk.localIP+":"dk.port"/"
    }
    const str = JSON.stringify(jsonData);
    //console.log("dk.php.callPhpFunc(): str = "+str);
    const data = "x=" + encodeURIComponent(str);
    //console.log("dk.php.callPhpFunc(): data = "+data);
    const url = path + "DK/DK.php?" + data;
    dk.sendRequest(url, function dk_sendRequest_callback(success, url, rVal) {
        if (args && typeof (args[args.length - 1]) === "function") {
            args[args.length - 1](rVal);
        } else {//console.log(rVal);
        }
    }, "POST");
}
*/
