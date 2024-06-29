if(typeof DK !== 'function'){ 
	console.log("DK.js")
	
	window.DK = function DK(){
		console.log("DK()")

		dk_load("dk_debugFunc", function(){
		dk_load("dk_set", function(){
		dk_load("dk_unset", function(){
		dk_load("dk_color", function(){
		dk_load("dk_echo", function(){
		dk_load("dk_echo", function(){
			console.log("done loading dk functions");
			DKTEST()
		});
		});
		});	
		});	
		});
		});
	};

	var script = document.createElement('script');
	script.src = "dk_load.js";
	script.onreadystatechange = script.onload = DK;
	document.head.appendChild(script);
};
