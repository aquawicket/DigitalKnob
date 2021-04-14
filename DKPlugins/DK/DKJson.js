"use strict";

const DKJson_PrettyJson = function(jsonStr) {
    if (typeof jsonStr !== 'string')
        return error("jsonStr invalid");

    const prettyJson = JSON.parse(jsonStr);
    return JSON.stringify(prettyJson, undefined, 4);
}

const DKJson_HighlightJson = function(jsonStr) {
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
function DKJson_StringifyJson(obj) {
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

/*
//search the object for a keyName's value that matches value
function DKJson_FindMatch(obj, key, value) {
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
function DKJson_FindPartialMatch(obj, key, value) {
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

function DKJson_FindPartialMatch(obj, key, value) {
    let foundObj;
    JSON.stringify(obj, (_,nestedValue)=>{
        if (nestedValue && nestedValue[key] && (value.includes(nestedValue[key]) || nestedValue[key].includes(value))) {
            foundObj = nestedValue;
        }
        return nestedValue;
    }
    );
    return foundObj;
}
