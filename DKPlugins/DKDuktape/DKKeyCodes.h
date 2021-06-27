#pragma once
#ifndef DKKeyCodes_H
#define DKKeyCodes_H
#include "DKDuktape/DKDuktape.h"
#include <iostream>
#include <map>
#include <string>
#include <iterator>

// Read
// https://keycode.info/
// https://www.w3.org/TR/uievents-code/
// https://chromium.googlesource.com/chromium/src/+/lkgr/ui/events/keycodes


////////////
//#ifdef WIN32
// Windows Keyboard mapping table
// https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
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
    KEY_ENTER,               //  13   0x0D   VK_RETURN           | Enter key
    //KEY_UNASSIGNED,        //  14   0x0E   -- UNASSIGNED --
    //KEY_UNASSIGNED,        //  15   0x0F   -- UNASSIGNED --
    KEY_SHIFT = 16,          //  16   0x10   VK_SHIFT            | Shift key
    KEY_CONTROL,             //  17   0x11   VK_CONTROL          | Ctrl key
    KEY_ALT,                 //  18   0x12   VK_MENU             | Alt key
    KEY_PAUSE,               //  19   0x13   VK_PAUSE            | Pause key
    KEY_CAPSLOCK,            //  20   0x14   VK_CAPITAL          | Caps-Lock
    KEY_KANA = 21,           //  21   0x15   VK_KANA / VK_HANGUL | IME Kana or Hangul mode
    KEY_HANGUL = 21,         //  21   0x15   VK_KANA / VK_HANGUL | IME Kana or Hangul mode
    //KEY_UNASSIGNED,        //  22   0x16   -- UNASSIGNED --
    KEY_JUNJA = 23,          //  23   0x17   VK_JUNJA            | IME Junja mode
    KEY_FINAL,               //  24   0x18   VK_FINAL            | IME final mode
    KEY_HANJA = 25,          //  25   0x19   VK_HANJA / VK_KANJI | IME Hanja or Kanji mode
    KEY_KANJI = 25,          //  25   0x19   VK_HANJA / VK_KANJI | IME Hanja or Kanji mode
    //KEY_UNASSIGNED,        //  26   0x1A   -- UNASSIGNED --
    KEY_ESCAPE = 27,         //  27   0x1B   VK_ESCAPE           | Esc key
    KEY_CONVERT,             //  28   0x1C   VK_CONVERT          | IME convert
    KEY_NONCONVERT,          //  29   0x1D   VK_NONCONVERT       | IME non-convert
    KEY_ACCEPT,              //  30   0x1E   VK_ACCEPT           | IME accept
    KEY_MODECHANGE,          //  31   0x1F   VK_MODECHANGE       | IME mode change request
    KEY_SPACE,               //  32   0x20   VK_SPACE            | Spacebar
    KEY_PAGEUP,              //  33   0x21   VK_PRIOR            | Page Up key
    KEY_PAGEDOWN,            //  34   0x22   VK_NEXT             | Page Down key
    KEY_END,                 //  35   0x23   VK_END              | End key
    KEY_HOME,                //  36   0x24   VK_HOME             | Home key
    KEY_LEFT,                //  37   0x25   VK_LEFT             | Left arrow key
    KEY_UP,                  //  38   0x26   VK_UP               | Up arrow key
    KEY_RIGHT,               //  39   0x27   VK_RIGHT            | Right arrow key
    KEY_DOWN,                //  40   0x28   VK_DOWN             | Down arrow key
    KEY_SELECT,              //  41   0x29   VK_SELECT           | Select key
    KEY_PRINT,               //  42   0x2A   VK_PRINT            | Print key
    KEY_EXECUTE_,            //  43   0x2B   VK_EXECUTE          | Execute key
    KEY_PRINTSCREEN,         //  44   0x2C   VK_SNAPSHOT         | Print Screen key
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
    KEY_METALEFT,            //  91   0x5B   VK_LWIN             | Left Windows  - MS Natural kbd
    KEY_METARIGHT,           //  92   0x5C   VK_RWIN             | Right Windows - MS Natural kbd
    KEY_CONTEXTMENU,         //  93   0x5D   VK_APPS             | Application key-MS Natural kbd
    //KEY_RESERVED,          //  94   0x5E   -- RESERVED --
    KEY_STANDBY = 95,        //  95   0x5F   VK_SLEEP
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
    KEY_SCROLLLOCK,          // 145   0x91   VK_SCROLL           | Scroll Lock key
                             // Fujitsu/OASYS kbd --------------------
    KEY_OEM_FJ_JISHO,        // 146   0x92   VK_OEM_FJ_JISHO     | 'Dictionary' key /
                             //              VK_OEM_NEC_EQUAL    | key on numpad on NEC PC-9800 kbd
    KEY_OEM_FJ_MASSHOU,      // 147   0x93   VK_OEM_FJ_MASSHOU   | 'Unregister word' key
    KEY_OEM_FJ_TOUROKU,      // 148   0x94   VK_OEM_FJ_TOUROKU   | 'Register word' key
    KEY_OEM_FJ_LOYA,         // 149   0x95   VK_OEM_FJ_LOYA      | 'Left OYAYUBI' key
    KEY_OEM_FJ_ROYA,         // 150   0x96   VK_OEM_FJ_ROYA      | 'Right OYAYUBI' key
    //KEY_UNASSIGNED,        // 151   0x97   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 152   0x98   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 153   0x99   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 154   0x9A   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 155   0x9B   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 156   0x9C   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 157   0x9D   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 157   0x9D   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 158   0x9E   -- UNASSIGNED --
    //KEY_UNASSIGNED,        // 159   0x9F   -- UNASSIGNED --
    KEY_SHIFTLEFT = 160,     // 160   0xA0   VK_LSHIFT              | Left Shift key
    KEY_SHIFTRIGHT,          // 161   0xA1   VK_RSHIFT              | Right Shift key
    KEY_CONTROLLEFT,         // 162   0xA2   VK_LCONTROL            | Left Ctrl key
    KEY_CONTROLRIGHT,        // 163   0xA3   VK_RCONTROL            | Right Ctrl key
    KEY_ALTLEFT,             // 164   0xA4   VK_LMENU               | Left Menu key
    KEY_ALTRIGHT,            // 165   0xA5   VK_RMENU               | Right Menu key
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
    KEY_PROCESS,             // 229   0xE5   VK_PROCESSKEY       | IME Process key
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
//#endif  //WIN32


/*
//////////
#ifdef MAC
// Mac Keyboard mapping table
enum Key {
                           // Dec | Hex |  Mac Virtual key
    KEY_UNASSIGNED         //   0   0x00   -- UNASSIGNED --
    //TODO
}
#endif //MAC


////////////
#ifdef LINUX
// Linux Keyboard mapping table
enum Key {
    // Dec | Hex |  Linux Virtual key
    KEY_UNASSIGNED         //   0   0x00   -- UNASSIGNED --
    //TODO
}
#endif //LINUX
*/

// Reference
// https://dreamswork.github.io/qt4/qkeymapper__mac_8cpp_source.html
// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode 
// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values
// https://www.w3.org/TR/uievents-key/
// https://code.woboq.org/qt5/qtbase/src/corelib/global/qnamespace.h.html
// https://code.woboq.org/qt5/qtbase/src/plugins/platforms/windows/qwindowskeymapper.cpp.html

class DKKeyCodes
{
public:
    template< typename T >
    static std::string int_to_hex(T i) {
        std::stringstream stream;
        stream << "0x" << std::setfill('0') << std::setw(sizeof(T) * 2) << std::hex << i;
        return stream.str();
    };

    static void mapKeys();
    static void mapKey(Key name, DKString code, DKString key, int location = 0);

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
};

#endif //DKKeyCodes_H