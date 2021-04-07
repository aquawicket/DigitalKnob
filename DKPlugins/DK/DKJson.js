"use strict";

const DKJson_PrettyJson = function(json) {
    if (typeof json !== 'string') {
        return;
    }
    const prettyJson = JSON.parse(json);
    return JSON.stringify(prettyJson, undefined, 4);
}

const DKJson_HighlightJson = function(jsonString) {
    let hightlightedJson = jsonString.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
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
function DKJson_StringifyJson(object) {
    let simpleObject = {};
    for (let prop in object) {
        if (!object.hasOwnProperty(prop)) {
            continue;
        }
        if (typeof (object[prop]) == 'object') {
            continue;
        }
        if (typeof (object[prop]) == 'function') {
            continue;
        }
        simpleObject[prop] = object[prop];
    }
    return JSON.stringify(simpleObject);
    // returns cleaned up JSON
}

/*
//search the object for a keyName's value that matches value
function DKJson_FindObject(obj, keyToFind, valueToFind) {
    if (obj.length) {
        //array of objects
        for (let n = 0; n < obj.length; n++) {
            if (keyToFind in obj[n]) {
                if (obj[n][keyToFind] === valueToFind) {
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
//search the object for a keyName's value that includes valueToFind
function DKJson_FindObjectValueIncludes(obj, keyToFind, valueToFind) {
    if (obj.length) {
        //array of objects
        for (let n = 0; n < obj.length; n++) {
            if (keyToFind in obj[n]) {
                if (valueToFind.includes(obj[n][keyToFind])) {
                    return obj[n];
                }
            }
        }
    } else {
        //single object
        if (keyToFind in obj) {
            if (valueToFind.includes(obj[keyToFind])) {
                return obj;
            }
        }
    }
    return false;
}
*/

function DKJson_FindObjectValueIncludes(obj, keyToFind, valToFind) {
    let foundObj;
    JSON.stringify(obj, (_,nestedValue)=>{
        if (nestedValue && valToFind.includes(nestedValue[keyToFind])) {
            foundObj = nestedValue;
        }
        return nestedValue;
    }
    );
    return foundObj;
}
