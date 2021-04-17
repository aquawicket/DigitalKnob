const dkmessagebox = new Object;

dkmessagebox.init = function DKMessageBox_Init() {/*
	DK_Create("DKGui/DKMessageBox.html");
	byId("DKMessageBoxOk").addEventListener("click", DKMessageBox_OnEvent);
	byId("DKMessageBoxCancel").addEventListener("click", DKMessageBox_OnEvent);
	*/
}

dkmessagebox.end = function DKMessageBox_End() {
    byId("DKMessageBoxOk").removeEventListener("click", DKMessageBox_OnEvent);
    byId("DKMessageBoxCancel").removeEventListener("click", DKMessageBox_OnEvent);
    DK_Close("DKGui/DKMessageBox.html");
}

dkmessagebox.onevent = function DKMessageBox_OnEvent(event) {
    if (event.currentTarget.id === "DKMessageBoxOk") {
        if (byId("DKMessageBoxInput").value)
            dkmessagebox.callback && dkmessagebox.callback(byId("DKMessageBoxInput").value);
        else
            dkmessagebox.callback && dkmessagebox.callback(true);

        dkframe.close(byId("DKGui/DKMessageBox.html"));
        return true;
    }

    if (event.currentTarget.id === "DKMessageBoxCancel") {
        dkmessagebox.callback && dkmessagebox.callback(false);
        dkframe.close(byId("DKGui/DKMessageBox.html"));
        return true;
    }
}

dkmessagebox.message = function DKMessageBox_Message(message) {
    byId("DKMessageBoxText").innerHTML = message;
    byId("DKMessageBoxInput").style.display = "none";
    byId("DKMessageBoxCancel").style.display = "none";
    byId("DKMessageBoxText").style.display = "block";
    byId("DKMessageBoxText").style.visibility = "visible";
    byId("DKGui/DKMessageBox.html").style.display = "block";
    byId("DKGui/DKMessageBox.html").style.visibility = "visible";
}

dkmessagebox.confirm = function DKMessageBox_Confirm(message, callback) {
    DK_Create("DKGui/DKMessageBox.html", function() {
        dkframe.create(byId("DKGui/DKMessageBox.html"));
        DKMessageBoxText.innerHTML = message;
        DKMessageBoxInput.style.display = "none";
        DKMessageBoxText.style.display = "block";
        DKMessageBoxText.style.visibility = "visible";
        DKMessageBoxCancel.style.display = "block";
        DKMessageBoxCancel.style.visibility = "visible";
        byId("DKGui/DKMessageBox.html").style.display = "block";
        byId("DKGui/DKMessageBox.html").style.visibility = "visible";

        DKMessageBoxOk.addEventListener("click", dkmessagebox.onevent);
        DKMessageBoxCancel.addEventListener("click", dkmessagebox.onevent);
        dkmessagebox.callback = callback;
    });
}

dkmessagebox.value = function DKMessageBox_Value(message, callback) {
    byId("DKMessageBoxText").innerHTML = message;
    byId("DKMessageBoxText").style.display = "block";
    byId("DKMessageBoxText").style.visibility = "visible";
    byId("DKMessageBoxInput").style.display = "block";
    byId("DKMessageBoxInput").style.visibility = "visible";
    byId("DKMessageBoxCancel").style.display = "block";
    byId("DKMessageBoxCancel").style.visibility = "visible";
    byId("DKGui/DKMessageBox.html").style.display = "block";
    byId("DKGui/DKMessageBox.html").style.visibility = "visible";
    dkmessagebox.callback = callback;
}
