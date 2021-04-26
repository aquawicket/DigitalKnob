"use strict";

dk.file = new Object;

if (!dk.hasCPP()) {
    dk.file.chDir = function dk_file_chDir() {
        return warn("dk.file.chDir(): not available for " + dk.getBrowser());
    }
    dk.file.copyFolder = function dk_file_copyFolder(src, dst, overwrite, recursive) {
        return warn("dk.file.copyDirectory(): not available for " + dk.getBrowser());
    }
    dk.file.getExeName = function dk_file_getExeName() {
        return warn("dk.file.getExeName(): not available for " + dk.getBrowser());
    }
    dk.file.getFullExeName = function dk_file_getFullExeName() {
        return warn("dk.file.getFullExeName(): not available for " + dk.getBrowser());
    }
    dk.file.getModifiedTime = function dk_file_getModifiedTime() {
        return warn("dk.file.getModifiedTime(): not available for " + dk.getBrowser());
    }
    dk.file.getShortName = function dk_file_getShortName() {
        return warn("dk.file.getShortName(): not available for " + dk.getBrowser());
    }
    dk.file.mkDir = function dk_file_mkDir() {
        return warn("dk.file.mkDir(): not available for " + dk.getBrowser());
    }
    dk.file.getDrives = function dk_file_getDrives() {
        return warn("dk.file.getDrives(): not available for " + dk.getBrowser());
    }
}

dk.file.init = function dk_file_init() {
    dk.file.appFilename = "";
    dk.file.localAssets = "";
    dk.file.onlineAssets = "";
    dk.php.call("GET", "/DKFile/DKFile.php", "getAssetsPath", function dk_php_getAssetsPath_callback(rval) {
        rval && (dk.file.onlineAssets = rval) && console.debug("dk.file.onlineAssets = " + rval);
    });
}

dk.file.pushDKAssets = function dk_file_pushDKAssets() {
    console.log("Pushing assets to local repository");
    dk.php.call("POST", "/DKFile/DKFile.php", "pushDKAssets", function dk_php_pushDKAssets_callback(rval) {
        rval && console.log(rval) && console.log("done copying assets");
    });
}

dk.file.urlExists = function dk_file_urlExists(url, callback, usePhp) {
    if (!usePhp) {
        dk.sendRequest(url, function dk_sendRequest_callback(success, url, rval) {
            if (!callback)
                return error("callback invalid");
            if (success && url && rval && callback)
                callback(true);
            else if (!rval && callback)
                callback && callback(false);
            else
                return error("Unexpected Result: rval = " + rval);

        }, "HEAD");
    } else {
        dk.php.call("POST", "/DKFile/DKFile.php", "urlExists", url, function dk_php_urlExists_callback(rval) {
            if (!callback)
                return error("callback invalid");
            if (rval == "1" && callback)
                callback(true);
            else if (!rval && callback)
                callback && callback(false);
            else
                return error("Unexpected Result: rval = " + rval);
        });
    }
}

if (!dk.hasCPP()) {
    dk.file.getShortName = function dk_file_getShortName(path) {
        return warn("dk.file.GetShortName(): not available for browser");
    }
} else {
    dk.file.getShortName = function dk_file_getShortName(path) {
        return CPP_DKFile_GetShortName(path);
    }
}

if (!dk.hasCPP()) {
    dk.file.rename = function dk_file_rename(oldvalue, newvalue, overwrite) {
        return warn("dk.file.Rename(): not implemented for browser");
    }
} else {
    dk.file.rename = function dk_file_rename(oldvalue, newvalue, overwrite) {
        return CPP_DKFile_Rename(oldvalue, newvalue, overwrite);
    }
}

if (!dk.hasCPP()) {
    dk.file.exists = function dk_file_exists(path, callback) {
        if (!path)
            return error("path invalid");
        dir = dk.file.getAbsolutePath(path);
        if (dk.file.isDirectory(dir)) {
            callback && callback(true);
            return true;
        }
        dk.file.urlExists(path, function(rval) {
            callback && callback(rval);
            return rval;
        });
    }
}

//FIXME
dk.file.verifyPath = function dk_file_verifyPath(path) {
    return warn("FIXME: dk.file.verifyPath(" + path + ")");
    if (!path)
        return error("path invalid");
    console.log("dk.file.verifyPath(" + path + "): checking " + path);
    if (dk.file.exists(path)) {
        console.log("dk.file.verifyPath(" + path + "): Found " + path);
        return path;
    }

    var assets = DKAssets_LocalAssets();
    console.log("dk.file.VerifyPath(" + path + "): checking " + assets + path);
    if (dk.file.Exists(assets + path)) {
        console.log("dk.file.VerifyPath(" + path + "): Found " + assets + path);
        return assets + path;
    }

    return error("dk.file.verifyPath(" + path + ") Cannot find " + path);
}

dk.file.printFiles = function dk_file_printFiles() {
    return ajaxGetUrl(dk.file.onlineAssets + "/DKFile/DKFile.php?PrintFiles=1");
}

dk.file.getFilename = function dk_file_getFilename(path) {
    if (!path)
        return error("path invalid");
    var n = path.lastIndexOf("/");
    var out = path.substring(n + 1, path.length);
    //console.log("dk.file.GetFileName("+path+") -> "+out)
    return path.substring(n + 1, path.length);
}

dk.file.saveFile = function dk_file_saveFile(path, data) {//var send = phpurl;
//if(realpath){
//var filename = dk.file.GetFilename(path);
//path = realpath+path;
//}
//path = path.replace(datapath, realpath);
//path = path.replace(dk.file.onlineAssets, realpath);
//path = realpath+path;

//console.log("dk.file.SaveFile: "+path);
/*
    let send = dk.file.onlineAssets + "\\DKFile\\DKFile.php?SaveFile=";
    send += path;
    send += "&data="
    send += data;

    dk.php.stringToFile(path, data, "OVERWRITE", function(rVal) {
        console.log("characters written: " + rVal);
    });
    */

/*
    dk.sendRequest(send, function dk_sendRequest_callback(success, url, data){
        console.log("dk_sendRequest_callback(): success = "+success);
        //console.log("dk_sendRequest_callback(): url = "+url);
        console.log("dk_sendRequest_callback(): data = "+data);
    });
    */

//var response = ajaxGetUrl(send);
//console.log(response);

//FIXME
//if(response.indexOf("console.error") !== -1){
//	return false;
//}
//console.log("Saved file: " + path);
//return true;
}

if (!dk.hasCPP()) {
    dk.file.getSetting = function dk_file_getSetting(file, param) {
        //file is ignored in browser. We use cookie instead.
        if (!file) {
            return getCookie(param);
        } else {
            //If the variable looks like this: [VARIABLE]
            //then we return everything up to the next [VARIABLE] or to the end of the file.
            var str = dk.fileToString(file);
            if (!str)
                return "";
            if (param.indexOf("[") !== -1 && param.indexOf("]") !== -1) {
                var begin = str.indexOf(param);
                if (begin === -1)
                    return "";
                var start = str.indexOf("]", begin);
                var end = str.indexOf("[", start);
                if (end === -1)
                    end = str.length;
                var out = str.substr(start + 1, end - start - 1);
                replace(out, "\r", "");
                replace(out, "\n", " ");
                out = out.trim();
                return out;
            }

            //If the variable looks like this:  VARIABLE 
            //then we return the rest of the line
            var string = param + " ";
            var begin = str.indexOf(string, 0);
            if (begin === -1)
                return "";
            var start = str.indexOf(" ", begin);
            var end = str.indexOf("\n", start);
            var out = filestring.substr(start + 1, end - start - 1);
            replace(out, "\r", "");
            replace(out, "\n", "");
            out = out.trim();
            return out;
        }
    }
}

if (!dk.hasCPP()) {
    dk.file.setSetting = function dk_file_setSetting(file, param, value) {
        //file is ignored in browser. We use cookie instead.
        if (!file) {
            setCookie(param, value, 9999);
        } else {
            var path = file;
            //if(!DKAssets::VerifyPath(path)){ return false;}

            var filestring = dk.file.FileToString(path);
            if (!filestring)
                return error("filestring invalid");
            //If the variable looks like this: [VARIABLE]
            //then we return everything up to the next [VARIABLE] or to the end of the file.
            if (param.indexOf("[") !== -1 && param.indexOf("]") !== -1) {
                var begin = filestring.indexOf(param);
                if (begin === -1) {
                    filestring = filestring.concat("\n" + param + " " + value);
                    //create entry
                    dk.file.stringToFile(filestring, path);
                    console.log("WROTE: " + filestring + " TO: " + path);
                    return true;
                }
                var start = filestring.indexOf("]", begin);
                var end = filestring.indexOf("[", start);
                if (end === -1)
                    end = filestring.length;
                var out = " " + value;
                var oldstr = filestring.substr(start + 1, end - start - 1);
                filestring = replace(filestring, oldstr, out);
                dk.file.stringToFile(filestring, path);
                console.log("WROTE: " + filestring + " TO: " + path);
                return true;
            }

            //If the variable looks like this:  VARIABLE 
            //then we return the rest of the line
            var string = setting + " ";
            var begin = filestring.indexOf(string, 0);
            if (temp === -1) {
                filestring = filestring.concat("\n" + setting + " " + value);
                //create entry
                dk.file.stringToFile(filestring, file);
                console.log("WROTE: " + filestring + " TO: " + file);
                return true;
            }
            var start = filestring.indexOf(" ", begin);
            var end = filestring.indexOf("\n", start);
            var oldstr = filestring.substr(start + 1, end - start - 1);
            filestring.replace(filestring, oldstr, value);
            dk.file.stringToFile(filestring, file);
            console.log("WROTE: " + filestring + " TO: " + file);
            return true;
        }
    }
}

dk.file.fileToString = function dk_file_fileToString(url) {
    if (typeof absolutepath !== "undefined")
        url = url.replace(absolutepath, "");
    //var path = dk.file.VerifyPath(url);
    if (!url)
        return error("url invalid");
    //if(url.indexOf("http") > -1 && url.indexOf("digitalknob.com") === -1){
    //	return ajaxGetUrl("http://cors.io/?u="+url);
    //}
    return ajaxGetUrl(url);
}

// dk.file.fileToString(path, callback)
if (!dk.hasCPP()) {
    dk.file.fileToString = function dk_file_fileToString(path, callback) {
        let assets = dk.file.onlineAssets;
        if (!assets)
            return error("assets invalid");
        path = path.replace(" ", "_");
        path = assets + "/" + path;
        dk.php.call('POST', "/DKFile/DKFile.php", "fileToString", path, function(str) {
            callback && callback(str);
        });
    }
} else {
    dk.file.fileToString = function dk_file_fileToString(path, callback) {
        const str = CPP_DKFile_FileToString(path);
        callback && callback(str);
    }
}

// dk.file.stringToFile(str, path, flags, callback)
if (!dk.hasCPP()) {
    dk.file.stringToFile = function dk_file_stringToFile(str, path, flags, callback) {
        let assets = dk.file.onlineAssets;
        if (!assets)
            return error("assets invalid");
        path = path.replace(" ", "_");
        path = assets + "/" + path;
        dk.php.call('POST', "/DKFile/DKFile.php", "stringToFile", path, str, flags, function(rval) {
            callback && callback(rval);
        });
    }
} else {
    dk.file.stringToFile = function dk_file_stringToFile(str, path, flags, callback) {
        const rval = CPP_DKFile_StringToFile(data, path);
        callback && callback(rval);
    }
}

if (!dk.hasCPP()) {
    dk.file.directoryConstnts = function dk_file_directoryContents(url) {
        //TEST
        url = url.replace("http://localhost/", ".");
        //FIXME
        url = url.replace("http://127.0.0.1/", ".");
        //FIXME

        console.debug("dk.file.DirectoryContents(" + url + ")");
        if (url.indexOf(":") > -1)
            return error("url has : character");
        if (!dk.file.onlineAssets)
            return error("dk.file.onlineAssets not set")
        //var assets = DKAssets_LocalAssets();
        //url = url.replace(assets, dk.file.onlineAssets);
        //var path = dk.file.verifyPath(url);
        //if(!path){ return 0; }
        send = dk.file.onlineAssets + "DKFile/DKFile.php?DirectoryContents=" + url;
        console.log("ajaxGetUrl(" + send + ")");
        var result = ajaxGetUrl(send);
        return result;
    }
} else {
    dk.file.directoryContents = function dk_file_directoryContents(url) {
        return CPP_DKFile_DirectoryContents(url)
    }
}

if (!dk.hasCPP()) {
    dk.file.getAbsolutePath = function dk_file_getAbsolutePath(url) {
        if (!url)
            url = "/";
        if (url.includes("file:///"))
            url = pathname;
        url = url.replace(protocol + "//" + hostname + "/", "");
        url = url.replace("//", "/");
        //console.debug("dk.file.getAbsolutePath("+url+")");
        send = dk.file.onlineAssets + "DKFile/DKFile.php?GetAbsolutePath=" + url;
        var result = ajaxGetUrl(send);
        //result = result.replace(protocol+"//"+hostname+"/","");
        //result = result.replace("//","/");
        console.debug("dk.file.getAbsolutePath(" + url + ") -> " + result);
        return result;
    }
} else {
    dk.file.getAbsolutePath = function dk_file_getAbsolutePath(url) {
        return CPP_DKFile_GetAbsolutePath(url)
    }
}

dk.file.getRelativePath = function dk_file_getRelativePath(apath, datapath) {
    //var rpath = apath.replace(pathname,"");
    //var rpath = rpath.replace("/home/content/a/q/u/aquawicket1/html/DigitalKnob.com/DKApp/","");
    //send = dk.file.onlineAssets+"/DKFile/DKFile.php?GetRelativePath="+url;
    //var result = ajaxGetUrl(send);
    //console.log("dk.file.GetRelativePath("+url+") -> "+result);
    return apath;
}

if (!dk.hasCPP()) {
    dk.file.isDirectory = function dk_file_isDirectory(url) {
        send = dk.file.onlineAssets + "/DKFile/DKFile.php?IsDirectory=" + url;
        var result = ajaxGetUrl(send);
        //console.log("dk.file.IsDirectory("+url+") ->"+result);
        if (result === "0")
            return false;
        return true;
    }
} else {
    dk.file.isDirectory = function dk_file_isDirectory(url) {
        return CPP_DKFile_IsDirectory(url);
    }
}

dk.file.getExtention = function dk_file_getExtention(url) {
    var n = url.lastIndexOf(".");
    var out = url.substring(n + 1, url.length);
    return out;
}

if (!dk.hasCPP()) {
    dk.file.delete = function dk_file_delete(url) {
        console.log("Deleting: " + url);
        send = dk.file.onlineAssets + "/DKFile/DKFile.php?Delete=" + url;
        var result = ajaxGetUrl(send);
        return result;
    }
} else {
    dk.file.delete = function dk_file_delete(url) {
        return CPP_DKFile_Delete(url);
    }
}
