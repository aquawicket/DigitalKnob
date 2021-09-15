//Validate settings
if (DK_GetOS() === "Android" || DK_GetOS() === "iOS") {
    USE_CEF = 0;
    USE_SDL = 1;
    USE_RML = 1;
    USE_WEBVIEW = 0;
    //TODO
} else {
    USE_WEBVIEW = 0;
}

function init_init() {}

function init_end() {}

//Duktape
function init_onevent(event) {
    console.log("Init_onevent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")\n");

    if (event.type === "resize") {
        //NOTE: this is for SDL, OSG, ROCKET or any other created windows.
        DK_CallFunc("DKSDLCef::OnResize", "SdlWindow,0,0," + String(DKWindow_GetWidth()) + "," + String(DKWindow_GetHeight()));
    }
    if (event.type === "keydown" && event.code === "Back") {
        //NOTE: this is the back button on Android
        DK_Exit();
    }
}

if (DK_GetJSEngine() === "Duktape") {
    //C++: Create a window LoadPage() can support
    if (USE_RML && USE_CEF) {
        console.log("Creating SDL -> Rocket -> Cef -> GUI\n");
        CPP_DK_Create("DKWindow");
        DKWindow_Create();
        CPP_DK_Create("DKRocket");
        DKRocket_LoadUrl("DKRocket/blank.html");
        CPP_DK_Create("DKWidget");
        var iframe = DK_CreateElement(byId("body"), "iframe", "DKCef_frame");
        iframe.style.position = "absolute";
        iframe.style.top = "0rem";
        iframe.style.left = "0rem";
        iframe.style.width = "100%";
        iframe.style.height = "100%";
        iframe.style.right = "0rem";
        //iframe.style.bottom = "0rem";
        iframe.src = DKApp_url;
        CPP_DKCef_SetFocus(CPP_DKCef_GetCurrentBrowser());
    } else if (USE_RML) {
        console.log("Creating SDL -> ROCKET -> GUI\n");
        CPP_DK_Create("DKWindow");
        DKWindow_Create();
        CPP_DK_Create("DKRml");
        DKRocket_LoadUrl("index.html");
    } else if (USE_SDL && USE_CEF) {
        console.log("Creating SDL -> CEF -> GUI\n");
        CPP_DK_Create("DKWindow");
        DKWindow_Create();
        var width = DKWindow_GetWidth();
        var height = DKWindow_GetHeight();
        CPP_DK_Create("DKCef");
        CPP_DKCef_NewBrowser("SdlWindow", 0, 0, width, height, DKApp_url);
        CPP_DKCef_SetFocus(0);
        window.addEventListener("resize", init_onevent);
        DK_CallFunc("DKSDLCef::OnResize", "SdlWindow,0,0," + String(DKWindow_GetWidth()) + "," + String(DKWindow_GetHeight()));
    } else if (USE_CEF) {
        console.log("Creating CEF -> GUI\n");
        var assets = DKAssets_LocalAssets();
        var width = Number(DKFile_GetSetting(assets + "settings.txt", "[WIDTH]"));
        var height = Number(DKFile_GetSetting(assets + "settings.txt", "[HEIGHT]"));
        CPP_DK_Create("DKCef");
        CPP_DKCef_NewBrowser("CefWindow", 0, 0, width, height, DKApp_url);
        CPP_DKCef_SetFocus(CPP_DKCef_GetCurrentBrowser());
        CPP_DK_Create("DKWindow");
    } else if (USE_WEBVIEW) {
        //TODO
        console.log("Creating WEBVIEW -> GUI\n");
        window.addEventListener("keydown", init_onevent);
    }

    if (typeof app_LoadPlugins === "function") {
        app_LoadPlugins();
    }
}
