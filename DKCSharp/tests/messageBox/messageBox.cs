[System.Runtime.InteropServices.DllImport("user32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto)]
static extern int MessageBox(System.IntPtr hWnd, System.String text, System.String caption, int options);
public static void messageBox() {
    MessageBox(System.IntPtr.Zero, "Hello World", "Example", 0);
}