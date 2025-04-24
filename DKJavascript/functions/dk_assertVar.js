dk_source(DKJAVASCRIPT_DIR+"/functions/dk_error.js", function(){


//################################################################################
//# dk_assertVar(expression)
//#
dk_assertVar = function dk_assertVar_f(variable){
	//dk_debugFunc 0

	if(typeof globalThis[variable] !== "undefined"){ 
		return;
	}

	dk_error("ASSERTION: dk_assertVar(%*): "+variable+" not defined");
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(callback){
	//dk_debugFunc(0)
	console.log("dk_assertVar DKTEST()");

    //dk_set(myVar string);
	myVar = "string";
	dk_assertVar('myVar');

    myVarB=15;
	dk_assertVar('myVarB');

    myVarC="  ";
	dk_assertVar('myVarC');

    myVarD=" ";
	dk_assertVar('myVarD');

	//myVarE=99;
    //dk_unset(myVarE);
	dk_assertVar('myVarE');

    //console.log("dk_assertVar(noVar)");
	dk_assertVar('noVar');
	
	if(callback){ callback(); }
}

//# sourceURL=dk_assertVar.js
});