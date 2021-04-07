"use strict";

function PHP_GetRemoteAddress(callback) {
    DKPhp_CallPhpFunc(arguments);
}

function PHP_GetRemoteUser(callback) {
    DKPhp_CallPhpFunc(arguments);
}

function PHP_GetTime(callback) {
    DKPhp_CallPhpFunc(arguments);
}

function PHP_StringToFile(file, data, mode, callback) {
    DKPhp_CallPhpFunc(arguments);
}

//function DKPhp_noCB(rVal) {}

function DKPhp_CallPhpFunc(args) {
    let func = DKTrace_GetCurrentFunctionName(1);
    const n = func.indexOf("_") + 1;
    func = func.substring(n, func.length);
    const funcName = func.replace("PHP_", "");
    const jsonData = {
        func: funcName,
        args: []
    };
    for (let n = 0; args && n < args.length; n++) {
        if (typeof (args[n]) === "function") {
            continue;
        }
        let newArg = new Object;
        newArg[typeof (args[n])] = args[n];
        jsonData.args.push(newArg);
    }
    //dkconsole.log(JSON.stringify(jsonData));
    const data = "x=" + encodeURIComponent(JSON.stringify(jsonData));
    const url = "DK/DK.php?" + data;
    DK_SendRequest(url, function(success, url, rVal) {
        if (args && typeof (args[args.length - 1]) === "function") {
            args[args.length - 1](rVal);
        } else {//dkconsole.log(rVal);
        }
    });
}

/*
function DKPhp_CallPhpFunction(str, callback) {
    const func = str.split("(").shift();
    str = str.replace(func, "");
    str = str.replace("(", "");
    str = str.replace(")", "");
    const arg = str.split(",");
    const jsonData = {
        func: func,
        args: []
    };
    for (let n = 0; n < arg.length; n++) {
        arg[n] = arg[n].trim();
        let newArg = new Object;
        newArg[typeof (arg[n])] = arg[n];
        jsonData.args.push(newArg);
    }
    const data = "x=" + encodeURIComponent(JSON.stringify(jsonData));
    const url = "http://192.168.1.78:8000/DK/DK.php?" + data;
    DK_SendRequest(url, function(success, url, data) {
        callback(data);
    });
}
*/
