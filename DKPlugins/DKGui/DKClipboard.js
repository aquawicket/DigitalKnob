"use strict";

dk.clipboard = new Object;


dk.clipboard.cut = function dk_clipboard_cut(ele) {
    var text = "";
    if (window.getSelection)
        text = window.getSelection().toString();
    else if (document.selection && document.selection.type !== "Control")
        text = document.selection.createRange().text;
    dk.clipboard.copyToClipboard(text);
    dk.clipboard.removeSelection(id);
}

dk.clipboard.copy = function dk_clipboard_copy(ele) {
    var text = "";
    if (window.getSelection)
        text = window.getSelection().toString();
    else if (document.selection && document.selection.type !== "Control")
        text = document.selection.createRange().text;
    dk.clipboard.copyToClipboard(text);
}

dk.clipboard.paste = function dk_clipboard_paste(ele) {
    dk.clipboard.removeSelection(ele);
    ele.focus();
    ele.select();
    document.execCommand('Paste');
}

dk.clipboard.copyToClipboard = function dk_clipboard_copyToClipboard(text) {
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

dk.clipboard.removeSelection = function dk_clipboard_removeSelection(ele) {
    var text = ele.value;
    text = text.slice(0, ele.selectionStart) + text.slice(ele.selectionEnd);
    ele.value = text;
}
