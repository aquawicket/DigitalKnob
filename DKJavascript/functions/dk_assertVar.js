dk_depend("dk_error");


//################################################################################
//# dk_assertVar(expression)
//#
dk_assertVar = function dk_assertVar_f(variable){
	//dk_debugFunc 0

	if(dk_valid(variable)){
		return;
	}

	dk_error("ASSERTION: dk_assertVar("+arguments[0]+"): "+variable+" not defined");
	return 1;
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(callback){
	//dk_debugFunc(0)

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
