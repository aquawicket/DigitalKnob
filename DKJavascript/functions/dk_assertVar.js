if(typeof dk_fatal === "undefined"){ 		dk_source(DKJAVASCRIPT_DIR+"/functions/dk_fatal.js", 		function(){}); }
if(typeof dk_debugFunc === "undefined"){ 	dk_source(DKJAVASCRIPT_DIR+"/functions/dk_debugFunc.js", 	function(){}); }
if(typeof dk_set === "undefined"){ 			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_set.js", 			function(){}); }
if(typeof dk_echo === "undefined"){ 		dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js", 		function(){}); }

//################################################################################
//# dk_assertVar(expression)
//#
dk_assertVar = function dk_assertVar_f() {
	//dk_debugFunc 0
	
	if(arguments[0]){ return }

	dk_debugFunc(1)
    dk_fatal("ASSERTION: dk_assertVar(%*): %~1 not defined")
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0)

    dk_set(myVar string)
    dk_echo("dk_assertVar(myVar)")
	dk_assertVar(myVar)

    dk_set(myVarB 15)
    dk_echo("dk_assertVar(myVarB)")
	dk_assertVar(myVarB)

    dk_set(myVarC "  ")
    dk_echo("dk_assertVar(myVarC)")
	dk_assertVar(myVarC)

    dk_set(myVarD " ")
    dk_echo("dk_assertVar(myVarD)")
	dk_assertVar(myVarD)

	dk_set(myVarE 99)
    dk_unset(myVarE)
    dk_echo("dk_assertVar(myVarE)")
	dk_assertVar(myVarE)

    dk_echo("dk_assertVar(noVar)")
	dk_assertVar(noVar)
}

//# sourceURL=dk_assertVar.js
