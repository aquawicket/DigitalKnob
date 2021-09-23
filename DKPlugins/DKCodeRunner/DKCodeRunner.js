
//dk.coderunner = DKPlugin(DKCodeRunner)
function DKCodeRunner() {}


DKCodeRunner.prototype.init = function DKCodeRunner_init() {
    //dk.create("DKGui/DKConsole.css")
	//DKPlugin("DKFile/DKFile.js")
}

DKCodeRunner.prototype.end = function DKCodeRunner_end() {
    dk.close("DKGui/DKConsole.css");
}

DKCodeRunner.prototype.create = function DKCodeRunner_create(parent, top, bottom, left, right, width, height) {
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
	textarea.oncontextmenu = function container_oncontextmenu(event) {
		event.preventDefault();
		DKPlugin("DKGui/DKMenu.js", function(DKClass) {
			const dkmenu = DKClass.prototype.create();
			dkmenu.addItem("Clear console", 
			function DKMenu_Clear() {
				dk.console.clear();
			});
		});
	}
	
	const button = document.createElement("button")
	button.style.position = "absolute"
	button.style.top = "0px"
	button.style.left = "2px"
	button.style.width = "100px"
	button.style.height = "20px"
	button.style.color = "rgb(20,20,20)"
	button.style.backgroundColor = "rgb(200,200,200)"
	button.innerHTML = "Run Code"
	button.onclick = function(event) {
    console.log("*** Running Code ***")
		try {
			eval(textarea.value);
		} catch (err) {
			console.error(err);
		}
	}
	document.body.appendChild(button)
	
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
	//TODO
}


dk.coderunner = DKPlugin(DKCodeRunner)
