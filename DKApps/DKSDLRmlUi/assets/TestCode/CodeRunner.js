console.log("CodeRunner.js")

DKPlugin("DKFile/DKFile.js")


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
textarea.onchange = function(event){
    console.log(textarea.value)
    //TODO - save to file
	

    //dk.file.stringToFile(codeMirror.getValue(), "USER/devtoolscode.js")
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
button.onclick = function(event){
	console.log("*** Running Code ***")
    CPP_DK_RunDuktape(textarea.value)
}


document.body.appendChild(button)
console.log("CodeRunner.js loaded")
