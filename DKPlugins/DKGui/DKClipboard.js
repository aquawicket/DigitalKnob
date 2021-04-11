"use strict";

function DK_Cut(id) {
    console.warn("DKClipboard_Cut(id) should use the element instead of id");
    var text = "";
    if (window.getSelection) {
        text = window.getSelection().toString();
    } else if (document.selection && document.selection.type !== "Control") {
        text = document.selection.createRange().text;
    }
    //console.debug("DK_Cut("+id+"): text = "+text+"\n");
    DKClipboard_CopyToClipboard(text);
    DKClipboard_RemoveSelection(id);
}

function DK_Copy(id) {
    console.warn("DKClipboard_Copy(id) should use the element instead of id");
    var text = "";
    if (window.getSelection) {
        text = window.getSelection().toString();
    } else if (document.selection && document.selection.type !== "Control") {
        text = document.selection.createRange().text;
    }

    //console.debug("DK_Copy("+id+"): text = "+text+"\n");
    DKClipboard_CopyToClipboard(text);
}

function DKClipboard_Paste(id) {
    console.warn("DKClipboard_Paste(id) should use the element instead of id");
    DKClipboard_RemoveSelection(id);
    var ele = byId(id);
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
            console.warn("Copy to clipboard failed.", ex);
            return false;
        } finally {
            document.body.removeChild(textarea);
        }
    }
}

function DKClipboard_RemoveSelection(id) {
    console.warn("DKClipboard_RemoveSelection(id) should use the element instead of id");
    var ele = byId(id);
    var text = ele.value;
    text = text.slice(0, ele.selectionStart) + text.slice(ele.selectionEnd);
    ele.value = text;
}
