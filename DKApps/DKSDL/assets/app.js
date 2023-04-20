CPP_DK_Create("DKSdlWindow")
CPP_DK_Create("DKWindow")
CPP_DK_Create("DKSdlText")

console.log("CPP_DKWindow_TestInt(1234) = "+CPP_DKWindow_TestInt(1234)+"\n")
console.log("CPP_DKWindow_TestString(\"test string\") = "+CPP_DKWindow_TestString("test string")+"\n")
console.log("CPP_DKWindow_TestReturnInt() = "+CPP_DKWindow_TestReturnInt()+"\n")
console.log("CPP_DKWindow_TestReturnString() = "+CPP_DKWindow_TestReturnString()+"\n")


//ANDROID back key = exit
window.addEventListener("keydown", User_OnEvent)

function User_OnEvent(event){
	if(event.type === "keydown"){
		console.log("KEYDOWN: "+event.value)
		if(event.value == "4"){ //FIXME: Exit for ANDROID button
		    CPP_DK_Exit()
		}
	}
}
