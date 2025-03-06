if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_messageBox){ $dk_messageBox = 1 } else{ return } #include guard

##################################################################################
# dk_messageBox(text, caption, buttons, icon, defaultButton, options)
#
#
function Global:dk_messageBox() {
	dk_debugFunc 0

	${text} = $args[0];
	${caption} = $args[1];
	${flags} = $args[2];
	${timeout} = $args[3];
	Add-Type -AssemblyName PresentationCore,PresentationFramework;
	[System.Windows.MessageBox]::Show(${text}, ${caption}, ${flags})
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0

###### MessageBoxButtons ######	
#	OK					0		The message box contains an OK button.
#	OKCancel			1		The message box contains OK and Cancel buttons.
#	AbortRetryIgnore	2		The message box contains Abort, Retry, and Ignore buttons.
#	YesNoCancel			3		The message box contains Yes, No, and Cancel buttons.
#	YesNo				4		The message box contains Yes and No buttons.
#	RetryCancel			5		The message box contains Retry and Cancel buttons.
#	CancelTryContinue	6		Specifies that the message box contains Cancel, Try Again, and Continue buttons.
###### MessageBoxIcon ######	
#	None				0		The message box contains no symbols.
#	Error				16		The message box contains a symbol consisting of white X in a circle with a red background.
#	Question			32		The message box contains a symbol consisting of a question mark in a circle.
#	Warning				48		The message box contains a symbol consisting of an exclamation point in a triangle with a yellow background.
#	Information			64		The message box contains a symbol consisting of a lowercase letter i in a circle.
###### MessageBoxDefaultButton ######
#	Button1				0		The first button on the message box is the default button.
#	Button2				256		The second button on the message box is the default button.
#	Button3				512		The third button on the message box is the default button.
#	Button4				768		Specifies that the Help button on the message box should be the default button.
###### MessageBoxOptions ######
#	DefaultDesktopOnly	131072	The message box is displayed on the active desktop.
#	RightAlign			524288	The message box text is right-aligned.
#	RtlReading			1048576	Specifies that the message box text is displayed with right to left reading order.
#	ServiceNotification	2097152	The message box is displayed on the active desktop. The caller is a service notifying the user of an event. 

	dk_call dk_messageBox 'dk_messageBox test message' 'dk_messageBox Title' 3 64 0 524288
}