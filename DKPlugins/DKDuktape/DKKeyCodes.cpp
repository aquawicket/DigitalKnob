#include "DKDuktape/DKKeyCodes.h"

std::vector<DKKeyMap> keys;

bool MapKey(int decimal, DKString key, DKString description, DKString VK_win, DKString VK_mac, DKString VK_linux, DKString VK_android) {
#ifdef VK_RETURN
	DKINFO("Detected windows keyboard setup");
#endif
	DKString hex = int_to_hex(decimal);
	keys.push_back({ decimal, hex, key, });
	return true;
}

DKString GetKeyAttribute(unsigned int key) {
	if (key > keys.size())
		return "error";
	return keys[key].key;
}

DKString GetCodeAttribute(unsigned int key) {
	if (key > keys.size())
		return "error";
	return keys[key].code;
}


// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values
// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code/code_values
bool MapAllKeys() {
	MapKey(0, "Unidentified", "");
	MapKey(27, "Escape", "The Esc (Escape) key.", "VK_ESCAPE", "kVK_Escape", "GDK_KEY_Escape", "KEYCODE_ESCAPE");
	return true;
}



bool rtnval = MapAllKeys();