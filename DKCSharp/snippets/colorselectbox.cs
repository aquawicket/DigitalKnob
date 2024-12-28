using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;


namespace RobvanderWoude
{
	class ColorSelectBox
	{
		#region Global Variables

		static string progver = "1.00";
		static string defaultcaption = "Pick a Console Color";
		static string caption = defaultcaption;
		static bool usergb = false;
		public static Form colordialog;
		public static int selectedcolor = -1;
		// Available standard console colors;
		// do NOT change the order of these values,
		// even if it seems illogical at index 7 and 8
		static int[] consolecolors = new int[] {
				0x000000, // 0 Black
				0x000080, // 1 DarkBlue
				0x008000, // 2 DarkGreen
				0x008080, // 3 DarkCyan
				0x800000, // 4 DarkRed
				0x800080, // 5 DarkMagenta
				0x808000, // 6 DarkYellow
				0xC0C0C0, // 7 Gray
				0x808080, // 8 DarkGray
				0x0000FF, // 9 Blue
				0x00FF00, // A Green
				0x00FFFF, // B Cyan
				0xFF0000, // C Red
				0xFF00FF, // D Magenta
				0xFFFF00, // E Yellow
				0xFFFFFF  // F White
		};

		#endregion Global Variables


		static int Main( string[] args )
		{
			#region Command Line Parsing

			if ( args.Length == 1 && args[0] == "/?" )
			{
				return ShowHelp( );
			}
			foreach(string arg in args )
			{
				if ( arg[0] == '/' )
				{
					switch ( arg.ToUpper( )[1] )
					{
						case 'R':
							if ( usergb )
							{
								return ShowHelp( "Duplicate command line switch /R" );
							}
							usergb = true;
							break;
						case 'T':
							TestColors( );
							return -1;
						case '?':
							return ShowHelp( );
						default:
							return ShowHelp( "Invalid command line switch {0}", arg );
					}
				}
				else
				{
					if ( caption != defaultcaption )
					{
						return ShowHelp( "Duplicate command line argument" );
					}
					caption = args[0];
				}
			}

			#endregion Command Line Parsing


			// Define dialog window
			colordialog = new Form( );
			colordialog.Size = new Size( 230, 110 );
			colordialog.SizeGripStyle = SizeGripStyle.Hide;
			colordialog.Text = caption;
			//colordialog.MinimumSize = new Size( colordialog.Width, colordialog.Height );
			//colordialog.MaximumSize = new Size( colordialog.Width, colordialog.Height );
			colordialog.MinimizeBox = false;
			colordialog.MaximizeBox = false;
			int[] cols = new int[8];
			int[] rows = new int[2];
			// Fill dialog with color boxes
			for ( int col = 0; col < cols.Length; col++ )
			{
				for ( int row = 0; row < rows.Length; row++ )
				{
					TextBox colorbox = new TextBox( );
					colorbox.Size = new Size( 20, 20 );
					colorbox.Location = new Point( 10 + col * 25, 10 + row * 30 );
					int[] rgb = Color2RGB( consolecolors[8 * row + col] );
					colorbox.BackColor = Color.FromArgb( rgb[0], rgb[1], rgb[2] );
					colorbox.Click += Colorbox_Click;
					colordialog.Controls.Add( colorbox );
				}
			}
			// Make sure the cursor won't be visible in one of the color boxes
			colordialog.Select( );
			// Show the dialog window
			colordialog.ShowDialog( );
			return selectedcolor;
		}


		static int[] Color2RGB( int color )
		{
			int red = Convert.ToInt32( Math.Floor( ( (decimal) color ) / 65536 ) );
			int green = Convert.ToInt32( Math.Floor( ( ( (decimal) color ) - red * 65536 ) / 256 ) );
			int blue = color - red * 65536 - green * 256;
			return new int[3] { red, green, blue };
		}


		private static void Colorbox_Click( object sender, EventArgs e )
		{
			foreach ( Control colorbox in colordialog.Controls )
			{
				if ( colorbox.GetType( ) == typeof( TextBox ) )
				{
					// If the box has focus, it is the one that was clicked
					if ( colorbox.Focused )
					{
						selectedcolor = ( colorbox.BackColor.R * 256 + colorbox.BackColor.G ) * 256 + colorbox.BackColor.B;
						if ( usergb )
						{
							// Return RGB value of the selected color, e.g. 255,0,0 for bright red
							Console.Write( "{0},{1},{2}", colorbox.BackColor.R, colorbox.BackColor.G, colorbox.BackColor.B );
						}
						else
						{
							// Return the "index" of the selected color, e.g. 12 decimal / C hexadecimal for bright red
							selectedcolor = consolecolors.ToList<int>( ).IndexOf( selectedcolor );
							Console.Write( "{0:X}", selectedcolor );
						}
						colordialog.Close( );
						return;
					}
				}
			}
		}


		public static void TestColors( )
		{
			int width = Console.WindowWidth * 2;
			string text;
			for ( int i = 0; i < 16; i++ )
			{
				Console.BackgroundColor = (ConsoleColor) i;
				Console.ForegroundColor = ConsoleColor.White;
				int[] rgb = Color2RGB( consolecolors[i] );
				text = String.Format( "{0,-21} Index = {1,2} (0x{1:X})           RGB = {2,11} (0x{3:X6})", ( (ConsoleColor) i ).ToString( ), i, String.Join( ",", rgb ), consolecolors[i] );
				if ( i > 9 )
				{
					Console.ForegroundColor = ConsoleColor.Black;
				}
				Console.Write( "{0,-" + width + "}", text );
				Console.ResetColor( );
			}
		}


		public static int ShowHelp( params string[] errmsg )
		{
			/*
			ColorSelectBox,  Version 1.00
			Batch tool to present a color picker and return the selected (console) color

			Usage:    COLORSELECTBOX  [ "title" ]  [ /R ]  [ /T ]

			Where:    "title"     is the optional custom caption in the title bar
			                      (default: Pick a Console Color)
			          /R          return RGB value (R,G,B) of the selected color
			                      (default: single hexadcimal digit)
			          /T          Test: show console colors and their return values

			Notes:    Only the 16 standard console colors are available.
			          By default, the hexadecimal "index" of the selected
			          console color is shown on screen (e.g. "C" for bright red)
			          and returned as return code (e.g. 12 for bright red).
			          With /R however, the RGB value of the selected color
			          is shown (e.g. "255,0,0" for bright red) and returned
			          as return code (i.e. 65536 x red + 256 x green + blue).
			          With /T any other command line arguments will be ignored.
			          With /T or if no selection is made or in case of
			          (command line) errors, return code is -1.

			Written by Rob van der Woude
			http://www.robvanderwoude.com
			*/

			if ( errmsg.Length > 0 )
			{
				List<string> errargs = new List<string>( errmsg );
				errargs.RemoveAt( 0 );
				Console.Error.WriteLine( );
				Console.ForegroundColor = ConsoleColor.Red;
				Console.Error.Write( "ERROR:\t" );
				Console.ForegroundColor = ConsoleColor.White;
				Console.Error.WriteLine( errmsg[0], errargs.ToArray( ) );
				Console.ResetColor( );
			}

			Console.Error.WriteLine( );

			Console.Error.WriteLine( "ColorSelectBox,  Version {0}", progver );

			Console.Error.WriteLine( "Batch tool to present a color picker and return the selected (console) color" );

			Console.Error.WriteLine( );

			Console.Error.Write( "Usage:    " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.WriteLine( "COLORSELECTBOX  [ \"title\" ]  [ /R ]  [ /T ]" );
			Console.ResetColor( );

			Console.Error.WriteLine( );

			Console.Error.Write( "Where:    " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "\"title\"" );
			Console.ResetColor( );
			Console.Error.WriteLine( "     is the optional custom caption in the title bar" );

			Console.Error.WriteLine( "                      (default: {0})", caption );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "          /R" );
			Console.ResetColor( );
			Console.Error.Write( "          return " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "R" );
			Console.ResetColor( );
			Console.Error.WriteLine( "GB value (R,G,B) of the selected color" );

			Console.Error.WriteLine( "                      (default: single hexadcimal digit)" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "          /T          T" );
			Console.ResetColor( );
			Console.Error.WriteLine( "est: show console colors and their return values" );

			Console.Error.WriteLine( );

			Console.Error.WriteLine( "Notes:    Only the 16 standard console colors are available." );

			Console.Error.WriteLine( "          By default, the hexadecimal \"index\" of the selected" );

			Console.Error.WriteLine( "          console color is shown on screen (e.g. \"C\" for bright red)" );

			Console.Error.WriteLine( "          and returned as return code (e.g. 12 for bright red)." );

			Console.Error.Write( "          With " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/R" );
			Console.ResetColor( );
			Console.Error.WriteLine( " however, the RGB value of the selected color" );

			Console.Error.WriteLine( "          is shown (e.g. \"255,0,0\" for bright red) and returned" );

			Console.Error.WriteLine( "          as return code (i.e. 65536 x red + 256 x green + blue)." );

			Console.Error.Write( "          With " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/T" );
			Console.ResetColor( );
			Console.Error.WriteLine( " any other command line arguments will be ignored." );

			Console.Error.Write( "          With " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/T" );
			Console.ResetColor( );
			Console.Error.WriteLine( " or if no selection is made or in case of" );

			Console.Error.WriteLine( "          (command line) errors, return code is -1." );

			Console.Error.WriteLine( );

			Console.Error.WriteLine( "Written by Rob van der Woude" );

			Console.Error.WriteLine( "http://www.robvanderwoude.com" );

			return -1;
		}
	}
}
