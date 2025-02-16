//NOTE: use string removed for Duktape to work
//"use strict";

//NOTE: initiator moved to the bottom and "singleton" removed for Duktape to work
//dk.file = DKPlugin(DKFile)

function DKFile(){}
dk.file = DKPlugin(DKFile)


DKFile.prototype.init = function DKFile_init() {
    //lets replace DK.js's version of fileToString to this one
    //if (!DUKTAPE)
        dk.fileToString = dk.file.fileToString;

    this.appFilename = "";
    this.localAssets = "";
    this.onlineAssets = "";

    // FIXME - temporary
    if (DUKTAPE) {
        this.onlineAssets = //"C:/DKTasmota_Data/";
		console.log("look at DKFile.js line 23")
        return;
    }
    if (dk.php) {
        dk.php.call("GET", "DKFile/DKFile.php", "getAssetsPath", function dk_php_getAssetsPath_callback(result) {
            (dk.file.onlineAssets = result)
            //&& console.debug("dk.file.onlineAssets = " + result);
        });
    }
}

DKFile.prototype.validatepath = function DKFile_validatepath(path) {
    /*
	if (path.charAt(0) === '/') {
        console.error(path + "  path has / as the first character");
        path = path.replace("/", "");
    }
	*/
    if (path.includes("\\")) {
        console.error(path + "  path contains \\");
        path = path.split("\\").join("/");
    }
    const count = path.split("//").length - 1;
    if (!path.includes("://") && (count > 0)) {
        console.error(path + "  path contains // seperator");
        path = path.split("//").join("/");
    }
    if (path.includes("://") && (count > 1)) {
        console.error(path + "  path contains // seperator");
        path = path.split("//").join("/");
        path = path.replace(":/", "://");
    }
    //TODO - Check that directory paths end with a /
    return path;
}

DKFile.prototype.makeDir = function DKFile_makeDir(path, mode, recursive, callback) {
    path = dk.file.validatepath(path);
    !mode && (mode = "0777");
    !recursive && (recursive = false);
    dk.file.isDir(path, function DKFile_isDir_callback(result) {
        if (result) {
            console.log("Directory already exists");
            return ok(callback, result);
        }
        console.debug("Creating directory " + path);
        dk.php.call("POST", "DKFile/DKFile.php", "makeDir", path, /*mode, recursive,*/
        function dk_php_call_callback(result) {
            return ok(callback, result);
        });
    });
}

if (!DUKTAPE) {
    DKFile.prototype.pushDKAssets = function DKFile_pushDKAssets(callback) {
        console.log("Pushing assets to local repository");
        dk.php.call("POST", "DKFile/DKFile.php", "pushDKAssets", function dk_php_pushDKAssets_callback(result) {
            if (!result)
                return error("pushDKAssets failed", callback);
            callback && callback(result);
            return result
        });
    }
} else {
    DKFile.prototype.pushDKAssets = function DKFile_pushDKAssets(callback) {
        //This is the js->cpp method
        var assets = CPP_DKAssets_LocalAssets();
        if (!assets) {
            console.error("assets is invalid");
            return false;
        }
        var search = assets;
        while (!CPP_DKFile_Exists(search + "/Development/DKCpp/plugins")) {
            var n = search.lastIndexOf("/");
            if (n === -1) {
                return error("could not locate a DKPlugins folder");
            }
            search = search.substring(0, n);
            console.log(search + "");
        }
        DIGITALKNOB_DIR = search;
        if (!CPP_DKFile_Exists(DIGITALKNOB_DIR)) {
            return error("Could not find search");
        }
        var temp = CPP_DKFile_DirectoryContents(DIGITALKNOB_DIR);
        if (!temp) {
            console.log("dk.debug.PushDKFiles() variable temp is invalid");
            return false;
        }
        var folders = temp.split(",");
        var plugin_folders = [];
        plugin_folders.push(DIGITALKNOB_DIR + "/Development/DKCpp/plugins");
        for (var n = 0; n < folders.length; n++) {
            if (CPP_DKFile_Exists(DIGITALKNOB_DIR + "/" + folders[n] + "/DKPlugins"))
                plugin_folders.push(DIGITALKNOB_DIR + "/" + folders[n] + "/DKPlugins");
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
}

// dk.file.pullDKAssets(callback)
DKFile.prototype.pullDKAssets = function DKFile_pullDKAssets(callback) {
    console.log("Pulling assets from local repository");
    dk.php.call("POST", "DKFile/DKFile.php", "pullDKAssets", function dk_php_pullDKAssets_callback(result) {
        if (!result)
            return error("pullDKAssets failed", callback);
        callback && callback(result);
        return result;
    });
}

// dk.file.exists(path, callback)
if(typeof CPP_DKFile_Exists === "function") {
	DKFile.prototype.exists = function DKFile_Exists(path, callback) {
        path = dk.file.validatepath(path);
        const result = CPP_DKFile_Exists(path);
        return callback(result);
    }
} 
else {
	DKFile.prototype.exists = function DKFile_exists(url, callback/*, usePhp*/) { //FIXME: usephp currently does nothing
		url = dk.file.validatepath(url);
		if (!url.includes(dk.file.onlineAssets))
			url = dk.file.onlineAssets + url;
		if (dk.php) {
			dk.php.call("GET", "DKFile/DKFile.php", "exists", url, function dk_php_exists_callback(result) {
				if (result) {
					callback && callback(true);
					return true;
				} else {
					callback && callback(false);
					return false;
				}
			});
		} else {
			dk.sendRequest("GET", url, function dk_sendRequest_callback(success, url, result) {
				if (success && url && result) {
					callback && callback(true);
					return true;
				} else {
					callback && callback(false);
					return false;
				}
			});
		}
	}
}

// dk.file.getShortName(path)
if (typeof CPP_DKFile_GetShortName === "function") {
    DKFile.prototype.getShortName = function DKFile_getShortName(path) {
        path = dk.file.validatepath(path);
        return (path);
    }
} else {
    DKFile.prototype.getShortName = function DKFile_getShortName(path) {
        path = dk.file.validatepath(path);
        return warn("DKFile.prototype.GetShortName(): not available for browser");
    }
}

if (typeof CPP_DKFile_Rename === "function") {
    DKFile.prototype.rename = function DKFile_rename(path, newvalue, overwrite) {
        path = dk.file.validatepath(path);
        return CPP_DKFile_Rename(path, newvalue, overwrite);
    }
} else {
    DKFile.prototype.rename = function DKFile_rename(oldpath, newpath, overwrite) {
        oldpath = dk.file.validatepath(oldpath);
        newpath = dk.file.validatepath(newpath);
        console.debug("DKFile.prototype.rename(" + oldpath + "," + newpath + "," + overwrite + "): not implemented yet");
    }
}

//FIXME
/*
DKFile.prototype.verifyPath = function DKFile_verifyPath(path) {
    path = dk.file.validatepath(path);
    console.log("DKFile.prototype.verifyPath(" + path + ")");
    if (dk.file.exists(path)) {
        console.log("DKFile.prototype.verifyPath(" + path + "): Found " + path);
        return path;
    }
    var assets = DKAssets_LocalAssets();
    console.log("DKFile.prototype.VerifyPath(" + path + "): checking " + assets + path);
    if (dk.file.Exists(assets + path)) {
        console.log("DKFile.prototype.VerifyPath(" + path + "): Found " + assets + path);
        return assets + path;
    }
    return error("DKFile.prototype.verifyPath(" + path + ") Cannot find " + path);
}
*/

//FIXME
/*
DKFile.prototype.printFiles = function DKFile_printFiles() {
    return ajaxGetUrl(dk.file.onlineAssets + "DKFile/DKFile.php?PrintFiles=1");
}
*/

DKFile.prototype.getFilename = function DKFile_getFilename(path) {
    path = dk.file.validatepath(path);
    var n = path.lastIndexOf("/");
    var out = path.substring(n + 1, path.length);
    return path.substring(n + 1, path.length);
}

/*
DKFile.prototype.saveFile = function DKFile_saveFile(path, data) {//var send = phpurl;
path = dk.file.validatepath(path);
//if(realpath){
//var filename = dk.file.GetFilename(path);
//path = realpath+path;
//}
//path = path.replace(datapath, realpath);
//path = path.replace(dk.file.onlineAssets, realpath);
//path = realpath+path;

//console.log("DKFile.prototype.SaveFile: "+path);

    var send = dk.file.onlineAssets + "\\DKFile\\DKFile.php?SaveFile=";
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
    DKFile.prototype.getSetting = function DKFile_getSetting(file, param) {
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
    DKFile.prototype.setSetting = function DKFile_setSetting(file, param, value) {
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

if(typeof CPP_DKFile_FileToString === "function") {
	DKFile.prototype.fileToString = function DKFile_fileToString(path, callback) {
        path = dk.file.validatepath(path);
        const str = CPP_DKFile_FileToString(path);
        return callback(str);
    }
} 
else {
    DKFile.prototype.fileToString = function DKFile_fileToString(path, callback) {
        path = dk.file.validatepath(path);
        if (location.protocol === "file:") {
            if (!dk.php)
                return error("dk.php invalid", callback);
            if (!dk.file.onlineAssets)
                return error("DKFile.prototype.onlineAssets invalid", callback);
            !path.includes(dk.file.onlineAssets) && (path = dk.file.onlineAssets + path);
            dk.php.call('POST', "DKFile/DKFile.php", "fileToString", path, function dk_php_call_callback(str) {
                if (!str && str !== "")
                    return error("str invalid", callback(false));
                callback && callback(str);
                return str;
            });
        } else {
            dk.sendRequest("GET", path, function dk_sendRequest_callback(success, url, data) {
                if (!data)
                    return error("data invalid", callback(false));
                callback && callback(data);
                return data;
            });
        }
    }
}

//	dk.file.stringToFile(string, path, flags, callback)
//		(str)    string: the text string to save
//		(path)   string: the file path to save to
//		(flags)     int: FILE_APPEND, FILE_USE_INCLUDE_PATH, LOCK_EX
//		(callback) bool: return boolean result variable
if (typeof CPP_DKFile_StringToFile === "function") {
    DKFile.prototype.stringToFile = function DKFile_stringToFile(str, path, flags, callback) {
        path = dk.file.validatepath(path);
        const result = CPP_DKFile_StringToFile(str, path);
        callback && callback(result);
		return
    }
} else {
    DKFile.prototype.stringToFile = function DKFile_stringToFile(str, path, flags, callback) {
        path = dk.file.validatepath(path);
        if (!dk.php)
            return error("dk.php invalid", callback);
        if (!dk.file.onlineAssets)
            return error("DKFile.prototype.onlineAssets invalid", callback);
        if (!path.includes(dk.file.onlineAssets))
            path = dk.file.onlineAssets + path;
        dk.php.call('POST', "DKFile/DKFile.php", "stringToFile", path, str, flags, function dk_php_call_callback(result) {
            return ok(callback, result);
        });
    }
}

if(typeof CPP_DKFile_DirectoryContents === "function") {
    DKFile.prototype.directoryContents = function DKFile_directoryContents(path, callback) {
        path = dk.file.validatepath(path)
		var results = CPP_DKFile_DirectoryContents(path)
		results = results.replace("..,","")
		results = results.replace(".,","")
		return callback(results)
    }
} else {
    DKFile.prototype.directoryContents = function DKFile_directoryContents(path, callback) {
        path = dk.file.validatepath(path)
        dk.php.call('POST', "DKFile/DKFile.php", "directoryContents", path, function dk_php_call_callback(results) {
            results = results.replace("..,","")
			results = results.replace(".,","")
			return callback(results)
        });
    }
}

if (typeof CPP_DKFile_GetAbsolutePath === "function") {
    DKFile.prototype.getAbsolutePath = function DKFile_getAbsolutePath(path, callback) {
        path = dk.file.validatepath(path);
        const aPath = CPP_DKFile_GetAbsolutePath(path);
        aPath = dk.file.validatepath(aPath);
        return callback(aPath)
    }
} else {
    DKFile.prototype.getAbsolutePath = function DKFile_getAbsolutePath(path, callback) {
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
}

if (typeof CPP_DKFile_GetRelativePath === "function") {
    DKFile.prototype.getRelativePath = function DKFile_getRelativePath(path, callback) {
        path = dk.file.validatepath(path);
        const rPath = CPP_DKFile_GetRelativePath(path);
        rPath = dk.file.validatepath(rPath);
        return callback(rPath);
    }
} else {
    DKFile.prototype.getRelativePath = function DKFile_getRelativePath(path, callback) {
        path = dk.file.validatepath(path);
        path = path.replace("\\", "/");
        path = path.replace("//", "/");
        dk.php.call('GET', "DKFile/DKFile.php", "getRelativePath", path, function dk_php_call_callback(rPath) {
            rPath = dk.file.validatepath(rPath);
            return callback(rPath);
        });
    }
}

if (typeof CPP_DKFile_GetPaths === "function") {
	DKFile.prototype.getPathObject = function DKFile_getPathObject(path, callback) {
		//console.log("original path = " + path);
		const _pObj = CPP_DKFile_GetPaths(path);
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
		console.log("path = " + pObj.path);
		console.log("aPath = " + pObj.aPath);
		console.log("root = " + pObj.root);
		console.log("rPath = " + pObj.rPath);
		console.log("realpath = " + pObj.realpath);
		console.log("dir = " + pObj.dir);
		console.log("basename = " + pObj.basename);
		console.log("extension = " + pObj.extension);
		console.log("filename = " + pObj.filename);
		*/
		return callback(pObj);
	}
} 
else {
	DKFile.prototype.getPathObject = function DKFile_getPathObject(path, callback) {
		//path = dk.file.validatepath(path);
		//console.log("original path = " + path);
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
			console.log("path = " + pObj.path);
			console.log("aPath = " + pObj.aPath);
			console.log("root = " + pObj.root);
			console.log("rPath = " + pObj.rPath);
			console.log("realpath = " + pObj.realpath);
			console.log("dir = " + pObj.dir);
			console.log("basename = " + pObj.basename);
			console.log("extension = " + pObj.extension);
			console.log("filename = " + pObj.filename);
			*/
			return callback(pObj);
		});
	}
}

if(typeof CPP_DKFile_IsDirectory === "function") {
    DKFile.prototype.isDir = function DKFile_isDir(path, callback) {
        path = dk.file.validatepath(path);
        const result = CPP_DKFile_IsDirectory(path);
        return callback(!!result);
    }
} else {
    DKFile.prototype.isDir = function DKFile_isDir(path, callback) {
        path = dk.file.validatepath(path);
        dk.php.call('GET', "DKFile/DKFile.php", "isDir", path, function dk_php_call_callback(result) {
            return callback(!!result);
        });
    }
}

DKFile.prototype.getExtention = function DKFile_getExtention(path) {
    path = dk.file.validatepath(path);
    var n = path.lastIndexOf(".");
    var extention = path.substring(n + 1, path.length);
    return extention;
}

if(typeof CPP_DKFile_Delete === "function") {
    DKFile.prototype.delete = function DKFile_delete(path, callback) {
        path = dk.file.validatepath(path);
        return CPP_DKFile_Delete(path);
    }
} else {
    DKFile.prototype.delete = function DKFile_delete(path, callback) {
        path = dk.file.validatepath(path);
        console.log("Deleting: " + path);
        dk.php.call("GET", "DKFile/DKFile.php", "delete", path, function dk_php_call_callback(result) {
            return callback(!!result);
        });
    }
}
