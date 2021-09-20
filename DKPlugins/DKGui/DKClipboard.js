//"use strict";

function DKClipboard() {}

DKClipboard.prototype.cut = function DKClipboard_cut(ele) {
    let text = "";
    if (window.getSelection)
        text = window.getSelection().toString();
    else if (document.selection && document.selection.type !== "Control")
        text = document.selection.createRange().text;
    dk.clipboard.copyToClipboard(text);
    dk.clipboard.removeSelection(id);
}

DKClipboard.prototype.copy = function DKClipboard_copy(ele) {
    var text = "";
    if (window.getSelection)
        text = window.getSelection().toString();
    else if (document.selection && document.selection.type !== "Control")
        text = document.selection.createRange().text;
    dk.clipboard.copyToClipboard(text);
}

DKClipboard.prototype.paste = function DKClipboard_paste(ele) {
    dk.clipboard.removeSelection(ele);
    ele.focus();
    ele.select();
    document.execCommand('Paste');
}

DKClipboard.prototype.copyToClipboard = function DKClipboard_copyToClipboard(text) {
    if (window.clipboardData && window.clipboardData.setData)
        return clipboardData.setData("Text", text);
    else if (document.queryCommandSupported && document.queryCommandSupported("copy")) {
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

DKClipboard.prototype.removeSelection = function DKClipboard_removeSelection(ele) {
    var text = ele.value;
    text = text.slice(0, ele.selectionStart) + text.slice(ele.selectionEnd);
    ele.value = text;
}

dk.clipboard = DKPlugin(DKClipboard, "singleton")