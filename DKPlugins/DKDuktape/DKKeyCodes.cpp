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

    // Numerical and Character keys
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
    mapKey(KEY_DELETE, "Delete", "Delete");
    mapKey(KEY_EREOF, "EraseEof", "EraseEof");
    mapKey(KEY_EXSEL, "ExSel", "ExSel");
    mapKey(KEY_INSERT, "Insert", "Insert");
    mapKey(KEY_APPCOMMAND_PASTE, "Paste", "Paste");
    mapKey(KEY_APPCOMMAND_REDO, "Redo", "Redo");
    mapKey(KEY_APPCOMMAND_UNDO, "Undo", "Undo");

    // UI Keys
    mapKey(KEY_ACCEPT, "Accept", "Accept");
    //mapKey(KEY_AGAIN, "Again", "Again");
    mapKey(KEY_ATTN, "Attn", "Attn");
    mapKey(KEY_CANCEL, "Cancel", "Cancel");
    mapKey(KEY_CONTEXTMENU, "ContextMenu", "ContextMenu");
    mapKey(KEY_ESCAPE, "Escape", "Escape");
    mapKey(KEY_EXECUTE_, "Execute", "Execute");
    mapKey(KEY_APPCOMMAND_FIND, "Find", "Find");
    mapKey(KEY_OEM_FINISH, "Finish", "Finish");
    mapKey(KEY_HELP, "Help", "Help");
    mapKey(KEY_PAUSE, "Pause", "Pause");
    mapKey(KEY_PLAY, "Play", "Play");
    //mapKey(KEY_PROPS, "Props", "Props");
    mapKey(KEY_SELECT, "Select", "Select");
    //mapKey(KEY_ZOOMIN, "ZoomIn", "ZoomIn");
    //mapKey(KEY_ZOOMOUT, "ZoomOut", "ZoomOut");

    // Device keys
    //mapKey(KEY_BRIGHTNESSDOWN, "BrightnessDown", "BrightnessDown");
    //mapKey(KEY_BRIGHTNESSUP, "BrightnessUp", "BrightnessUp");
    //mapKey(KEY_EJECT, "Eject", "Eject");
    //mapKey(KEY_LOGOFF, "LogOff", "LogOff");
    //mapKey(KEY_POWER, "Power", "Power");
    //mapKey(KEY_POWEROFF, "PowerOff", "PowerOff");
    mapKey(KEY_PRINTSCREEN, "PrintScreen", "PrintScreen");
    //mapKey(KEY_HIBERNATE, "Hibernate", "Hibernate");
    mapKey(KEY_STANDBY, "Standby", "Standby");
    //mapKey(KEY_WAKEUP, "WakeUp", "WakeUp");

    //IME and composition keys
    //mapKey(KEY_ALLCANDIDATES, "AllCandidates", "AllCandidates");
    mapKey(KEY_OEM_ATTN, "Alphanumeric", "Alphanumeric");
    //mapKey(KEY_CODEINPUT, "CodeInput", "CodeInput");
    //mapKey(KEY_COMPOSE, "Compose", "Compose");
    mapKey(KEY_CONVERT, "Convert", "Convert");
    //mapKey(KEY_DEAD, "Dead", "Dead");
    mapKey(KEY_FINAL, "FinalMode", "FinalMode");
    //mapKey(KEY_GROUPFIRST, "GroupFirst", "GroupFirst");
    //mapKey(KEY_GROUPNEXT, "GroupNext", "GroupNext");
    //mapKey(KEY_GROUPPREVIOUS, "GroupPrevious", "GroupPrevious");
    mapKey(KEY_MODECHANGE, "ModeChange", "ModeChange");
    //mapKey(KEY_NEXTCANDIDATE, "NextCandidate", "NextCandidate");
    mapKey(KEY_NONCONVERT, "NonEonvert", "NonConvert");
    //mapKey(KEY_PREVIOUSCANDIDATE, "PreviousCandidate", "PreviousCandidate");
    mapKey(KEY_PROCESS, "Process", "Process");
    //mapKey(KEY_SINGLECANDIDATE, "SingleCandidate", "SingleCandidate");
    
    // Korean keyboards only
    mapKey(KEY_HANGUL, "HangulMode", "HangulMode");
    mapKey(KEY_HANJA, "HanjaMode", "HanjaMode");
    mapKey(KEY_JUNJA, "JunjaMode", "JunjaMode");

    // Japanese keyboards only
    // TODO
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#japanese_keyboards_only
    //"Eisu"
    mapKey(KEY_OEM_AUTO, "Hankaku", "Hankaku");
    mapKey(KEY_OEM_COPY, "Hiragana", "Hiragana");
    //"HiraganaKatakana"
    mapKey(KEY_KANA, "KanaMode", "KanaMode");  //Same as KEY_HANGUL
    mapKey(KEY_KANJI, "KanjiMode", "KanjiMode"); //Same as KEY_HANJA
    mapKey(KEY_OEM_FINISH, "Katakana", "Katakana");
    mapKey(KEY_OEM_BACKTAB, "Romaji", "Romaji");
    mapKey(KEY_OEM_ENLW, "Zenkaku", "Zenkaku");
    //"ZenkakuHanaku"
    
    // Dead keycodes for Linux
    // TODO
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#dead_keycodes_for_linux

    // Function keys
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
    //mapKey(KEY_SOFT1, "Soft1", "Soft1");
    //mapKey(KEY_SOFT2, "Soft2", "Soft2");
    //mapKey(KEY_SOFT3, "Soft3", "Soft3");
    //mapKey(KEY_SOFT4, "Soft4", "Soft4");

    // Phone keys
    // TODO
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#phone_keys

    // Multimedia keys
    // TODO
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#multimedia_keys

    // Audio control keys
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#audio_control_keys
    //mapKey(TODO, "AudioBalanceLeft", "AudioBalanceLeft");
    //mapKey(TODO, "AudioBalanceRight", "AudioBalanceRight");
    mapKey(KEY_APPCOMMAND_BASS_DOWN, "AudioBassDown", "AudioBassDown");
    //mapKey(TODO, "AudioBassBoostDown", "AudioBassBoostDown");
    mapKey(KEY_APPCOMMAND_BASS_BOOST, "AudioBassBoostToggle", "AudioBassBoostToggle");
    //mapKey(TODO, "AudioBassBoostUp", "AudioBassBoostUp");
    mapKey(KEY_APPCOMMAND_BASS_UP, "AudioBassUp", "AudioBassUp");
    //mapKey(TODO, "AudioFaderFront", "AudioFaderFront");
    //mapKey(TODO, "AudioFaderRear", "AudioFaderRear");
    //mapKey(TODO, "AudioSurroundModeNext", "AudioSurroundModeNext");
    mapKey(KEY_APPCOMMAND_TREBLE_DOWN, "AudioTrebleDown", "AudioTrebleDown");
    mapKey(KEY_APPCOMMAND_TREBLE_UP, "AudioTrebleUp", "AudioTrebleUp");
    mapKey(KEY_VOLUME_DOWN, "AudioVolumeDown", "AudioVolumeDown");
    mapKey(KEY_VOLUME_MUTE, "AudioVolumeMute", "AudioVolumeMute");
    mapKey(KEY_VOLUME_UP, "AudioVolumeUp", "AudioVolumeUp");
    mapKey(KEY_APPCOMMAND_MIC_ON_OFF_TOGGLE, "MicrophoneToggle", "MicrophoneToggle");
    mapKey(KEY_APPCOMMAND_MICROPHONE_VOLUME_DOWN, "MicrophoneVolumeDown", "MicrophoneVolumeDown");
    mapKey(KEY_APPCOMMAND_MICROPHONE_VOLUME_MUTE, "MicrophoneVolumeMute", "MicrophoneVolumeMute");
    mapKey(KEY_APPCOMMAND_MICROPHONE_VOLUME_UP, "MicrophoneVolumeUp", "MicrophoneVolumeUp");

    // TV control keys
    // TODO
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#tv_control_keys

    // Media controller keys
    // TODO
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#media_controller_keys
    mapKey(KEY_MEDIA_NEXT_TRACK, "MediaTrackNext", "");
    mapKey(KEY_MEDIA_PREV_TRACK, "MediaTrackPrevious", "");
    mapKey(KEY_MEDIA_STOP, "MediaStop", "");
    mapKey(KEY_MEDIA_PLAY_PAUSE, "MediaPlayPause", "");
    mapKey(KEY_APPCOMMAND_MEDIA_NEXTTRACK, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_PREVIOUSTRACK, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_STOP, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_PLAYPAUSE, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_PLAY, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_PAUSE, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_RECORD, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_FAST_FORWARD, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_REWIND, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_CHANNEL_DOWN, "", "");
    mapKey(KEY_APPCOMMAND_MEDIA_CHANNEL_UP, "", "");

    // Speech recognition keys
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#speech_recognition_keys

    // Document keys
    mapKey(KEY_APPCOMMAND_CLOSE, "Close", "Close");
    mapKey(KEY_APPCOMMAND_NEW, "New", "New");
    mapKey(KEY_APPCOMMAND_OPEN, "Open", "Open");
    mapKey(KEY_APPCOMMAND_PRINT, "Print", "Print");
    mapKey(KEY_APPCOMMAND_SAVE, "Save", "Save");
    mapKey(KEY_APPCOMMAND_SPELL_CHECK, "SpellCheck", "SpellCheck");
    mapKey(KEY_APPCOMMAND_FORWARD_MAIL, "MailForward", "MailForward");
    mapKey(KEY_APPCOMMAND_REPLY_TO_MAIL, "MailReply", "MailReply");
    mapKey(KEY_APPCOMMAND_SEND_MAIL, "MailSend", "MailSend");

    // Application selector keys
    // TODO
    // https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#application_selector_keys
    //"LaunchCalculator"
    //"LaunchCalendar"
    //"LaunchContacts"
    mapKey(KEY_LAUNCH_MAIL, "LaunchMail", "LaunchMail");
    mapKey(KEY_LAUNCH_MEDIA_SELECT, "LaunchMediaPlayer", "LaunchMediaPlayer");
    //"LaunchMusicPlayer"
    //"LaunchMyComputer"
    //"LaunchPhone"
    //"LaunchScreenSaver"
    //"LaunchSpreadsheet"
    //"LaunchWebBrowser"
    //"LaunchWebCam"
    //"LaunchWordProcessor"
    mapKey(KEY_LAUNCH_APP1, "LaunchApplication1", "LaunchApplication1");
    mapKey(KEY_LAUNCH_APP2, "LaunchApplication2", "LaunchApplication2");
    //"LaunchApplication3"
    //"LaunchApplication4"
    //"LaunchApplication5"
    //"LaunchApplication6"
    //"LaunchApplication7"
    //"LaunchApplication8"
    //"LaunchApplication9"
    //"LaunchApplication10"
    //"LaunchApplication11"
    //"LaunchApplication12"
    //"LaunchApplication13"
    //"LaunchApplication14"
    //"LaunchApplication15"
    //"LaunchApplication16"

    // Browser control keys
    mapKey(KEY_BROWSER_BACK, "BrowserBack", "");
    mapKey(KEY_BROWSER_FAVORITES, "BrowserFavorites", "");
    mapKey(KEY_BROWSER_FORWARD, "BrowserForward", "");
    mapKey(KEY_BROWSER_HOME, "BrowserHome", "");
    mapKey(KEY_BROWSER_REFRESH, "BrowserRefresh", "");
    mapKey(KEY_BROWSER_SEARCH, "BrowserSearch", "");
    mapKey(KEY_BROWSER_STOP, "BrowserStop", "");
    
    // Numeric keypad keys
    mapKey(KEY_DECIMAL, ".", "NumpadDecimal");
    //mapKey(KEY_11, "Key11", "Key11");                       // The 11 key found on certain media numeric keypads.
    //mapKey(KEY_12, "Key12", "Key12");                       // The 12 key found on certain media numeric keypads.
    mapKey(KEY_MULTIPLY, "*", "NumpadMultiply");
    mapKey(KEY_ADD, "+", "NumpadAdd");
    //mapKey(KEY_CLEAR, "Clear", "Clear");
    mapKey(KEY_DIVIDE, "/", "NumpadDivide");
    mapKey(KEY_SUBTRACT, "-", "NumpadSubtract");
    mapKey(KEY_SEPERATOR, "Separator", "Separator");
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






    //////   EXTRA //////////////////
    mapKey(KEY_ICO_00, "KEY_ICO_00", "KEY_ICO_00");
    mapKey(KEY_ICO_HELP, "KEY_ICO_HELP", "KEY_ICO_HELP");
    mapKey(KEY_ICO_CLEAR, "KEY_ICO_CLEAR", "KEY_ICO_CLEAR");
    mapKey(KEY_PACKET, "KEY_PACKET", "KEY_PACKET");
    mapKey(KEY_ZOOM, "KEY_ZOOM", "KEY_ZOOM");
    mapKey(KEY_NONAME, "KEY_NONAME", "KEY_NONAME");
    mapKey(KEY_PA1, "KEY_PA1", "KEY_PA1");
    mapKey(KEY_OEM_RESET, "KEY_OEM_RESET", "KEY_OEM_RESET");
    mapKey(KEY_OEM_JUMP, "KEY_OEM_JUMP", "KEY_OEM_JUMP");
    mapKey(KEY_OEM_PA1, "KEY_OEM_PA1", "KEY_OEM_PA1");
    mapKey(KEY_OEM_PA2, "KEY_OEM_PA2", "KEY_OEM_PA2");
    mapKey(KEY_OEM_PA3, "KEY_OEM_PA3", "KEY_OEM_PA3");
    mapKey(KEY_OEM_WSCTRL, "KEY_OEM_WSCTRL", "KEY_OEM_WSCTRL");
    mapKey(KEY_OEM_CUSEL, "KEY_OEM_CUSEL", "KEY_OEM_CUSEL");
    mapKey(KEY_OEM_ATTN, "KEY_OEM_ATTN", "KEY_OEM_ATTN");       //Covered by KEY_ATTN
    mapKey(KEY_OEM_CLEAR, "KEY_OEM_CLEAR", "KEY_OEM_CLEAR");      //Covered by KEY_CLEAR
    mapKey(KEY_OEM_1, "KEY_OEM_1", "KEY_OEM_1");
    mapKey(KEY_OEM_2, "KEY_OEM_2", "KEY_OEM_2");
    mapKey(KEY_OEM_3, "KEY_OEM_3", "KEY_OEM_3");
    mapKey(KEY_OEM_4, "KEY_OEM_4", "KEY_OEM_4");
    mapKey(KEY_OEM_5, "KEY_OEM_5", "KEY_OEM_5");
    mapKey(KEY_OEM_6, "KEY_OEM_6", "KEY_OEM_6");
    mapKey(KEY_OEM_7, "KEY_OEM_7", "KEY_OEM_7");
    mapKey(KEY_OEM_8, "KEY_OEM_8", "KEY_OEM_8");
    mapKey(KEY_OEM_AX, "KEY_OEM_AX", "KEY_OEM_AX");
    mapKey(KEY_OEM_102, "KEY_OEM_102", "KEY_OEM_102");
    mapKey(KEY_OEM_PLUS, "KEY_OEM_PLUS", "KEY_OEM_PLUS");
    mapKey(KEY_OEM_COMMA, "KEY_OEM_COMMA", "KEY_OEM_COMMA");
    mapKey(KEY_OEM_MINUS, "KEY_OEM_MINUS", "KEY_OEM_MINUS");
    mapKey(KEY_OEM_PERIOD, "KEY_OEM_PERIOD", "KEY_OEM_PERIOD");
    mapKey(KEY_OEM_FJ_JISHO, "KEY_OEM_FJ_JISHO", "KEY_OEM_FJ_JISHO");
    mapKey(KEY_OEM_FJ_MASSHOU, "KEY_OEM_FJ_MASSHOU", "KEY_OEM_FJ_MASSHOU");
    mapKey(KEY_OEM_FJ_TOUROKU, "KEY_OEM_FJ_TOUROKU", "KEY_OEM_FJ_TOUROKU");
    mapKey(KEY_OEM_FJ_LOYA, "KEY_OEM_FJ_LOYA", "KEY_OEM_FJ_LOYA");
    mapKey(KEY_OEM_FJ_ROYA, "KEY_OEM_FJ_ROYA", "KEY_OEM_FJ_ROYA");
    mapKey(KEY_APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE, "KEY_APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE", "KEY_APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE");
    mapKey(KEY_APPCOMMAND_CORRECTION_LIST, "KEY_APPCOMMAND_CORRECTION_LIST", "KEY_APPCOMMAND_CORRECTION_LIST");
}