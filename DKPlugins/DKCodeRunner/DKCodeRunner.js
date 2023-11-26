
function DKCodeRunner(){}
dk.coderunner = DKPlugin(DKCodeRunner)

DKCodeRunner.prototype.init = function DKCodeRunner_init() {
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKGui.js")
	DKPlugin("DKGui/DKFrame.js")
	DKPlugin("DKGui/DKMenu.js")
	this.create()
}

DKCodeRunner.prototype.end = function DKCodeRunner_end() {
	console.log("DKCodeRunner.prototype.end()")
}

DKCodeRunner.prototype.create = function DKCodeRunner_create(parent, top, bottom, left, right, width, height) {
	console.log("DKCodeRunner.prototype.create()")
	
	const textareaDiv = document.createElement("div")
	textareaDiv.style.position = "absolute"
	textareaDiv.style.top = "35rem"
	textareaDiv.style.left = "5rem"
	textareaDiv.style.bottom = "5rem"
	textareaDiv.style.right = "5rem"
	document.body.appendChild(textareaDiv)
	
	const textarea = document.createElement("textarea")
	textarea.style.position = "absolute"
	textarea.style.top = "0rem"
	textarea.style.left = "0rem"
	textarea.style.bottom = "0rem"
	textarea.style.right = "0rem"
	textarea.style.width = "100%"
	textarea.style.height = "100%"
	textarea.style.fontSize = "18rem"
	textarea.style.color = "rgb(200,200,200)"
	textarea.style.backgroundColor = "rgb(30,30,30)"
	textareaDiv.appendChild(textarea)
	
	dk.file.exists("USER/cache.txt", function(result){
		if(result){
			dk.file.fileToString("USER/cache.txt", function(str){
				if(!str)
					console.error("dk.file.fileToString(USER/cache.txt): failed")
				else
					textarea.value = str
			})
		}
	}, 0)

	textarea.oncontextmenu = function textarea_oncontextmenu(event) {
		event.preventDefault();
		const dkmenu = DKMenu.prototype.create(textarea)
		dkmenu.addItem("Test", function dk_menu_test(){
			console.log("clicked Test")
		})
		dkmenu.addItem("Test 2", function dk_menu_test2(){
			console.log("clicked Test 2")
		})
	}
	
	
	// CEF ///////////////////////////////////////////////
	textarea.oninput = function textarea_oninput(event) {
		console.log("input")
		dk.coderunner.saveCache(textarea.value)
	}
	// RML /////////////////////////////////////////////////
	textarea.onchange = function textarea_onchange(event) {
		console.log("change")
		dk.coderunner.saveCache(textarea.value)
	}
	
	dk.gui.createButton(document.body, "Run Code", "4rem", "", "50rem", "", "100rem", "20rem", function() {
        console.log("*** Running Code ***")
		try {
			eval(textarea.value);
		} 
		catch (err) {
			console.error(err);
		}
    })
	
	dk.gui.createButton(document.body, "Pull Assets", "4rem", "", "200rem", "", "100rem", "20rem", function() {
        dk.file.pullDKAssets()
    })
	
	dk.gui.createButton(document.body, "Push Assets", "4rem", "", "350rem", "", "100rem", "20rem", function() {
        dk.file.pushDKAssets()
    })
	
	dk.gui.createImageButton(document.body, "Message Box", "DKCodeRunner/messageboxIcon.png", "3rem", "", "", "90rem", "35rem", "30rem", function() {
        DKPlugin("DKGui/DKMessageBox.js", function() {
            DKMessageBox.prototype.createConfirm("Restart Yes or No?", function dk_messagebox_createConfirm_callback(rval) {
                if (rval) {
                    console.log("you clicked "+rval);
                }
			});
		});
	})
	
	dk.gui.createImageButton(document.body, "File Manager", "DKCodeRunner/folderIcon.png", "3rem", "", "", "50rem", "35rem", "30rem", function() {
        DKPlugin("DKFile/filemanager.js", function() {
			DKFileManager.prototype.create();
		});
    })
	
	dk.gui.createImageButton(document.body, "Debugger", "DKCodeRunner/Debugger.png", "3rem", "", "", "10rem", "35rem", "30rem", function() {
        if(dk.getBrowser() === "Rml")
			CPP_DKRml_DebuggerToggle()
		if(dk.getBrowser() === "Cef")
			CPP_DKCef_ShowDevTools()
	})
}

DKCodeRunner.prototype.saveCache = function DKCodeRunner_saveCache(str){
	dk.file.stringToFile(str, "USER/cache.txt", 0, function(result){
		//DUMP({result})
	})
}


DKCodeRunner.prototype.close = function DKCodeRunner_close(){
	console.log("DKCodeRunner.prototype.close()")
	//TODO
}
