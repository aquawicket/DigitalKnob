console.log("DK.js")

if(DKINIT !== 1){
	window.DKINIT = 1;
	window.DK = function DK(){
		console.log("DK()")
			
		DKTEST()
	}; DK();
}