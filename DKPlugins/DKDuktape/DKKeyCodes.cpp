#include "DKDuktape/DKKeyCodes.h"

std::vector<DKKeyMap> keys;

bool MapKey(int decimal, DKString key, DKString description, DKString VK_win, DKString VK_mac, DKString VK_linux, DKString VK_android) {
	DKString hex = int_to_hex(decimal);
	keys.push_back({ decimal, hex, key, });
	return true;
}

// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values
// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code/code_values
bool MapAllKeys() {
	MapKey(0, "Unidentified", "");
	MapKey(1, "Escape", "The Esc (Escape) key.", "VK_ESCAPE", "kVK_Escape", "GDK_KEY_Escape", "KEYCODE_ESCAPE");
	return true;
}

DKString GetKeyAttribute(int key) {
	if (key > keys.size())
		return "error";
	return keys[key].key;
}


bool rtnval = MapAllKeys();