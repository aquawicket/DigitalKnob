"use strict";

function DK_Cut(ele) {
    var text = "";
    if (window.getSelection) {
        text = window.getSelection().toString();
    } else if (document.selection && document.selection.type !== "Control") {
        text = document.selection.createRange().text;
    }
    //console.debug("DK_Cut("+ele.id+"): text = "+text+"\n");
    DKClipboard_CopyToClipboard(text);
    DKClipboard_RemoveSelection(id);
}

function DK_Copy(ele) {
    var text = "";
    if (window.getSelection) {
        text = window.getSelection().toString();
    } else if (document.selection && document.selection.type !== "Control") {
        text = document.selection.createRange().text;
    }

    //console.debug("DK_Copy("+ele.id+"): text = "+text+"\n");
    DKClipboard_CopyToClipboard(text);
}

function DKClipboard_Paste(ele) {
    DKClipboard_RemoveSelection(ele);
    ele.focus();
    ele.select();
    document.execCommand('Paste');
}

function DKClipboard_CopyToClipboard(text) {
    if (window.clipboardData && window.clipboardData.setData) {
        // IE specific code path to prevent textarea being shown while dialog is visible.
        return clipboardData.setData("Text", text);

    } else if (document.queryCommandSupported && document.queryCommandSupported("copy")) {
        var textarea = document.createElement("textarea");
        textarea.textContent = text;
        textarea.style.position = "fixed";
        // Prevent scrolling to bottom of page in MS Edge.
        document.body.appendChild(textarea);
        textarea.select();
        try {
            return document.execCommand("copy");
            // Security exception may be thrown by some browsers.
        } catch (ex) {
            return error("Copy to clipboard failed.", ex);
        } finally {
            document.body.removeChild(textarea);
        }
    }
}

function DKClipboard_RemoveSelection(ele) {
    var text = ele.value;
    text = text.slice(0, ele.selectionStart) + text.slice(ele.selectionEnd);
    ele.value = text;
}
