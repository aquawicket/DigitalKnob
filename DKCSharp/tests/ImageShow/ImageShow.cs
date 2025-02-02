// https://stackoverflow.com/a/33652557/688352
// https://github.com/TashreefMuhammad/Drowsiness_Detector/blob/master/ImageShow.cs
// https://github.com/Solaire/GLC/blob/master/GameLauncher_Console/GameLauncher_Console/ConsoleImage.cs

using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.IO;
using System.Threading;

namespace DKConsole
{
    //Image Show Class To Show it in Console
    class ImageShow
    {
        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr GetConsoleWindow();

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr CreateFile(
            string lpFileName,
            int dwDesiredAccess,
            int dwShareMode,
            IntPtr lpSecurityAttributes,
            int dwCreationDisposition,
            int dwFlagsAndAttributes,
            IntPtr hTemplateFile);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool GetCurrentConsoleFont(
            IntPtr hConsoleOutput,
            bool bMaximumWindow,
            [Out][MarshalAs(UnmanagedType.LPStruct)] ConsoleFontInfo lpConsoleCurrentFont);

        [StructLayout(LayoutKind.Sequential)]
        internal class ConsoleFontInfo
        {
            internal int nFont;
            internal Coord dwFontSize;
        }

        [StructLayout(LayoutKind.Explicit)]
        internal struct Coord
        {
            [FieldOffset(0)]
            internal short X;
            [FieldOffset(2)]
            internal short Y;
        }

        private const int GENERIC_READ = unchecked((int)0x80000000);
        private const int GENERIC_WRITE = 0x40000000;
        private const int FILE_SHARE_READ = 1;
        private const int FILE_SHARE_WRITE = 2;
        private const int INVALID_HANDLE_VALUE = -1;
        private const int OPEN_EXISTING = 3;

        
        //Method Of Image Showing
        public void view_image()
        {
            string name = Environment.CurrentDirectory;

            int i = 0;

            System.Drawing.Point location = new System.Drawing.Point(5, 5);
            System.Drawing.Size imageSize = new System.Drawing.Size(20, 10); // desired image size in characters
                                                                             // draw some placeholders
            Console.SetCursorPosition(location.X - 1, location.Y);
            Console.Write(">");
            Console.SetCursorPosition(location.X + imageSize.Width, location.Y);
            Console.Write("<");
            Console.SetCursorPosition(location.X - 1, location.Y + imageSize.Height - 1);
            Console.Write(">");
            Console.SetCursorPosition(location.X + imageSize.Width, location.Y + imageSize.Height - 1);
            Console.WriteLine("<");

            
            while (true)
            {
                try
                {
                    i %= 100;
                    using (Graphics g = Graphics.FromHwnd(GetConsoleWindow()))
                    {
                        //using (Image image = Image.FromFile(name + @"\detectedImage\marked" + i + ".png"))
						using (Image image = Image.FromFile(name + @"\icon.png"))
                        {
                            System.Drawing.Size fontSize = GetConsoleFontSize();

                            // translating the character positions to pixels
                            System.Drawing.Rectangle imageRect = new System.Drawing.Rectangle(
                                location.X * fontSize.Width,
                                location.Y * fontSize.Height,
                                imageSize.Width * fontSize.Width,
                                imageSize.Height * fontSize.Height);
                            g.DrawImage(image, imageRect);
                        }
                    }
                    ++i;
                }
                catch (Exception e)
                {
                    Thread t = Thread.CurrentThread;
                    Thread.Sleep(1300);
                    
                }
            }
        }
       private static System.Drawing.Size GetConsoleFontSize()
        {
            // getting the console out buffer handle
            IntPtr outHandle = CreateFile("CONOUT$", GENERIC_READ | GENERIC_WRITE,
                FILE_SHARE_READ | FILE_SHARE_WRITE,
                IntPtr.Zero,
                OPEN_EXISTING,
                0,
                IntPtr.Zero);
            int errorCode = Marshal.GetLastWin32Error();
            if (outHandle.ToInt32() == INVALID_HANDLE_VALUE)
            {
                throw new IOException("Unable to open CONOUT$", errorCode);
            }

            ConsoleFontInfo cfi = new ConsoleFontInfo();
            if (!GetCurrentConsoleFont(outHandle, false, cfi))
            {
                throw new InvalidOperationException("Unable to get font information.");
            }
            return new System.Drawing.Size(cfi.dwFontSize.X, cfi.dwFontSize.Y);
        }
		
		public static void Main(String[] args)
		{
			Console.WriteLine("Image printed to console example");
			
			ImageShow imageShow = new ImageShow();
			imageShow.view_image();
		}
    }
	
	
}
