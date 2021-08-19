
let key = 0;
while(key !== 10){
	key = CPP_DK_GetKey();
	console.log(KeyTranslator_KeyToKeyboardEventCode(key))
}

// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
function KeyTranslator_KeyToKeyboardEventCode(num) {
	//TODO
	if(key === 65){
		return "KeyA";
	}
	return "unassigned";
}