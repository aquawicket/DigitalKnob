//alert("Calculator")

function insertValue(value) {
	if (isClear == true){
		document.getElementById("txtDisplay").value = value
		isClear = false
	} else {
		document.getElementById("txtDisplay").value += value
	}
}

function clearValue() {
	document.getElementById("txtDisplay").value = "0";
	isClear = true;
}

function evalStatement() {
	document.getElementById("txtDisplay").value = eval(document.getElementById("txtDisplay").value)
}
	
function main(){

	window.resizeTo(350, 350);
	isClear = true;
	
	var calculator_gui =
	'	<div style="text-align: center">' +
	'		<input type="text" id="txtDisplay" style="font-size: 24px; width: 220px; text-align: right" value="0" /><br /><br />' +
	'		<input type="button" style="height:50px;width:50px" value="7" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="8" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="9" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="*" onclick="insertValue(this.value)"></input><br />' +
	'		<input type="button" style="height:50px;width:50px" value="4" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="5" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="6" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="-" onclick="insertValue(this.value)"></input><br />' +
	'		<input type="button" style="height:50px;width:50px" value="1" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="2" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="3" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="+" onclick="insertValue(this.value)"></input><br />' +
	'		<input type="button" style="height:50px;width:50px" value="CLR" onclick="clearValue()"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="0" onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="." onclick="insertValue(this.value)"></input>' +
	'		<input type="button" style="height:50px;width:50px" value="=" onclick="evalStatement()"></input><br />' +
	'	</div>'

	document.body.innerHTML = calculator_gui;
}
