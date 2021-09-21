

function DKScriptOnloadTest() {}

DKScriptOnloadTest.prototype.init = function DKScriptOnloadTest_init() {
	console.log("\n\n DKScriptOnloadTest.prototype.init() \n\n");
	this.funcA()
	dk.script_onload_test.funcB()
}

DKScriptOnloadTest.prototype.end = function DKScriptOnloadTest_end() {
	console.log("\n\n DKScriptOnloadTest.prototype.end() \n\n");
}
	
DKScriptOnloadTest.prototype.funcA = function DKScriptOnloadTest_funcA() {
	console.log("\n\n DKScriptOnloadTest.prototype.funcA() \n\n");
}

DKScriptOnloadTest.prototype.funcB = function DKScriptOnloadTest_funcB() {
	console.log("\n\n DKScriptOnloadTest.prototype.funcB() \n\n");
}	
	
	
	
	

dk.script_onload_test = DKPlugin(DKFile)