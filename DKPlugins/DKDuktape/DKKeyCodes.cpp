#include "DKDuktape/DKKeyCodes.h"

// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values
// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code/code_values

std::map<Key, DKKeyCodes::KeyboardEventMap> DKKeyCodes::keys;

void DKKeyCodes::mapKey(Key name, DKString key, DKString code, int location) {
    DKString vk_keycode = int_to_hex(name);
    int which = name;
    keys[name] = KeyboardEventMap{code, vk_keycode, key, location, which};
}

void DKKeyCodes::mapKeys() {
    //https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values
    //mapKey(KEY_Name,    " code",   " key");

    // Special values //
    mapKey(KEY_UNASSIGNED, "Unidentified", "Unidentified");
    mapKey(KEY_RESERVED, "Reserved", "Reserved");

    // Modifier keys //
    mapKey(KEY_ALT, "Alt", "Alt");
    mapKey(KEY_ALTLEFT, "Alt", "AltLeft", 1);
    mapKey(KEY_ALTRIGHT, "Alt", "AltRight", 2);
    //mapKey(KEY_ALTGRAPH, "AltGraph", "");
    mapKey(KEY_CAPSLOCK, "CapsLock", "CapsLock");
    mapKey(KEY_CONTROL, "Control", "Control");
    mapKey(KEY_CONTROLLEFT, "Control", "ControlLeft", 1);
    mapKey(KEY_CONTROLRIGHT, "Control", "ControlRight", 2);
    //mapKey(KEY_FN, "Fn", "Fn");
    //mapKey(KEY_FNLOCK, "FnLock", "FnLock");
    //mapKey(KEY_HYPER, "Hyper", "Hyper");
    //mapKey(KEY_WIN, "Meta", "Meta");
    mapKey(KEY_METALEFT, "Meta", "MetaLeft", 1);
    mapKey(KEY_METARIGHT, "Meta", "MetaRight", 2);
    mapKey(KEY_NUMLOCK, "NumLock", "NumLock");
    mapKey(KEY_SCROLLLOCK, "ScrollLock", "ScrollLock");
    mapKey(KEY_SHIFT, "Shift", "Shift");
    mapKey(KEY_SHIFTLEFT, "Shift", "ShiftLeft", 1);
    mapKey(KEY_SHIFTRIGHT, "Shift", "ShiftRight", 2);
    //mapKey(KEY_SUPER, "Super", "Super");
    //mapKey(KEY_SYMBOL, "Symbol", "Symbol");
    //mapKey(KEY_SYMBOLLOCK, "SymbolLock", "SymbolLock");

    //Whitespace keys
    mapKey(KEY_ENTER, "Enter", "Enter");
    mapKey(KEY_TAB, "Tab", "Tab");
    mapKey(KEY_SPACE, " ", "Space");

    // Navagation Keys
    mapKey(KEY_DOWN, "ArrowDown", "ArrowDown");
    mapKey(KEY_LEFT, "ArrowLeft", "ArrowLeft");
    mapKey(KEY_RIGHT, "ArrowRight", "ArrowRight");
    mapKey(KEY_RIGHT, "ArrowUp", "ArrowUp");
    mapKey(KEY_END, "End", "End");
    mapKey(KEY_BROWSER_HOME, "Home", "Home");
    mapKey(KEY_PAGEDOWN, "PageDown", "PageDown");
    mapKey(KEY_PAGEUP, "PageUp", "PageUp");

    //Editing keys
    mapKey(KEY_BACK, "Backspace", "BackSpace");
    mapKey(KEY_CLEAR, "Clear", "");
    mapKey(KEY_APPCOMMAND_COPY, "Copy", "Copy");
    mapKey(KEY_CRSEL, "CrSel", "CrSel");
    mapKey(KEY_APPCOMMAND_CUT, "Cut", "Cut");
    mapKey(KEY_DELETE, "Delete", "Delete")
        mapKey(KEY_ERASEEOF, "EraseEof", "EraseEof");








    //mapKey(KEY_LBUTTON, "", "");
    //mapKey(KEY_RBUTTON, "", "");
    mapKey(KEY_CANCEL, "Cancel", "");
    //mapKey(KEY_MBUTTON, "", "");
    //mapKey(KEY_XBUTTON1, "", "");
    //mapKey(KEY_XBUTTON2, "", "");
    
    mapKey(KEY_TAB, "Tab", "Tab");
    
    mapKey(KEY_PAUSE, "Pause", "Pause");
    mapKey(KEY_KANA, "KanaMode", "");
    mapKey(KEY_JUNJA, "JunjaMode", "");
    mapKey(KEY_FINAL, "FinalMode", "");
    mapKey(KEY_HANJA, "HanjaMode", "");
    mapKey(KEY_ESCAPE, "Escape", "Escape");
    mapKey(KEY_CONVERT, "Convert", "");
    mapKey(KEY_NONCONVERT, "NonConvert", "");
    mapKey(KEY_ACCEPT, "Accept", "");
    mapKey(KEY_MODECHANGE, "ModeChange", "");
    mapKey(KEY_SPACE, " ", "Space");
    

    
    mapKey(KEY_SELECT, "Select", "");
    //mapKey(KEY_PRINT, "", "");
    mapKey(KEY_EXECUTE_, "Execute", "");
    mapKey(KEY_SNAPSHOT, "PrintScreen", "");
    mapKey(KEY_INSERT, "Insert", "Insert");
    mapKey(KEY_DELETE, "Delete", "Delete");
    mapKey(KEY_HELP, "Help", "");  
    mapKey(KEY_0, "0", "Digit0");
    mapKey(KEY_1, "1", "Digit1");
    mapKey(KEY_2, "2", "Digit2");
    mapKey(KEY_3, "3", "Digit3");
    mapKey(KEY_4, "4", "Digit4");
    mapKey(KEY_5, "5", "Digit5");
    mapKey(KEY_6, "6", "Digit6");
    mapKey(KEY_7, "7", "Digit7");
    mapKey(KEY_8, "8", "Digit8");
    mapKey(KEY_9, "9", "Digit9");
    mapKey(KEY_A, "a", "KeyA");
    mapKey(KEY_B, "b", "KeyB");
    mapKey(KEY_C, "c", "KeyC");
    mapKey(KEY_D, "d", "KeyD");
    mapKey(KEY_E, "e", "KeyE");
    mapKey(KEY_F, "f", "KeyF");
    mapKey(KEY_G, "g", "KeyG");
    mapKey(KEY_H, "h", "KeyH");
    mapKey(KEY_I, "i", "KeyI");
    mapKey(KEY_J, "j", "KeyJ");
    mapKey(KEY_K, "k", "KeyK");
    mapKey(KEY_L, "l", "KeyL");
    mapKey(KEY_M, "m", "KeyM");
    mapKey(KEY_N, "n", "KeyN");
    mapKey(KEY_O, "o", "KeyO");
    mapKey(KEY_P, "p", "KeyP");
    mapKey(KEY_Q, "q", "KeyQ");
    mapKey(KEY_R, "r", "KeyR");
    mapKey(KEY_S, "s", "KeyS");
    mapKey(KEY_T, "t", "KeyT");
    mapKey(KEY_U, "u", "KeyU");
    mapKey(KEY_V, "v", "KeyV");
    mapKey(KEY_W, "w", "KeyW");
    mapKey(KEY_X, "x", "KeyX");
    mapKey(KEY_Y, "y", "KeyY");
    mapKey(KEY_Z, "z", "KeyZ");
    mapKey(KEY_APPS, "", "");
    mapKey(KEY_SLEEP, "", "");
    mapKey(KEY_NUMPAD0, "0", "Numpad0");
    mapKey(KEY_NUMPAD1, "1", "Numpad1");
    mapKey(KEY_NUMPAD2, "2", "Numpad2");
    mapKey(KEY_NUMPAD3, "3", "Numpad3");
    mapKey(KEY_NUMPAD4, "4", "Numpad4");
    mapKey(KEY_NUMPAD5, "5", "Numpad5");
    mapKey(KEY_NUMPAD6, "6", "Numpad6");
    mapKey(KEY_NUMPAD7, "7", "Numpad7");
    mapKey(KEY_NUMPAD8, "8", "Numpad8");
    mapKey(KEY_NUMPAD9, "9", "Numpad9");
    mapKey(KEY_MULTIPLY, "*", "NumpadMultiply");
    mapKey(KEY_ADD, "+", "NumpadAdd");
    mapKey(KEY_SEPERATOR, "", "");
    mapKey(KEY_SUBTRACT, "-", "NumpadSubtract");
    mapKey(KEY_DECIMAL, ".", "NumpadDecimal");
    mapKey(KEY_DIVIDE, "/", "NumpadDivide");
    mapKey(KEY_F1, "F1", "F1");
    mapKey(KEY_F2, "F2", "F2");
    mapKey(KEY_F3, "F3", "F3");
    mapKey(KEY_F4, "F4", "F4");
    mapKey(KEY_F5, "F5", "F5");
    mapKey(KEY_F6, "F6", "F6");
    mapKey(KEY_F7, "F7", "F7");
    mapKey(KEY_F8, "F8", "F8");
    mapKey(KEY_F9, "F9", "F9");
    mapKey(KEY_F10, "F10", "F10");
    mapKey(KEY_F11, "F11", "F11");
    mapKey(KEY_F12, "F12", "F12");
    mapKey(KEY_F13, "F13", "F13");
    mapKey(KEY_F14, "F14", "F14");
    mapKey(KEY_F15, "F15", "F15");
    mapKey(KEY_F16, "F16", "F16");
    mapKey(KEY_F17, "F17", "F17");
    mapKey(KEY_F18, "F18", "F18");
    mapKey(KEY_F19, "F19", "F19");
    mapKey(KEY_F20, "F20", "F20");
    mapKey(KEY_F21, "F21", "F21");
    mapKey(KEY_F22, "F22", "F22");
    mapKey(KEY_F23, "F23", "F23");
    mapKey(KEY_F24, "F24", "F24");
    mapKey(KEY_NUMLOCK, "NumLock", "NumLock");

    mapKey(KEY_OEM_FJ_JISHO, "", "");
    mapKey(KEY_OEM_FJ_MASSHOU, "", "");
    mapKey(KEY_OEM_FJ_TOUROKU, "", "");
    mapKey(KEY_OEM_FJ_LOYA, "", "");
    mapKey(KEY_OEM_FJ_ROYA, "", "");

    mapKey(KEY_BROWSER_BACK, "BrowserBack", "");
    mapKey(KEY_BROWSER_FORWARD, "BrowserForward", "");
    mapKey(KEY_BROWSER_REFRESH, "BrowserRefresh", "");
    mapKey(KEY_BROWSER_STOP, "BrowserStop", "");
    mapKey(KEY_BROWSER_SEARCH, "BrowserSearch", "");
    mapKey(KEY_BROWSER_FAVORITES, "BrowserFavorites", "");
    mapKey(KEY_BROWSER_HOME, "Home", "Home");
    mapKey(KEY_VOLUME_MUTE, "AudioVolumeMute", "");
    mapKey(KEY_VOLUME_DOWN, "AudioVolumeDown", "");
    mapKey(KEY_VOLUME_UP, "AudioVolumeUp", "");
    mapKey(KEY_MEDIA_NEXT_TRACK, "MediaTrackNext", "");
    mapKey(KEY_MEDIA_PREV_TRACK, "MediaTrackPrevious", "");
    mapKey(KEY_MEDIA_STOP, "MediaStop", "");
    mapKey(KEY_MEDIA_PLAY_PAUSE, "MediaPlayPause", "");
    mapKey(KEY_LAUNCH_MAIL, "LaunchMail", "");
    mapKey(KEY_LAUNCH_MEDIA_SELECT, "", "");
    mapKey(KEY_LAUNCH_APP1, "LaunchApplication1", "");
    mapKey(KEY_LAUNCH_APP2, "LaunchApplication2", "");
    mapKey(KEY_RESERVED, "", "");
    mapKey(KEY_OEM_1, "", "");
    mapKey(KEY_OEM_PLUS, "", "");
    mapKey(KEY_OEM_COMMA, "", "");
    mapKey(KEY_OEM_MINUS, "", "");
    mapKey(KEY_OEM_PERIOD, "", "");
    mapKey(KEY_OEM_2, "", "");
    mapKey(KEY_OEM_3, "", "");
    mapKey(KEY_OEM_4, "", "");
    mapKey(KEY_OEM_5, "", "");
    mapKey(KEY_OEM_6, "", "");
    mapKey(KEY_OEM_7, "", "");
    mapKey(KEY_OEM_8, "", ""); 
    mapKey(KEY_OEM_AX, "", "");
    mapKey(KEY_OEM_102, "", "");
    mapKey(KEY_ICO_HELP, "", "");
    mapKey(KEY_ICO_00, "", "");
    mapKey(KEY_PROCESSKEY, "", "");
    mapKey(KEY_ICO_CLEAR, "", "");
    mapKey(KEY_PACKET, "", "");
    
    // Nokia/Ericsson definitions
    mapKey(KEY_OEM_RESET, "", "");
    mapKey(KEY_OEM_JUMP, "", "");
    mapKey(KEY_OEM_PA1, "", "");
    mapKey(KEY_OEM_PA2, "", "");
    mapKey(KEY_OEM_PA3, "", "");
    mapKey(KEY_OEM_WSCTRL, "", "");
    mapKey(KEY_OEM_CUSEL, "", "");
    mapKey(KEY_OEM_ATTN, "", "");
    mapKey(KEY_OEM_FINISH, "", "");
    mapKey(KEY_OEM_COPY, "", "");
    mapKey(KEY_OEM_AUTO, "", "");
    mapKey(KEY_OEM_ENLW, "", "");
    mapKey(KEY_OEM_BACKTAB, "", "");
    mapKey(KEY_ATTN, "", "");
    mapKey(KEY_CRSEL, "", "");
    mapKey(KEY_EXSEL, "", "");
    mapKey(KEY_EREOF, "", "");
    mapKey(KEY_PLAY, "", "");
    mapKey(KEY_ZOOM, "", "");
    mapKey(KEY_NONAME, "", "");
    mapKey(KEY_PA1, "", "");
    mapKey(KEY_OEM_CLEAR, "", "");

    // Multimedia key table
    mapKey(KEY_APPCOMMAND_BROWSER_BACKWARD, "", "");
    mapKey(KEY_APPCOMMAND_BROWSER_FORWARD, "", ""); 
    mapKey(KEY_APPCOMMAND_BROWSER_REFRESH, "", "");
    mapKey(KEY_APPCOMMAND_BROWSER_STOP, "", "");
    mapKey(KEY_APPCOMMAND_BROWSER_SEARCH, "", "");
    mapKey(KEY_APPCOMMAND_BROWSER_FAVORITES, "", "");
    mapKey(KEY_APPCOMMAND_BROWSER_HOME, "", "");
    mapKey(KEY_APPCOMMAND_VOLUME_MUTE, "", "");
    mapKey(KEY_APPCOMMAND_VOLUME_DOWN, "", "");
    mapKey(KEY_APPCOMMAND_VOLUME_UP, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_NEXTTRACK, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_PREVIOUSTRACK, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_STOP, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_PLAYPAUSE, "", "");
    mapKey(KEY_APPCOMMAND_LAUNCH_MAIL, "", "");
    mapKey(KEY_APPCOMMAND_LAUNCH_MEDIA_SELECT, "", "");
    mapKey(KEY_APPCOMMAND_LAUNCH_APP1, "", "");
    mapKey(KEY_APPCOMMAND_LAUNCH_APP2, "", "");
    mapKey(KEY_APPCOMMAND_BASS_DOWN, "", "");
    mapKey(KEY_APPCOMMAND_BASS_BOOST, "", "");
    mapKey(KEY_APPCOMMAND_BASS_UP, "", "");
    mapKey(KEY_APPCOMMAND_TREBLE_DOWN, "", "");
    mapKey(KEY_APPCOMMAND_TREBLE_UP, "", "");
    mapKey(KEY_APPCOMMAND_MICROPHONE_VOLUME_MUTE, "", "");
    mapKey(KEY_APPCOMMAND_MICROPHONE_VOLUME_DOWN, "", "");
    mapKey(KEY_APPCOMMAND_MICROPHONE_VOLUME_UP, "", "");
    mapKey(KEY_APPCOMMAND_HELP, "", "");
    mapKey(KEY_APPCOMMAND_FIND, "", "");
    mapKey(KEY_APPCOMMAND_NEW, "", "");
    mapKey(KEY_APPCOMMAND_OPEN, "", "");
    mapKey(KEY_APPCOMMAND_CLOSE, "", "");
    mapKey(KEY_APPCOMMAND_SAVE, "", "");
    mapKey(KEY_APPCOMMAND_PRINT, "", "");
    mapKey(KEY_APPCOMMAND_UNDO, "", "");
    mapKey(KEY_APPCOMMAND_REDO, "", "");
    mapKey(KEY_APPCOMMAND_COPY, "", "");
    mapKey(KEY_APPCOMMAND_CUT, "", "");
    mapKey(KEY_APPCOMMAND_PASTE, "", "");
    mapKey(KEY_APPCOMMAND_REPLY_TO_MAIL, "", "");
    mapKey(KEY_APPCOMMAND_FORWARD_MAIL, "", "");
    mapKey(KEY_APPCOMMAND_SEND_MAIL, "", "");
    mapKey(KEY_APPCOMMAND_SPELL_CHECK, "", "");
    mapKey(KEY_APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE, "", "");
    mapKey(KEY_APPCOMMAND_MIC_ON_OFF_TOGGLE, "", "");
    mapKey(KEY_APPCOMMAND_CORRECTION_LIST, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_PLAY, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_PAUSE, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_RECORD, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_FAST_FORWARD, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_REWIND, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_CHANNEL_DOWN, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_CHANNEL_UP, "", "");
}