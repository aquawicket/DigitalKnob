dk.scrolltest = new DKPlugin(dk_scrolltest)

dk.scrolltest.init = function dk_scrolltest_init() {
    dk.create("DKGui/scrolltest.html", function dk_create_callback() {
        dk.create("DKGui/scrolltest1.html", function dk_create_callback() {
            dk.create("DKGui/scrolltest2.html", function dk_create_callback() {
                byId("DKGui/scrolltest.html").appendChild(byId("DKGui/scrolltest1.html"));
                byId("DKGui/scrolltest.html").appendChild(byId("DKGui/scrolltest2.html"));
                byId("bottomdiv").onmousedown = dk.scrolltest.onevent;
            });
        });
    });
}

dk.scrolltest.end = function dk_scrolltest_end() {
    byId("bottomdiv").onmousedown = null;
}

dk.scrolltest.onevent = function dk_scrolltest_onevent(event) {
    DKPlugin("DKGui/DKMessageBox.js", function dk_create_callback() {
        dk.frame.create("DKGui/DKMessageBox.html");
        // dk.messagebox.message("bottomdiv clicked");
    });
}
