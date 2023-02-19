//"use strict"; //FIXME: "use strict" breaks Duktape
if(DUKTAPE)
	return


function DKPhp(){}

//dk.php = DKPlugin(DKPhp, "singleton") //FIXME: "singleton" breaks Duktape
dk.php = DKPlugin(DKPhp)


// EXAMPLE
//DKPhp.prototype.call("GET", "DK/DK.php", "Function", "args", "args", dkphp_callback);
DKPhp.prototype.call = function DKPhp_call(httpMethod, phpPath, funcName){
    const args = arguments;
    var dkphp_callback = null;
    if (args && typeof (args[args.length - 1]) === "function")
        dkphp_callback = args[args.length - 1];

    /*
    const allowed = ["C", "DK.js", "DKFile.js", "DKJson.js", "DKDebug.js", "DKTrace.js", "DKPlugin.js"];
    const callerFilename = dk.trace && dk.trace.getFilename();
    if (!allowed.includes(callerFilename))
        return error("PHP Permission Denied for " + callerFilename, dkphp_callback);
    */
    
    if (!phpPath)
        return error("phpPath invalid", dkphp_callback);
    !httpMethod && (httpMethod = "GET");
    if (typeof funcName !== "string")
        return error("funcName invalid", dkphp_callback);

    const jsonData = {
        func: funcName,
        args: []
    };
    for (var n = 3; arguments && n < arguments.length; n++){
        if (typeof (arguments[n]) === "function"){
            continue;
        }
        var newArg = new Object;
        newArg[typeof (arguments[n])] = arguments[n];
        jsonData.args.push(newArg);
    }

    var path = "";
    if (location.protocol == "file:" || dk.hasCPP())
        path = "http://127.0.0.1:2393/";
    const str = JSON.stringify(jsonData);
    const data = "dkx=" + encodeURIComponent(str);
    const url = dk.file.validatepath(path + phpPath) + "?" + data;
    const php_error = function php_error(msg, dkphp_callback){
        return error(msg, dkphp_callback);
    }

    dk.sendRequest(httpMethod, url, function dk_sendRequest_callback(success, url, rval){
        if (!success)
            return error("DKPhp.prototype.call request failed, is php server running?", dkphp_callback);
        const beforeLastLine = rval.substr(0, rval.lastIndexOf("\n") + 1);
        if (beforeLastLine !== "" && beforeLastLine !== "\n")
            console.log(beforeLastLine);
        const lastLine = rval.substr(rval.lastIndexOf("\n") + 1);
        var rJson;
        try {
            rJson = JSON.parse(lastLine);
        } catch (e){
            !rval && (rval = e.message);
            return error(rval, dkphp_callback);
        }
        if (!rJson.status)
            return warn("We appear to have gotten JSON compatable data with no status key" + rval, dkphp_callback);
        if (rJson.status !== "success")
            return php_error(rJson.message, dkphp_callback);
        //if (rJson.status === "success" && beforeLastLine !== "" && beforeLastLine !== "\n")
        //    console.log(beforeLastLine);
        return dkphp_callback && dkphp_callback(rJson.message);
    });
    return true;
}

//Todo - listen for broadcast messaged from php 
DKPhp.prototype.listen = function DKPhp_listen(){
}

//DKPhp.prototype.noCB = function DKPhp_noCB(rVal){}

/*
DKPhp.prototype.callPhpFunc = function DKPhp_callPhpFunc(args){
    //const args = arguments;
    var func = dk.trace.getCurrentFunctionName(1);
    //const n = func.indexOf("_") + 1;
    //func = func.substring(n, func.length);
    var funcName = func.replace("Object.DKPhp_", "");
    const jsonData = {
        func: funcName,
        args: []
    };
    for (var n = 0; args && n < args.length; n++){
        //console.log(typeof args[n]);
        if (typeof args[n] === "function"){
            continue;
        }
        var newArg = new Object;
        newArg[typeof (args[n])] = args[n];
        jsonData.args.push(newArg);
    }
    var path = "";
    if (location.protocol == "file:"){
        path = "";
        path = "http://"+dk.localIP+":"dk.port"/"
    }
    const str = JSON.stringify(jsonData);
    //console.log("DKPhp.prototype.callPhpFunc(): str = "+str);
    const data = "dkx=" + encodeURIComponent(str);
    //console.log("DKPhp.prototype.callPhpFunc(): data = "+data);
    const url = path + "DK/DK.php?" + data;
    dk.sendRequest("POST", url, function dk_sendRequest_callback(success, url, rVal){
        if (args && typeof (args[args.length - 1]) === "function"){
            args[args.length - 1](rVal);
        } else {//console.log(rVal);
        }
    });
}
*/
