#pragma once
#ifndef DKKeyCodes_H
#define DKKeyCodes_H
#include "DKDuktape/DKDuktape.h"
#include <iostream>
#include <map>
#include <string>
#include <iterator>

template< typename T >
std::string int_to_hex(T i) {
    std::stringstream stream;
    stream << "0x" << std::setfill('0') << std::setw(sizeof(T) * 2) << std::hex << i;
    return stream.str();
};

// Read
// https://www.w3.org/TR/uievents-code/
// https://chromium.googlesource.com/chromium/src/+/lkgr/ui/events/keycodes

/*
enum Key {
    Key_Escape = 0x01000000,
    Key_Tab = 0x01000001,
    Key_Backtab = 0x01000002,
    Key_Backspace = 0x01000003,
    Key_Return = 0x01000004,
    Key_Enter = 0x01000005,
    Key_Insert = 0x01000006,
    Key_Delete = 0x01000007,
    Key_Pause = 0x01000008,
    Key_Print = 0x01000009,
    Key_SysReq = 0x0100000a,
    Key_Clear = 0x0100000b,
    Key_Home = 0x01000010,
    Key_End = 0x01000011,
    Key_Left = 0x01000012,
    Key_Up = 0x01000013,
    Key_Right = 0x01000014,
    Key_Down = 0x01000015,
    Key_PageUp = 0x01000016,
    Key_PageDown = 0x01000017,
    Key_Shift = 0x01000020,
    Key_Control = 0x01000021,
    Key_Meta = 0x01000022,
    Key_Alt = 0x01000023,
    Key_CapsLock = 0x01000024,
    Key_NumLock = 0x01000025,
    Key_ScrollLock = 0x01000026,
    Key_F1 = 0x01000030,
    Key_F2 = 0x01000031,
    Key_F3 = 0x01000032,
    Key_F4 = 0x01000033,
    Key_F5 = 0x01000034,
    Key_F6 = 0x01000035,
    Key_F7 = 0x01000036,
    Key_F8 = 0x01000037,
    Key_F9 = 0x01000038,
    Key_F10 = 0x01000039,
    Key_F11 = 0x0100003a,
    Key_F12 = 0x0100003b,
    Key_F13 = 0x0100003c,
    Key_F14 = 0x0100003d,
    Key_F15 = 0x0100003e,
    Key_F16 = 0x0100003f,
    Key_F17 = 0x01000040,
    Key_F18 = 0x01000041,
    Key_F19 = 0x01000042,
    Key_F20 = 0x01000043,
    Key_F21 = 0x01000044,
    Key_F22 = 0x01000045,
    Key_F23 = 0x01000046,
    Key_F24 = 0x01000047,
    Key_F25 = 0x01000048,
    Key_F26 = 0x01000049,
    Key_F27 = 0x0100004a,
    Key_F28 = 0x0100004b,
    Key_F29 = 0x0100004c,
    Key_F30 = 0x0100004d,
    Key_F31 = 0x0100004e,
    Key_F32 = 0x0100004f,
    Key_F33 = 0x01000050,
    Key_F34 = 0x01000051,
    Key_F35 = 0x01000052,
    Key_Super_L = 0x01000053,
    Key_Super_R = 0x01000054,
    Key_Menu = 0x01000055,
    Key_Hyper_L = 0x01000056,
    Key_Hyper_R = 0x01000057,
    Key_Help = 0x01000058,
    Key_Direction_L = 0x01000059,
    Key_Direction_R = 0x01000060,
    Key_AltLeft = 0x01000061,
    Key_AltRight = 0x01000062,

    Key_Space = 0x20,
    Key_Any = Key_Space,
    Key_Exclam = 0x21,
    Key_QuoteDbl = 0x22,
    Key_NumberSign = 0x23,
    Key_Dollar = 0x24,
    Key_Percent = 0x25,
    Key_Ampersand = 0x26,
    Key_Apostrophe = 0x27,
    Key_ParenLeft = 0x28,
    Key_ParenRight = 0x29,
    Key_MULTIPLY = 0x2a,
    Key_Plus = 0x2b,
    Key_Comma = 0x2c,
    Key_Minus = 0x2d,
    Key_Period = 0x2e,
    Key_Slash = 0x2f,
    Key_0 = 0x30,
    Key_1 = 0x31,
    Key_2 = 0x32,
    Key_3 = 0x33,
    Key_4 = 0x34,
    Key_5 = 0x35,
    Key_6 = 0x36,
    Key_7 = 0x37,
    Key_8 = 0x38,
    Key_9 = 0x39,
    Key_Colon = 0x3a,
    Key_Semicolon = 0x3b,
    Key_Less = 0x3c,
    Key_Equal = 0x3d,
    Key_Greater = 0x3e,
    Key_Question = 0x3f,
    Key_At = 0x40,
    Key_A = 0x41,
    Key_B = 0x42,
    Key_C = 0x43,
    Key_D = 0x44,
    Key_E = 0x45,
    Key_F = 0x46,
    Key_G = 0x47,
    Key_H = 0x48,
    Key_I = 0x49,
    Key_J = 0x4a,
    Key_K = 0x4b,
    Key_L = 0x4c,
    Key_M = 0x4d,
    Key_N = 0x4e,
    Key_O = 0x4f,
    Key_P = 0x50,
    Key_Q = 0x51,
    Key_R = 0x52,
    Key_S = 0x53,
    Key_T = 0x54,
    Key_U = 0x55,
    Key_V = 0x56,
    Key_W = 0x57,
    Key_X = 0x58,
    Key_Y = 0x59,
    Key_Z = 0x5a,
    Key_BracketLeft = 0x5b,
    Key_Backslash = 0x5c,
    Key_BracketRight = 0x5d,
    Key_AsciiCircum = 0x5e,
    Key_Underscore = 0x5f,
    Key_QuoteLeft = 0x60,
    Key_BraceLeft = 0x7b,
    Key_Bar = 0x7c,
    Key_BraceRight = 0x7d,
    Key_AsciiTilde = 0x7e,
    Key_nobreakspace = 0x0a0,
    Key_exclamdown = 0x0a1,
    Key_cent = 0x0a2,
    Key_sterling = 0x0a3,
    Key_currency = 0x0a4,
    Key_yen = 0x0a5,
    Key_brokenbar = 0x0a6,
    Key_section = 0x0a7,
    Key_diaeresis = 0x0a8,
    Key_copyright = 0x0a9,
    Key_ordfeminine = 0x0aa,
    Key_guillemotleft = 0x0ab,
    Key_notsign = 0x0ac,
    Key_hyphen = 0x0ad,
    Key_registered = 0x0ae,
    Key_macron = 0x0af,
    Key_degree = 0x0b0,
    Key_plusminus = 0x0b1,
    Key_twosuperior = 0x0b2,
    Key_threesuperior = 0x0b3,
    Key_acute = 0x0b4,
    Key_mu = 0x0b5,
    Key_paragraph = 0x0b6,
    Key_periodcentered = 0x0b7,
    Key_cedilla = 0x0b8,
    Key_onesuperior = 0x0b9,
    Key_masculine = 0x0ba,
    Key_guillemotright = 0x0bb,
    Key_onequarter = 0x0bc,
    Key_onehalf = 0x0bd,
    Key_threequarters = 0x0be,
    Key_questiondown = 0x0bf,
    Key_Agrave = 0x0c0,
    Key_Aacute = 0x0c1,
    Key_Acircumflex = 0x0c2,
    Key_Atilde = 0x0c3,
    Key_Adiaeresis = 0x0c4,
    Key_Aring = 0x0c5,
    Key_AE = 0x0c6,
    Key_Ccedilla = 0x0c7,
    Key_Egrave = 0x0c8,
    Key_Eacute = 0x0c9,
    Key_Ecircumflex = 0x0ca,
    Key_Ediaeresis = 0x0cb,
    Key_Igrave = 0x0cc,
    Key_Iacute = 0x0cd,
    Key_Icircumflex = 0x0ce,
    Key_Idiaeresis = 0x0cf,
    Key_ETH = 0x0d0,
    Key_Ntilde = 0x0d1,
    Key_Ograve = 0x0d2,
    Key_Oacute = 0x0d3,
    Key_Ocircumflex = 0x0d4,
    Key_Otilde            = 0x0d5,
    Key_Odiaeresis        = 0x0d6,
    Key_multiply          = 0x0d7,
    Key_Ooblique          = 0x0d8,
    Key_Ugrave            = 0x0d9,
    Key_Uacute            = 0x0da,
    Key_Ucircumflex       = 0x0db,
    Key_Udiaeresis        = 0x0dc,
    Key_Yacute            = 0x0dd,
    Key_THORN             = 0x0de,
    Key_ssharp            = 0x0df,
    Key_division          = 0x0f7,
    Key_ydiaeresis        = 0x0ff,
    Key_AltGr             = 0x01001103,
    Key_Multi_key         = 0x01001120,  // Multi-key character compose
    Key_Codeinput         = 0x01001137,
    Key_SingleCandidate   = 0x0100113c,
    Key_MultipleCandidate = 0x0100113d,
    Key_PreviousCandidate = 0x0100113e,
    Key_Mode_switch       = 0x0100117e,  // Character set switch
    Key_script_switch     = 0x0100117e,  // Alias for mode_switch

    // Japanese keyboard support
    Key_Kanji             = 0x01001121,  // Kanji, Kanji convert
    Key_Muhenkan          = 0x01001122,  // Cancel Conversion
    Key_Henkan_Mode       = 0x01001123,  // Start/Stop Conversion
    Key_Henkan            = 0x01001123,  // Alias for Henkan_Mode
    Key_Romaji            = 0x01001124,  // to Romaji
    Key_Hiragana          = 0x01001125,  // to Hiragana
    Key_Katakana          = 0x01001126,  // to Katakana
    Key_Hiragana_Katakana = 0x01001127,  // Hiragana/Katakana toggle
    Key_Zenkaku           = 0x01001128,  // to Zenkaku
    Key_Hankaku           = 0x01001129,  // to Hankaku
    Key_Zenkaku_Hankaku   = 0x0100112a,  // Zenkaku/Hankaku toggle
    Key_Touroku           = 0x0100112b,  // Add to Dictionary
    Key_Massyo            = 0x0100112c,  // Delete from Dictionary
    Key_Kana_Lock         = 0x0100112d,  // Kana Lock
    Key_Kana_Shift        = 0x0100112e,  // Kana Shift
    Key_Eisu_Shift        = 0x0100112f,  // Alphanumeric Shift
    Key_Eisu_toggle       = 0x01001130,  // Alphanumeric toggle
    Key_Kanji_Bangou      = 0x01001137,  // Codeinput
    Key_Zen_Koho          = 0x0100113d,  // Multiple/All Candidate(s)
    Key_Mae_Koho          = 0x0100113e,  // Previous Candidate

    // Korean keyboard support
    Key_Hangul = 0x01001131,  // Hangul start/stop(toggle)
    Key_Hangul_Start = 0x01001132,  // Hangul start
    Key_Hangul_End = 0x01001133,  // Hangul end, English start
    Key_Hangul_Hanja = 0x01001134,  // Start Hangul->Hanja Conversion
    Key_Hangul_Jamo = 0x01001135,  // Hangul Jamo mode
    Key_Hangul_Romaja = 0x01001136,  // Hangul Romaja mode
    Key_Hangul_Codeinput    = 0x01001137,  // Hangul code input mode
    Key_Hangul_Jeonja = 0x01001138,  // Jeonja mode
    Key_Hangul_Banja = 0x01001139,  // Banja mode
    Key_Hangul_PreHanja = 0x0100113a,  // Pre Hanja conversion
    Key_Hangul_PostHanja = 0x0100113b,  // Post Hanja conversion
    Key_Hangul_SingleCandidate   = 0x0100113c,  // Single candidate
    Key_Hangul_MultipleCandidate = 0x0100113d,  // Multiple candidate
    Key_Hangul_PreviousCandidate = 0x0100113e,  // Previous candidate
    Key_Hangul_Special = 0x0100113f,  // Special symbols
    Key_Hangul_switch       = 0x0100117e,  // Alias for mode_switch

    // dead keys
    Key_Dead_Grave = 0x01001250,
    Key_Dead_Acute = 0x01001251,
    Key_Dead_Circumflex = 0x01001252,
    Key_Dead_Tilde = 0x01001253,
    Key_Dead_Macron = 0x01001254,
    Key_Dead_Breve = 0x01001255,
    Key_Dead_Abovedot = 0x01001256,
    Key_Dead_Diaeresis = 0x01001257,
    Key_Dead_Abovering = 0x01001258,
    Key_Dead_Doubleacute = 0x01001259,
    Key_Dead_Caron = 0x0100125a,
    Key_Dead_Cedilla = 0x0100125b,
    Key_Dead_Ogonek = 0x0100125c,
    Key_Dead_Iota = 0x0100125d,
    Key_Dead_Voiced_Sound = 0x0100125e,
    Key_Dead_Semivoiced_Sound = 0x0100125f,
    Key_Dead_Belowdot = 0x01001260,
    Key_Dead_Hook = 0x01001261,
    Key_Dead_Horn = 0x01001262,
    Key_Dead_Stroke = 0x01001263,
    Key_Dead_Abovecomma = 0x01001264,
    Key_Dead_Abovereversedcomma = 0x01001265,
    Key_Dead_Doublegrave = 0x01001266,
    Key_Dead_Belowring = 0x01001267,
    Key_Dead_Belowmacron = 0x01001268,
    Key_Dead_Belowcircumflex = 0x01001269,
    Key_Dead_Belowtilde = 0x0100126a,
    Key_Dead_Belowbreve = 0x0100126b,
    Key_Dead_Belowdiaeresis = 0x0100126c,
    Key_Dead_Invertedbreve = 0x0100126d,
    Key_Dead_Belowcomma = 0x0100126e,
    Key_Dead_Currency = 0x0100126f,
    Key_Dead_a = 0x01001280,
    Key_Dead_A = 0x01001281,
    Key_Dead_e = 0x01001282,
    Key_Dead_E = 0x01001283,
    Key_Dead_i = 0x01001284,
    Key_Dead_I = 0x01001285,
    Key_Dead_o = 0x01001286,
    Key_Dead_O = 0x01001287,
    Key_Dead_u = 0x01001288,
    Key_Dead_U = 0x01001289,
    Key_Dead_Small_Schwa = 0x0100128a,
    Key_Dead_Capital_Schwa = 0x0100128b,
    Key_Dead_Greek = 0x0100128c,
    Key_Dead_Lowline = 0x01001290,
    Key_Dead_Aboveverticalline = 0x01001291,
    Key_Dead_Belowverticalline = 0x01001292,
    Key_Dead_Longsolidusoverlay = 0x01001293,

    // multimedia/internet keys
    Key_Back = 0x01000061,
    Key_Forward = 0x01000062,
    Key_Stop = 0x01000063,
    Key_Refresh = 0x01000064,
    Key_VolumeDown = 0x01000070,
    Key_VolumeMute = 0x01000071,
    Key_VolumeUp = 0x01000072,
    Key_BassBoost = 0x01000073,
    Key_BassUp = 0x01000074,
    Key_BassDown = 0x01000075,
    Key_TrebleUp = 0x01000076,
    Key_TrebleDown = 0x01000077,
    Key_MediaPlay = 0x01000080,
    Key_MediaStop = 0x01000081,
    Key_MediaPrevious = 0x01000082,
    Key_MediaNext = 0x01000083,
    Key_MediaRecord = 0x01000084,
    Key_MediaPause = 0x1000085,
    Key_MediaPlayPause = 0x1000086,
    Key_HomePage = 0x01000090,
    Key_Favorites = 0x01000091,
    Key_Search = 0x01000092,
    Key_Standby = 0x01000093,
    Key_OpenUrl = 0x01000094,
    Key_LaunchMail = 0x010000a0,
    Key_LaunchMedia = 0x010000a1,
    Key_Launch0 = 0x010000a2,
    Key_Launch1 = 0x010000a3,
    Key_Launch2 = 0x010000a4,
    Key_Launch3 = 0x010000a5,
    Key_Launch4 = 0x010000a6,
    Key_Launch5 = 0x010000a7,
    Key_Launch6 = 0x010000a8,
    Key_Launch7 = 0x010000a9,
    Key_Launch8 = 0x010000aa,
    Key_Launch9 = 0x010000ab,
    Key_LaunchA = 0x010000ac,
    Key_LaunchB = 0x010000ad,
    Key_LaunchC = 0x010000ae,
    Key_LaunchD = 0x010000af,
    Key_LaunchE = 0x010000b0,
    Key_LaunchF = 0x010000b1,
    Key_MonBrightnessUp = 0x010000b2,
    Key_MonBrightnessDown = 0x010000b3,
    Key_KeyboardLightOnOff = 0x010000b4,
    Key_KeyboardBrightnessUp = 0x010000b5,
    Key_KeyboardBrightnessDown = 0x010000b6,
    Key_PowerOff = 0x010000b7,
    Key_WakeUp = 0x010000b8,
    Key_Eject = 0x010000b9,
    Key_ScreenSaver = 0x010000ba,
    Key_WWW = 0x010000bb,
    Key_Memo = 0x010000bc,
    Key_LightBulb = 0x010000bd,
    Key_Shop = 0x010000be,
    Key_History = 0x010000bf,
    Key_AddFavorite = 0x010000c0,
    Key_HotLinks = 0x010000c1,
    Key_BrightnessAdjust = 0x010000c2,
    Key_Finance = 0x010000c3,
    Key_Community = 0x010000c4,
    Key_AudioRewind = 0x010000c5,
    Key_BackForward = 0x010000c6,
    Key_ApplicationLeft = 0x010000c7,
    Key_ApplicationRight = 0x010000c8,
    Key_Book = 0x010000c9,
    Key_CD = 0x010000ca,
    Key_Calculator = 0x010000cb,
    Key_ToDoList = 0x010000cc,
    Key_ClearGrab = 0x010000cd,
    Key_Close = 0x010000ce,
    Key_Copy = 0x010000cf,
    Key_Cut = 0x010000d0,
    Key_Display = 0x010000d1,
    Key_DOS = 0x010000d2,
    Key_Documents = 0x010000d3,
    Key_Excel = 0x010000d4,
    Key_Explorer = 0x010000d5,
    Key_Game = 0x010000d6,
    Key_Go = 0x010000d7,
    Key_iTouch = 0x010000d8,
    Key_LogOff = 0x010000d9,
    Key_Market = 0x010000da,
    Key_Meeting = 0x010000db,
    Key_MenuKB = 0x010000dc,
    Key_MenuPB = 0x010000dd,
    Key_MySites = 0x010000de,
    Key_News = 0x010000df,
    Key_OfficeHome = 0x010000e0,
    Key_Option = 0x010000e1,
    Key_Paste = 0x010000e2,
    Key_Phone = 0x010000e3,
    Key_Calendar = 0x010000e4,
    Key_Reply = 0x010000e5,
    Key_Reload = 0x010000e6,
    Key_RotateWindows = 0x010000e7,
    Key_RotationPB = 0x010000e8,
    Key_RotationKB = 0x010000e9,
    Key_Save = 0x010000ea,
    Key_Send = 0x010000eb,
    Key_Spell = 0x010000ec,
    Key_SplitScreen = 0x010000ed,
    Key_Support = 0x010000ee,
    Key_TaskPane = 0x010000ef,
    Key_Terminal = 0x010000f0,
    Key_Tools = 0x010000f1,
    Key_Travel = 0x010000f2,
    Key_Video = 0x010000f3,
    Key_Word = 0x010000f4,
    Key_Xfer = 0x010000f5,
    Key_ZoomIn = 0x010000f6,
    Key_ZoomOut = 0x010000f7,
    Key_Away = 0x010000f8,
    Key_Messenger = 0x010000f9,
    Key_WebCam = 0x010000fa,
    Key_MailForward = 0x010000fb,
    Key_Pictures = 0x010000fc,
    Key_Music = 0x010000fd,
    Key_Battery = 0x010000fe,
    Key_Bluetooth = 0x010000ff,
    Key_WLAN = 0x01000100,
    Key_UWB = 0x01000101,
    Key_AudioForward = 0x01000102,
    Key_AudioRepeat = 0x01000103,
    Key_AudioRandomPlay = 0x01000104,
    Key_Subtitle = 0x01000105,
    Key_AudioCycleTrack = 0x01000106,
    Key_Time = 0x01000107,
    Key_Hibernate = 0x01000108,
    Key_View = 0x01000109,
    Key_TopMenu = 0x0100010a,
    Key_PowerDown = 0x0100010b,
    Key_Suspend = 0x0100010c,
    Key_ContrastAdjust = 0x0100010d,
    Key_LaunchG = 0x0100010e,
    Key_LaunchH = 0x0100010f,
    Key_TouchpadToggle = 0x01000110,
    Key_TouchpadOn = 0x01000111,
    Key_TouchpadOff = 0x01000112,
    Key_MicMute = 0x01000113,
    Key_Red = 0x01000114,
    Key_Green = 0x01000115,
    Key_Yellow = 0x01000116,
    Key_Blue = 0x01000117,
    Key_ChannelUp = 0x01000118,
    Key_ChannelDown = 0x01000119,
    Key_Guide = 0x0100011a,
    Key_Info = 0x0100011b,
    Key_Settings = 0x0100011c,
    Key_MicVolumeUp = 0x0100011d,
    Key_MicVolumeDown = 0x0100011e,
    Key_New = 0x01000120,
    Key_Open = 0x01000121,
    Key_Find = 0x01000122,
    Key_Undo = 0x01000123,
    Key_Redo = 0x01000124,
    Key_OEM_1,
    Key_OEM_2,
    Key_OEM_3,
    Key_OEM_4,
    Key_OEM_5,
    Key_OEM_6,
    Key_OEM_7,
    Key_OEM_8,
    Key_OEM_102,
    Key_OEM_PLUS, 
    Key_OEM_COMMA,
    Key_OEM_MINUS,
    Key_OEM_PERIOD,
    
    Key_NUMPAD0,        
    Key_NUMPAD1,
    Key_NUMPAD2, 
    Key_NUMPAD3,
    Key_NUMPAD4,
    Key_NUMPAD5,
    Key_NUMPAD6,
    Key_NUMPAD7,
    Key_NUMPAD8,
    Key_NUMPAD9,

    Key_MediaLast = 0x0100ffff,

    // navigation keys
    Key_Select = 0x01010000,
    Key_Yes = 0x01010001,
    Key_No = 0x01010002,

    // misc keys
    Key_Cancel = 0x01020001,
    Key_Printer = 0x01020002,
    Key_Execute = 0x01020003,
    Key_Sleep = 0x01020004,
    Key_Play = 0x01020005, // Not Key_MediaPlay
    Key_Zoom = 0x01020006,
    Key_Jisho   = 0x01020007, // IME: Dictionary key
    Key_Oyayubi_Left = 0x01020008, // IME: Left Oyayubi key
    Key_Oyayubi_Right = 0x01020009, // IME: Right Oyayubi key
    Key_Exit = 0x0102000a,

    // Device keys
    Key_Context1 = 0x01100000,
    Key_Context2 = 0x01100001,
    Key_Context3 = 0x01100002,
    Key_Context4 = 0x01100003,
    Key_Call = 0x01100004,      
    Key_Hangup = 0x01100005, 
    Key_Flip = 0x01100006,
    Key_ToggleCallHangup = 0x01100007,
    Key_VoiceDial = 0x01100008,
    Key_LastNumberRedial = 0x01100009,
    Key_Camera = 0x01100020,
    Key_CameraFocus = 0x01100021,
    Key_unknown = 0x01ffffff
};
*/

////////////
#ifdef WIN32
// https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
// Windows Keyboard mapping table
//static const unsigned int winKey[] = { 
// 
//std::map<int, Key> winKey;
enum Key{
                             // Dec | Hex |  Windows Virtual key
    KEY_UNASSIGNED,          //   0   0x00   -- UNASSIGNED --
    KEY_LBUTTON,             //   1   0x01   VK_LBUTTON          | Left mouse button
    KEY_RBUTTON,             //   2   0x02   VK_RBUTTON          | Right mouse button
    KEY_CANCEL,              //   3   0x03   VK_CANCEL           | Control-Break processing
    KEY_MBUTTON,             //   4   0x04   VK_MBUTTON          | Middle mouse button
    KEY_XBUTTON1,            //   5   0x05   VK_XBUTTON1         | X1 mouse button
    KEY_XBUTTON2,            //   6   0x06   VK_XBUTTON2         | X2 mouse button
    //KEY_UNASSIGNED,        //   7   0x07   -- UNASSIGNED --
    KEY_BACK = 8,            //   8   0x08   VK_BACK             | BackSpace key
    KEY_TAB,                 //   9   0x09   VK_TAB              | Tab key
    KEY_RESERVED,            //  10   0x0A   -- RESERVED --
    //KEY_RESERVED,          //  11   0x0B   -- RESERVED --
    KEY_CLEAR = 12,          //  12   0x0C   VK_CLEAR            | Clear key
    KEY_RETURN,              //  13   0x0D   VK_RETURN           | Enter key
    //KEY_UNASSIGNED,        //  14   0x0E   -- UNASSIGNED --
    //KEY_UNASSIGNED,        //  15   0x0F   -- UNASSIGNED --
    KEY_SHIFT = 16,          //  16   0x10   VK_SHIFT            | Shift key
    KEY_CONTROL,             //  17   0x11   VK_CONTROL          | Ctrl key
    KEY_MENU,                //  18   0x12   VK_MENU             | Alt key
    KEY_PAUSE,               //  19   0x13   VK_PAUSE            | Pause key
    KEY_CAPITAL,             //  20   0x14   VK_CAPITAL          | Caps-Lock
    KEY_KANA,                //  21   0x15   VK_KANA / VK_HANGUL | IME Kana or Hangul mode
    //KEY_UNASSIGNED,        //  22   0x16   -- UNASSIGNED --
    KEY_JUNJA = 23,          //  23   0x17   VK_JUNJA            | IME Junja mode
    KEY_FINAL,               //  24   0x18   VK_FINAL            | IME final mode
    KEY_HANJA,               //  25   0x19   VK_HANJA / VK_KANJI | IME Hanja or Kanji mode
    //KEY_UNASSIGNED,        //  26   0x1A   -- UNASSIGNED --
    KEY_ESCAPE = 27,         //  27   0x1B   VK_ESCAPE           | Esc key
    KEY_CONVERT,             //  28   0x1C   VK_CONVERT          | IME convert
    KEY_NONCONVERT,          //  29   0x1D   VK_NONCONVERT       | IME non-convert
    KEY_ACCEPT,              //  30   0x1E   VK_ACCEPT           | IME accept
    KEY_MODECHANGE,          //  31   0x1F   VK_MODECHANGE       | IME mode change request
    KEY_SPACE,               //  32   0x20   VK_SPACE            | Spacebar
    KEY_PRIOR,               //  33   0x21   VK_PRIOR            | Page Up key
    KEY_NEXT,                //  34   0x22   VK_NEXT             | Page Down key
    KEY_END,                 //  35   0x23   VK_END              | End key
    KEY_HOME,                //  36   0x24   VK_HOME             | Home key
    KEY_LEFT,                //  37   0x25   VK_LEFT             | Left arrow key
    KEY_UP,                  //  38   0x26   VK_UP               | Up arrow key
    KEY_RIGHT,               //  39   0x27   VK_RIGHT            | Right arrow key
    KEY_DOWN,                //  40   0x28   VK_DOWN             | Down arrow key
    KEY_SELECT,              //  41   0x29   VK_SELECT           | Select key
    KEY_PRINT,               //  42   0x2A   VK_PRINT            | Print key
    KEY_EXECUTE_,            //  43   0x2B   VK_EXECUTE          | Execute key
    KEY_SNAPSHOT,            //  44   0x2C   VK_SNAPSHOT         | Print Screen key
    KEY_INSERT,              //  45   0x2D   VK_INSERT           | Ins key
    KEY_DELETE,              //  46   0x2E   VK_DELETE           | Del key
    KEY_HELP,                //  47   0x2F   VK_HELP             | Help key
    KEY_0,                   //  48   0x30   VK_0                | 0 key
    KEY_1,                   //  49   0x31   VK_1                | 1 key
    KEY_2,                   //  50   0x32   VK_2                | 2 key
    KEY_3,                   //  51   0x33   VK_3                | 3 key
    KEY_4,                   //  52   0x34   VK_4                | 4 key
    KEY_5,                   //  53   0x35   VK_5                | 5 key
    KEY_6,                   //  54   0x36   VK_6                | 6 key
    KEY_7,                   //  55   0x37   VK_7                | 7 key
    KEY_8,                   //  56   0x38   VK_8                | 8 key
    KEY_9,                   //  57   0x39   VK_9                | 9 key
    //KEY_UNASSIGNED,        //  58   0x3A   -- UNASSIGNED --
    //KEY_UNASSIGNED,        //  59   0x3B   -- UNASSIGNED --
    //KEY_UNASSIGNED,        //  60   0x3C   -- UNASSIGNED --
    //KEY_UNASSIGNED,        //  61   0x3D   -- UNASSIGNED --
    //KEY_UNASSIGNED,        //  62   0x3E   -- UNASSIGNED --
    //KEY_UNASSIGNED,        //  63   0x3F   -- UNASSIGNED --
    //KEY_UNASSIGNED,        //  64   0x40   -- UNASSIGNED --
    KEY_A = 65,              //  65   0x41   VK_A                | A key
    KEY_B,                   //  66   0x42   VK_B                | B key
    KEY_C,                   //  67   0x43   VK_C                | C key
    KEY_D,                   //  68   0x44   VK_D                | D key
    KEY_E,                   //  69   0x45   VK_E                | E key
    KEY_F,                   //  70   0x46   VK_F                | F key
    KEY_G,                   //  71   0x47   VK_G                | G key
    KEY_H,                   //  72   0x48   VK_H                | H key
    KEY_I,                   //  73   0x49   VK_I                | I key
    KEY_J,                   //  74   0x4A   VK_J                | J key
    KEY_K,                   //  75   0x4B   VK_K                | K key
    KEY_L,                   //  76   0x4C   VK_L                | L key
    KEY_M,                   //  77   0x4D   VK_M                | M key
    KEY_N,                   //  78   0x4E   VK_N                | N key
    KEY_O,                   //  79   0x4F   VK_O                | O key
    KEY_P,                   //  80   0x50   VK_P                | P key
    KEY_Q,                   //  81   0x51   VK_Q                | Q key
    KEY_R,                   //  82   0x52   VK_R                | R key
    KEY_S,                   //  83   0x53   VK_S                | S key
    KEY_T,                   //  84   0x54   VK_T                | T key
    KEY_U,                   //  85   0x55   VK_U                | U key
    KEY_V,                   //  86   0x56   VK_V                | V key
    KEY_W,                   //  87   0x57   VK_W                | W key
    KEY_X,                   //  88   0x58   VK_X                | X key
    KEY_Y,                   //  89   0x59   VK_Y                | Y key
    KEY_Z,                   //  90   0x5A   VK_Z                | Z key
    KEY_LWIN,                //  91   0x5B   VK_LWIN             | Left Windows  - MS Natural kbd
    KEY_RWIN,                //  92   0x5C   VK_RWIN             | Right Windows - MS Natural kbd
    KEY_APPS,                //  93   0x5D   VK_APPS             | Application key-MS Natural kbd
    //KEY_RESERVED,          //  94   0x5E   -- RESERVED --
    KEY_SLEEP = 95,          //  95   0x5F   VK_SLEEP
    KEY_NUMPAD0,             //  96   0x60   VK_NUMPAD0          | Numeric keypad 0 key
    KEY_NUMPAD1,             //  97   0x61   VK_NUMPAD1          | Numeric keypad 1 key
    KEY_NUMPAD2,             //  98   0x62   VK_NUMPAD2          | Numeric keypad 2 key
    KEY_NUMPAD3,             //  99   0x63   VK_NUMPAD3          | Numeric keypad 3 key
    KEY_NUMPAD4,             // 100   0x64   VK_NUMPAD4          | Numeric keypad 4 key
    KEY_NUMPAD5,             // 101   0x65   VK_NUMPAD5          | Numeric keypad 5 key
    KEY_NUMPAD6,             // 102   0x66   VK_NUMPAD6          | Numeric keypad 6 key
    KEY_NUMPAD7,             // 103   0x67   VK_NUMPAD7          | Numeric keypad 7 key
    KEY_NUMPAD8,             // 104   0x68   VK_NUMPAD8          | Numeric keypad 8 key
    KEY_NUMPAD9,             // 105   0x69   VK_NUMPAD9          | Numeric keypad 9 key
    KEY_MULTIPLY,            // 106   0x6A   VK_MULTIPLY         | Multiply key
    KEY_ADD,                 // 107   0x6B   VK_ADD              | Add key
    KEY_SEPERATOR,           // 108   0x6C   VK_SEPARATOR        | Separator key (locale-dependent)
    KEY_SUBTRACT,            // 109   0x6D   VK_SUBTRACT         | Subtract key
    KEY_DECIMAL,             // 110   0x6E   VK_DECIMAL          | Decimal key (locale-dependent)
    KEY_DIVIDE,              // 111   0x6F   VK_DIVIDE           | Divide key
    KEY_F1,                  // 112   0x70   VK_F1               | F1 key
    KEY_F2,                  // 113   0x71   VK_F2               | F2 key
    KEY_F3,                  // 114   0x72   VK_F3               | F3 key
    KEY_F4,                  // 115   0x73   VK_F4               | F4 key
    KEY_F5,                  // 116   0x74   VK_F5               | F5 key
    KEY_F6,                  // 117   0x75   VK_F6               | F6 key
    KEY_F7,                  // 118   0x76   VK_F7               | F7 key
    KEY_F8,                  // 119   0x77   VK_F8               | F8 key
    KEY_F9,                  // 120   0x78   VK_F9               | F9 key
    KEY_F10,                 // 121   0x79   VK_F10              | F10 key
    KEY_F11,                 // 122   0x7A   VK_F11              | F11 key
    KEY_F12,                 // 123   0x7B   VK_F12              | F12 key
    KEY_F13,                 // 124   0x7C   VK_F13              | F13 key
    KEY_F14,                 // 125   0x7D   VK_F14              | F14 key
    KEY_F15,                 // 126   0x7E   VK_F15              | F15 key
    KEY_F16,                 // 127   0x7F   VK_F16              | F16 key
    KEY_F17,                 // 128   0x80   VK_F17              | F17 key
    KEY_F18,                 // 129   0x81   VK_F18              | F18 key
    KEY_F19,                 // 130   0x82   VK_F19              | F19 key
    KEY_F20,                 // 131   0x83   VK_F20              | F20 key
    KEY_F21,                 // 132   0x84   VK_F21              | F21 key
    KEY_F22,                 // 133   0x85   VK_F22              | F22 key
    KEY_F23,                 // 134   0x86   VK_F23              | F23 key
    KEY_F24,                 // 135   0x87   VK_F24              | F24 key
    //KEY_UNASSIGNED,        // 136   0x88   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 137   0x89   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 138   0x8A   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 139   0x8B   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 140   0x8C   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 141   0x8D   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 142   0x8E   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 143   0x8F   -- UNASSIGNED --
    KEY_NUMLOCK = 144,       // 144   0x90   VK_NUMLOCK          | Num Lock key
    KEY_SCROLL,              // 145   0x91   VK_SCROLL           | Scroll Lock key
                             // Fujitsu/OASYS kbd --------------------
    KEY_OEM_FJ_JISHO,        // 146   0x92   VK_OEM_FJ_JISHO     | 'Dictionary' key /
                             //              VK_OEM_NEC_EQUAL    | key on numpad on NEC PC-9800 kbd
    KEY_OEM_FJ_MASSHOU,      // 147   0x93   VK_OEM_FJ_MASSHOU   | 'Unregister word' key
    KEY_OEM_FJ_TOUROKU,      // 148   0x94   VK_OEM_FJ_TOUROKU   | 'Register word' key
    KEy_OEM_FJ_LOYA,         // 149   0x95   VK_OEM_FJ_LOYA      | 'Left OYAYUBI' key
    KEY_OEM_FJ_ROYA,         // 150   0x96   VK_OEM_FJ_ROYA      | 'Right OYAYUBI' key
    //KEY_UNASSIGNED,        // 151   0x97   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 152   0x98   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 153   0x99   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 154   0x9A   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 155   0x9B   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 156   0x9C   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 157   0x9D   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 158   0x9E   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 159   0x9F   -- UNASSIGNED --
    KEY_LSHIFT = 160,        // 160   0xA0   VK_LSHIFT              | Left Shift key
    KEY_RSHIFT,              // 161   0xA1   VK_RSHIFT              | Right Shift key
    KEY_LCONTROL,            // 162   0xA2   VK_LCONTROL            | Left Ctrl key
    KEY_RCONTROL,            // 163   0xA3   VK_RCONTROL            | Right Ctrl key
    KEY_LMENU,               // 164   0xA4   VK_LMENU               | Left Menu key
    KEY_RMENU,               // 165   0xA5   VK_RMENU               | Right Menu key
    KEY_BROWSER_BACK,        // 166   0xA6   VK_BROWSER_BACK        | Browser Back key
    KEY_BROWSER_FORWARD,     // 167   0xA7   VK_BROWSER_FORWARD     | Browser Forward key
    KEY_BROWSER_REFRESH,     // 168   0xA8   VK_BROWSER_REFRESH     | Browser Refresh key
    KEY_BROWSER_STOP,        // 169   0xA9   VK_BROWSER_STOP        | Browser Stop key
    KEY_BROWSER_SEARCH,      // 170   0xAA   VK_BROWSER_SEARCH      | Browser Search key
    KEY_BROWSER_FAVORITES,   // 171   0xAB   VK_BROWSER_FAVORITES   | Browser Favorites key
    KEY_BROWSER_HOME,        // 172   0xAC   VK_BROWSER_HOME        | Browser Start and Home key
    KEY_VOLUME_MUTE,         // 173   0xAD   VK_VOLUME_MUTE         | Volume Mute key
    KEY_VOLUME_DOWN,         // 174   0xAE   VK_VOLUME_DOWN         | Volume Down key
    KEY_VOLUME_UP,           // 175   0xAF   VK_VOLUME_UP           | Volume Up key
    KEY_MEDIA_NEXT_TRACK,    // 176   0xB0   VK_MEDIA_NEXT_TRACK    | Next Track key
    KEY_MEDIA_PREV_TRACK,    // 177   0xB1   VK_MEDIA_PREV_TRACK    | Previous Track key
    KEY_MEDIA_STOP,          // 178   0xB2   VK_MEDIA_STOP          | Stop Media key
    KEY_MEDIA_PLAY_PAUSE,    // 179   0xB3   VK_MEDIA_PLAY_PAUSE    | Play/Pause Media key
    KEY_LAUNCH_MAIL,         // 180   0xB4   VK_LAUNCH_MAIL         | Start Mail key
    KEY_LAUNCH_MEDIA_SELECT, // 181   0xB5   VK_LAUNCH_MEDIA_SELECT | Select Media key
    KEY_LAUNCH_APP1,         // 182   0xB6   VK_LAUNCH_APP1         | Start Application 1 key
    KEY_LAUNCH_APP2,         // 183   0xB7   VK_LAUNCH_APP2         | Start Application 2 key
    //KEY_RESERVED,          // 184   0xB8   -- RESERVED --
    //KEY_RESERVED,          // 185   0xB9   -- RESERVED --
    KEY_OEM_1 = 186,         // 186   0xBA   VK_OEM_1               | ';:' for US
    KEY_OEM_PLUS,            // 187   0xBB   VK_OEM_PLUS            | '+' any country
    KEY_OEM_COMMA,           // 188   0xBC   VK_OEM_COMMA           | ',' any country
    KEY_OEM_MINUS,           // 189   0xBD   VK_OEM_MINUS           | '-' any country
    KEY_OEM_PERIOD,          // 190   0xBE   VK_OEM_PERIOD          | '.' any country
    KEY_OEM_2,               // 191   0xBF   VK_OEM_2               | '/?' for US
    KEY_OEM_3,               // 192   0xC0   VK_OEM_3               | '`~' for US
    //KEY_RESERVED,          // 193   0xC1   -- RESERVED --
    //KEY_RESERVED,          // 194   0xC2   -- RESERVED --
    //KEY_RESERVED,          // 195   0xC3   -- RESERVED --
    //KEY_RESERVED,          // 196   0xC4   -- RESERVED --
    //KEY_RESERVED,          // 197   0xC5   -- RESERVED --
    //KEY_RESERVED,          // 198   0xC6   -- RESERVED --
    //KEY_RESERVED,          // 199   0xC7   -- RESERVED --
    //KEY_RESERVED,          // 200   0xC8   -- RESERVED --
    //KEY_RESERVED,          // 201   0xC9   -- RESERVED --
    //KEY_RESERVED,          // 202   0xCA   -- RESERVED --
    //KEY_RESERVED,          // 203   0xCB   -- RESERVED --
    //KEY_RESERVED,          // 204   0xCC   -- RESERVED --
    //KEY_RESERVED,          // 205   0xCD   -- RESERVED --
    //KEY_RESERVED,          // 206   0xCE   -- RESERVED --
    //KEY_RESERVED,          // 207   0xCF   -- RESERVED --
    //KEY_RESERVED,          // 208   0xD0   -- RESERVED --
    //KEY_RESERVED,          // 209   0xD1   -- RESERVED --
    //KEY_RESERVED,          // 210   0xD2   -- RESERVED --
    //KEY_RESERVED,          // 211   0xD3   -- RESERVED --
    //KEY_RESERVED,          // 212   0xD4   -- RESERVED --
    //KEY_RESERVED,          // 213   0xD5   -- RESERVED --
    //KEY_RESERVED,          // 214   0xD6   -- RESERVED --
    //KEY_RESERVED,          // 215   0xD7   -- RESERVED --
    //KEY_UNASSIGNED,        // 216   0xD8   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 217   0xD9   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 218   0xDA   -- UNASSIGNED --
    KEY_OEM_4 = 219,         // 219   0xDB   VK_OEM_4            | '[{' for US
    KEY_OEM_5,               // 220   0xDC   VK_OEM_5            | '\|' for US
    KEY_OEM_6,               // 221   0xDD   VK_OEM_6            | ']}' for US
    KEY_OEM_7,               // 222   0xDE   VK_OEM_7            | ''"' for US
    KEY_OEM_8,               // 223   0xDF   VK_OEM_8
    //KEY_RESERVED,          // 224   0xE0   -- RESERVED --
    KEY_OEM_AX = 225,        // 225   0xE1   VK_OEM_AX           | 'AX' key on Japanese AX kbd
    KEY_OEM_102,             // 226   0xE2   VK_OEM_102          | "<>" or "\|" on RT 102-key kbd
    KEY_ICO_HELP,            // 227   0xE3   VK_ICO_HELP         | Help key on ICO
    KEY_ICO_00,              // 228   0xE4   VK_ICO_00           | 00 key on ICO
    KEY_PROCESSKEY,          // 229   0xE5   VK_PROCESSKEY       | IME Process key
    KEY_ICO_CLEAR,           // 230   0xE6   VK_ICO_CLEAR        |
    KEY_PACKET,              // 231   0xE7   VK_PACKET           | Unicode char as keystrokes
    //KEY_UNASSIGNED,        // 232   0xE8   -- UNASSIGNED --
                             // Nokia/Ericsson definitions ---------------
    KEY_OEM_RESET = 233,     // 233   0xE9   VK_OEM_RESET
    KEY_OEM_JUMP,            // 234   0xEA   VK_OEM_JUMP
    KEY_OEM_PA1,             // 235   0xEB   VK_OEM_PA1
    KEY_OEM_PA2,             // 236   0xEC   VK_OEM_PA2
    KEY_OEM_PA3,             // 237   0xED   VK_OEM_PA3
    KEY_OEM_WSCTRL,          // 238   0xEE   VK_OEM_WSCTRL
    KEY_OEM_CUSEL,           // 239   0xEF   VK_OEM_CUSEL
    KEY_OEM_ATTN,            // 240   0xF0   VK_OEM_ATTN
    KEY_OEM_FINISH,          // 241   0xF1   VK_OEM_FINISH
    KEY_OEM_COPY,            // 242   0xF2   VK_OEM_COPY
    KEY_OEM_AUTO,            // 243   0xF3   VK_OEM_AUTO
    KEY_OEM_ENLW,            // 244   0xF4   VK_OEM_ENLW
    KEY_OEM_BACKTAB,         // 245   0xF5   VK_OEM_BACKTAB
    KEY_ATTN,                // 246   0xF6   VK_ATTN             | Attn key
    KEY_CRSEL,               // 247   0xF7   VK_CRSEL            | CrSel key
    KEY_EXSEL,               // 248   0xF8   VK_EXSEL            | ExSel key
    KEY_EREOF,               // 249   0xF9   VK_EREOF            | Erase EOF key
    KEY_PLAY,                // 250   0xFA   VK_PLAY             | Play key
    KEY_ZOOM,                // 251   0xFB   VK_ZOOM             | Zoom key
    KEY_NONAME,              // 252   0xFC   VK_NONAME           | Reserved
    KEY_PA1,                 // 253   0xFD   VK_PA1              | PA1 key
    KEY_OEM_CLEAR,           // 254   0xFE   VK_OEM_CLEAR        | Clear key

                                                      // Multimedia key table
                                                      // Dec |  Hex | AppCommand
    //KEY_UNASSIGNED,                                 //   0   0x00   -- UNASSIGNED --
    KEY_APPCOMMAND_BROWSER_BACKWARD = 1,              //   1   0x01   APPCOMMAND_BROWSER_BACKWARD
    KEY_APPCOMMAND_BROWSER_FORWARD,                   //   2   0x02   APPCOMMAND_BROWSER_FORWARD
    KEY_APPCOMMAND_BROWSER_REFRESH,                   //   3   0x03   APPCOMMAND_BROWSER_REFRESH
    KEY_APPCOMMAND_BROWSER_STOP,                      //   4   0x04   APPCOMMAND_BROWSER_STOP
    KEY_APPCOMMAND_BROWSER_SEARCH,                    //   5   0x05   APPCOMMAND_BROWSER_SEARCH
    KEY_APPCOMMAND_BROWSER_FAVORITES,                 //   6   0x06   APPCOMMAND_BROWSER_FAVORITES
    KEY_APPCOMMAND_BROWSER_HOME,                      //   7   0x07   APPCOMMAND_BROWSER_HOME
    KEY_APPCOMMAND_VOLUME_MUTE,                       //   8   0x08   APPCOMMAND_VOLUME_MUTE
    KEY_APPCOMMAND_VOLUME_DOWN,                       //   9   0x09   APPCOMMAND_VOLUME_DOWN
    KEY_APPCOMMAND_VOLUME_UP,                         //  10   0x0a   APPCOMMAND_VOLUME_UP
    KEY_APPCOMMAND_MEDIA_NEXTTRACK,                   //  11   0x0b   APPCOMMAND_MEDIA_NEXTTRACK
    KEY_APPCOMMAND_MEDIA_PREVIOUSTRACK,               //  12   0x0c   APPCOMMAND_MEDIA_PREVIOUSTRACK
    KEY_APPCOMMAND_MEDIA_STOP,                        //  13   0x0d   APPCOMMAND_MEDIA_STOP
    KEY_APPCOMMAND_MEDIA_PLAYPAUSE,                   //  14   0x0e   APPCOMMAND_MEDIA_PLAYPAUSE
    KEY_APPCOMMAND_LAUNCH_MAIL,                       //  15   0x0f   APPCOMMAND_LAUNCH_MAIL
    KEY_APPCOMMAND_LAUNCH_MEDIA_SELECT,               //  16   0x10   APPCOMMAND_LAUNCH_MEDIA_SELECT
    KEY_APPCOMMAND_LAUNCH_APP1,                       //  17   0x11   APPCOMMAND_LAUNCH_APP1
    KEY_APPCOMMAND_LAUNCH_APP2,                       //  18   0x12   APPCOMMAND_LAUNCH_APP2
    KEY_APPCOMMAND_BASS_DOWN,                         //  19   0x13   APPCOMMAND_BASS_DOWN
    KEY_APPCOMMAND_BASS_BOOST,                        //  20   0x14   APPCOMMAND_BASS_BOOST
    KEY_APPCOMMAND_BASS_UP,                           //  21   0x15   APPCOMMAND_BASS_UP
    KEY_APPCOMMAND_TREBLE_DOWN,                       //  22   0x16   APPCOMMAND_TREBLE_DOWN
    KEY_APPCOMMAND_TREBLE_UP,                         //  23   0x17   APPCOMMAND_TREBLE_UP
    KEY_APPCOMMAND_MICROPHONE_VOLUME_MUTE,            //  24   0x18   APPCOMMAND_MICROPHONE_VOLUME_MUTE
    KEY_APPCOMMAND_MICROPHONE_VOLUME_DOWN,            //  25   0x19   APPCOMMAND_MICROPHONE_VOLUME_DOWN
    KEY_APPCOMMAND_MICROPHONE_VOLUME_UP,              //  26   0x1a   APPCOMMAND_MICROPHONE_VOLUME_UP
    KEY_APPCOMMAND_HELP,                              //  27   0x1b   APPCOMMAND_HELP
    KEY_APPCOMMAND_FIND,                              //  28   0x1c   APPCOMMAND_FIND
    KEY_APPCOMMAND_NEW,                               //  29   0x1d   APPCOMMAND_NEW
    KEY_APPCOMMAND_OPEN,                              //  30   0x1e   APPCOMMAND_OPEN
    KEY_APPCOMMAND_CLOSE,                             //  31   0x1f   APPCOMMAND_CLOSE
    KEY_APPCOMMAND_SAVE,                              //  32   0x20   APPCOMMAND_SAVE
    KEY_APPCOMMAND_PRINT,                             //  33   0x21   APPCOMMAND_PRINT
    KEY_APPCOMMAND_UNDO,                              //  34   0x22   APPCOMMAND_UNDO
    KEY_APPCOMMAND_REDO,                              //  35   0x23   APPCOMMAND_REDO
    KEY_APPCOMMAND_COPY,                              //  36   0x24   APPCOMMAND_COPY
    KEY_APPCOMMAND_CUT,                               //  37   0x25   APPCOMMAND_CUT
    KEY_APPCOMMAND_PASTE,                             //  38   0x26   APPCOMMAND_PASTE
    KEY_APPCOMMAND_REPLY_TO_MAIL,                     //  39   0x27   APPCOMMAND_REPLY_TO_MAIL
    KEY_APPCOMMAND_FORWARD_MAIL,                      //  40   0x28   APPCOMMAND_FORWARD_MAIL
    KEY_APPCOMMAND_SEND_MAIL,                         //  41   0x29   APPCOMMAND_SEND_MAIL
    KEY_APPCOMMAND_SPELL_CHECK,                       //  42   0x2a   APPCOMMAND_SPELL_CHECK 
    KEY_APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE, //  43   0x2b   APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE
    KEY_APPCOMMAND_MIC_ON_OFF_TOGGLE,                 //  44   0x2c   APPCOMMAND_MIC_ON_OFF_TOGGLE
    KEY_APPCOMMAND_CORRECTION_LIST,                   //  45   0x2d   APPCOMMAND_CORRECTION_LIST
    KEY_APPCOMMAND_MEDIA_PLAY,                        //  46   0x2e   APPCOMMAND_MEDIA_PLAY
    KEY_APPCOMMAND_MEDIA_PAUSE,                       //  47   0x2f   APPCOMMAND_MEDIA_PAUSE
    KEY_APPCOMMAND_MEDIA_RECORD,                      //  48   0x30   APPCOMMAND_MEDIA_RECORD
    KEY_APPCOMMAND_MEDIA_FAST_FORWARD,                //  49   0x31   APPCOMMAND_MEDIA_FAST_FORWARD
    KEY_APPCOMMAND_MEDIA_REWIND,                      //  50   0x32   APPCOMMAND_MEDIA_REWIND
    KEY_APPCOMMAND_MEDIA_CHANNEL_DOWN,                //  51   0x33   APPCOMMAND_MEDIA_CHANNEL_DOWN
    KEY_APPCOMMAND_MEDIA_CHANNEL_UP                   //  52   0x34   APPCOMMAND_MEDIA_CHANNEL_UP
};

/*
static const int KeyboardModifiers[] = {
    NoModifier,                                     // 0
    ShiftModifier,                                  // 1
    ControlModifier,                                // 2
    ControlModifier | ShiftModifier,                // 3
    AltModifier,                                    // 4
    AltModifier | ShiftModifier,                    // 5
    AltModifier | ControlModifier,                  // 6
    AltModifier | ShiftModifier | ControlModifier,  // 7
    NoModifier,                                             // Fall-back to raw Key_*
};
*/
#endif  //WIN32


//////////
#ifdef MAC
// TODO
#endif //MAC


////////////
#ifdef LINUX
// TODO
#endif //LINUX


// Reference
// https://dreamswork.github.io/qt4/qkeymapper__mac_8cpp_source.html
// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode 
// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values
// https://www.w3.org/TR/uievents-key/
// https://code.woboq.org/qt5/qtbase/src/corelib/global/qnamespace.h.html
// https://code.woboq.org/qt5/qtbase/src/plugins/platforms/windows/qwindowskeymapper.cpp.html


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
static std::map<Key, KeyboardEventMap> keys;
void mapKeys();
void mapKey(Key name, int vk_keycode, DKString code, DKString key, int location = 0);

#endif //DKKeyCodes_H