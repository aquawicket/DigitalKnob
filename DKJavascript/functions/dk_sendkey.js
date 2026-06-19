

//################################################################################
//# dk_sendkey()
//#	
//#		~ 				{~} 				Send a tilde (~)
//#		! 				{!} 				Send an exclamation point (!)
//#		^ 				{^} 				Send a caret (^)
//#		+ 				{+} 				Send a plus sign (+)
//#		Backspace 		{BACKSPACE} or {BKSP} or {BS} 	Send a Backspace keystroke
//#		Break 			{BREAK} 			Send a Break keystroke
//#		Caps Lock 		{CAPSLOCK} 			Press the Caps Lock Key (toggle on or off)
//#		Clear 			{CLEAR} 			Clear the field
//#		Delete 			{DELETE} or {DEL} 	Send a Delete keystroke
//#		Insert 			{INSERT} or {INS} 	Send an Insert keystroke
//#		Arrows 			{LEFT} / {RIGHT} / {UP} / {DOWN} 	Send a Left/Right/Up/Down Arrow
//#		End 			{END} 				Send an End keystroke
//#		Enter 			{ENTER} or ~ 		Send an Enter keystroke
//#		Escape 			{ESCAPE} 			Send an Esc keystroke
//#		F1 thru F16 	{F1} 				through {F16} 	Send a Function keystroke
//#		Help 			{HELP} 				Send a Help keystroke
//#		Home 			{HOME} 				Send a Home keystroke
//#		Numlock 		{NUMLOCK} 			Send a Num Lock keystroke
//#		Page Down		{PGDN}
//#		Page Up 		{PGUP} 				Send a Page Down or Page Up keystroke
//#		Print Screen	{PRTSC} 			Send a Print Screen keystroke
//#		Scroll lock 	{SCROLLLOCK} 		Press the Scroll lock Key (toggle on or off)
//#		TAB 			{TAB} 				Send a TAB keystroke
//#
dk_sendkey = function dk_sendkey_f(win_name, keys){
	//dk_debugFunc(0, 99);
	
	var WScript_Shell = new ActiveXObject("WScript.Shell");
	WScript_Shell.Exec("cmd /c title batchfs");
	WScript.Sleep(100);
	WScript_Shell.AppActivate(win_name);
	WScript_Shell.SendKeys(keys);
	
	/*
	WScript_Shell.Exec("cmd /c (title batchfs) ^& mshta.exe \"javascript:var WshShell = new ActiveXObject('WScript.Shell');WshShell.AppActivate('batchfs');WshShell.SendKeys('{F11}');close();\"");
	*/
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_sendkey('notepad.exe','Triad2393{!}{!}{ENTER}');
}