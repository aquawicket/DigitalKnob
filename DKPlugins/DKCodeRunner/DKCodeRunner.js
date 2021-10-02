
function DKCodeRunner(){}
dk.coderunner = DKPlugin(DKCodeRunner)

DKCodeRunner.prototype.init = function DKCodeRunner_init() {
	console.log("DKCodeRunner.prototype.init()")
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
	
	const div = document.createElement("div")
	div.style.position = "absolute"
	div.style.top = "35px"
	div.style.left = "5px"
	div.style.bottom = "5px"
	div.style.right = "5px"
	div.style.backgroundColor = "rgb(250,250,250)"
	document.body.appendChild(div)
	
	const textarea = document.createElement("textarea")
	textarea.style.position = "absolute"
	textarea.style.top = "0px"
	textarea.style.left = "0px"
	textarea.style.bottom = "0px"
	textarea.style.right = "000px"
	textarea.style.width = "100%"
	textarea.style.height = "100%"
	textarea.style.fontSize = "18rem"
	textarea.style.color = "rgb(200,200,200)"
	textarea.style.backgroundColor = "rgb(30,30,30)"
	div.appendChild(textarea)
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
	
	const runCode = document.createElement("button")
	runCode.style.position = "absolute"
	runCode.style.top = "0px"
	runCode.style.left = "50px"
	runCode.style.width = "100px"
	runCode.style.height = "20px"
	runCode.style.color = "rgb(20,20,20)"
	runCode.style.backgroundColor = "rgb(200,200,200)"
	runCode.innerHTML = "Run Code"
	runCode.onclick = function (event) {
		console.log("*** Running Code ***")
		try {
			eval(textarea.value);
		} 
		catch (err) {
			console.error(err);
		}
	}
	document.body.appendChild(runCode)
	
	const pushAssets = document.createElement("button")
	pushAssets.style.position = "absolute"
	pushAssets.style.top = "0px"
	pushAssets.style.left = "350px"
	pushAssets.style.width = "100px"
	pushAssets.style.height = "20px"
	pushAssets.style.color = "rgb(20,20,20)"
	pushAssets.style.backgroundColor = "rgb(200,200,200)"
	pushAssets.innerHTML = "Push Assets"
	pushAssets.onclick = function(event) {
		dk.file.pushDKAssets()
	}
	document.body.appendChild(pushAssets)
	
	const pullAssets = document.createElement("button")
	pullAssets.style.position = "absolute"
	pullAssets.style.top = "0px"
	pullAssets.style.left = "200px"
	pullAssets.style.width = "100px"
	pullAssets.style.height = "20px"
	pullAssets.style.color = "rgb(20,20,20)"
	pullAssets.style.backgroundColor = "rgb(200,200,200)"
	pullAssets.innerHTML = "Pull Assets"
	pullAssets.onclick = function(event) {
		dk.file.pushDKAssets()
	}
	document.body.appendChild(pullAssets)
	
	/*
	const folderIcon = document.createElement("img")
	folderIcon.src = "DKCodeRunner/folderIcon.png"
	folderIcon.style.position = "absolute"
	folderIcon.style.top = "3rem"
	folderIcon.style.right = "50rem"
	folderIcon.style.width = "35rem"
	folderIcon.style.height = "30rem"
	folderIcon.onclick = function(event) {
		DKPlugin("DKFile/filemanager.js", function fm_onload() {
			console.log("done")
            DKFileManager.prototype.init();
            DKFileManager.prototype.create();
        });
		DKFileManager.prototype.init();
        DKFileManager.prototype.create();
	}
	document.body.appendChild(folderIcon)
	*/
	
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
            DKFileManager.prototype.init()
            DKFileManager.prototype.create()
        });
    })
	
	dk.gui.createImageButton(document.body, "Debugger", "DKCodeRunner/Debugger.png", "3rem", "", "", "10rem", "35rem", "30rem", function() {
        if(dk.getBrowser() === "Rml")
			CPP_DKRml_DebuggerToggle()
	})
}

DKCodeRunner.prototype.close = function DKCodeRunner_close(){
	console.log("DKCodeRunner.prototype.close()")
	//TODO
}
