"use strict";

function DKGui_CreateElement(parent, tag, id) {
    var ele = document.createElement(tag);
    ele.id = DK_GetAvailableId(id);
    parent.appendChild(ele);
    //This is not working on IE
    return ele;
}

function DKGui_CreateElementBefore(parent, tag, id) {
    var ele = document.createElement(tag);
    ele.id = DK_GetAvailableId(id);
    parent.parentNode.insertBefore(ele, parent);
    return ele;
}

function DKGui_GetLeftPx(element) {
    if (!element) {
        return 0;
    }
    if (!element.style.left) {
        return 0;
    }
    if (element.style.left.indexOf("%") > -1) {
        return parseInt(element.style.left) * WindowWidth() / 100;
    }
    return parseInt(element.style.left);
}

function DKGui_GetTopPx(element) {
    if (!element) {
        return 0;
    }
    if (!element.style.top) {
        return 0;
    }
    if (element.style.top.indexOf("%") > -1) {
        return parseInt(element.style.top) * WindowHeight() / 100;
    }
    return parseInt(element.style.top);
}

function DKGui_GetWidthPx(element) {
    if (!element) {
        return 0;
    }
    if (!element.style.width) {
        return 0;
    }
    if (element.style.width.indexOf("%") > -1) {
        return parseInt(element.style.width) * WindowWidth() / 100;
    }
    return parseInt(element.style.width);
}

function DKGui_GetHeightPx(element) {
    if (!element) {
        return 0;
    }
    if (!element.style.height) {
        return 0;
    }
    if (element.style.height.indexOf("%") > -1) {
        return parseInt(element.style.height) * WindowHeight() / 100;
    }
    return parseInt(element.style.height);
}

function DKGui_Pos(position) {
    if (position === '') {
        return position;
    }
    if (typeof position === 'string') {
        if (position.search('rem') !== -1) {
            if (DK_IE() && DK_IE() < 9) {
                position = position.replace("rem", "px");
            }
            return position;
        }
        if (position.search('px') !== -1) {
            return position;
        }
        if (position.search('%') !== -1) {
            return position;
        }
        if (position.search('auto') !== -1) {
            return position;
        }

        if (DK_IE() && DK_IE() < 9) {
            return position + 'px';
        } else {
            return position + 'rem';
        }
    }
    if (typeof position === 'number') {
        if (DK_IE() && DK_IE() < 9) {
            return position + 'px';
        } else {
            return position + 'rem';
        }
    }

    return error("Pos() ERROR");
}

function DKGui_CreateButton(parent, id, top, bottom, left, right, width, height, onclick) {
    const button = document.createElement("button");
    button.id = id;
    button.innerHTML = id;
    button.style.position = "absolute";
    top && (button.style.top = top);
    bottom && (button.style.bottom = bottom);
    left && (button.style.left = left);
    right && (button.style.right = right);
    width && (button.style.width = width);
    height && (button.style.height = height);
    //button.style.padding = "0rem";
    button.style.cursor = "pointer";
    onclick && (button.onclick = onclick);
    parent.appendChild(button);
    return button;
}

function DKGui_CreateImageButton(parent, id, src, top, bottom, left, right, width, height, onclick) {
    const button = document.createElement("img");
    button.id = id;
    button.src = src;
    button.style.position = "absolute";
    top && (button.style.top = top);
    bottom && (button.style.bottom = bottom);
    left && (button.style.left = left);
    right && (button.style.right = right);
    width && (button.style.width = width);
    height && (button.style.height = height);
    //button.style.padding = "0rem";
    button.style.cursor = "pointer";
    onclick && (button.onclick = onclick);
    parent.appendChild(button);
    return button;
}

//TODO  //https://github.com/juggle/resize-observer
//TODO:  make this a CustomEvent
//https://stackoverflow.com/a/48718956/688352
function DKGui_AddResizeHandler(element, callback) {
    var observer = new MutationObserver(function(mutations) {
        callback && callback();
    }
    );
    observer.observe(element, {
        attributes: true
    });
}

/*
function DKGui_ConfirmBox(msg, callback) {
    const confirm = DKCreateWindow("DKConfirm", "200rem", "100rem");
    confirm.style.textAlign = "center";
    confirm.style.paddingTop = "20rem";
    const message = document.createElement("span");
    message.innerHTML = msg;
    confirm.appendChild(message);
    const no = DKCreateButton(confirm, "No", "50rem", "75rem", "", "", function() {
        document.body.removeChild(confirm);
    });
    const yes = DKCreateButton(confirm, "Yes", "50rem", "105rem", "", "", function() {
        callback && callback();
        document.body.removeChild(confirm);
    });
}
*/