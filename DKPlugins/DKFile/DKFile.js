"use strict";

dk.file = new DKPlugin("dk_file");

dk.file.init = function dk_file_init() {
    dk.file.appFilename = "";
    dk.file.localAssets = "";
    dk.file.onlineAssets = "";
    dk.php.call("GET", "/DKFile/DKFile.php", "getAssetsPath", function dk_php_getAssetsPath_callback(result) {
        (dk.file.onlineAssets = result) && console.debug("dk.file.onlineAssets = " + result);
    });
}

dk.file.makeDir = function dk_file_makeDir(path, mode, recursive, callback) {
    !mode && (mode = "0777");
    !recursive && (recursive = false);
    dk.file.isDir(path, function dk_file_isDir_callback(result) {
        if (result)
            return warn("Directory already exists", callback);
        console.debug("Creating directory " + path);
        dk.php.call("POST", "/DKFile/DKFile.php", "makeDir", path, /*mode, recursive,*/
        function dk_php_pushDKAssets_callback(result) {
            return callback(result);
        });
    });
}

dk.file.pushDKAssets = function dk_file_pushDKAssets(callback) {
    console.log("Pushing assets to local repository");
    dk.php.call("POST", "/DKFile/DKFile.php", "pushDKAssets", function dk_php_pushDKAssets_callback(result) {
        if (!result)
            return error("pushDKAssets failed", callback);
        return callback(result);
    });
}

dk.file.pullDKAssets = function dk_file_pullDKAssets(callback) {
    console.log("Pulling assets from local repository");
    dk.php.call("POST", "/DKFile/DKFile.php", "pullDKAssets", function dk_php_pullDKAssets_callback(result) {
        if (!result)
            return error("pullDKAssets failed", callback);
        return callback(result);
    });
}

dk.file.urlExists = function dk_file_urlExists(url, callback, usePhp) {
    if (!usePhp) {
        dk.sendRequest(url, function dk_sendRequest_callback(success, url, result) {
            if (!callback)
                return error("callback invalid");
            if (success && url && result && callback)
                return callback(result);
            else if (!result)
                return callback(result);
            else
                return error("Unexpected Result: result = " + result, callback);

        }, "HEAD");
    } else {
        dk.php.call("POST", "/DKFile/DKFile.php", "urlExists", url, function dk_php_urlExists_callback(result) {
            if (result == "1")
                return callback(true);
            else if (!result)
                return callback(false);
            else
                return error("Unexpected Result: result = " + result, callback);
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
            return error("path invalid", callback);
        dk.file.getAbsolutePath(path, function dk_file_getAbsolutePath_callback(result) {
            dk.file.isDir(path, function dk_file_isDir_callback(result) {
                if (result)
                    return callback(result);
                dk.file.urlExists(path, function dk_file_urlExists_callback(result) {
                    return callback(result);
                });
            });
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
    return path.substring(n + 1, path.length);
}

/*
dk.file.saveFile = function dk_file_saveFile(path, data) {//var send = phpurl;
//if(realpath){
//var filename = dk.file.GetFilename(path);
//path = realpath+path;
//}
//path = path.replace(datapath, realpath);
//path = path.replace(dk.file.onlineAssets, realpath);
//path = realpath+path;

//console.log("dk.file.SaveFile: "+path);

    let send = dk.file.onlineAssets + "\\DKFile\\DKFile.php?SaveFile=";
    send += path;
    send += "&data="
    send += data;

    dk.php.stringToFile(path, data, "OVERWRITE", function dk.php.stringToFile_callback(result) {
        console.log("characters written: " + result);
    });
    
/*
    dk.sendRequest(send, function dk_sendRequest_callback(success, url, data){
        console.log("dk_sendRequest_callback(): success = "+success);
        //console.log("dk_sendRequest_callback(): url = "+url);
        console.log("dk_sendRequest_callback(): data = "+data);
    });
    

//var response = ajaxGetUrl(send);
//console.log(response);

//FIXME
//if(response.indexOf("console.error") !== -1){
//	return false;
//}
//console.log("Saved file: " + path);
//return true;
}
*/

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
                return error("str invalid");
            if (param.indexOf("[") !== -1 && param.indexOf("]") !== -1) {
                var begin = str.indexOf(param);
                if (begin === -1)
                    return error("begin invalid");
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
                return error("begin invallid");
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

if (!dk.hasCPP()) {
    dk.file.fileToString = function dk_file_fileToString(path, callback) {
        if (location.protocol === "file:") {
            if(!dk.php)
                return error("dk.php invalid", callback);
            if (!dk.file.onlineAssets)
                return error("dk.file.onlineAssets invalid", callback);
                
            //path = path.replace(" ", "_");
            !path.includes(assets) && (path = assets + "/" + path);
            dk.php.call('POST', "/DKFile/DKFile.php", "fileToString", path, function dk_php_call_callback(str) {
                return callback(str);
            });
        } else {
            dk.sendRequest(path, function dk_sendRequest_callback(success, url, data) {
                return callback(data);
            });
        }
    }
} else {
    dk.file.fileToString = function dk_file_fileToString(path, callback) {
        const str = CPP_DKFile_FileToString(path);
        return callback(str);
    }
}
dk.fileToString = dk.file.fileToString;

if (!dk.hasCPP()) {
    dk.file.stringToFile = function dk_file_stringToFile(str, path, flags, callback) {
        if (!dk.php)
            return error("dk.php invalid", callback);
        if (!dk.file.onlineAssets)
            return error("dk.file.onlineAssets invalid", callback);
        //path = path.replace(" ", "_");
        if (!path.includes(dk.file.onlineAssets))
            path = dk.file.onlineAssets + "/" + path;
        dk.php.call('POST', "/DKFile/DKFile.php", "stringToFile", path, str, flags, function dk_php_call_callback(result) {
            return callback(result);
        });
    }
} else {
    dk.file.stringToFile = function dk_file_stringToFile(str, path, flags, callback) {
        const result = CPP_DKFile_StringToFile(data, path);
        return callback(result);
    }
}

if (!dk.hasCPP()) {
    dk.file.directoryContents = function dk_file_directoryContents(path, callback) {
        console.debug("dk.file.DirectoryContents(" + path + ")");
        if (!dk.php)
            return error("dk.php invalid", callback);
        if (!dk.file.onlineAssets)
            return error("dk.file.onlineAssets invalid", callback);

        //path = path.replace("http://localhost/", ".");
        //path = path.replace("http://127.0.0.1/", ".");
        //if (path.indexOf(":") > -1)
        //    return error("path has : character", callback);

        if (!path.includes(dk.file.onlineAssets))
            path = dk.file.onlineAssets + "/" + path;
        dk.php.call('POST', "/DKFile/DKFile.php", "directoryContents", url, function dk_php_call_callback(results) {
            results && console.debug(results);
            return callback(results)
        });
    }
} else {
    dk.file.directoryContents = function dk_file_directoryContents(url) {
        return CPP_DKFile_DirectoryContents(url)
    }
}

if (!dk.hasCPP()) {
    dk.file.getAbsolutePath = function dk_file_getAbsolutePath(url, callback) {
        !url && (url = "/");
        if (url.includes("file:///"))
            url = pathname;
        url = url.replace(location.protocol + "//" + location.hostname + "/", "");
        url = url.replace("//", "/");
        dk.php.call('POST', "/DKFile/DKFile.php", "getAbsolutePath", url, function dk_php_call_callback(results) {
            results && console.debug(results);
            return callback(results)
        });
    }
} else {
    dk.file.getAbsolutePath = function dk_file_getAbsolutePath(url, callback) {
        let result = CPP_DKFile_GetAbsolutePath(url);
        return callback(results)
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
    dk.file.isDir = function dk_file_isDir(url, callback) {
        url = dk.file.onlineAssets + url;
        dk.php.call('GET', "/DKFile/DKFile.php", "isDir", url, function dk_php_call_callback(result) {
            return callback(result);
        });
    }
} else {
    dk.file.isDir = function dk_file_isDir(url, callback) {
        let result = CPP_DKFile_IsDirectory(url);
        return callback(result);
    }
}

dk.file.getExtention = function dk_file_getExtention(url) {
    if (!url)
        return error("url invalid");
    var n = url.lastIndexOf(".");
    var out = url.substring(n + 1, url.length);
    return out;
}

/*
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
*/
