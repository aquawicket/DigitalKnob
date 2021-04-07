var appfilename;
var local_assets;
var online_assets;

if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_ChDir = function() {
        console.warn("DKFile_ChDir(): not available for " + DK_GetBrowser());
    }
    var DKFile_CopyFolder = function(src, dst, overwrite, recursive) {
        console.warn("DKFile_CopyDirectory(): not available for " + DK_GetBrowser());
    }
    var DKFile_GetExeName = function() {
        console.warn("DKFile_GetExeName(): not available for " + DK_GetBrowser());
    }
    var DKFile_GetFullExeName = function() {
        console.warn("DKFile_GetFullExeName(): not available for " + DK_GetBrowser());
    }
    var DKFile_GetModifiedTime = function() {
        console.warn("DKFile_GetModifiedTime(): not available for " + DK_GetBrowser());
    }
    var DKFile_GetShortName = function() {
        console.warn("DKFile_GetShortName(): not available for " + DK_GetBrowser());
    }
    var DKFile_MkDir = function() {
        console.warn("DKFile_MkDir(): not available for " + DK_GetBrowser());
    }
    var DKFile_GetDrives = function() {
        console.warn("DKFile_GetDrives(): not available for " + DK_GetBrowser());
    }
}

//////////////////////
function DKFile_Init() {
}

///////////////////////////
function UrlExists(url, fn) {
    var request = "";
    try {
        request = new XMLHttpRequest();
    } catch (e) {}
    try {
        request = new ActiveXObject("Msxml3.XMLHTTP");
    } catch (e) {}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP.6.0");
    } catch (e) {}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP.3.0");
    } catch (e) {}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {}
    try {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (e) {}
    if (!request) {
        console.error("AJAX ERROR: Error creating request object");
        return;
        // false;
    }

    request.onreadystatechange = function() {
        if (request.readyState == 4) {
            if (request.status == 200 || request.status == 0) {
                //output.value = request.responseText;
                console.warn(url + " status: " + request.status);
                fn && fn(true);
                return true;
            } else {
                console.warn("AJAX ERROR: " + request.statusText);
                //report error
                console.warn(url + " status: " + request.status);
                fn && fn(false);
                //return;// false;
            }
        }
    }

    //try{ 
    request.open("HEAD", url);
    //request.open("GET",url); 
    request.send();
    //}
    //catch(err){
    //output.value = "";
    //	return;// false;
    //}
    //return;// true;
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_GetShortName = function(path) {
        console.warn("DKFile_GetShortName(): not available for browser");
    }
} else {
    var DKFile_GetShortName = function(path) {
        return CPP_DKFile_GetShortName(path);
    }
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_Rename = function(oldvalue, newvalue, overwrite) {
        console.warn("DKFile_Rename(): not implemented for browser");
    }
} else {
    var DKFile_Rename = function(oldvalue, newvalue, overwrite) {
        return CPP_DKFile_Rename(oldvalue, newvalue, overwrite);
    }
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_Exists = function(path, fn) {
        if (!path) {
            return false;
        }

        dir = DKFile_GetAbsolutePath(path);
        if (DKFile_IsDirectory(dir)) {
            fn && fn(true);
            return true;
        }

        UrlExists(path, function(rval) {
            fn && fn(rval);
            return rval;
        });
    }
}

////////////////////////////////
function DKFile_VerifyPath(path) {
    //FIXME
    console.log("DKFile_VerifyPath(" + path + "): FIXME");
    return true;

    if (!path) {
        return false;
    }

    console.log("DKFile_VerifyPath(" + path + "): checking " + path);
    if (DKFile_Exists(path)) {
        console.log("DKFile_VerifyPath(" + path + "): Found " + path);
        return path;
    }

    var assets = DKAssets_LocalAssets();
    console.log("DKFile_VerifyPath(" + path + "): checking " + assets + path);
    if (DKFile_Exists(assets + path)) {
        console.log("DKFile_VerifyPath(" + path + "): Found " + assets + path);
        return assets + path;
    }

    console.error("DKFile_VerifyPath(" + path + ") Cannot find " + path);
    return false;
}

////////////////////////////
function DKFile_PrintFiles() {
    return ajaxGetUrl(online_assets + "/DKFile/DKFile.php?PrintFiles=1");
}

/////////////////////////////////
function DKFile_GetFilename(path) {
    if (!path) {
        return;
    }
    var n = path.lastIndexOf("/");
    var out = path.substring(n + 1, path.length);
    //console.log("DKFile_GetFileName("+path+") -> "+out)
    return path.substring(n + 1, path.length);
}

////////////////////////////////////
function DKFile_SaveFile(path, data) {
    //var send = phpurl;
    //if(realpath){
    //var filename = DKFile_GetFilename(path);
    //path = realpath+path;
    //}
    //path = path.replace(datapath, realpath);
    //path = path.replace(online_assets, realpath);
    //path = realpath+path;

    //console.log("DKFile_SaveFile: "+path);
    send = online_assets + "/DKFile/DKFile.php?SaveFile=";
    send += path;
    send += "&data="
    send += data;
    var response = ajaxGetUrl(send);
    console.log(response);

    //FIXME
    //if(response.indexOf("console.error") !== -1){
    //	return false;
    //}
    console.log("Saved file: " + path);
    return true;
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_GetSetting = function(file, param) {
        //file is ignored in browser. We use cookie instead.
        if (!file) {
            return getCookie(param);
        } else {
            //If the variable looks like this: [VARIABLE]
            //then we return everything up to the next [VARIABLE] or to the end of the file.
            var str = DK_FileToString(file);
            if (!str) {
                return "";
            }
            if (param.indexOf("[") !== -1 && param.indexOf("]") !== -1) {
                var begin = str.indexOf(param);
                if (begin === -1) {
                    return "";
                }

                var start = str.indexOf("]", begin);
                var end = str.indexOf("[", start);
                if (end === -1) {
                    end = str.length;
                }

                var out = str.substr(start + 1, end - start - 1);

                replace(out, "\r", "");
                replace(out, "\n", " ");
                out = out.trim();
                //console.log("DKFile_GetSetting("+file+", "+param+") -> "+out);
                return out;
            }

            //If the variable looks like this:  VARIABLE 
            //then we return the rest of the line
            var string = param + " ";
            var begin = str.indexOf(string, 0);
            if (begin === -1) {
                return "";
            }
            var start = str.indexOf(" ", begin);
            var end = str.indexOf("\n", start);

            var out = filestring.substr(start + 1, end - start - 1);
            replace(out, "\r", "");
            replace(out, "\n", "");
            out = out.trim();
            //console.log("DKFile_GetSetting("+file+", "+param+") -> "+out);
            return out;
        }
    }
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_SetSetting = function(file, param, value) {
        //file is ignored in browser. We use cookie instead.
        if (!file) {
            setCookie(param, value, 9999);
        } else {
            var path = file;
            //if(!DKAssets::VerifyPath(path)){ return false;}

            var filestring = DKFile_FileToString(path);
            if (!filestring) {
                return false;
            }

            //If the variable looks like this: [VARIABLE]
            //then we return everything up to the next [VARIABLE] or to the end of the file.
            if (param.indexOf("[") !== -1 && param.indexOf("]") !== -1) {
                var begin = filestring.indexOf(param);
                if (begin === -1) {
                    filestring = filestring.concat("\n" + param + " " + value);
                    //create entry
                    DKFile_StringToFile(filestring, path);
                    console.log("WROTE: " + filestring + " TO: " + path);
                    return true;
                }
                var start = filestring.indexOf("]", begin);
                var end = filestring.indexOf("[", start);
                if (end === -1) {
                    end = filestring.length;
                }

                var out = " " + value;
                var oldstr = filestring.substr(start + 1, end - start - 1);
                filestring = replace(filestring, oldstr, out);
                DKFile_StringToFile(filestring, path);
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
                DKFile_StringToFile(filestring, file);
                console.log("WROTE: " + filestring + " TO: " + file);
                return true;
            }
            var start = filestring.indexOf(" ", begin);
            var end = filestring.indexOf("\n", start);

            var oldstr = filestring.substr(start + 1, end - start - 1);
            filestring.replace(filestring, oldstr, value);
            DKFile_StringToFile(filestring, file);

            console.log("WROTE: " + filestring + " TO: " + file);
            return true;
        }
    }
}

///////////////////////////////////////
var DKFile_FileToString = function(url) {
    console.log("DKFile_FileToString(" + url + ")");
    if (typeof absolutepath !== "undefined") {
        url = url.replace(absolutepath, "");
    }

    //var path = DKFile_VerifyPath(url);
    if (!url) {
        return;
    }
    //if(url.indexOf("http") > -1 && url.indexOf("digitalknob.com") === -1){
    //	return ajaxGetUrl("http://cors.io/?u="+url);
    //}
    return ajaxGetUrl(url);
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_StringToFile = function(data, path) {
        if (typeof absolutepath !== "undefined") {
            if (!path.includes(absolutepath)) {
                path = absolutepath + path;
            }
        }

        data = replace(data, ": ", ":");
        data = replace(data, "; ", ";");
        data = replace(data, ", ", ",");
        data = replace(data, " ", "%20");
        data = replace(data, "'", "%27");
        data = replace(data, "\n", "%0A");
        //console.log("StringToFile("+data+", "+path+")");
        DKFile_SaveFile(path, data);
    }
} else {
    var DKFile_StringToFile = function(data, path) {
        return CPP_DKFile_StringToFile(data, path)
    };
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_DirectoryContents = function(url) {
        //TEST
        url = url.replace("http://localhost/", ".");
        //FIXME
        url = url.replace("http://127.0.0.1/", ".");
        //FIXME

        console.debug("DKFile_DirectoryContents(" + url + ")");
        if (url.indexOf(":") > -1) {
            console.error("DKFile_DirectoryContents(" + url + "): url has :");
            return;
        }
        if (!online_assets) {
            console.error("DKFile_DirectoryContents(url): online_assets not set")
        }
        //var assets = DKAssets_LocalAssets();
        //url = url.replace(assets, online_assets);
        //var path = DKFile_VerifyPath(url);
        //if(!path){ return 0; }
        send = online_assets + "DKFile/DKFile.php?DirectoryContents=" + url;
        console.log("ajaxGetUrl(" + send + ")");
        var result = ajaxGetUrl(send);
        return result;
    }
} else {
    var DKFile_DirectoryContents = function(url) {
        return CPP_DKFile_DirectoryContents(url)
    };
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_GetAbsolutePath = function(url) {
        //console.debug("DKFile_GetAbsolutePath("+url+")");
        if (!url) {
            url = "/";
        }
        if (url.indexOf("file:///") > -1) {
            url = pathname;
        }

        url = url.replace(protocol + "//" + hostname + "/", "");
        url = url.replace("//", "/");
        //console.debug("DKFile_GetAbsolutePath("+url+")");

        send = online_assets + "DKFile/DKFile.php?GetAbsolutePath=" + url;
        var result = ajaxGetUrl(send);

        //result = result.replace(protocol+"//"+hostname+"/","");
        //result = result.replace("//","/");

        console.debug("DKFile_GetAbsolutePath(" + url + ") -> " + result);
        return result;
    }
} else {
    var DKFile_GetAbsolutePath = function(url) {
        return CPP_DKFile_GetAbsolutePath(url)
    };
}

////////////////////////////////////////////////
function DKFile_GetRelativePath(apath, datapath) {
    //var rpath = apath.replace(pathname,"");
    //var rpath = rpath.replace("/home/content/a/q/u/aquawicket1/html/DigitalKnob.com/DKApp/","");
    //send = online_assets+"/DKFile/DKFile.php?GetRelativePath="+url;
    //var result = ajaxGetUrl(send);
    //console.log("DKFile_GetRelativePath("+url+") -> "+result);
    return apath;
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_IsDirectory = function(url) {
        send = online_assets + "/DKFile/DKFile.php?IsDirectory=" + url;
        var result = ajaxGetUrl(send);
        //console.log("DKFile_IsDirectory("+url+") ->"+result);
        if (result === "0") {
            return false;
        }
        return true;
    }
} else {
    var DKFile_IsDirectory = function(url) {
        return CPP_DKFile_IsDirectory(url);
    }
}

/////////////////////////////////
function DKFile_GetExtention(url) {
    var n = url.lastIndexOf(".");
    var out = url.substring(n + 1, url.length);
    return out;
}

///////////////////////////////////////////////////////////
if (DK_GetBrowser() !== "CEF" && DK_GetBrowser() !== "RML") {
    var DKFile_Delete = function(url) {
        console.log("Deleting: " + url);
        send = online_assets + "/DKFile/DKFile.php?Delete=" + url;
        var result = ajaxGetUrl(send);
        return result;
    }
} else {
    var DKFile_Delete = function(url) {
        return CPP_DKFile_Delete(url);
    }
}
