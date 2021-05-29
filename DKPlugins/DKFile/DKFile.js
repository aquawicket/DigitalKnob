"use strict";

dk.file = new DKPlugin("dk_file");

dk.file.init = function dk_file_init() {
    dk.file.appFilename = "";
    dk.file.localAssets = "";
    dk.file.onlineAssets = "";
    if (dk.php) {
    dk.php.call("GET", "DKFile/DKFile.php", "getAssetsPath", function dk_php_getAssetsPath_callback(result) {
        (dk.file.onlineAssets = result) && console.debug("dk.file.onlineAssets = " + result);
    });
    }
}

dk.file.validatepath = function dk_file_validatepath(path) {
    //console.log("dk.file.validatepath(" + path + ")");
    if (path.charAt(0) === '/') {
        console.error(path + "  path has / as the first character");
        path = path.replace("/", "");
        //console.debug("AFTER: " + path);
    }
    if (path.includes("\\")) {
        console.error(path + "  path contains \\");
        path = path.split("\\").join("/");
        //console.debug("AFTER: " + path);
    }
    const count = path.split("//").length - 1;
    if (!path.includes("://") && (count > 0)) {
        console.error(path + "  path contains // seperator");
        path = path.split("//").join("/");
        //console.debug("AFTER: " + path);
    }
    if (path.includes("://") && (count > 1)) {
        console.error(path + "  path contains // seperator");
        path = path.split("//").join("/");
        path = path.replace(":/", "://");
        //console.debug("AFTER: " + path);
    }
    //TODO - Check that directory paths end with a /
    return path;
}

dk.file.makeDir = function dk_file_makeDir(path, mode, recursive, callback) {
    path = dk.file.validatepath(path);
    !mode && (mode = "0777");
    !recursive && (recursive = false);
    dk.file.isDir(path, function dk_file_isDir_callback(result) {
        if (result)
            return callback;
        // warn("Directory already exists", callback);
        console.debug("Creating directory " + path);
        dk.php.call("POST", "DKFile/DKFile.php", "makeDir", path, /*mode, recursive,*/
        function dk_php_call_callback(result) {
            return callback(result);
        });
    });
}

dk.file.pushDKAssets = function dk_file_pushDKAssets(callback) {
    console.log("Pushing assets to local repository");
    dk.php.call("POST", "DKFile/DKFile.php", "pushDKAssets", function dk_php_pushDKAssets_callback(result) {
        if (!result)
            return error("pushDKAssets failed", callback);
        return callback(result);
    });
}

dk.file.pullDKAssets = function dk_file_pullDKAssets(callback) {
    console.log("Pulling assets from local repository");
    dk.php.call("POST", "DKFile/DKFile.php", "pullDKAssets", function dk_php_pullDKAssets_callback(result) {
        if (!result)
            return error("pullDKAssets failed", callback);
        return callback(result);
    });
}

dk.file.exists = function dk_file_exists(url, callback, usePhp) {
    url = dk.file.validatepath(url);
    if (!url.includes(dk.file.onlineAssets))
        url = dk.file.onlineAssets + url;
    if (dk.php) {
        dk.php.call("GET", "DKFile/DKFile.php", "exists", url, function dk_php_exists_callback(result) {
            if (result)
                return callback(true);
            else
                return callback(false);
        });
    } else {
        dk.sendRequest("GET", url, function dk_sendRequest_callback(success, url, result) {
            if (success && url && result)
                return callback(true);
            else
                return callback(false);
        });
    }
}

if (!dk.hasCPP()) {
    dk.file.getShortName = function dk_file_getShortName(path) {
        path = dk.file.validatepath(path);
        return warn("dk.file.GetShortName(): not available for browser");
    }
} else {
    dk.file.getShortName = function dk_file_getShortName(path) {
        path = dk.file.validatepath(path);
        return CPP_DKFile_GetShortName(path);
    }
}

if (!dk.hasCPP()) {
    dk.file.rename = function dk_file_rename(oldpath, newpath, overwrite) {
        oldpath = dk.file.validatepath(oldpath);
        newpath = dk.file.validatepath(newpath);
        console.debug("dk.file.rename("+oldpath+","+newpath+","+overwrite+"): not implemented yet");
    }
} else {
    dk.file.rename = function dk_file_rename(path, newvalue, overwrite) {
        path = dk.file.validatepath(path);
        return CPP_DKFile_Rename(path, newvalue, overwrite);
    }
}

//FIXME
/*
dk.file.verifyPath = function dk_file_verifyPath(path) {
    path = dk.file.validatepath(path);
    console.log("dk.file.verifyPath(" + path + ")");
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
*/

//FIXME
/*
dk.file.printFiles = function dk_file_printFiles() {
    return ajaxGetUrl(dk.file.onlineAssets + "DKFile/DKFile.php?PrintFiles=1");
}
*/

dk.file.getFilename = function dk_file_getFilename(path) {
    path = dk.file.validatepath(path);
    var n = path.lastIndexOf("/");
    var out = path.substring(n + 1, path.length);
    return path.substring(n + 1, path.length);
}

/*
dk.file.saveFile = function dk_file_saveFile(path, data) {//var send = phpurl;
path = dk.file.validatepath(path);
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
    dk.sendRequest("GET", send, function dk_sendRequest_callback(success, url, data){
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
        file = dk.file.validatepath(file);
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
        file = dk.file.validatepath(file);
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
        path = dk.file.validatepath(path);
        if (location.protocol === "file:") {
            if (!dk.php)
                return error("dk.php invalid", callback);
            if (!dk.file.onlineAssets)
                return error("dk.file.onlineAssets invalid", callback);
            !path.includes(dk.file.onlineAssets) && (path = dk.file.onlineAssets + path);
            dk.php.call('POST', "DKFile/DKFile.php", "fileToString", path, function dk_php_call_callback(str) {
                if (!str)
                    return error("str invalid", callback(false));
                return callback(str);
            });
        } else {
            dk.sendRequest("GET", path, function dk_sendRequest_callback(success, url, data) {
                if (!data)
                    return error("data invalid", callback(false));
                return callback(data);
            });
        }
    }
} else {
    dk.file.fileToString = function dk_file_fileToString(path, callback) {
        path = dk.file.validatepath(path);
        const str = CPP_DKFile_FileToString(path);
        return callback(str);
    }
}
//Update DK.js to use this function
dk.fileToString = dk.file.fileToString;

if (!dk.hasCPP()) {
    dk.file.stringToFile = function dk_file_stringToFile(str, path, flags, callback) {
        path = dk.file.validatepath(path);
        if (!dk.php)
            return error("dk.php invalid", callback);
        if (!dk.file.onlineAssets)
            return error("dk.file.onlineAssets invalid", callback);
        if (!path.includes(dk.file.onlineAssets))
            path = dk.file.onlineAssets + path;
            //str = dk.stringToBinary(str);
        dk.php.call('POST', "DKFile/DKFile.php", "stringToFile", path, str, flags, function dk_php_call_callback(result) {
            return callback(result);
        });
    }
} else {
    dk.file.stringToFile = function dk_file_stringToFile(str, path, flags, callback) {
        path = dk.file.validatepath(path);
        const result = CPP_DKFile_StringToFile(data, path);
        return callback(result);
    }
}

if (!dk.hasCPP()) {
    dk.file.directoryContents = function dk_file_directoryContents(path, callback) {
        console.debug("dk.file.directoryContents(" + path + ")");
        path = dk.file.validatepath(path);
        dk.php.call('POST', "DKFile/DKFile.php", "directoryContents", path, function dk_php_call_callback(results) {
            return callback(results)
        });
    }
} else {
    dk.file.directoryContents = function dk_file_directoryContents(path) {
        path = dk.file.validatepath(path);
        return CPP_DKFile_DirectoryContents(path);
    }
}

if (!dk.hasCPP()) {
    dk.file.getAbsolutePath = function dk_file_getAbsolutePath(path, callback) {
        path = dk.file.validatepath(path);
        //!path && (path = "/");
        //if (path.includes("file:///"))
        //    path = pathname;
        //path = path.replace(location.protocol + "//" + location.hostname + "/", "");
        path = path.replace("\\", "/");
        path = path.replace("//", "/");
        dk.php.call('GET', "DKFile/DKFile.php", "getAbsolutePath", path, function dk_php_call_callback(aPath) {
            aPath = dk.file.validatepath(aPath);
            return callback(aPath);
        });
    }
} else {
    dk.file.getAbsolutePath = function dk_file_getAbsolutePath(path, callback) {
        path = dk.file.validatepath(path);
        const aPath = CPP_DKFile_GetAbsolutePath(path);
        aPath = dk.file.validatepath(aPath);
        return callback(aPath)
    }
}

if (!dk.hasCPP()) {
    dk.file.getRelativePath = function dk_file_getRelativePath(path, callback) {
        path = dk.file.validatepath(path);
        path = path.replace("\\", "/");
        path = path.replace("//", "/");
        dk.php.call('GET', "DKFile/DKFile.php", "getRelativePath", path, function dk_php_call_callback(rPath) {
            rPath = dk.file.validatepath(rPath);
            return callback(rPath);
        });
    }
} else {
    dk.file.getRelativePath = function dk_file_getRelativePath(path, callback) {
        path = dk.file.validatepath(path);
        const rPath = CPP_DKFile_GetRelativePath(path);
        rPath = dk.file.validatepath(rPath);
        return callback(rPath);
    }
}

dk.file.getPathObject = function dk_file_getPathObject(path, callback) {
    //path = dk.file.validatepath(path);
    //console.debug("original path = \"" + path + "\"");
    dk.php.call('GET', "DKFile/DKFile.php", "getPaths", path, function dk_php_call_callback(_pObj) {
        const pObj = new Object();
        pObj.path = _pObj.split(",")[0];
        pObj.aPath = _pObj.split(",")[1];
        pObj.root = _pObj.split(",")[2];
        pObj.rPath = _pObj.split(",")[3];
        pObj.realpath = _pObj.split(",")[4];
        pObj.dir = _pObj.split(",")[5];
        pObj.basename = _pObj.split(",")[6];
        pObj.extension = _pObj.split(",")[7];
        pObj.filename = _pObj.split(",")[8];
        /*
        console.debug("path = " + pObj.path);
        console.debug("aPath = " + pObj.aPath);
        console.debug("root = " + pObj.root);
        console.debug("rPath = " + pObj.rPath);
        console.debug("realpath = " + pObj.realpath);
        console.debug("dir = " + pObj.dir);
        console.debug("basename = " + pObj.basename);
        console.debug("extension = " + pObj.extension);
        console.debug("filename = " + pObj.filename);
        */
        return callback(pObj);
    });
}

if (!dk.hasCPP()) {
    dk.file.isDir = function dk_file_isDir(path, callback) {
        path = dk.file.validatepath(path);
        dk.php.call('GET', "DKFile/DKFile.php", "isDir", path, function dk_php_call_callback(result) {
            return callback(!!result);
        });
    }
} else {
    dk.file.isDir = function dk_file_isDir(path, callback) {
        path = dk.file.validatepath(path);
        const result = CPP_DKFile_IsDirectory(path);
        return callback(!!result);
    }
}

dk.file.getExtention = function dk_file_getExtention(path) {
    path = dk.file.validatepath(path);
    var n = path.lastIndexOf(".");
    var extention = path.substring(n + 1, path.length);
    return extention;
}

/*
if (!dk.hasCPP()) {
    dk.file.delete = function dk_file_delete(path) {
        path = dk.file.validatepath(path);
        console.log("Deleting: " + path);
        request = dk.file.onlineAssets + "DKFile/DKFile.php?Delete=" + path;
        var result = ajaxGetUrl(request);
        return result;
    }
} else {
    dk.file.delete = function dk_file_delete(path) {
        path = dk.file.validatepath(path);
        return CPP_DKFile_Delete(path);
    }
}
*/
