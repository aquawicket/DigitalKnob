#ifndef DKKEYCODES_H
#define DKKEYCODES_H


	
enum DK_KeyModifier {
        NoModifier           = 0x00000000,
        ShiftModifier        = 0x02000000,
        ControlModifier      = 0x04000000,
        AltModifier          = 0x08000000,
        MetaModifier         = 0x10000000,
        KeypadModifier       = 0x20000000,
        GroupSwitchModifier  = 0x40000000,
        // Do not extend the mask to include 0x01000000
        KeyboardModifierMask = 0xfe000000
};

 //shorter names for shortcuts
    // The use of all-caps identifiers has the potential for clashing with
    // user-defined or third-party macros. More so when the identifiers are not
    // "namespace"-prefixed. This is considered bad practice and is why
    // KeypadModifier was not added to the Modifier enum.
enum DK_Modifier {
        META          = MetaModifier,
        SHIFT         = ShiftModifier,
        CTRL          = ControlModifier,
        ALT           = AltModifier,
        MODIFIER_MASK = KeyboardModifierMask,
        UNICODE_ACCEL = 0x00000000
};

enum DK_Key {
        Key_Escape = 0x01000000,                // misc keys
        Key_Tab = 0x01000001,
        Key_Backtab = 0x01000002,
        Key_Backspace = 0x01000003,
        Key_Return = 0x01000004,
        Key_Enter = 0x01000005,
        Key_Insert = 0x01000006,
        Key_Delete = 0x01000007,
        Key_Pause = 0x01000008,
        Key_Print = 0x01000009,               // print screen
        Key_SysReq = 0x0100000a,
        Key_Clear = 0x0100000b,
        Key_Home = 0x01000010,                // cursor movement
        Key_End = 0x01000011,
        Key_Left = 0x01000012,
        Key_Up = 0x01000013,
        Key_Right = 0x01000014,
        Key_Down = 0x01000015,
        Key_PageUp = 0x01000016,
        Key_PageDown = 0x01000017,
        Key_Shift = 0x01000020,                // modifiers
        Key_Control = 0x01000021,
        Key_Meta = 0x01000022,
        Key_Alt = 0x01000023,
        Key_CapsLock = 0x01000024,
        Key_NumLock = 0x01000025,
        Key_ScrollLock = 0x01000026,
        Key_F1 = 0x01000030,                // function keys
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
        Key_F25 = 0x01000048,                // F25 .. F35 only on X11
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
        Key_Super_L = 0x01000053,                 // extra keys
        Key_Super_R = 0x01000054,
        Key_Menu = 0x01000055,
        Key_Hyper_L = 0x01000056,
        Key_Hyper_R = 0x01000057,
        Key_Help = 0x01000058,
        Key_Direction_L = 0x01000059,
        Key_Direction_R = 0x01000060,
        Key_Space = 0x20,                // 7 bit printable ASCII
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
        Key_Asterisk = 0x2a,
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
        Key_guillemotleft = 0x0ab,        // left angle quotation mark
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
        Key_guillemotright = 0x0bb,        // right angle quotation mark
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
        Key_Otilde = 0x0d5,
        Key_Odiaeresis = 0x0d6,
        Key_multiply = 0x0d7,
        Key_Ooblique = 0x0d8,
        Key_Ugrave = 0x0d9,
        Key_Uacute = 0x0da,
        Key_Ucircumflex = 0x0db,
        Key_Udiaeresis = 0x0dc,
        Key_Yacute = 0x0dd,
        Key_THORN = 0x0de,
        Key_ssharp = 0x0df,
        Key_division = 0x0f7,
        Key_ydiaeresis = 0x0ff,
        // International input method support (X keycode - 0xEE00, the
        // definition follows Qt/Embedded 2.3.7) Only interesting if
        // you are writing your own input method
        // International & multi-key character composition
        Key_AltGr               = 0x01001103,
        Key_Multi_key           = 0x01001120,  // Multi-key character compose
        Key_Codeinput           = 0x01001137,
        Key_SingleCandidate     = 0x0100113c,
        Key_MultipleCandidate   = 0x0100113d,
        Key_PreviousCandidate   = 0x0100113e,
        // Misc Functions
        Key_Mode_switch         = 0x0100117e,  // Character set switch
        //Key_script_switch       = 0x0100117e,  // Alias for mode_switch
        // Japanese keyboard support
        Key_Kanji               = 0x01001121,  // Kanji, Kanji convert
        Key_Muhenkan            = 0x01001122,  // Cancel Conversion
        //Key_Henkan_Mode         = 0x01001123,  // Start/Stop Conversion
        Key_Henkan              = 0x01001123,  // Alias for Henkan_Mode
        Key_Romaji              = 0x01001124,  // to Romaji
        Key_Hiragana            = 0x01001125,  // to Hiragana
        Key_Katakana            = 0x01001126,  // to Katakana
        Key_Hiragana_Katakana   = 0x01001127,  // Hiragana/Katakana toggle
        Key_Zenkaku             = 0x01001128,  // to Zenkaku
        Key_Hankaku             = 0x01001129,  // to Hankaku
        Key_Zenkaku_Hankaku     = 0x0100112a,  // Zenkaku/Hankaku toggle
        Key_Touroku             = 0x0100112b,  // Add to Dictionary
        Key_Massyo              = 0x0100112c,  // Delete from Dictionary
        Key_Kana_Lock           = 0x0100112d,  // Kana Lock
        Key_Kana_Shift          = 0x0100112e,  // Kana Shift
        Key_Eisu_Shift          = 0x0100112f,  // Alphanumeric Shift
        Key_Eisu_toggle         = 0x01001130,  // Alphanumeric toggle
        //Key_Kanji_Bangou        = 0x01001137,  // Codeinput
        //Key_Zen_Koho            = 0x0100113d,  // Multiple/All Candidate(s)
        //Key_Mae_Koho            = 0x0100113e,  // Previous Candidate
        // Korean keyboard support
        //
        // In fact, many Korean users need only 2 keys, Key_Hangul and
        // Key_Hangul_Hanja. But rest of the keys are good for future.
        Key_Hangul              = 0x01001131,  // Hangul start/stop(toggle)
        Key_Hangul_Start        = 0x01001132,  // Hangul start
        Key_Hangul_End          = 0x01001133,  // Hangul end, English start
        Key_Hangul_Hanja        = 0x01001134,  // Start Hangul->Hanja Conversion
        Key_Hangul_Jamo         = 0x01001135,  // Hangul Jamo mode
        Key_Hangul_Romaja       = 0x01001136,  // Hangul Romaja mode
        //Key_Hangul_Codeinput    = 0x01001137,  // Hangul code input mode
        Key_Hangul_Jeonja       = 0x01001138,  // Jeonja mode
        Key_Hangul_Banja        = 0x01001139,  // Banja mode
        Key_Hangul_PreHanja     = 0x0100113a,  // Pre Hanja conversion
        Key_Hangul_PostHanja    = 0x0100113b,  // Post Hanja conversion
        //Key_Hangul_SingleCandidate   = 0x0100113c,  // Single candidate
        //Key_Hangul_MultipleCandidate = 0x0100113d,  // Multiple candidate
        //Key_Hangul_PreviousCandidate = 0x0100113e,  // Previous candidate
        Key_Hangul_Special      = 0x0100113f,  // Special symbols
        //Key_Hangul_switch       = 0x0100117e,  // Alias for mode_switch
        // dead keys (X keycode - 0xED00 to avoid the conflict)
        Key_Dead_Grave          = 0x01001250,
        Key_Dead_Acute          = 0x01001251,
        Key_Dead_Circumflex     = 0x01001252,
        Key_Dead_Tilde          = 0x01001253,
        Key_Dead_Macron         = 0x01001254,
        Key_Dead_Breve          = 0x01001255,
        Key_Dead_Abovedot       = 0x01001256,
        Key_Dead_Diaeresis      = 0x01001257,
        Key_Dead_Abovering      = 0x01001258,
        Key_Dead_Doubleacute    = 0x01001259,
        Key_Dead_Caron          = 0x0100125a,
        Key_Dead_Cedilla        = 0x0100125b,
        Key_Dead_Ogonek         = 0x0100125c,
        Key_Dead_Iota           = 0x0100125d,
        Key_Dead_Voiced_Sound   = 0x0100125e,
        Key_Dead_Semivoiced_Sound = 0x0100125f,
        Key_Dead_Belowdot       = 0x01001260,
        Key_Dead_Hook           = 0x01001261,
        Key_Dead_Horn           = 0x01001262,
        Key_Dead_Stroke         = 0x01001263,
        Key_Dead_Abovecomma     = 0x01001264,
        Key_Dead_Abovereversedcomma = 0x01001265,
        Key_Dead_Doublegrave    = 0x01001266,
        Key_Dead_Belowring      = 0x01001267,
        Key_Dead_Belowmacron    = 0x01001268,
        Key_Dead_Belowcircumflex = 0x01001269,
        Key_Dead_Belowtilde     = 0x0100126a,
        Key_Dead_Belowbreve     = 0x0100126b,
        Key_Dead_Belowdiaeresis = 0x0100126c,
        Key_Dead_Invertedbreve  = 0x0100126d,
        Key_Dead_Belowcomma     = 0x0100126e,
        Key_Dead_Currency       = 0x0100126f,
        Key_Dead_a              = 0x01001280,
        Key_Dead_A              = 0x01001281,
        Key_Dead_e              = 0x01001282,
        Key_Dead_E              = 0x01001283,
        Key_Dead_i              = 0x01001284,
        Key_Dead_I              = 0x01001285,
        Key_Dead_o              = 0x01001286,
        Key_Dead_O              = 0x01001287,
        Key_Dead_u              = 0x01001288,
        Key_Dead_U              = 0x01001289,
        Key_Dead_Small_Schwa    = 0x0100128a,
        Key_Dead_Capital_Schwa  = 0x0100128b,
        Key_Dead_Greek          = 0x0100128c,
        Key_Dead_Lowline        = 0x01001290,
        Key_Dead_Aboveverticalline = 0x01001291,
        Key_Dead_Belowverticalline = 0x01001292,
        Key_Dead_Longsolidusoverlay = 0x01001293,
        // multimedia/internet keys - ignored by default - see QKeyEvent c'tor
        Key_Back  = 0x01000061,
        Key_Forward  = 0x01000062,
        Key_Stop  = 0x01000063,
        Key_Refresh  = 0x01000064,
        Key_VolumeDown = 0x01000070,
        Key_VolumeMute  = 0x01000071,
        Key_VolumeUp = 0x01000072,
        Key_BassBoost = 0x01000073,
        Key_BassUp = 0x01000074,
        Key_BassDown = 0x01000075,
        Key_TrebleUp = 0x01000076,
        Key_TrebleDown = 0x01000077,
        Key_MediaPlay  = 0x01000080,
        Key_MediaStop  = 0x01000081,
        Key_MediaPrevious  = 0x01000082,
        Key_MediaNext  = 0x01000083,
        Key_MediaRecord = 0x01000084,
        Key_MediaPause = 0x1000085,
        Key_MediaTogglePlayPause = 0x1000086,
        Key_HomePage  = 0x01000090,
        Key_Favorites  = 0x01000091,
        Key_Search  = 0x01000092,
        Key_Standby = 0x01000093,
        Key_OpenUrl = 0x01000094,
        Key_LaunchMail  = 0x010000a0,
        Key_LaunchMedia = 0x010000a1,
        Key_Launch0  = 0x010000a2,
        Key_Launch1  = 0x010000a3,
        Key_Launch2  = 0x010000a4,
        Key_Launch3  = 0x010000a5,
        Key_Launch4  = 0x010000a6,
        Key_Launch5  = 0x010000a7,
        Key_Launch6  = 0x010000a8,
        Key_Launch7  = 0x010000a9,
        Key_Launch8  = 0x010000aa,
        Key_Launch9  = 0x010000ab,
        Key_LaunchA  = 0x010000ac,
        Key_LaunchB  = 0x010000ad,
        Key_LaunchC  = 0x010000ae,
        Key_LaunchD  = 0x010000af,
        Key_LaunchE  = 0x010000b0,
        Key_LaunchF  = 0x010000b1,
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
        Key_AudioRewind = 0x010000c5, // Media rewind
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
        Key_Display = 0x010000d1, // Output switch key
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
        Key_AudioForward = 0x01000102, // Media fast-forward
        Key_AudioRepeat = 0x01000103, // Toggle repeat mode
        Key_AudioRandomPlay = 0x01000104, // Toggle shuffle mode
        Key_Subtitle = 0x01000105,
        Key_AudioCycleTrack = 0x01000106,
        Key_Time = 0x01000107,
        Key_Hibernate = 0x01000108,
        Key_View = 0x01000109,
        Key_TopMenu = 0x0100010a,
        Key_PowerDown = 0x0100010b,
        Key_Suspend = 0x0100010c,
        Key_ContrastAdjust = 0x0100010d,
        Key_LaunchG  = 0x0100010e,
        Key_LaunchH  = 0x0100010f,
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
        Key_Guide    = 0x0100011a,
        Key_Info     = 0x0100011b,
        Key_Settings = 0x0100011c,
        Key_MicVolumeUp   = 0x0100011d,
        Key_MicVolumeDown = 0x0100011e,
        Key_New      = 0x01000120,
        Key_Open     = 0x01000121,
        Key_Find     = 0x01000122,
        Key_Undo     = 0x01000123,
        Key_Redo     = 0x01000124,
        Key_MediaLast = 0x0100ffff,
        // Keypad navigation keys
        Key_Select = 0x01010000,
        Key_Yes = 0x01010001,
        Key_No = 0x01010002,
        // Newer misc keys
        Key_Cancel  = 0x01020001,
        Key_Printer = 0x01020002,
        Key_Execute = 0x01020003,
        Key_Sleep   = 0x01020004,
        Key_Play    = 0x01020005, // Not the same as Key_MediaPlay
        Key_Zoom    = 0x01020006,
        //Key_Jisho   = 0x01020007, // IME: Dictionary key
        //Key_Oyayubi_Left = 0x01020008, // IME: Left Oyayubi key
        //Key_Oyayubi_Right = 0x01020009, // IME: Right Oyayubi key
        Key_Exit    = 0x0102000a,
        // Device keys
        Key_Context1 = 0x01100000,
        Key_Context2 = 0x01100001,
        Key_Context3 = 0x01100002,
        Key_Context4 = 0x01100003,
        Key_Call = 0x01100004,      // set absolute state to in a call (do not toggle state)
        Key_Hangup = 0x01100005,    // set absolute state to hang up (do not toggle state)
        Key_Flip = 0x01100006,
        Key_ToggleCallHangup = 0x01100007, // a toggle key for answering, or hanging up, based on current call state
        Key_VoiceDial = 0x01100008,
        Key_LastNumberRedial = 0x01100009,
        Key_Camera = 0x01100020,
        Key_CameraFocus = 0x01100021,
        Key_unknown = 0x01ffffff
};


DK_Key asciiToKey(char ascii){
    switch ((unsigned char)ascii) {
    case 0x08: return Key_Backspace;
    case 0x09: return Key_Tab;
    case 0x0b: return Key_Backtab;
    case 0x0d: return Key_Return;
    case 0x1b: return Key_Escape;
    case 0x13: return Key_Up;
    case 0x15: return Key_Down;
    case 0x20: return Key_Space;
    case 0x21: return Key_Exclam;
    case 0x22: return Key_QuoteDbl;
    case 0x23: return Key_NumberSign;
    case 0x24: return Key_Dollar;
    case 0x25: return Key_Percent;
    case 0x26: return Key_Ampersand;
    case 0x27: return Key_Apostrophe;
    case 0x28: return Key_ParenLeft;
    case 0x29: return Key_ParenRight;
    case 0x2a: return Key_Asterisk;
    case 0x2b: return Key_Plus;
    case 0x2c: return Key_Comma;
    case 0x2d: return Key_Minus;
    case 0x2e: return Key_Period;
    case 0x2f: return Key_Slash;
    case 0x30: return Key_0;
    case 0x31: return Key_1;
    case 0x32: return Key_2;
    case 0x33: return Key_3;
    case 0x34: return Key_4;
    case 0x35: return Key_5;
    case 0x36: return Key_6;
    case 0x37: return Key_7;
    case 0x38: return Key_8;
    case 0x39: return Key_9;
    case 0x3a: return Key_Colon;
    case 0x3b: return Key_Semicolon;
    case 0x3c: return Key_Less;
    case 0x3d: return Key_Equal;
    case 0x3e: return Key_Greater;
    case 0x3f: return Key_Question;
    case 0x40: return Key_At;
    case 0x41: return Key_A;
    case 0x42: return Key_B;
    case 0x43: return Key_C;
    case 0x44: return Key_D;
    case 0x45: return Key_E;
    case 0x46: return Key_F;
    case 0x47: return Key_G;
    case 0x48: return Key_H;
    case 0x49: return Key_I;
    case 0x4a: return Key_J;
    case 0x4b: return Key_K;
    case 0x4c: return Key_L;
    case 0x4d: return Key_M;
    case 0x4e: return Key_N;
    case 0x4f: return Key_O;
    case 0x50: return Key_P;
    case 0x51: return Key_Q;
    case 0x52: return Key_R;
    case 0x53: return Key_S;
    case 0x54: return Key_T;
    case 0x55: return Key_U;
    case 0x56: return Key_V;
    case 0x57: return Key_W;
    case 0x58: return Key_X;
    case 0x59: return Key_Y;
    case 0x5a: return Key_Z;
    case 0x5b: return Key_BracketLeft;
    case 0x5c: return Key_Backslash;
    case 0x5d: return Key_BracketRight;
    case 0x5e: return Key_AsciiCircum;
    case 0x5f: return Key_Underscore;
    case 0x60: return Key_QuoteLeft;
    case 0x61: return Key_A;
    case 0x62: return Key_B;
    case 0x63: return Key_C;
    case 0x64: return Key_D;
    case 0x65: return Key_E;
    case 0x66: return Key_F;
    case 0x67: return Key_G;
    case 0x68: return Key_H;
    case 0x69: return Key_I;
    case 0x6a: return Key_J;
    case 0x6b: return Key_K;
    case 0x6c: return Key_L;
    case 0x6d: return Key_M;
    case 0x6e: return Key_N;
    case 0x6f: return Key_O;
    case 0x70: return Key_P;
    case 0x71: return Key_Q;
    case 0x72: return Key_R;
    case 0x73: return Key_S;
    case 0x74: return Key_T;
    case 0x75: return Key_U;
    case 0x76: return Key_V;
    case 0x77: return Key_W;
    case 0x78: return Key_X;
    case 0x79: return Key_Y;
    case 0x7a: return Key_Z;
    case 0x7b: return Key_BraceLeft;
    case 0x7c: return Key_Bar;
    case 0x7d: return Key_BraceRight;
    case 0x7e: return Key_AsciiTilde;
    // Latin 1 codes adapted from X: keysymdef.h,v 1.21 94/08/28 16:17:06
    case 0xa0: return Key_nobreakspace;
    case 0xa1: return Key_exclamdown;
    case 0xa2: return Key_cent;
    case 0xa3: return Key_sterling;
    case 0xa4: return Key_currency;
    case 0xa5: return Key_yen;
    case 0xa6: return Key_brokenbar;
    case 0xa7: return Key_section;
    case 0xa8: return Key_diaeresis;
    case 0xa9: return Key_copyright;
    case 0xaa: return Key_ordfeminine;
    case 0xab: return Key_guillemotleft;
    case 0xac: return Key_notsign;
    case 0xad: return Key_hyphen;
    case 0xae: return Key_registered;
    case 0xaf: return Key_macron;
    case 0xb0: return Key_degree;
    case 0xb1: return Key_plusminus;
    case 0xb2: return Key_twosuperior;
    case 0xb3: return Key_threesuperior;
    case 0xb4: return Key_acute;
    case 0xb5: return Key_mu;
    case 0xb6: return Key_paragraph;
    case 0xb7: return Key_periodcentered;
    case 0xb8: return Key_cedilla;
    case 0xb9: return Key_onesuperior;
    case 0xba: return Key_masculine;
    case 0xbb: return Key_guillemotright;
    case 0xbc: return Key_onequarter;
    case 0xbd: return Key_onehalf;
    case 0xbe: return Key_threequarters;
    case 0xbf: return Key_questiondown;
    case 0xc0: return Key_Agrave;
    case 0xc1: return Key_Aacute;
    case 0xc2: return Key_Acircumflex;
    case 0xc3: return Key_Atilde;
    case 0xc4: return Key_Adiaeresis;
    case 0xc5: return Key_Aring;
    case 0xc6: return Key_AE;
    case 0xc7: return Key_Ccedilla;
    case 0xc8: return Key_Egrave;
    case 0xc9: return Key_Eacute;
    case 0xca: return Key_Ecircumflex;
    case 0xcb: return Key_Ediaeresis;
    case 0xcc: return Key_Igrave;
    case 0xcd: return Key_Iacute;
    case 0xce: return Key_Icircumflex;
    case 0xcf: return Key_Idiaeresis;
    case 0xd0: return Key_ETH;
    case 0xd1: return Key_Ntilde;
    case 0xd2: return Key_Ograve;
    case 0xd3: return Key_Oacute;
    case 0xd4: return Key_Ocircumflex;
    case 0xd5: return Key_Otilde;
    case 0xd6: return Key_Odiaeresis;
    case 0xd7: return Key_multiply;
    case 0xd8: return Key_Ooblique;
    case 0xd9: return Key_Ugrave;
    case 0xda: return Key_Uacute;
    case 0xdb: return Key_Ucircumflex;
    case 0xdc: return Key_Udiaeresis;
    case 0xdd: return Key_Yacute;
    case 0xde: return Key_THORN;
    case 0xdf: return Key_ssharp;
    case 0xe5: return Key_Aring;
    case 0xe6: return Key_AE;
    case 0xf7: return Key_division;
    case 0xf8: return Key_Ooblique;
    case 0xff: return Key_ydiaeresis;
    default: 
		DKERROR("KEY(0)");
		return DK_Key(0);
    }
}

char keyToAscii(DK_Key key){
    switch (key) {
    case Key_Backspace: return 0x8; //BS
    case Key_Tab: return 0x09; // HT
    case Key_Backtab: return 0x0b; // VT
    case Key_Enter:
    case Key_Return: return 0x0d; // CR
    case Key_Escape: return 0x1b; // ESC
    case Key_Space: return 0x20;        // 7 bit printable ASCII
    case Key_Exclam: return 0x21;
    case Key_QuoteDbl: return 0x22;
    case Key_NumberSign: return 0x23;
    case Key_Dollar: return 0x24;
    case Key_Percent: return 0x25;
    case Key_Ampersand: return 0x26;
    case Key_Apostrophe: return 0x27;
    case Key_ParenLeft: return 0x28;
    case Key_ParenRight: return 0x29;
    case Key_Asterisk: return 0x2a;
    case Key_Plus: return 0x2b;
    case Key_Comma: return 0x2c;
    case Key_Minus: return 0x2d;
    case Key_Period: return 0x2e;
    case Key_Slash: return 0x2f;
    case Key_0: return 0x30;
    case Key_1: return 0x31;
    case Key_2: return 0x32;
    case Key_3: return 0x33;
    case Key_4: return 0x34;
    case Key_5: return 0x35;
    case Key_6: return 0x36;
    case Key_7: return 0x37;
    case Key_8: return 0x38;
    case Key_9: return 0x39;
    case Key_Colon: return 0x3a;
    case Key_Semicolon: return 0x3b;
    case Key_Less: return 0x3c;
    case Key_Equal: return 0x3d;
    case Key_Greater: return 0x3e;
    case Key_Question: return 0x3f;
    case Key_At: return 0x40;
    case Key_A: return 0x61; // 0x41 == 'A', 0x61 == 'a'
    case Key_B: return 0x62;
    case Key_C: return 0x63;
    case Key_D: return 0x64;
    case Key_E: return 0x65;
    case Key_F: return 0x66;
    case Key_G: return 0x67;
    case Key_H: return 0x68;
    case Key_I: return 0x69;
    case Key_J: return 0x6a;
    case Key_K: return 0x6b;
    case Key_L: return 0x6c;
    case Key_M: return 0x6d;
    case Key_N: return 0x6e;
    case Key_O: return 0x6f;
    case Key_P: return 0x70;
    case Key_Q: return 0x71;
    case Key_R: return 0x72;
    case Key_S: return 0x73;
    case Key_T: return 0x74;
    case Key_U: return 0x75;
    case Key_V: return 0x76;
    case Key_W: return 0x77;
    case Key_X: return 0x78;
    case Key_Y: return 0x79;
    case Key_Z: return 0x7a;
    case Key_BracketLeft: return 0x5b;
    case Key_Backslash: return 0x5c;
    case Key_BracketRight: return 0x5d;
    case Key_AsciiCircum: return 0x5e;
    case Key_Underscore: return 0x5f;
    case Key_QuoteLeft: return 0x60;
    case Key_BraceLeft: return 0x7b;
    case Key_Bar: return 0x7c;
    case Key_BraceRight: return 0x7d;
    case Key_AsciiTilde: return 0x7e;
    case Key_Delete: return 0;
    case Key_Insert: return 0; // = 0x1006,
    case Key_Pause: return 0; // = 0x1008,
    case Key_Print: return 0; // = 0x1009,
    case Key_SysReq: return 0; // = 0x100a,
    case Key_Clear: return 0; // = 0x100b,
    case Key_Home: return 0; // = 0x1010,        // cursor movement
    case Key_End: return 0; // = 0x1011,
    case Key_Left: return 0; // = 0x1012,
    case Key_Up: return 0; // = 0x1013,
    case Key_Right: return 0; // = 0x1014,
    case Key_Down: return 0; // = 0x1015,
    case Key_PageUp: return 0; // = 0x1016,
    case Key_PageDown: return 0; // = 0x1017,
    case Key_Shift: return 0; // = 0x1020,        // modifiers
    case Key_Control: return 0; // = 0x1021,
    case Key_Meta: return 0; // = 0x1022,
    case Key_Alt: return 0; // = 0x1023,
    case Key_CapsLock: return 0; // = 0x1024,
    case Key_NumLock: return 0; // = 0x1025,
    case Key_ScrollLock: return 0; // = 0x1026,
    case Key_F1: return 0; // = 0x1030,        // function keys
    case Key_F2: return 0; // = 0x1031,
    case Key_F3: return 0; // = 0x1032,
    case Key_F4: return 0; // = 0x1033,
    case Key_F5: return 0; // = 0x1034,
    case Key_F6: return 0; // = 0x1035,
    case Key_F7: return 0; // = 0x1036,
    case Key_F8: return 0; // = 0x1037,
    case Key_F9: return 0; // = 0x1038,
    case Key_F10: return 0; // = 0x1039,
    case Key_F11: return 0; // = 0x103a,
    case Key_F12: return 0; // = 0x103b,
    case Key_F13: return 0; // = 0x103c,
    case Key_F14: return 0; // = 0x103d,
    case Key_F15: return 0; // = 0x103e,
    case Key_F16: return 0; // = 0x103f,
    case Key_F17: return 0; // = 0x1040,
    case Key_F18: return 0; // = 0x1041,
    case Key_F19: return 0; // = 0x1042,
    case Key_F20: return 0; // = 0x1043,
    case Key_F21: return 0; // = 0x1044,
    case Key_F22: return 0; // = 0x1045,
    case Key_F23: return 0; // = 0x1046,
    case Key_F24: return 0; // = 0x1047,
    case Key_F25: return 0; // = 0x1048,        // F25 .. F35 only on X11
    case Key_F26: return 0; // = 0x1049,
    case Key_F27: return 0; // = 0x104a,
    case Key_F28: return 0; // = 0x104b,
    case Key_F29: return 0; // = 0x104c,
    case Key_F30: return 0; // = 0x104d,
    case Key_F31: return 0; // = 0x104e,
    case Key_F32: return 0; // = 0x104f,
    case Key_F33: return 0; // = 0x1050,
    case Key_F34: return 0; // = 0x1051,
    case Key_F35: return 0; // = 0x1052,
    case Key_Super_L: return 0; // = 0x1053,        // extra keys
    case Key_Super_R: return 0; // = 0x1054,
    case Key_Menu: return 0; // = 0x1055,
    case Key_Hyper_L: return 0; // = 0x1056,
    case Key_Hyper_R: return 0; // = 0x1057,
    case Key_Help: return 0; // = 0x1058,
    case Key_Direction_L: return 0; // = 0x1059,
    case Key_Direction_R: return 0; // = 0x1060,
    // Latin 1 codes adapted from X: keysymdef.h,v 1.21 94/08/28 16:17:06
    case Key_nobreakspace: return char(0xa0);
    case Key_exclamdown: return char(0xa1);
    case Key_cent: return char(0xa2);
    case Key_sterling: return char(0xa3);
    case Key_currency: return char(0xa4);
    case Key_yen: return char(0xa5);
    case Key_brokenbar: return char(0xa6);
    case Key_section: return char(0xa7);
    case Key_diaeresis: return char(0xa8);
    case Key_copyright: return char(0xa9);
    case Key_ordfeminine: return char(0xaa);
    case Key_guillemotleft: return char(0xab); // left angle quotation mar
    case Key_notsign: return char(0xac);
    case Key_hyphen: return char(0xad);
    case Key_registered: return char(0xae);
    case Key_macron: return char(0xaf);
    case Key_degree: return char(0xb0);
    case Key_plusminus: return char(0xb1);
    case Key_twosuperior: return char(0xb2);
    case Key_threesuperior: return char(0xb3);
    case Key_acute: return char(0xb4);
    case Key_mu: return char(0xb5);
    case Key_paragraph: return char(0xb6);
    case Key_periodcentered: return char(0xb7);
    case Key_cedilla: return char(0xb8);
    case Key_onesuperior: return char(0xb9);
    case Key_masculine: return char(0xba);
    case Key_guillemotright: return char(0xbb); // right angle quotation mar
    case Key_onequarter: return char(0xbc);
    case Key_onehalf: return char(0xbd);
    case Key_threequarters: return char(0xbe);
    case Key_questiondown: return char(0xbf);
    case Key_Agrave: return char(0xc0);
    case Key_Aacute: return char(0xc1);
    case Key_Acircumflex: return char(0xc2);
    case Key_Atilde: return char(0xc3);
    case Key_Adiaeresis: return char(0xc4);
    case Key_Aring: return char(0xe5);
    case Key_AE: return char(0xe6);
    case Key_Ccedilla: return char(0xc7);
    case Key_Egrave: return char(0xc8);
    case Key_Eacute: return char(0xc9);
    case Key_Ecircumflex: return char(0xca);
    case Key_Ediaeresis: return char(0xcb);
    case Key_Igrave: return char(0xcc);
    case Key_Iacute: return char(0xcd);
    case Key_Icircumflex: return char(0xce);
    case Key_Idiaeresis: return char(0xcf);
    case Key_ETH: return char(0xd0);
    case Key_Ntilde: return char(0xd1);
    case Key_Ograve: return char(0xd2);
    case Key_Oacute: return char(0xd3);
    case Key_Ocircumflex: return char(0xd4);
    case Key_Otilde: return char(0xd5);
    case Key_Odiaeresis: return char(0xd6);
    case Key_multiply: return char(0xd7);
    case Key_Ooblique: return char(0xf8);
    case Key_Ugrave: return char(0xd9);
    case Key_Uacute: return char(0xda);
    case Key_Ucircumflex: return char(0xdb);
    case Key_Udiaeresis: return char(0xdc);
    case Key_Yacute: return char(0xdd);
    case Key_THORN: return char(0xde);
    case Key_ssharp: return char(0xdf);
    case Key_division: return char(0xf7);
    case Key_ydiaeresis: return char(0xff);
    // multimedia/internet keys - ignored by default - see QKeyEvent c'tor
    case Key_Back : return 0; // = 0x1061,
    case Key_Forward : return 0; // = 0x1062,
    case Key_Stop : return 0; // = 0x1063,
    case Key_Refresh : return 0; // = 0x1064,
    case Key_VolumeDown: return 0; // = 0x1070,
    case Key_VolumeMute : return 0; // = 0x1071,
    case Key_VolumeUp: return 0; // = 0x1072,
    case Key_BassBoost: return 0; // = 0x1073,
    case Key_BassUp: return 0; // = 0x1074,
    case Key_BassDown: return 0; // = 0x1075,
    case Key_TrebleUp: return 0; // = 0x1076,
    case Key_TrebleDown: return 0; // = 0x1077,
    case Key_MediaPlay : return 0; // = 0x1080,
    case Key_MediaStop : return 0; // = 0x1081,
    case Key_MediaPrevious : return 0; // = 0x1082,
    case Key_MediaNext : return 0; // = 0x1083,
    case Key_MediaRecord: return 0; // = 0x1084,
    case Key_HomePage : return 0; // = 0x1090,
    case Key_Favorites : return 0; // = 0x1091,
    case Key_Search : return 0; // = 0x1092,
    case Key_Standby: return 0; // = 0x1093,
    case Key_OpenUrl: return 0; // = 0x1094,
    case Key_LaunchMail : return 0; // = 0x10a0,
    case Key_LaunchMedia: return 0; // = 0x10a1,
    case Key_Launch0 : return 0; // = 0x10a2,
    case Key_Launch1 : return 0; // = 0x10a3,
    case Key_Launch2 : return 0; // = 0x10a4,
    case Key_Launch3 : return 0; // = 0x10a5,
    case Key_Launch4 : return 0; // = 0x10a6,
    case Key_Launch5 : return 0; // = 0x10a7,
    case Key_Launch6 : return 0; // = 0x10a8,
    case Key_Launch7 : return 0; // = 0x10a9,
    case Key_Launch8 : return 0; // = 0x10aa,
    case Key_Launch9 : return 0; // = 0x10ab,
    case Key_LaunchA : return 0; // = 0x10ac,
    case Key_LaunchB : return 0; // = 0x10ad,
    case Key_LaunchC : return 0; // = 0x10ae,
    case Key_LaunchD : return 0; // = 0x10af,
    case Key_LaunchE : return 0; // = 0x10b0,
    case Key_LaunchF : return 0; // = 0x10b1,
    default: 
		DKERROR("ERROR");
		return 0;
    }
}

#endif