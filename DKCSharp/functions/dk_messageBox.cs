using System;
using System.Runtime.InteropServices;

public class APP {
        	
	[DllImport("user32.dll", CharSet = CharSet.Auto)]
	public static extern int MessageBox(IntPtr hWnd, String text, String caption, uint type);

		
	//############################################################################
	//# dk_messageBox(message)
	//#
	public static int dk_messageBox(string message){
		MessageBox(IntPtr.Zero, message, "My Message Box", 0);
		return 0;
	}
		
		
	//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	public static void DKTEST(){
		dk_messageBox("DKTEST() dk_messageBox()");
	}
}
