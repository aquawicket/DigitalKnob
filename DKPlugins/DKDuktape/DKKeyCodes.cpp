#include "DKDuktape/DKKeyCodes.h"

// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values
// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code/code_values

/*
struct KeyboardEventMap {
    DKString      code;         // KeyboardEvent.code
    //DKString    description;  //
    DKString      vk_keycode;   // Current OS Keycode
    DKString      key;          // KeyboardEvent.key
    int           location;     // KeyboardEvent.location
    //DKString    type;         // KeyboardEvent.type
    int           which;        // KeyboardEvent.which
    //DKString    vk_win;       // OS Specific Keycode
    //DKString    vk_mac;       // OS Specific Keycode
    //DKString    vk_linux;     // OS Specific Keycode
    //DKString    vk_android;   // OS Specific Keycode
};
*/
//static std::map<Key, KeyboardEventMap> keys;

void mapKey(Key name, DKString code, DKString key, int location = 0) {
    DKString vk_keycode = int_to_hex(name);
    int which = name;
    keys[name] = KeyboardEventMap{code, vk_keycode, key, location, which};
}

void mapKeys() {
  //mapKey(Key_Name,    " code",   " key");
    mapKey(Key_Escape, "Escape", "Escape");
    mapKey(Key_Tab, "", "");
    mapKey(Key_Backtab, "", "");
    mapKey(Key_Backspace, "", "");
    mapKey(Key_Return, "", "");
    mapKey(Key_Enter, "", "");
    mapKey(Key_Insert, "", "");
    mapKey(Key_Delete, "", "");
    mapKey(Key_Pause, "", "");
    mapKey(Key_Print, "", "");
    mapKey(Key_SysReq, "", "");
    mapKey(Key_Clear, "", "");
    mapKey(Key_Home, "", "");
    mapKey(Key_End, "", "");
    mapKey(Key_Left, "", "");
    mapKey(Key_Up, "", "");
    mapKey(Key_Right, "", "");
    mapKey(Key_Down, "", "");
    mapKey(Key_PageUp, "", ""); 
    mapKey(Key_PageDown, "", "");
    mapKey(Key_Shift, "", "");
    mapKey(Key_Control, "", "");
    mapKey(Key_Meta, "", "");
    mapKey(Key_Alt, "Alt", "Alt", 0);
    mapKey(Key_AltLeft, "AltLeft", "Alt", 1);
    mapKey(Key_AltRight, "AltRight", "Alt", 2);
    mapKey(Key_CapsLock, "", "");
    mapKey(Key_NumLock, "", "");
    mapKey(Key_ScrollLock, "", "");
    mapKey(Key_F1, "", "");
    mapKey(Key_F2, "", "");
    mapKey(Key_F3, "", "");
    mapKey(Key_F4, "", "");
    mapKey(Key_F5, "", "");
    mapKey(Key_F6, "", "");
    mapKey(Key_F7, "", "");
    mapKey(Key_F8, "", "");
    mapKey(Key_F9, "", "");
    mapKey(Key_F10, "", "");
    mapKey(Key_F11, "", "");
    mapKey(Key_F12, "", "");
    mapKey(Key_F13, "", "");
    mapKey(Key_F14, "", "");
    mapKey(Key_F15, "", "");
    mapKey(Key_F16, "", "");
    mapKey(Key_F17, "", "");
    mapKey(Key_F18, "", "");
    mapKey(Key_F19, "", "");
    mapKey(Key_F20, "", "");
    mapKey(Key_F21, "", "");
    mapKey(Key_F22, "", "");
    mapKey(Key_F23, "", "");
    mapKey(Key_F24, "", "");
    mapKey(Key_F25, "", "");
    mapKey(Key_F26, "", "");
    mapKey(Key_F27, "", "");
    mapKey(Key_F28, "", "");
    mapKey(Key_F29, "", "");
    mapKey(Key_F30, "", "");
    mapKey(Key_F31, "", "");
    mapKey(Key_F32, "", "");
    mapKey(Key_F33, "", "");
    mapKey(Key_F34, "", "");
    mapKey(Key_F35, "", "");
    mapKey(Key_Super_L, "", "");
    mapKey(Key_Super_R, "", "");
    mapKey(Key_Menu, "", "");
    mapKey(Key_Hyper_L, "", "");
    mapKey(Key_Hyper_R, "", "");
    mapKey(Key_Help, "", "");
    mapKey(Key_Direction_L, "", "");
    mapKey(Key_Direction_R, "", "");
    mapKey(Key_Space, "", "");
    mapKey(Key_Any, "", "");
    mapKey(Key_Space, "", "");
    mapKey(Key_Exclam, "", "");
    mapKey(Key_QuoteDbl, "", "");
    mapKey(Key_NumberSign, "", "");
    mapKey(Key_Dollar, "", "");
    mapKey(Key_Percent, "", "");
    mapKey(Key_Ampersand, "", "");
    mapKey(Key_Apostrophe, "", "");
    mapKey(Key_ParenLeft, "", "");
    mapKey(Key_ParenRight, "", "");
    mapKey(Key_Asterisk, "", "");
    mapKey(Key_Plus, "", "");
    mapKey(Key_Comma, "", "");
    mapKey(Key_Minus, "", "");
    mapKey(Key_Period, "", "");
    mapKey(Key_Slash, "", "");
    mapKey(Key_0, "", "");
    mapKey(Key_1, "", "");
    mapKey(Key_2, "", "");
    mapKey(Key_3, "", "");
    mapKey(Key_4, "", "");
    mapKey(Key_5, "", "");
    mapKey(Key_6, "", "");
    mapKey(Key_7, "", "");
    mapKey(Key_8, "", "");
    mapKey(Key_9, "", "");
    mapKey(Key_Colon, "", "");
    mapKey(Key_Semicolon, "", "");
    mapKey(Key_Less, "", "");
    mapKey(Key_Equal, "", "");
    mapKey(Key_Greater, "", "");
    mapKey(Key_Question, "", "");
    mapKey(Key_At, "", "");
    mapKey(Key_A, "", "");
    mapKey(Key_B, "", "");
    mapKey(Key_C, "", "");
    mapKey(Key_D, "", "");
    mapKey(Key_E, "", "");
    mapKey(Key_F, "", "");
    mapKey(Key_G, "", "");
    mapKey(Key_H, "", "");
    mapKey(Key_I, "", "");
    mapKey(Key_J, "", "");
    mapKey(Key_K, "", "");
    mapKey(Key_L, "", "");
    mapKey(Key_M, "", "");
    mapKey(Key_N, "", "");
    mapKey(Key_O, "", "");
    mapKey(Key_P, "", "");
    mapKey(Key_Q, "", "");
    mapKey(Key_R, "", "");
    mapKey(Key_S, "", "");
    mapKey(Key_T, "", "");
    mapKey(Key_U, "", "");
    mapKey(Key_V, "", "");
    mapKey(Key_W, "", "");
    mapKey(Key_X, "", "");
    mapKey(Key_Y, "", "");
    mapKey(Key_Z, "", "");
    mapKey(Key_BracketLeft, "", "");
    mapKey(Key_Backslash, "", "");
    mapKey(Key_BracketRight, "", "");
    mapKey(Key_AsciiCircum, "", "");
    mapKey(Key_Underscore, "", "");
    mapKey(Key_QuoteLeft, "", "");
    mapKey(Key_BraceLeft, "", "");
    mapKey(Key_Bar, "", "");
    mapKey(Key_BraceRight, "", "");
    mapKey(Key_AsciiTilde, "", "");
    mapKey(Key_nobreakspace, "", "");
    mapKey(Key_exclamdown, "", "");
    mapKey(Key_cent, "", "");
    mapKey(Key_sterling, "", "");
    mapKey(Key_currency, "", "");
    mapKey(Key_yen, "", "");
    mapKey(Key_brokenbar, "", "");
    mapKey(Key_section, "", "");
    mapKey(Key_diaeresis, "", "");
    mapKey(Key_copyright, "", "");
    mapKey(Key_ordfeminine, "", "");
    mapKey(Key_guillemotleft, "", "");
    mapKey(Key_notsign, "", "");
    mapKey(Key_hyphen, "", "");
    mapKey(Key_registered, "", "");
    mapKey(Key_macron, "", "");
    mapKey(Key_degree, "", "");
    mapKey(Key_plusminus, "", "");
    mapKey(Key_twosuperior, "", "");
    mapKey(Key_threesuperior, "", "");
    mapKey(Key_acute, "", "");
    mapKey(Key_mu, "", "");
    mapKey(Key_paragraph, "", "");
    mapKey(Key_periodcentered, "", "");
    mapKey(Key_cedilla, "", "");
    mapKey(Key_onesuperior, "", "");
    mapKey(Key_masculine, "", "");
    mapKey(Key_guillemotright, "", "");
    mapKey(Key_onequarter, "", "");
    mapKey(Key_onehalf, "", "");
    mapKey(Key_threequarters, "", "");
    mapKey(Key_questiondown, "", "");
    mapKey(Key_Agrave, "", "");
    mapKey(Key_Aacute, "", "");
    mapKey(Key_Acircumflex, "", "");
    mapKey(Key_Atilde, "", "");
    mapKey(Key_Adiaeresis, "", "");
    mapKey(Key_Aring, "", "");
    mapKey(Key_AE, "", "");
    mapKey(Key_Ccedilla, "", "");
    mapKey(Key_Egrave, "", "");
    mapKey(Key_Eacute, "", "");
    mapKey(Key_Ecircumflex, "", "");
    mapKey(Key_Ediaeresis, "", "");
    mapKey(Key_Igrave, "", "");
    mapKey(Key_Iacute, "", "");
    mapKey(Key_Icircumflex, "", "");
    mapKey(Key_Idiaeresis, "", "");
    mapKey(Key_ETH, "", "");
    mapKey(Key_Ntilde, "", "");
    mapKey(Key_Ograve, "", "");
    mapKey(Key_Oacute, "", "");
    mapKey(Key_Ocircumflex, "", "");
    mapKey(Key_Otilde, "", "");
    mapKey(Key_Odiaeresis, "", "");
    mapKey(Key_multiply, "", "");
    mapKey(Key_Ooblique, "", "");
    mapKey(Key_Ugrave, "", "");
    mapKey(Key_Uacute, "", "");
    mapKey(Key_Ucircumflex, "", "");
    mapKey(Key_Udiaeresis, "", "");
    mapKey(Key_Yacute, "", "");
    mapKey(Key_THORN, "", "");
    mapKey(Key_ssharp, "", "");
    mapKey(Key_division, "", "");
    mapKey(Key_ydiaeresis, "", "");
    mapKey(Key_AltGr, "", "");
    mapKey(Key_Multi_key, "", ""); // Multi-key character compose
    mapKey(Key_Codeinput, "", "");
    mapKey(Key_SingleCandidate, "", "");
    mapKey(Key_MultipleCandidate, "", "");
    mapKey(Key_PreviousCandidate, "", "");
    mapKey(Key_Mode_switch, "", "");  // Character set switch
    mapKey(Key_script_switch, "", "");  // Alias for mode_switch    
}