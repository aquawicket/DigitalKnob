function SendBugReport_init() {
    dk.create("DKDebug/SendBugReport.css");
    dk.create("DKDebug/SendBugReport.html");
    byId("SendBugReport_Button").addEventListener("click", SendBugReport_onevent);
}

function SendBugReport_end() {
    byId("SendBugReport_Button").removeEventListener("click", SendBugReport_onevent);
    dk.close("DKDebug/SendBugReport.html");
    dk.close("DKDebug/SendBugReport.css");
}

function SendBugReport_onevent(event) {
    console.log("SendBugReport_onevent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")");
    if (event.currentTarget.id === "SendBugReport_Button") {
        SendBugReport_CreateReport();
    }
}

function SendBugReport_CreateReport() {
    var str = byId("SendBugReport_Textarea").value;
    console.log(str + "\n");

    var assets = CPP_DKAssets_LocalAssets();
    var log = CPP_DKFile_FileToString(assets + "log.txt");
    CPP_DKFile_StringToFile(str + "\n\n" + log, assets + "log.txt");
    SendBugReport_SendReport();

    byId("DKDebug/SendBugReport.html").style.display = "none";
    //TODO: say thank you here
    DKPlugin("DKGui/DKMessageBox.js", function dk_create_callback() {
        DKFrame_Html("DKGui/DKMessageBox.html");
        DKMessageBox_Message("Thank You :)");
        DKFrame_Close("DKDebug/SendBugReport.html");
    });
}

function SendBugReport_SendReport() {
    byId("SendBugReport_Image").style.display = "block";
    byId("SendBugReport_Image").style.visibility = "visible";
    byId("SendBugReport_Sending").style.display = "block";
    byId("SendBugReport_Sending").style.visibility = "visible";
    CPP_DK_DoFrame();

    var num = Math.floor((Math.random() * 99999999) + 1);
    CPP_DKDebug_SendBugReport(num.toString());
}
