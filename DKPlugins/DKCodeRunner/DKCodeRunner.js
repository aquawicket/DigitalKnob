
function DKCodeRunner(){}
dk.coderunner = DKPlugin(DKCodeRunner)

DKCodeRunner.prototype.init = function DKCodeRunner_init() {
	console.log("DKCodeRunner.prototype.init()")
	//dk.create("DKGui/DKConsole.css")
	DKPlugin("DKFile/DKFile.js")
	DKPlugin("DKGui/DKMenu.js")
	this.create()
}

DKCodeRunner.prototype.end = function DKCodeRunner_end() {
	console.log("DKCodeRunner.prototype.end()")
	
    dk.close("DKGui/DKConsole.css");
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
	textarea.style.fontSize = "14px"
	textarea.style.color = "rgb(200,200,200)"
	textarea.style.backgroundColor = "rgb(30,30,30)"
	div.appendChild(textarea)
	textarea.oncontextmenu = function textarea_oncontextmenu(event) {
		event.preventDefault();
		
		const dkmenu = DKMenu.prototype.create(textarea)
		/*
		dkmenu.div.setAttribute("dk_menu", "menu")
		dkmenu.div.style.position = "absolute"
		dkmenu.div.style.top = window.mouseY + "rem"
		dkmenu.div.style.left = window.mouseX + "rem"
		dkmenu.div.style.borderColor = "rgb(22,20,20)"
		dkmenu.div.style.backgroundColor = "rgb(51, 47, 47)"
		dkmenu.div.style.padding = "0rem"
		dkmenu.div.style.width = "150rem"
		dkmenu.div.style.minHeight = "18rem"
		dkmenu.div.style.borderStyle = "solid"
		dkmenu.div.style.borderWidth = "1rem"
		dkmenu.div.style.borderTopWidth = "1rem"
		dkmenu.div.style.borderLeftWidth = "1rem"
		dkmenu.div.style.borderRightWidth = "1rem"
		dkmenu.div.style.borderBottomWidth = "0rem"
		//dkmenu.div.style.right = "unset"
		dkmenu.div.style.removeProperty("right")
		dkmenu.validatePosition()
		*/
		dkmenu.addItem("Test", function dk_menu_test() {
			console.log("clicked Test")
		})
		/*
		dkmenu.div.dkmenuItem.setAttribute("dk_menu", "item");
		dkmenu.div.dkmenuItem.class = "option";
		dkmenu.div.dkmenuItem.style.position = "absolute";
		dkmenu.div.dkmenuItem.style.paddingTop = "2rem";
		dkmenu.div.dkmenuItem.style.paddingLeft = "4rem";
		dkmenu.div.dkmenuItem.style.cursor = "pointer";
		dkmenu.div.dkmenuItem.style.whiteSpace = "pre-wrap";
		dkmenu.div.dkmenuItem.style.boxSizing = "border-box";
		dkmenu.div.dkmenuItem.style.borderColor = "rgb(22,20,20)"
		dkmenu.div.dkmenuItem.style.borderStyle = "solid";
		dkmenu.div.dkmenuItem.style.borderBottomWidth = "1rem";
		dkmenu.div.dkmenuItem.style.borderTopWidth = "0rem";
		dkmenu.div.dkmenuItem.style.borderLeftWidth = "0rem";
		dkmenu.div.dkmenuItem.style.borderRightWidth = "0rem";
		*/
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
}

DKCodeRunner.prototype.close = function DKCodeRunner_close(){
	console.log("DKCodeRunner.prototype.close()")
	//TODO
}
