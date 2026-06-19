if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1 } else { . '${PSScriptRoot}/DK.ps1' }
if(!$dk_mouseEvent_ps1){ $dk_mouseEvent_ps1 = 1; } else{ return; } #include guard



################################################################################
# dk_mouseEvent(dwFlags, dx, dy, cButtons, dwExtraInfo)
#
#	https://stackoverflow.com/a/44838831/688352
#	https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-mouse_event
#
#	dwFlags - Controls various aspects of mouse motion AND button clicking. This parameter can be certain combinations of the following values.
#
#	MOUSEEVENTF_ABSOLUTE	0x8000		The dx AND dy parameters contain normalized absolute coordinates. If NOT set, those parameters contain relative data: 
#										the change in position since the last reported position. This flag can be set, or NOT set.
#	MOUSEEVENTF_LEFTDOWN	0x0002		The left button is down.
#	MOUSEEVENTF_LEFTUP		0x0004		The left button is up.
#	MOUSEEVENTF_MIDDLEDOWN	0x0020		The middle button is down.
#	MOUSEEVENTF_MIDDLEUP	0x0040		The middle button is up.
#	MOUSEEVENTF_MOVE		0x0001		Movement occurred.
#	MOUSEEVENTF_RIGHTDOWN	0x0008		The right button is down.
#	MOUSEEVENTF_RIGHTUP		0x0010		The right button is up.
#	MOUSEEVENTF_WHEEL		0x0800		The wheel has been moved, if the mouse has a wheel. The amount of movement is specified in dwData
#	MOUSEEVENTF_XDOWN		0x0080		An X button was pressed.
#	MOUSEEVENTF_XUP			0x0100		An X button was released.
#	MOUSEEVENTF_WHEEL		0x0800		The wheel button is rotated.
#	MOUSEEVENTF_HWHEEL		0x01000		The wheel button is tilted.
#
function Global:dk_mouseEvent() {
	#dk_debugFunc 0 99
	
	$dwFlags=$($args[0]);
	$dx=$($args[0]);
	$dy=$($args[0]);
	$cButtons=$($args[0]);
	$dwExtraInfo=$($args[0]);
	
	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing");
	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms");
	
$signature=@'
[DllImport("user32.dll",CharSet=CharSet.Auto,CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
	
	# $x = 20
	# $y = 835
	# [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)

	$SendMouseEvent = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru
	$SendMouseEvent::mouse_event($dwFlags, $dx, $dy, $cButtons, $dwExtraInfo);
}










################################################################################
function Global:DKTEST() {
	#dk_debugFunc 0 99

	dk_mouseEvent 0x00000002 0 0 0 0;
	dk_mouseEvent 0x00000004 0 0 0 0;
}