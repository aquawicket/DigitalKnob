//if(!dk_valid("DK"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}
if(!dk_valid("dk_todo"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_todo.js", function(){});	}

//################################################################################
//# dk_validate(VAR <code>)
//#
//#
dk_validate = function dk_validate_f() {
	//dk_debugFunc(2);
	console.log("dk_validate()");
	
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	console.log("dk_validate("+_ARGV_+")");
	
	if(!dk_valid(arguments[0])){
		eval(arguments[1]);
	}
	//dk_todo("dk_validate");
};





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myVar;
	dk_validate('myVar', 'myVar = "abc";');
	console.log('myVar = '+myVar);
};
