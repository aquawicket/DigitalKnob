dk.messagebox = new Object;

dk.messagebox.init = function dk_messagebox_init() {/*
	DK_Create("DKGui/dk.messagebox.html");
	byId("DKMessageBoxOk").addEventListener("click", dk_messagebox_OnEvent);
	byId("DKMessageBoxCancel").addEventListener("click", dk_messagebox_OnEvent);
	*/
}

dk.messagebox.end = function dk_messagebox_end() {
    byId("DKMessageBoxOk").removeEventListener("click", dk.messagebox.onevent);
    byId("DKMessageBoxCancel").removeEventListener("click", dk.messagebox.onevent);
    DK_Close("DKGui/DKMessageBox.html");
}

dk.messagebox.onevent = function dk_messagebox_onevent(event) {
    if (event.currentTarget.id === "DKMessageBoxOk") {
        if (byId("DKMessageBoxInput").value)
            dk.messagebox.callback && dk.messagebox.callback(byId("DKMessageBoxInput").value);
        else
            dk.messagebox.callback && dk.messagebox.callback(true);

        dk.frame.close(byId("DKGui/DKMessageBox.html"));
        return true;
    }

    if (event.currentTarget.id === "DKMessageBoxCancel") {
        dk.messagebox.callback && dk.messagebox.callback(false);
        dk.frame.close(byId("DKGui/DKMessageBox.html"));
        return true;
    }
}

dk.messagebox.message = function dk_messagebox_message(message) {
    byId("DKMessageBoxText").innerHTML = message;
    byId("DKMessageBoxInput").style.display = "none";
    byId("DKMessageBoxCancel").style.display = "none";
    byId("DKMessageBoxText").style.display = "block";
    byId("DKMessageBoxText").style.visibility = "visible";
    byId("DKGui/DKMessageBox.html").style.display = "block";
    byId("DKGui/DKMessageBox.html").style.visibility = "visible";
}

dk.messagebox.confirm = function dk_messagebox_confirm(message, callback) {
    DK_Create("DKGui/DKMessageBox.html", function() {
        dk.frame.create(byId("DKGui/DKMessageBox.html"));
        DKMessageBoxText.innerHTML = message;
        DKMessageBoxInput.style.display = "none";
        DKMessageBoxText.style.display = "block";
        DKMessageBoxText.style.visibility = "visible";
        DKMessageBoxCancel.style.display = "block";
        DKMessageBoxCancel.style.visibility = "visible";
        byId("DKGui/DKMessageBox.html").style.display = "block";
        byId("DKGui/DKMessageBox.html").style.visibility = "visible";

        DKMessageBoxOk.addEventListener("click", dk.messagebox.onevent);
        DKMessageBoxCancel.addEventListener("click", dk.messagebox.onevent);
        dk.messagebox.callback = callback;
    });
}

dk.messagebox.value = function dk_messagebox_value(message, callback) {
    byId("DKMessageBoxText").innerHTML = message;
    byId("DKMessageBoxText").style.display = "block";
    byId("DKMessageBoxText").style.visibility = "visible";
    byId("DKMessageBoxInput").style.display = "block";
    byId("DKMessageBoxInput").style.visibility = "visible";
    byId("DKMessageBoxCancel").style.display = "block";
    byId("DKMessageBoxCancel").style.visibility = "visible";
    byId("DKGui/DKMessageBox.html").style.display = "block";
    byId("DKGui/DKMessageBox.html").style.visibility = "visible";
    dk.messagebox.callback = callback;
}
