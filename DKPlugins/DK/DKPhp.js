//"use strict";

dk.php = new Object;

//dk.php.call("GET", "/DK/DK.php", "Function", "args", "args", callback);
dk.php.call = function dk_php_call(httpMethod, phpPath, funcName) {
    const args = arguments;
    let callback = null;
    if (args && typeof (args[args.length - 1]) === "function")
       callback = args[args.length - 1];

    const allowed = ["DK.js", "DKFile.js", "DKDebug.js"];
    const callerFilename = dk.trace && dk.trace.getFilename();
    if (!allowed.includes(callerFilename))
        return error("PHP Permission Denied for " + callerFilename, callback);

    if (!phpPath)
        return error("phpPath invalid", callback);
    !httpMethod && (httpMethod = "GET");
    if (typeof funcName !== "string")
        return error("funcName invalid", callback);

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
        path = "http://"+dk.localIP+":"+dk.port;
    const str = JSON.stringify(jsonData);
    const data = "x=" + encodeURIComponent(str);
    const url = path + phpPath + "?" + data;
    const php_error = function(msg, callback){ 
        return error(msg, callback);
    }
  
    dk.sendRequest(url, function dk_sendRequest_callback(success, url, rval) {

        //rval && console.debug(rval);
        if (!success)
            return error("dk.php.call request failed, is php server running?", callback);
        const beforeLastLine = rval.substr(0, rval.lastIndexOf("\n") + 1);
        if (beforeLastLine !== "" && beforeLastLine !== "\n")
            console.log(beforeLastLine);
        const lastLine = rval.substr(rval.lastIndexOf("\n") + 1);
        let rJson;
        try {
            rJson = JSON.parse(lastLine);
        } catch (e) {
            !rval && (rval = e.message);
            return error(rval, callback);
        }
        if (!rJson.status)
            return warn("We appear to have gotten JSON compatable data with no status key" + rval, callback);
        if (rJson.status !== "success")
            return php_error("php: " + rJson.message, callback);
        //if (rJson.status === "success" && beforeLastLine !== "" && beforeLastLine !== "\n")
        //    console.log(beforeLastLine);

        callback && callback(rJson.message);
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
    dk.sendRequest(url, function(success, url, rVal) {
        if (args && typeof (args[args.length - 1]) === "function") {
            args[args.length - 1](rVal);
        } else {//console.log(rVal);
        }
    }, "POST");
}
*/
