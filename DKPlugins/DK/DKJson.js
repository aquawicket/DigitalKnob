"use strict";

//https://goessner.net/articles/JsonPath/index.html#e2

dk.json = DKPlugin(DKJson)

function DKJson() {}

DKJson.prototype.prettyJson = function DKJson_prettyJson(jsonStr) {
    if (typeof jsonStr !== 'string')
        return error("jsonStr invalid");

    const prettyJson = JSON.parse(jsonStr);
    return JSON.stringify(prettyJson, undefined, 4);
}

DKJson.prototype.highlightJson = function DKJson_highlightJson(jsonStr) {
    if (typeof jsonStr !== 'string')
        return error("jsonStr invalid");

    let hightlightedJson = jsonStr.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return hightlightedJson.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function(match) {
        let cls = 'number';
        if (/^"/.test(match)) {
            if (/:$/.test(match)) {
                cls = 'key';
                return '<span style="color:red;">' + match + '</span>';
            } else {
                cls = 'string';
                return '<span style="color:green;">' + match + '</span>';
            }
        } else if (/true|false/.test(match)) {
            cls = 'boolean';
            return '<span style="color:blue;">' + match + '</span>';
        } else if (/null/.test(match)) {
            cls = 'null';
            return '<span style="color:magenta;">' + match + '</span>';
        }
        return '<span style="color:darkOrange;">' + match + '</span>';
    });
}

///Takes care of circular refrences in objects
DKJson.prototype.stringifyJson = function DKJson_stringifyJson(obj) {
    if (typeof obj !== 'object')
        return error("obj invalid");

    let obj2 = {};
    for (let prop in obj) {
        if (!obj.hasOwnProperty(prop)) {
            continue;
        }
        if (typeof (obj[prop]) == 'object') {
            continue;
        }
        if (typeof (obj[prop]) == 'function') {
            continue;
        }
        obj2[prop] = obj[prop];
    }
    return JSON.stringify(obj2);
}

DKJson.prototype.findPartialMatch = function DKJson_findPartialMatch(obj, key, value) {
    //console.log(obj.length);
    let foundObj;
    JSON.stringify(obj, function(_, nestedValue) {
        if (nestedValue && nestedValue[key] && (value.includes(nestedValue[key]) || nestedValue[key].includes(value)))
            foundObj = nestedValue;
        return nestedValue;
    });
    return foundObj;
}

DKJson.prototype.saveJsonToFile = function DKJson_saveJsonToFile(json, path, flags, callback) {
    const str = JSON.stringify(json);
    dk.file.stringToFile(str, path, flags, function dk_file_stringToFile_callback(rval) {
        return callback && callback(rval);
    });
}

DKJson.prototype.loadJsonFromFile = function DKJson_loadJsonFromFile(path, callback) {
    dk.file.exists(path, function(result) {
        if (result) {
            dk.file.fileToString(path, function dk_file_fileToString_callback(str) {
                let json;
                try {
                    json = JSON.parse(str);
                } catch (err) {
                    return callback(false);
                }
                return callback(json);
            });
        } else {
            return callback(false);
        }
    });
}

DKJson.prototype.saveToLocalStorage = function DKJson_saveToLocalStorage(label, json) {
    const str = JSON.stringify(json);
    dk.saveToLocalStorage(label, str);
}

DKJson.prototype.loadFromLocalStorage = function DKJson_loadFromLocalStorage(label) {
    const str = dk.loadFromLocalStorage(label);
    const json = JSON.parse(str);
    return json;
}

// https://stackoverflow.com/a/8611131/688352
// https://stackoverflow.com/a/5612849/688352
DKJson.prototype.objectToString = function DKJson_objectToString(obj) {
    const result = JSON.stringify(obj, null, 4);
    return result;
}

/*
//search the object for a keyName's value that matches value
DKJson.prototype.findMatch = function DKJson_findMatch(obj, key, value) {
    if (obj.length) {
        //array of objects
        for (let n = 0; n < obj.length; n++) {
            if (key in obj[n]) {
                if (obj[n][key] === value) {
                    //return obj[n];
                    return n;
                }
            }
        }
    }
    return -1;
}
*/

/*
//search the object for a key value that includes value
DKJson.prototype.findPartialMatch = function dkjson_findPartialMatch(obj, key, value) {
    if (obj.length) {
        //array of objects
        for (let n = 0; n < obj.length; n++) {
            if (key in obj[n]) {
                if (value.includes(obj[n][key])) {
                    return obj[n];
                }
            }
        }
    } else {
        //single object
        if (key in obj) {
            if (value.includes(obj[key])) {
                return obj;
            }
        }
    }
    return false;
}
*/
