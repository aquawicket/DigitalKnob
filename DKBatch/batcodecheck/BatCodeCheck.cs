using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;


namespace RobvanderWoude
{
	public partial class BatCodeCheck
	{
		public static string progver = "0.37 beta";


		#region Global Variables and Constants


		public const RegexOptions ignorecase = RegexOptions.IgnoreCase;

		public static int commentlines = 0;
		public static int lasterrline = -1;
		public static int lastline = -1;
		public static int linenum = 0;
		public static int lineswitherrors = 0;
		public static int maxvarlen = 32; // Some day, we may have to adjust the accepted variable name length if 32 characters is not enough ([\w\.-]{1,32})
		public static int mysteryvars = 0;
		public static int obsoletecmd = 0;
		public static int parenthesis = 0;
		public static int rc = 1;
		public static int setlocal = 0;
		public static int unterminatedexclamations = 0;
		public static int unterminateddoublequotes = 0;
		public static int unterminatedpercentsigns = 0;
		public static int unterminatedsinglequotes = 0;
		public static bool addtimestamp = false;
		public static bool checkall = true;
		public static bool checkbadpr = false;
		public static bool checkbestpr = false;
		public static bool checkcmdargs = false;
		public static bool checkcommerr = false;
		public static bool checkenvvars = false;
		public static bool checklabels = false;
		public static bool checksubs = false;
		public static bool checkundef = false;
		public static bool checkupdates = false;
		public static bool checkvulnr = false;
		public static bool debugmode = false;
		public static bool delayedvarexp = false;
		public static bool delayedvarglobal = false;
		public static bool dispnums = true;
		public static bool errinline = false;
		public static bool htmlopen = false;
		public static bool includelocalvars = false;
		public static bool incomment = false;
		public static bool interactive = false;
		public static bool licensed = true;
		public static bool log2html = false;
		public static bool logging = false;
		public static bool openalllogs = false;
		public static bool openlog = false;
		public static bool openhtml = false;
		public static bool replacehtml = true;
		public static bool replacelog = true;
		public static bool spanopen = false;
		public static bool splitoneliners = false;
		public static bool verbosesummary = true;
		public static bool wrap = false;
		public static string allargs;
		public static string allsrc;
		public static string allsrc_nocomments;
		public static string allerrors = string.Empty;
		public static string allbadpr = string.Empty;
		public static string alltips = string.Empty;
		public static string allwarnings = string.Empty;
		public static string allerrsum = string.Empty;
		public static string dynvarpattern = @"__APPDIR__|__CD__|CD|CMDCMDLINE|CMDEXTVESION|DATE|ERRORLEVEL|HIGHESTNUMANODENUMBER|RANDOM|TIME";
		public static string html = string.Empty;
		public static string htmlfile = string.Empty;
		public static string intcmdpattern = @"ASSOC|BREAK|CALL|CD|CHDIR|CLS|COLOR|COPY|DATE|DEL|DIR|DPATH|ECHO|ENDLOCAL|ERASE|EXIT|FOR|FTYPE|GOTO|IF|KEYS|MD|MKDIR|MKLINK|MOVE|PATH|PAUSE|POPD|PROMPT|PUSHD|RD|REM|REN|RENAME|RMDIR|SET|SETLOCAL|SHIFT|START|TIME|TITLE|TYPE|VER|VERIFY|VOL";
		public static string logfile = string.Empty;
		public static string newline = Environment.NewLine;
		public static string notx32pattern = @"BREAK|CTTY|FASTOPEN|FASTOPEN\.COM|FASTOPEN\.EXE|KEYS|SHARE|SHARE\.EXE";
		public static string notx64pattern = @"APPEND|APPEND\.COM|APPEND\.EXE|DEBUG|DEBUG\.COM|DEBUG\.EXE";
		public static string source = string.Empty;
		public static string sysvarpattern = @"AllUsersProfile|AppData|CommonProgramFiles|CommonProgramFiles\(x86\)|CommonProgramW6432|ComputerName|ComSpec|HomeDrive|HomePath|LocalAppData|LogonServer|NUMBER_OF_PROCESSORS|OS|PATH|PATHEXT|PROCESSOR_ARCHITECTURE|PROCESSOR_IDENTIFIER|PROCESSOR_LEVEL|PROCESSOR_REVISION|ProgramData|ProgramFiles|ProgramFiles\(x86\)|ProgramW6432|PROMPT|SystemDrive|SystemRoot|TEMP|TMP|UserDomain|UserName|UserProfile|windir";
		public static string timestamp = string.Empty;
		public static string[] path = ( Environment.CurrentDirectory + ";" + Environment.GetEnvironmentVariable( "PATH" ) ).Split( ';' );
		public static string[] pathext = ( ";" + Environment.GetEnvironmentVariable( "PATHEXT" ).ToLower( ) ).Split( ';' );
		public static SortedList<string, int> labels = new SortedList<string, int>( );
		public static SortedList<string, int> envvars = new SortedList<string, int>( );
		public static SortedList<string, int> subroutines = new SortedList<string, int>( );
		public static List<string> upcaselabels = new List<string>( );
		public static List<string> gotoerrors = new List<string>( );
		public static List<string> callerrors = new List<string>( );
		public static List<string> upcaseenvvars = new List<string>( );
		public static List<string> envvarerrors = new List<string>( );
		public static List<string> localenvvars = new List<string>( );
		public static StreamWriter htmlstream;
		public static ConsoleColor badprbgcolor = ConsoleColor.Yellow;
		public static ConsoleColor badprfgcolor = ConsoleColor.Red;
		public static ConsoleColor commentfgscolor = ConsoleColor.DarkYellow;
		public static ConsoleColor doublequotedfgcolor = ConsoleColor.Yellow;
		public static ConsoleColor echoedtextfgcolor = ConsoleColor.Cyan;
		public static ConsoleColor errorbgcolor = ConsoleColor.Red;
		public static ConsoleColor errorfgcolor = ConsoleColor.White;
		public static ConsoleColor extcmdbgcolor = ConsoleColor.Black;
		public static ConsoleColor extcmdfgcolor = ConsoleColor.White;
		public static ConsoleColor intcmdbgcolor = ConsoleColor.Black;
		public static ConsoleColor intcmdfgcolor = ConsoleColor.Yellow;
		public static ConsoleColor lastbgc = Console.BackgroundColor;
		public static ConsoleColor lastfgc = Console.ForegroundColor;
		public static ConsoleColor linenumbgcolor = ConsoleColor.Gray;
		public static ConsoleColor linenumfgcolor = ConsoleColor.DarkMagenta;
		public static ConsoleColor parenthesisfgcolor = ConsoleColor.Red;
		public static ConsoleColor redirectionfgcolor = ConsoleColor.Red;
		public static ConsoleColor reportbgcolor = Console.BackgroundColor;
		public static ConsoleColor reportfgcolor = ConsoleColor.Red;
		public static ConsoleColor singlequotedfgcolor = ConsoleColor.DarkGray;
		public static ConsoleColor tipsbgcolor = ConsoleColor.Blue;
		public static ConsoleColor tipsfgcolor = ConsoleColor.White;
		public static ConsoleColor variablesfgcolor = ConsoleColor.Green;
		public static ConsoleColor warningbgcolor = ConsoleColor.DarkYellow;
		public static ConsoleColor warningfgcolor = ConsoleColor.White;
		public static ConsoleColor windowbgcolor = Console.BackgroundColor;
		public static ConsoleColor windowfgcolor = Console.ForegroundColor;
		// Inline variables
		public static string badprmsg = string.Empty;
		public static string errormsg = string.Empty;
		public static string tipsmsg = string.Empty;
		public static string warnmsg = string.Empty;
		public static string message = string.Empty;
		public static string part = string.Empty;
		public static string buildword = string.Empty;
		public static string lastword = string.Empty;


		#endregion Global Variables and Constants


		[STAThread]
		static int Main( string[] args )
		{
			// Check for updates (licensed version only)
			CheckUpdate( );


			#region Command Line Parsing


			allargs = string.Join( " ", args );


			#region Command Line Arguments


			if ( args.Length == 0 || args.Length > 8 )
			{
				return ShowHelp( );
			}
			foreach ( string arg in args )
			{
				if ( arg[0] == '/' )
				{
					switch ( arg.ToUpper( ).Substring( 0, Math.Min( 2, arg.Length ) ) )
					{
						case "/?":
							return ShowHelp( );
						case "/C":
							if ( !checkall )
							{
								return ShowHelp( "Duplicate command line argument /C" );
							}
							if ( arg.Length < 4 || arg[2] != ':' )
							{
								return ShowHelp( "Invalid command line argument \"{0}\"", arg );
							}
							string checks = arg.Substring( 3 ).ToUpper( );
							checkall = false;
							checkcmdargs = ( checks.IndexOf( 'A' ) > -1 ); // command line Arguments for batch commands
							checkbestpr = ( checks.IndexOf( 'B' ) > -1 ); // Best practice tips
							checkenvvars = ( checks.IndexOf( 'E' ) > -1 ); // Environment variables
							checkcommerr = ( checks.IndexOf( 'M' ) > -1 ); //' common Mistakes
							checklabels = ( checks.IndexOf( 'L' ) > -1 ); // Labels
							verbosesummary = ( checks.IndexOf( 'S' ) > -1 ); // verbose Summary (variables, labels, subroutines)
							checkundef = ( checks.IndexOf( 'U' ) > -1 ); // Undefined environment variables
							checkvulnr = ( checks.IndexOf( 'V' ) > -1 ); // Vulnerabilities
							break;
						case "/D":
							if ( debugmode )
							{
								return ShowHelp( "Duplicate command line argument /D" );
							}
							debugmode = true;
							break;
						case "/E":
							if ( includelocalvars )
							{
								return ShowHelp( "Duplicate command line argument /E" );
							}
							includelocalvars = true;
							break;
						case "/H":
							if ( log2html )
							{
								return ShowHelp( "Duplicate command line argument /H" );
							}
							log2html = true;
							if ( arg.Length > 3 && arg.ToUpper( ).Substring( 2, 1 ) == ":" )
							{
								htmlfile = arg.Substring( 3 );
							}
							break;
						case "/I":
							if ( interactive )
							{
								return ShowHelp( "Duplicate command line argument /I" );
							}
							interactive = true;
							break;
						case "/L":
							if ( logging )
							{
								return ShowHelp( "Duplicate command line argument /L" );
							}
							logging = true;
							if ( arg.Length > 3 && arg.ToUpper( ).Substring( 2, 1 ) == ":" )
							{
								logfile = arg.Substring( 3 );
							}
							break;
						case "/O":
							if ( openalllogs )
							{
								return ShowHelp( "Duplicate command line argument /O" );
							}
							openalllogs = true;
							break;
						case "/S":
							if ( splitoneliners )
							{
								return ShowHelp( "Duplicate command line argument /S" );
							}
							splitoneliners = true;
							break;
						case "/T":
							if ( addtimestamp )
							{
								return ShowHelp( "Duplicate command line argument /T" );
							}
							addtimestamp = true;
							break;
						case "/U":
							if ( checkupdates )
							{
								return ShowHelp( "Duplicate command line argument /U" );
							}
							checkupdates = true;
							break;
						case "/W":
							if ( wrap )
							{
								return ShowHelp( "Duplicate command line argument /W" );
							}
							wrap = true;
							break;
						default:
							return ShowHelp( "Invalid command line argument \"{0}\"", arg );
					}
				}
				else
				{
					if ( string.IsNullOrEmpty( source ) )
					{
						source = arg;
					}
					else
					{
						return ShowHelp( "Invalid command line argument \"{0}\"", arg );
					}
				}
			}

			if ( checkupdates )
			{
				string updatecheckurl = "http://www.robvanderwoude.com/getlatestver.php?progfile=BatCodeCheck.exe&amp;version=" + progver;
				Process.Start( updatecheckurl );
			}


			#endregion Command Line Arguments


			#region Validate paths


			if ( !interactive )
			{
				if ( string.IsNullOrEmpty( source ) )
				{
					return ShowHelp( "Please specify a source file" );
				}
				if ( !addtimestamp && source.IndexOfAny( "/?*".ToCharArray( ) ) > -1 )
				{
					return ShowHelp( );
				}
				if ( !File.Exists( source ) )
				{
					return ShowHelp( "Source file not found" );
				}
			}
			if ( !string.IsNullOrWhiteSpace( source ) )
			{
				source = Path.GetFullPath( source );
			}
			if ( !string.IsNullOrEmpty( logfile ) )
			{
				if ( !Directory.Exists( Directory.GetParent( logfile ).FullName ) )
				{
					return ShowHelp( "Invalid path to log file" );
				}
				logfile = Path.GetFullPath( logfile );
			}
			if ( !string.IsNullOrEmpty( htmlfile ) )
			{
				if ( !Directory.Exists( Directory.GetParent( htmlfile ).FullName ) )
				{
					return ShowHelp( "Invalid path to HTML file" );
				}
				htmlfile = Path.GetFullPath( htmlfile );
			}


			#endregion Validate paths


			#region BatCodeCheck Environment Variable


			// Local environment variable %BatCodeCheck% can be used to set defaults, but it is overruled by command line arguments
			try
			{
				string envargs = Environment.GetEnvironmentVariable( "BatCodeCheck" );
				if ( !string.IsNullOrWhiteSpace( envargs ) )
				{
					envargs = envargs.ToUpper( );
				}
				if ( new Regex( @"^\s*(/[EHILOSTW]\s*)+$" ).IsMatch( envargs ) )
				{
					foreach ( Match match in new Regex( "/[DEHILOSTW]" ).Matches( envargs ) )
					{
						switch ( match.ToString( ) )
						{
							case "/D":
								if ( !debugmode )
								{
									debugmode = true;
									allargs += " /D";
								}
								break;
							case "/E":
								if ( !includelocalvars )
								{
									includelocalvars = true;
									allargs += " /E";
								}
								break;
							case "/H":
								if ( !log2html )
								{
									log2html = true;
									allargs += " /H";
								}
								break;
							case "/I":
								if ( !interactive )
								{
									interactive = true;
									allargs += " /I";
								}
								break;
							case "/L":
								if ( !logging )
								{
									logging = true;
									allargs += " /L";
								}
								break;
							case "/O":
								if ( !openalllogs )
								{
									openalllogs = true;
									allargs += " /O";
								}
								break;
							case "/S":
								if ( !splitoneliners )
								{
									splitoneliners = true;
									allargs += " /S";
								}
								break;
							case "/T":
								if ( !addtimestamp )
								{
									addtimestamp = true;
									allargs += " /T";
								}
								break;
							case "/W":
								if ( !wrap )
								{
									wrap = true;
									allargs += " /W";
								}
								break;
						}
					}
				}
			}
			catch ( Exception )
			{
				// Environment variable BatCodeCheck not found
			}


			#endregion BatCodeCheck Environment Variable


			#region Command Line Defaults


			if ( !includelocalvars )
			{
				pathext = ".com;.exe;.bat;.cmd".Split( ';' );
			}
			if ( addtimestamp )
			{
				AddTimeStamp( );
			}
			if ( log2html && string.IsNullOrWhiteSpace( htmlfile ) )
			{
				htmlfile = Path.Combine( Path.GetDirectoryName( source ), Path.GetFileNameWithoutExtension( source ) + timestamp + ".html" );
			}
			if ( logging && string.IsNullOrWhiteSpace( logfile ) )
			{
				logfile = Path.Combine( Path.GetDirectoryName( source ), Path.GetFileNameWithoutExtension( source ) + timestamp + ".log" );
			}


			#endregion Command Line Defaults


			#region Command Line Dependencies


			openalllogs = openalllogs && ( logging || log2html );
			openhtml = openalllogs && log2html;
			openlog = openalllogs && logging;


			#endregion Command Line Dependencies


			#region Interactive


			if ( licensed && interactive )
			{
				try
				{
					if ( !ShowSettings( ) )
					{
						Console.Error.WriteLine( "Aborted by user request" );
						return 1;
					}
				}
				catch ( Exception )
				{
					return ShowHelp( "Interactive use of BatCodeCheck (/I switch) requires a licensed version" );
				}
			}


			#endregion Interactive


			#endregion Command Line Parsing


#if DEBUG
			debugmode = true;
#endif


			if ( File.Exists( source ) )
			{
				ReadSource( source );
				CollectEnvironmentVariables( );
				CollectLabels( );
				CreateHTML( );

				// Now parse the source line by line
				rc = 0;
				foreach ( string line in allsrc.Split( new string[] { "\r\n", "\n", "\r" }, StringSplitOptions.None ) )
				{
					linenum += 1;

					// If /S switch was used, split the line on parenthesis and ampersands, except parentheses surrounding the list in FOR loops, and except comments
					if ( splitoneliners && !new Regex( @"^\s*(::|REM)(\b|\s|$)", ignorecase ).IsMatch( line ) && line.IndexOfAny( "(&|)".ToCharArray( ) ) > -1 )
					{
						#region Split One-Liners

						bool inelse = false;
						bool inforloop = false;
						string tmpline = string.Empty;

						string pattern = @"(?<!\^)\((?!['\n\r])";
						Regex regex = new Regex( pattern );
						if ( regex.IsMatch( line ) )
						{
							MatchCollection matches = regex.Matches( line );
							tmpline = line.Substring( 0, matches[0].Index );
							if ( new Regex( @"\s%%[A-Z!]\s+IN\s+$", ignorecase ).IsMatch( tmpline ) )
							{
								inforloop = true;
							}
							else if ( new Regex( @"\)\s+ELSE\s+\(", ignorecase ).IsMatch( tmpline ) )
							{
								inelse = true;
							}

						}
						if ( inforloop || inelse )
						{
							tmpline = regex.Replace( line, "(\n\t", 100, line.IndexOf( ')' ) + 1 );
						}
						else
						{
							tmpline = regex.Replace( line, "(\n\t" );
						}

						pattern = @"(?<!['\^\n\r])\)";
						regex = new Regex( pattern );
						if ( inforloop || inelse )
						{
							tmpline = regex.Replace( tmpline, "\n)", 100, line.IndexOf( ')' ) + 1 );
						}
						else
						{
							tmpline = regex.Replace( tmpline, "\n)" );
						}

						pattern = @"(?<!\^|2>|1>)&(?>!1|2)";
						regex = new Regex( pattern );
						tmpline = regex.Replace( tmpline, "\n\t" );

						foreach ( string part in tmpline.Split( new string[] { "\n" }, StringSplitOptions.None ) )
						{
							if ( !string.IsNullOrWhiteSpace( part ) )
							{
								ParseLine( part );
							}
						}

						#endregion Split One-Liners
					}
					else
					{
						ParseLine( line );
					}
				}
				DisplayMessagesSummary( );
				CloseHTML( );
				RestoreConsoleColors( );
				if ( OpenLogFile( ) + OpenHTMLFile( ) != 0 )
				{
					return 1;
				}
				return rc;
			}
			else
			{
				return ShowHelp( "File \"{0}\" not found", source );
			}
		}


		#region Subroutines


		public static void AddTimeStamp( )
		{
			if ( string.IsNullOrWhiteSpace( timestamp ) )
			{
				timestamp = DateTime.Now.ToString( ".yyyyMMddHHmmss" );
			}
		}


		public static void CheckBadPractices( string line )
		{
			if ( checkall || checkbadpr )
			{
				string pattern;
				Regex regex;

				// SET dynamic variables
				#region SET dynamic variables

				pattern = string.Format( @"\bSET\s+({0})=", dynvarpattern );
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					string dynvar = matches[0].Groups[1].Value;
					message = string.Format( "Setting dynamic variable \"{0}\" to a static value may cause problems later on in the batch file; consider using an alternative variable name instead", dynvar.ToUpper( ) );
					allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					badprmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion SET dynamic variables

				// SET system variables
				#region SET system variables

				pattern = string.Format( @"\bSET\s+({0})=", sysvarpattern );
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					string dynvar = matches[0].Groups[1].Value;
					message = string.Format( "Setting system variable \"{0}\" may cause problems later on in the batch file; consider using an alternative variable name instead", dynvar.ToUpper( ) );
					allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					badprmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion SET system variables

				// Quoted paths
				// Disabled for now, as it is extremely hard, if possible at all, to extract a path from a command line without a true interpreter
				#region Quoted paths
				/*
			pattern = @"[^""=]((?:[A-Z]:|\\\\\w+\\\w+)(?:\\[^\\]+)*\\[^\s\\]+\s+[^\\]+(?:\\[^\\]+)*(?:\\|\b|$))";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string path = matches[0].Groups[1].ToString( );
				message = string.Format( "Whitespace found in unquoted path: \"{0}\"", path );
				allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
				badprmsg += string.Format( "{0}{1}.", newline, message );
				errinline = true;
			}

			pattern = @"[^""]((?:[A-Z]:|\\\\\w+\\\w+)(?:\\[^\\]+)*\\[^\\]*(\(|\))[^\\]*(?:\\[^\\]+)*\\?(?:\b|$))";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string path = matches[0].Groups[1].ToString( );
				string spec = matches[0].Groups[2].ToString( );
				message = string.Format( "Parenthesis found in unquoted path: \"{1}\"; use doublequotes, especially inside code blocks", spec, path );
				allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
				badprmsg += string.Format( "{0}{1}.", newline, message );
				errinline = true;
			}

			pattern = @"[^""=]((?:[A-Z]:|\\\\\w+\\\w+)(?:\\[^\\]+)*\\[^\\]*(&|'|,|\^)[^\\]*(?:\\[^\\]+)*\\?(?:\b|$))";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string path = matches[0].Groups[1].ToString( );
				string spec = matches[0].Groups[2].ToString( );
				message = string.Format( "Special character \"{0}\" found in unquoted path: \"{1}\"; use doublequotes", spec, path );
				allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
				badprmsg += string.Format( "{0}{1}.", newline, message );
				errinline = true;
			}
			*/
				#endregion Quoted paths
			}
		}


		public static void CheckBestPractices( string line )
		{
			if ( checkall || checkbestpr )
			{
				string pattern;
				Regex regex;

				// Doublequotes in SET statements
				#region Doublequoted SET

				pattern = @"(?:^|\b|\()(SET\s+""([\w_\.-]+)=([^""&\n\r]+)"")";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					foreach ( Match match in regex.Matches( line ) )
					{
						string wrong = match.Groups[1].ToString( );
						string correct = string.Format( "SET {0}={1}", match.Groups[2].ToString( ), match.Groups[3].ToString( ) );
						message = string.Format( "Doublequoted SET statements are not recommended, except with /A (or /P) switch; use {0} instead of {1}", correct, wrong );
						alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						tipsmsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
				}

				#endregion Doublequoted SET

				// Whitespace around equal signs in IF statements
				#region Whitespace around equal signs

				pattern = @"(^|\b)IF\s+(/I\s+)?(?:\w+|\""[^""]+\"")\s*==?\s*(?:\w+|\""[^""]+\"")\s*[\(\w]";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b)(IF\s+(/I\s)?\s*(\w+|\""[^""]+\"")(?:\s+==?\s*|\s*==?\s+)(\w+|\""[^""]+\""))\s*[\(\w]";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						MatchCollection matches = regex.Matches( line );
						string wrong = matches[0].Groups[1].ToString( );
						string correct = string.Format( "IF {0}{1}=={2}", matches[0].Groups[2].ToString( ).ToUpper( ).Trim( ), matches[0].Groups[3].ToString( ), matches[0].Groups[4].ToString( ) );
						message = string.Format( "Whitespace around the double equal sign in an IF statement is not recommended, use {0} instead of {1}", correct, wrong );
						alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						tipsmsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
				}

				#endregion Whitespace around equal signs

				// Devices with appended colons
				#region Devices with appended colons

				pattern = @"(?:>|\b)(AUX|CLOCK\$|COM[1-8]|CON|LPT[1-8]|NUL|PRN):(?:\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					string device = matches[0].Groups[1].ToString( ).ToUpper( );
					message = string.Format( "Redundant colon appended to device name \"{0}\"", device );
					alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					tipsmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion Devices with appended colons

				// Obsolete commands BREAK, CTTY, KEYS, and 16-bit commands
				#region Obsolete commands

				pattern = string.Format( @"(?:^|&|\|\()\s*({0})\b", notx32pattern );
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					foreach ( Match match in matches )
					{
						string cmd = match.Groups[1].ToString( ).ToUpper( );
						message = string.Format( "Obsolete command \"{0}\" is accepted only for MS-DOS backwards compatibility", cmd );
						alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						tipsmsg += string.Format( "{0}{1}.", newline, message );
						obsoletecmd += 1;
					}
					errinline = true;
				}

				pattern = string.Format( @"(?:^|&|\|\()\s*({0})\b", notx64pattern );
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					foreach ( Match match in matches )
					{
						string cmd = match.Groups[1].ToString( ).ToUpper( );
						if ( System.Environment.Is64BitOperatingSystem )
						{
							message = string.Format( "16-bit command \"{0}\" is not available in 64-bit Windows", cmd );
							allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
							errormsg += string.Format( "{0}{1}.", newline, message );
						}
						else
						{
							message = string.Format( "16-bit command \"{0}\" will not be available in 64-bit Windows", cmd );
							alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
							tipsmsg += string.Format( "{0}{1}.", newline, message );
						}
						obsoletecmd += 1;
					}
					errinline = true;
				}

				#endregion Obsolete commands

				// @ all over the place
				#region Hiding command echo

				if ( linenum > 1 )
				{
					pattern = @"^\s*@(?>!ECHO\s*(ON|OFF)\s)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						message = "Using multiple @s to hide command echoing is NOT recommended, as it makes debugging batch files harder. @ECHO OFF at the start of the batch file suffices to hide ALL command echoing.";
						alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						tipsmsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
				}
				#endregion Hiding command echo
			}
		}


		public static void CheckCommandLineArguments( string line )
		{
			if ( checkall || checkcmdargs )
			{
				string pattern;
				Regex regex;

				// Invalid arguments for ASSOC command
				#region ASSOC command line

				pattern = @"(^|\b|\()ASSOC(\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b|\()ASSOC(\s+\.\w+(?:=[\w \.\-]{3,})?)?\s*$";
					regex = new Regex( pattern, ignorecase );
					if ( !regex.IsMatch( line ) )
					{
						pattern = @"(?:^|\b|\()ASSOC([^\n\r&|]+)";
						regex = new Regex( pattern, ignorecase );
						if ( regex.IsMatch( line ) )
						{
							string cla = regex.Match( line ).Groups[1].ToString( ).Trim( );
							if ( !string.IsNullOrWhiteSpace( cla ) && cla[0] != '/' ) // No need to display a message for switches, the check for switches will handle that
							{
								message = string.Format( "Invalid command line argument(s) \"{0}\" for ASSOC command", cla );
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
								errinline = true;
							}
						}
					}
				}

				#endregion ASSOC command line

				// Invalid arguments for BREAK command
				#region BREAK command line

				pattern = @"(^|\b|\()BREAK(\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b|\()BREAK(\s+(ON|OFF))\s*$";
					regex = new Regex( pattern, ignorecase );
					if ( !regex.IsMatch( line ) )
					{
						pattern = @"(?:^|\b|\()BREAK([^\n\r&|]+)";
						regex = new Regex( pattern, ignorecase );
						if ( regex.IsMatch( line ) )
						{
							string cla = regex.Match( line ).Groups[1].ToString( ).Trim( );
							if ( !String.IsNullOrWhiteSpace( cla ) && cla[0] != '/' ) // No need to display a message for switches, the check for switches will handle that
							{
								message = string.Format( "Invalid command line argument \"{0}\" for BREAK command, the only arguments accepted are ON and OFF", cla );
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
								errinline = true;
							}
						}
					}
					message = "The BREAK command is available for backward compatibility only, it does not DO anything in Windows";
					alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					tipsmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion BREAK command line

				// Invalid arguments for CALL command
				#region CALL command line

				pattern = @"(?:^|\b|\()CALL\s+([^\n\r\s]+)(\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					bool callerr = false;
					string cla = regex.Match( line ).Groups[1].ToString( );
					if ( string.IsNullOrWhiteSpace( cla ) )
					{
						callerr = true;
					}
					else
					{
						if ( cla[0] != ':' ) // CALLs to subroutine labels will be handled later
						{
							pattern = string.Format( @"^({0})$", intcmdpattern );
							regex = new Regex( pattern, ignorecase );
							if ( !regex.IsMatch( cla ) )
							{
								if ( string.IsNullOrWhiteSpace( Which( cla ) ) )
								{
									callerr = true;
								}
							}
						}
					}
					if ( callerr )
					{
						message = string.Format( "Invalid command line argument \"{0}\" for CALL command: no matching internal command, nor external command was found", cla );
						allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						errormsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
				}

				#endregion CALL command line

				// Invalid switch for CD command
				#region CD switches

				pattern = @"(?:^|\b|\()(CD|CHDIR)\s+(/[^D][^\n\r\s/]*)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cmd = regex.Match( line ).Groups[1].ToString( );
					string cls = regex.Match( line ).Groups[2].ToString( );
					message = string.Format( "Invalid command line switch \"{0}\" for {1} command, the only accepted switch is /D", cls, cmd );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion CD switches

				// Invalid argument for DATE command
				#region DATE arguments

				pattern = @"(^|\b|\()(?<![%!])DATE(?>![%!:])(\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b|\()DATE\s+(/[^T][^\^\n\r\s&|\)']*|/T[^\^\n\r\s&|\)']+)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						string cls = regex.Match( line ).Groups[1].ToString( );
						message = string.Format( "Invalid command line switch \"{0}\" for DATE command, the only valid switch is /T", cls );
						allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						errormsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
					else
					{
						pattern = @"(?:^|\b|\()DATE\s+(/T|(%|!)[\w_-]{1,16}\2|[\d/-]{10})";
						regex = new Regex( pattern, ignorecase );
						if ( !regex.IsMatch( line ) )
						{
							string cls = regex.Match( line ).Groups[1].ToString( );
							message = string.Format( "Invalid command line argument \"{0}\" for DATE command, this should be a date", cls );
							allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
							errormsg += string.Format( "{0}{1}.", newline, message );
							errinline = true;
						}
					}
				}

				#endregion DATE arguments

				// Invalid switch for EXIT command
				#region EXIT switches

				pattern = @"(?:^|\b|\()EXIT\s+(/[^B][^\n\r\s/]*)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cls = regex.Match( line ).Groups[1].ToString( );
					message = string.Format( "Invalid command line switch \"{0}\" for EXIT command, the only accepted switch is /B", cls );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion EXIT switches

				// Invalid switch for FOR command
				#region FOR switches

				pattern = @"(?:^|\b|\()FOR\s+(/[^DFLR][^\n\r\s=/]*)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = string.Format( "Invalid command line switch \"{0}\" for FOR command, accepted switches are /D, /F, /L and /R", regex.Match( line ).Groups[1].ToString( ) );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion FOR switches

				// Invalid arguments for FTYPE command
				#region FTYPE command line

				pattern = @"(^|\b|\()FTYPE(\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b|\()FTYPE(\s+[^\.\n\r&|][\w \.\-]{2,}(=[\w: \.\\\-\(\)]+)?)?\s*$";
					regex = new Regex( pattern, ignorecase );
					if ( !regex.IsMatch( line ) )
					{
						pattern = @"(?:^|\b|\()FTYPE\s+([^\n\r&|]+)";
						regex = new Regex( pattern, ignorecase );
						if ( regex.IsMatch( line ) )
						{
							string cla = regex.Match( line ).Groups[1].ToString( ).Trim( );
							if ( !String.IsNullOrWhiteSpace( cla ) && cla[0] != '/' ) // No need to display a message for switches, the check for switches will handle that
							{
								message = string.Format( "Invalid command line argument(s) \"{0}\" for FTYPE command", cla );
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
								errinline = true;
							}
						}
					}
				}

				#endregion FTYPE command line

				// Invalid switch for IF command
				#region IF switches

				pattern = @"(?:^|\b|\()(?<!/)IF\s+(/[^I][^\n\r\s/]*)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cls = regex.Match( line ).Groups[1].ToString( );
					message = string.Format( "Invalid command line switch \"{0}\" for IF command, the only accepted switch is /I", cls );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion IF switches

				// Invalid switch for SET command
				#region SET switches

				pattern = @"(?:^|\b|\()SET\s+(/[^AP][^\n\r\s=/]*)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = string.Format( "Invalid command line switch \"{0}\" for SET command, accepted switches are /A and /P", regex.Match( line ).Groups[1].ToString( ) );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion SET switches

				// Invalid switch for SHIFT command
				#region SHIFT switches

				pattern = @"(?:^|\b|\()SHIFT\s+(/[^0-8][^\n\r\s/]*)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cls = regex.Match( line ).Groups[1].ToString( );
					message = string.Format( "Invalid command line switch \"{0}\" for SHIFT command, the only accepted switch is a forward slash followed by a number from 0 to 8", cls );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion SHIFT switches

				// Invalid argument for TIME command
				#region TIME arguments

				pattern = @"(^|\b|\()(?<![%!])TIME(?>![%!:])(\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b|\()TIME\s+(/[^T][^\^\n\r\s&|\)']*|/T[^\^\n\r\s&|\)']+)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						string cls = regex.Match( line ).Groups[1].ToString( );
						message = string.Format( "Invalid command line switch \"{0}\" for TIME command, the only valid switch is /T", cls );
						allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						errormsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
					else
					{
						pattern = @"(?:^|\b|\()TIME\s+(/T|(%|!)[\w_-]{1,16}\2|[\d:\.,AMP\s]{4,11})";
						regex = new Regex( pattern, ignorecase );
						if ( !regex.IsMatch( line ) )
						{
							string cls = regex.Match( line ).Groups[1].ToString( );
							message = string.Format( "Invalid command line argument \"{0}\" for TIME command, this should be a time value", cls );
							allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
							errormsg += string.Format( "{0}{1}.", newline, message );
							errinline = true;
						}
					}
				}

				#endregion TIME arguments

				// Switches not allowed for ASSOC, CALL, COLOR, FTYPE, GOTO, MD, MKDIR, PUSHD, SETLOCAL
				#region Switches not allowed

				pattern = @"(?:^|\b|\()(ASSOC|CALL|COLOR|FTYPE|GOTO|MD|MKDIR|PUSHD|SETLOCAL)\s+(/[^\n\r\s=/]*)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cmd = regex.Match( line ).Groups[1].ToString( ).ToUpper( );
					string cls = regex.Match( line ).Groups[2].ToString( );
					message = string.Format( "Switch \"{1}\" for {0} command is not valid, as {0} does not accept switches at all", cmd, cls );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion Switches not allowed

				// Arguments not required for CLS, ENDLOCAL, PAUSE, POPD, VER
				#region Arguments not required

				pattern = @"(?:^|\b|\()(CLS|ENDLOCAL|PAUSE|POPD|VER)\s+([^\n\r&|>]+)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cmd = regex.Match( line ).Groups[1].ToString( ).ToUpper( );
					string cla = regex.Match( line ).Groups[2].ToString( );
					message = string.Format( "Argument \"{1}\" for {0} command is not valid, as {0} does not accept arguments at all", cmd, cla );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion Arguments not required
			}
		}


		public static void CheckCommonMistakes( string line )
		{
			if ( checkall || checkcommerr )
			{
				string pattern;
				Regex regex;

				// IF [NOT] EXISTS or IF [NOT] EXIT or IF [NOT] EXITS instead of IF EXIST
				#region IF EXIST

				pattern = @"\bIF(\s+NOT)?\s+EXI(STS|T|TS)\s";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					//message = "Found \"IF EXISTS ...\" (note the incorrect trailing \"S\"); use \"IF EXIST ...\" (without trailing \"S\") instead";
					MatchCollection matches = regex.Matches( line );
					string matchall = matches[0].ToString( ).ToUpper( );
					string matchnot = matches[0].Groups[1].ToString( ).ToUpper( );
					string matchend = matches[0].Groups[2].ToString( ).ToUpper( );
					switch ( matchend )
					{
						case "STS":
							message = string.Format( "Found \"{0} ...\" (note the incorrect trailing \"S\"); use \"IF{1} EXIST ...\" (without trailing \"S\") instead", matchall, matchnot );
							break;
						case "T":
							message = string.Format( "Found \"{0} ...\" (note the missing \"S\"); use \"IF{1} EXIST ...\" (with \"S\") instead", matchall, matchnot );
							break;
						case "TS":
							message = string.Format( "Found \"{0} ...\" (note the swapped \"S\" and \"T\"); use \"IF{1} EXIST ...\" (\"S\" first, followed by \"T\") instead", matchall, matchnot );
							break;
					}
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion IF EXIST

				// Common typos for %AllUsersProfile% variable
				#region AllUsersProfile

				pattern = @"(%|!)(A+L+USERPROFILES?)(\1)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					foreach ( Match match in matches )
					{
						string wrong = match.Groups[2].ToString( ).ToUpper( );
						string varchr = match.Groups[1].ToString( );
						message = string.Format( "Possible typo: the system variable name is spelled \"{0}ALLUSERSPROFILE{0}\", not \"{0}{1}{0}\"", varchr, wrong );
						allwarnings += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						warnmsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
				}

				#endregion AllUsersProfile

				// IF [NOT] ERRORLEVEL 0
				#region IF ERRORLEVEL 0

				pattern = @"(^|\b|\()IF\s+ERRORLEVEL\s+0\s";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = "IF ERRORLEVEL 0 tests if the errorlevel is greater than or equal to 0, so it ALWAYS returns true; use either IF NOT ERRORLEVEL 1 or IF %ErrorLevel% EQU 0 instead";
					allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					badprmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
					rc = linenum;
				}

				pattern = @"(^|\b|\()IF\s+NOT\s+ERRORLEVEL\s+0\s";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = "IF NOT ERRORLEVEL 0 tests if the errorlevel is less than 0, so it always ALWAYS returns false; use either IF ERRORLEVEL 1 or IF %ErrorLevel% NEQ 0 instead";
					allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					badprmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
					rc = linenum;
				}

				#endregion IF ERRORLEVEL 0

				// :: inside code blocks
				#region Double colons in code blocks

				// check if :: is used inside a code block, but skip REM or ECHO followed by ::
				bool codeblock = ( parenthesis > 0 );
				bool dblcolcmnt = ( line.IndexOf( "::" ) > line.IndexOfAny( "(&|".ToCharArray( ) ) );
				bool echoedcmnt = new Regex( @"^([^:]*|([^:]*:[^:]+)*)ECHO\b[^\n\r&\|\>]*::", ignorecase ).IsMatch( line ); // Skip if ECHO is found before :: and no redirection in between
				bool remcomment = new Regex( @"^([^:]*|([^:]*:[^:]+)*)REM\b[^\n\r&]*::", ignorecase ).IsMatch( line ); // Skip if REM is found before :: and no ampersand in between
				if ( dblcolcmnt && codeblock && !remcomment && !echoedcmnt )
				{
					message = "Found \"::\" inside a code block (i.e. in parenthesis); use \"REM\" instead";
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
					rc = linenum;
				}

				#endregion Double colons in code blocks

				// CALLs to undefined subroutines
				#region CALLs

				if ( new Regex( @"(?:^|\s)CALL\s+:", ignorecase ).IsMatch( line ) )
				// if ( new Regex( @"(?:^|\b)CALL\s+:", ignorecase ).IsMatch( line ) )
				{
					//MatchCollection matches = new Regex( @"(?:^|\b)CALL\s+:([\w\.\[\]\/+\-\(\)\{\}]{1,127})(?=$|\s|\)|&|\|)", ignorecase ).Matches( line );
					MatchCollection matches = new Regex( @"(?:^|\s)CALL\s+:([\w\.\[\]\/+\-\(\)\{\}]{1,127})(?=$|\s|\)|&|\|)", ignorecase ).Matches( line );
					foreach ( Match match in matches )
					{
						string label = match.Groups[1].ToString( );
						// if ( !upcaselabels.Contains( label ) )
						if ( !labels.Keys.Contains( label ) )
						{
							callerrors.Add( label );
							message = string.Format( "A CALL is made to a subroutine named \"{0}\" but the subroutine was not found", label );
							allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
							errormsg += string.Format( "{0}{1}.", newline, message );
							errinline = true;
						}
					}
				}

				#endregion CALLs

				// GOTOs to undefined labels
				#region GOTOs

				if ( new Regex( @"(?:^|\b|\s|\()GOTO\s", ignorecase ).IsMatch( line ) )
				{
					MatchCollection matches = new Regex( @"(?:^|\b|\s|\()GOTO\s+:?([\w\.\[\]/+\-]{1,127})[\)&|\s]*", ignorecase ).Matches( line );
					foreach ( Match match in matches )
					{
						string label = match.Groups[1].ToString( );
						if ( label.ToUpper( ) != "EOF" && !upcaselabels.Contains( label.ToUpper( ) ) )
						{
							gotoerrors.Add( label );
							message = string.Format( "A jump (GOTO) to a label named \"{0}\" was detected, but the label was not found", label );
							allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
							errormsg += string.Format( "{0}{1}.", newline, message );
							errinline = true;
						}
					}
				}

				#endregion GOTOs

				// Redirected Standard Error typos
				#region Redirected Standard Error

				pattern = @"\s(2(?:>>|<+|\s+)&\s*1)(?:\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					string redirect = matches[0].Groups[1].ToString( ).ToUpper( );
					message = string.Format( "Incorrect redirection of Standard Error to Standard Output: \"{0}\"", redirect );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				pattern = @"\s(1(?:>>|<+|\s+)&\s*2)(?:\b|$)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					string redirect = matches[0].Groups[1].ToString( ).ToUpper( );
					message = string.Format( "Incorrect redirection of Standard Output to Standard Error: \"{0}\"", redirect );
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				pattern = @"2>&1[ \t""]*[^$&\|\)]";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = "Redirection of Standard Error to Standard Output (2>&1) should always be placed at the end of the command";
					allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					badprmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion Redirected Standard Error

				// Unescaped redirection in FOR /F loops
				#region Unescaped redirection in FOR /F loops

				pattern = @"FOR\s+/F\s+(""((delims|eol|skip|tokens)=[^ ""]*\s*|usebackq\s*)*"")?\s*%%[A-Z?]\s+IN\s+\('[^\^']*[\&\<\>\|]";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = "Unescaped redirection symbol(s) in a FOR /F loop";
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion Unescaped redirection in FOR /F loops

				// Unescaped ECHOed parenthesis inside code block
				#region Unescaped ECHOed parenthesis inside code block

				if ( parenthesis > 0 ) // if we're inside a code block...
				{
					pattern = @"(^|\b)ECHO(?=\.|\s)[^&\|\n\r\(\)^]*[^^][\(\)]";
				}
				else
				{
					pattern = @"\(\s*ECHO(?=\.|\s)[^&\|\n\r\(\)^]*[^^][\(\)]";
				}
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = "Unescaped ECHOed parenthesis inside a code block";
					allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					errormsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion Unescaped ECHOed parenthesis inside code block

				// Delayed variables with delayed variable expansion disabled vv.
				#region Delayed variables without delayed expansion

				if ( delayedvarexp )
				{
					pattern = @"%\w{1,16}%";
					regex = new Regex( pattern );
					if ( regex.IsMatch( line ) )
					{
						string envvar = regex.Match( line ).Value.ToUpper( );
						string varname = envvar.Substring( 1, envvar.Length - 2 );
						// Skip warning if we are dealing with a (dynamic) system variable
						pattern = string.Format( @"^({0}|{1})$", dynvarpattern, sysvarpattern );
						if ( !new Regex( pattern, ignorecase ).IsMatch( varname ) )
						{
							message = string.Format( "Variable \"{0}\" found with delayed variable expansion enabled; shouldn't that be \"!{1}!\" instead?", envvar, varname );
							// Skip warning if line is a comment
							if ( !new Regex( @"(^|&)\s*(REM($|\s)|::)", ignorecase ).IsMatch( line ) )
							{
								allwarnings += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								warnmsg += string.Format( "{0}{1}.", newline, message );
								errinline = true;
							}
						}
					}
				}
				else
				{
					pattern = @"!\w{1,16}!";
					regex = new Regex( pattern );
					if ( regex.IsMatch( line ) )
					{
						// Skip warning if line is a comment
						if ( !new Regex( @"^\s*(REM($|\s)|::)", ignorecase ).IsMatch( line ) )
						{
							if ( delayedvarglobal )
							{
								message = string.Format( "\"{0}\" looks like a delayed variable, check if delayed variable expansion is enabled", regex.Match( line ).Value.ToUpper( ) );
								allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								badprmsg += string.Format( "{0}{1}.", newline, message );
							}
							else
							{
								message = string.Format( "\"{0}\" looks like a delayed variable, but delayed variable expansion is not enabled", regex.Match( line ).Value.ToUpper( ) );
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
							}
							errinline = true;
						}
					}
				}

				#endregion Delayed variables without delayed expansion

				// Excess number of delimiters in FOR /F loop
				#region Too many delimiters

				pattern = @"(?<!\w)FOR\s+/F\s+\""(?:[^""]+\s)?delims=([^\s\)\""]{5,})(?:\s[^""]+)?\""";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string delims = regex.Match( line ).Groups[1].ToString( );
					List<char> nodups = new List<char>( );
					foreach ( char del in delims )
					{
						if ( !nodups.Contains( del ) )
						{
							nodups.Add( del );
						}
					}
					if ( nodups.Count == delims.Length )
					{
						message = string.Format( "Found {0} delimiters in a FOR /F loop: \"{1}\". Are you trying to split a string on a WORD? The value of \"delims\" is a CHARACTER array, each individual character is a delimiter", delims.Length, delims, delims.Length - nodups.Count );
						alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						tipsmsg += string.Format( "{0}{1}.", newline, message );
					}
					else
					{
						message = string.Format( "Found {0} delimiters in a FOR /F loop: \"{1}\" (including {2} duplicates). Are you trying to split a string on a WORD? The value of \"delims\" is a CHARACTER array, each individual character is a delimiter", delims.Length, delims, delims.Length - nodups.Count );
						allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						errormsg += string.Format( "{0}{1}.", newline, message );
					}
					errinline = true;
				}
				else
				{
					pattern = @"(?<!\w)FOR\s+/F\s+\""(?:[^""]+\s)?delims=([^\s\)\""]+)(?:\s[^""]+)?\""";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						string delims = regex.Match( line ).Groups[1].ToString( );
						List<char> nodups = new List<char>( );
						foreach ( char del in delims )
						{
							if ( !nodups.Contains( del ) )
							{
								nodups.Add( del );
							}
						}
						if ( delims.Length > nodups.Count )
						{
							message = string.Format( "Found {0} duplicate delimiters (delims={1}) in a FOR /F loop", delims.Length - nodups.Count, delims );
							allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
							errormsg += string.Format( "{0}{1}.", newline, message );
							errinline = true;
						}
					}
				}

				#endregion Too many delimiters

				// Wildcards in IF comparison
				#region Wildcards in IF comparison

				pattern = @"\bIF\s+(?:/I\s+)?(?:NOT\s+)?\""%\w{1,16}%\""\s*==\s*\""[^""\*\?]*[\*\?]";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = "Wildcard character(s) found in IF comparison; IF \"%var%\"==\"literal_string\" does not accept wildcards; though asterisks and exclamation marks CAN be valid literals, make sure you did not try to apply them as wildcards";
					alltips += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					tipsmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion Wildcards in IF comparison

				// Undefined variables
				#region Undefined variables

				// Skip this test if variable is inside comment
				pattern = @"^\s*(::|REM\s)";
				regex = new Regex( pattern, ignorecase );
				if ( !regex.IsMatch( line ) )
				{
					// This regex pattern catches "straight" variables as well as "nested" ones
					pattern = @"((?<!%)%{1,2}|(?:\^!)?!)([\w\.-]{1," + maxvarlen + @"})(\1|:)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						MatchCollection matches = regex.Matches( line );
						foreach ( Match match in matches )
						{
							string envvar = match.Groups[2].ToString( );
							if ( !upcaseenvvars.Contains( envvar.ToUpper( ) ) )
							{
								if ( !envvarerrors.Contains( envvar.ToUpper( ) ) )
								{
									envvarerrors.Add( envvar.ToUpper( ) );
								}
								if ( includelocalvars || !localenvvars.Contains( envvar.ToUpper( ) ) )
								{
									if ( mysteryvars > 0 )
									{
										if ( mysteryvars == 1 )
										{
											message = string.Format( "No SET statement found setting variable \"{0}\"; however, a line was found setting a nested variable, which could account for this program's inability to find the SET statement for this particular variable", envvar );
										}
										else
										{
											message = string.Format( "No SET statement found setting variable \"{0}\"; however, lines were found setting nested variables, which could account for this program's inability to find the SET statement for this particular variable", envvar );
										}
										allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
										badprmsg += string.Format( "{0}{1}.", newline, message );
									}
									else
									{
										message = string.Format( "Undefined variable \"{0}\"", envvar );
										allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
										errormsg += string.Format( "{0}{1}.", newline, message );
									}
								}
								else
								{
									message = string.Format( "Variable \"{0}\" is never set in the batch file; however, the variable IS set in this computer's local environment. Use BatCodeCheck's \"/E\" switch to include the local environment variables", envvar );
									allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
									badprmsg += string.Format( "{0}{1}.", newline, message );
								}
								errinline = true;
							}
						}
					}
				}

				#endregion Undefined variables

				// count SETLOCAL and ENDLOCAL pairs
				#region SETLOCAL ENDLOCAL pairs

				pattern = @"^\s*SETLOCAL\b";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					setlocal += 1;
				}
				if ( setlocal > 1 )
				{
					message = "Found a nested SETLOCAL";
					if ( allwarnings.IndexOf( message ) > -1 )
					{
						allwarnings += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						warnmsg += string.Format( "{0}{1}.", newline, message );
					}
					errinline = true;
				}

				pattern = @"^\s*ENDLOCAL\b";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					setlocal -= 1;
				}
				if ( setlocal < 0 )
				{
					message = "Number of ENDLOCALs exceeds number of SETLOCALs";
					allwarnings += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					warnmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}

				#endregion SETLOCAL ENDLOCAL pairs

				// Whitespace and equal signs in IF statements
				#region Whitespace and equal signs in IF statements

				pattern = @"(^|\b)IF\s+(/I\s+)?(?:\w+|\""[^""]+\"")\s*==?\s*(?:\w+|\""[^""]+\"")\s*[\(\w]";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					// Single equal sign
					pattern = @"(^|\b)IF\s+(/I\s+)?(?:\w+|\""[^""]+\"")\s*=\s*(?:\w+|\""[^""]+\"")\s*[\(\w]";
					regex = new Regex( pattern, RegexOptions.IgnoreCase );
					if ( regex.IsMatch( line ) )
					{
						message = "Single equal sign in IF statement, where a double equal sign is required";
						allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						errormsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
					// Whitespace before code block
					pattern = @"(?:^|\b)(IF\s+(/I\s)?\s*(\w+|\""[^""]+\"")\s*==?\s*(\w+|\""[^""]+\"")\()";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						MatchCollection matches = regex.Matches( line );
						string wrong = matches[0].ToString( );
						string correct = string.Format( "IF {0}{1}=={2} (", matches[0].Groups[2].ToString( ).ToUpper( ), matches[0].Groups[3].ToString( ), matches[0].Groups[4].ToString( ) );
						message = string.Format( "Insert whitespace after the IF comparison, before the opening parenthesis of the code block: {0}...) instead of {1}...)", correct, wrong );
						allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						errormsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
				}

				#endregion Whitespace and equal signs in IF statements
			}
		}


		public static void CheckVulnerabilities( string line )
		{
			if ( checkall || checkvulnr )
			{
				string pattern;
				Regex regex;

				// Unquoted %CD% code insertion vulnerability
				#region Code insertion
				if ( !incomment )
				{
					pattern = @"[^""%!](([%!])(CD|__CD__)(:~\d+(,\d+)?|:[^\2\n\r]+=[^\2\n\r]*)?\2)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						string cd = regex.Match( line ).Groups[1].ToString( ).ToUpper( );
						message = string.Format( "Unquoted {0} makes the code vulnerable to code insertion (see http://www.thesecurityfactory.be/command-injection-windows.html)", cd );
						allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						badprmsg += string.Format( "{0}{1}.", newline, message );
						errinline = true;
					}
					else
					{
						pattern = @"[^""](([%!])([%!])(CD|__CD__)(:~\d+(,\d+)?|:[^\2\3\n\r]+=[^\2\3\n\r]*)?\3\2)";
						regex = new Regex( pattern, ignorecase );
						if ( regex.IsMatch( line ) )
						{
							string cd = regex.Match( line ).Groups[1].ToString( ).ToUpper( );
							message = string.Format( "Unquoted {0} makes the code vulnerable to code insertion (see http://www.thesecurityfactory.be/command-injection-windows.html)", cd );
							allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
							badprmsg += string.Format( "{0}{1}.", newline, message );
							errinline = true;
						}
					}
				}
				#endregion Code insertion

				// SET /P vulnerability
				#region SET /P

				pattern = @"(^|\b)SET\s+/P\s+""?\w{1,16}\s*=";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = "SET /P could make your code vulnerable to exploits (see http://www.robvanderwoude.com/battech_inputvalidation.php#SetP)";
					allbadpr += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					badprmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}


				#endregion SET /P
			}
		}


		public static void CloseHTML( )
		{
			if ( log2html )
			{
				htmlstream.WriteLine( "</span>" );
				htmlstream.WriteLine( );
				htmlstream.WriteLine( "</pre>" );
				htmlstream.WriteLine( "</body>" );
				htmlstream.Write( "</html>" );
				htmlstream.Close( );
				htmlopen = false;
			}
		}


		public static void CollectEnvironmentVariables( )
		{
			string pattern;
			Regex regex;

			// Static system environment variables
			foreach ( string envvar in sysvarpattern.Split( '|' ) )
			{
				//envvars.Add( envvar, 0 );
				envvars[envvar] = 0;
				upcaseenvvars.Add( envvar.ToUpper( ) );
			}

			// Dynamic system environment variables
			foreach ( string envvar in dynvarpattern.Split( '|' ) )
			{
				//envvars.Add( envvar, 0 );
				envvars[envvar] = 0;
				upcaseenvvars.Add( envvar.ToUpper( ) );
			}

			// Environment variables SET in the source code with "plain" SET statement
			pattern = @"(?:^|\b)SET\s+(\w{1," + maxvarlen + @"})=";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( allsrc_nocomments ) )
			{
				foreach ( Match match in regex.Matches( allsrc_nocomments ) )
				{
					if ( !upcaseenvvars.Contains( match.Groups[1].ToString( ).ToUpper( ) ) )
					{
						//envvars.Add( match.Groups[1].ToString( ), 0 );
						envvars[match.Groups[1].ToString( )] = 0;
						upcaseenvvars.Add( match.Groups[1].ToString( ).ToUpper( ) );
					}
				}
			}

			// Environment variables SET in the source code with SET /A or SET /P statement
			pattern = @"(?:^|\b)SET\s+(?:/[AP]\s+)?""?(\w{1," + maxvarlen + @"})\s*=";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( allsrc_nocomments ) )
			{
				foreach ( Match match in regex.Matches( allsrc_nocomments ) )
				{
					if ( !upcaseenvvars.Contains( match.Groups[1].ToString( ).ToUpper( ) ) )
					{
						//envvars.Add( match.Groups[1].ToString( ), 0 );
						envvars[match.Groups[1].ToString( )] = 0;
						upcaseenvvars.Add( match.Groups[1].ToString( ).ToUpper( ) );
					}
				}
			}

			// Take into account lines like SET %%A or SET %Var%=...
			pattern = @"(^|\b)\s*SET\s+[%!]";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( allsrc_nocomments ) )
			{
				MatchCollection matches = regex.Matches( allsrc_nocomments );
				mysteryvars = matches.Count;
			}

			// Include local environment variables if /E command line switch was used
			if ( includelocalvars )
			{
				foreach ( string envvar in Environment.GetEnvironmentVariables( ).Keys )
				{
					if ( !upcaseenvvars.Contains( envvar ) )
					{
						//envvars.Add( envvar, 0 );
						envvars[envvar] = 0;
						upcaseenvvars.Add( envvar.ToUpper( ) );
					}
				}
			}

			// Check how often a variable is used
			string[] envvarskeys = envvars.Keys.ToArray( );
			foreach ( string envvar in envvarskeys )
			{
				string substringpattern = @"~\-?\d+(,\d+)?";
				string replacepattern = @"[^\1\=]{1,127}=[^\1\=]";
				pattern = string.Format( @"(%|!){0}(\:({1}|{2}))\1", envvar, substringpattern, replacepattern );
				regex = new Regex( pattern, ignorecase );
				int used = regex.Matches( allsrc_nocomments ).Count;
				envvars[envvar] = used;
			}

			// All loacal environment variables
			foreach ( string envvar in Environment.GetEnvironmentVariables( ).Keys )
			{
				if ( !localenvvars.Contains( envvar.ToUpper( ) ) )
				{
					localenvvars.Add( envvar.ToUpper( ) );
				}
			}
		}


		public static void CollectLabels( )
		{
			string pattern;
			Regex regex;

			pattern = @"(?:^|\n|\r)\s*:([\w\.\[\]/+\-\(\)\{\}]{1,127})";
			regex = new Regex( pattern );
			if ( regex.IsMatch( allsrc_nocomments ) )
			{
				foreach ( Match match in regex.Matches( allsrc_nocomments ) )
				{
					string label = match.Groups[1].ToString( );
					// Find the number of GOTOs to this label
					pattern = string.Format( @"(?<=^|\s|\b|\()GOTO[ \t]+:?{0}(?=\n|\r|[ \t]+[\n\r]|\)|$)", label );
					regex = new Regex( pattern, ignorecase );
					int jumps = regex.Matches( allsrc_nocomments ).Count;
					//labels.Add( label, jumps );
					labels[label] = jumps;
					upcaselabels.Add( label.ToUpper( ) );
				}
			}
		}


		public static void CollectSubroutines( )
		{
			// For each label, check if it is a subroutine label
			foreach ( string label in labels.Keys )
			{
				if ( subroutines.IndexOfKey( label ) == -1 )
				{
					string pattern = string.Format( @"(?=\n|\r|^)\s*:{0}\s*[\n\r]+(?:[ \t]*(?:[^\:\s]|\:\:)[^\n\r]*[\n\r]+)*[ \t]*($|GOTO[ \t]*:EOF[ \t]*(?=\n|\r|\)|&|$))", label );
					Regex regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( allsrc_nocomments ) )
					{
						MatchCollection matches = regex.Matches( allsrc_nocomments );
						foreach ( Match match in matches )
						{
							string pattern2 = @"(?=\n|\r|^)\s*:([\w\.\[\]/+\-\(\)\{\}]{1,127})(?=\n|\r|\s|$)";
							Regex regex2 = new Regex( pattern2, ignorecase );
							string match2 = match.Groups[1].ToString( );
							if ( !regex2.IsMatch( match2 ) )
							{
								//subroutines.Add( label, 0 );
								subroutines[label] = 0;
							}
						}
					}
				}
			}

			// Find the number of CALLs to each subroutine
			foreach ( string subroutine in subroutines.Keys )
			{
				string pattern = string.Format( @"(?<=^|\n|\r|\s|\b|&\()CALL[ \t]+:{{0}}(?=\n|\r|\s|\b|&|\)|$)" );
				Regex regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( allsrc_nocomments ) )
				{
					MatchCollection matches = regex.Matches( allsrc_nocomments );
					subroutines[subroutine] = matches.Count;
				}
			}
		}


		public static string ConsoleColor2CSSColor( ConsoleColor color )
		{
			return ConsoleColor2CSSColor( color.ToString( ) );
		}


		public static string ConsoleColor2CSSColor( string color )
		{
			string csscolor = color.ToLower( );
			switch ( csscolor )
			{
				case "darkyellow": // darkyellow is not a valid CSS value, reported and fixed by Alfons van Zwol
					csscolor = "#808000";
					break;
			}
			return csscolor;
		}


		public static void CreateHTML( )
		{
			if ( log2html )
			{
				htmlstream = new StreamWriter( htmlfile );
				htmlopen = true;
				htmlstream.WriteLine( "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">" );
				htmlstream.WriteLine( "<html>" );
				htmlstream.WriteLine( "<head>" );
				htmlstream.WriteLine( "<title>BatCodeCheck Version {0} report for {1}</title>", progver, Path.GetFileName( source ) );
				htmlstream.WriteLine( "<style type=\"text/css\">" );
				htmlstream.WriteLine( "body" );
				htmlstream.WriteLine( "{" );
				htmlstream.WriteLine( "\tbackground-color: {0};", windowbgcolor.ToString( ).ToLower( ) );
				htmlstream.WriteLine( "\tcolor: {0};", windowfgcolor.ToString( ).ToLower( ) );
				htmlstream.WriteLine( "}" );
				htmlstream.WriteLine( "</style>" );
				htmlstream.WriteLine( "</head>" );
				htmlstream.WriteLine( "<body>" );
				htmlstream.WriteLine( "<pre>" );
				htmlstream.WriteLine( "<span style=\"color: white;\">Time      :  {0}", DateTime.Now.ToString( "yyyy-MM-dd HH:mm:ss" ) );
				htmlstream.WriteLine( "Program   :  BatCodeCheck, Version {0}", progver );
				htmlstream.WriteLine( "Arguments :  {0}", allargs );
				htmlstream.WriteLine( "File name :  \"{0}\"", Path.GetFullPath( source ) );
				htmlstream.Write( "File date :  {0}", File.GetLastWriteTime( source ).ToString( "yyyy-MM-dd HH:mm:ss" ) );
				if ( envvarerrors.Count > 0 )
				{
					htmlstream.Write( "\nLocal environment variables are {1}", ( includelocalvars ? "included" : "ignored" ) );
				}
				htmlstream.WriteLine( "</span>\n" );
			}
		}


		public static void DisplayLineNumber( int num )
		{
			if ( dispnums )
			{
				Console.BackgroundColor = linenumbgcolor;
				Console.ForegroundColor = linenumfgcolor;
				if ( num == lastline )
				{
					Console.Write( "{0,4} ", string.Empty );
					WriteLineHTML( string.Format( "{0,4} ", string.Empty ) );
				}
				else
				{
					Console.Write( "{0,4} ", num );
					WriteLineHTML( string.Format( "{0,4} ", num ) );
				}
				Console.ResetColor( );
				Console.BackgroundColor = windowbgcolor;
				Console.ForegroundColor = windowfgcolor;
				lastline = num;
			}
		}


		public static void DisplayMessagesPerLine( string line )
		{
			bool padline = true;
			string blankline = new String( ' ', Console.WindowWidth );
			string msgline;

			if ( errinline )
			{
				if ( lasterrline != linenum )
				{
					lineswitherrors += 1;
				}
				foreach ( string error in errormsg.Split( "\n\r".ToCharArray( ) ) )
				{
					if ( !String.IsNullOrWhiteSpace( error ) )
					{
						if ( wrap )
						{
							msgline = WordWrap( ( error ).Replace( "\t", " ERROR:   " ), padline );
						}
						else
						{
							msgline = ( error + blankline ).Replace( "\t", " ERROR:   " ).Substring( 0, Console.WindowWidth - 1 );
						}
						Console.BackgroundColor = errorbgcolor;
						Console.ForegroundColor = errorfgcolor;
						Console.Write( msgline );
						WriteLineHTML( msgline );
						Console.ResetColor( );
						Console.WriteLine( );
					}
				}
				foreach ( string warning in warnmsg.Split( "\n\r".ToCharArray( ) ) )
				{
					if ( !String.IsNullOrWhiteSpace( warning ) )
					{
						if ( wrap )
						{
							msgline = WordWrap( ( warning ).Replace( "\t", " WARNING: " ), padline );
						}
						else
						{
							msgline = ( warning + blankline ).Replace( "\t", " WARNING: " ).Substring( 0, Console.WindowWidth - 1 );
						}
						Console.BackgroundColor = warningbgcolor;
						Console.ForegroundColor = warningfgcolor;
						Console.Write( msgline );
						WriteLineHTML( msgline );
						Console.ResetColor( );
						Console.WriteLine( );
					}
				}
				foreach ( string badpractice in badprmsg.Split( "\n\r".ToCharArray( ) ) )
				{
					if ( !String.IsNullOrWhiteSpace( badpractice ) )
					{
						if ( wrap )
						{
							msgline = WordWrap( ( badpractice ).Replace( "\t", " WARNING: " ), padline );
						}
						else
						{
							msgline = ( badpractice + blankline ).Replace( "\t", " WARNING: " ).Substring( 0, Console.WindowWidth - 1 );
						}
						Console.BackgroundColor = badprbgcolor;
						Console.ForegroundColor = badprfgcolor;
						Console.Write( msgline );
						WriteLineHTML( msgline );
						Console.ResetColor( );
						Console.WriteLine( );
					}
				}
				foreach ( string tip in tipsmsg.Split( "\n\r".ToCharArray( ) ) )
				{
					if ( !String.IsNullOrWhiteSpace( tip ) )
					{
						if ( wrap )
						{
							msgline = WordWrap( ( tip ).Replace( "\t", " TIP:     " ), padline );
						}
						else
						{
							msgline = ( tip + blankline ).Replace( "\t", " TIP:     " ).Substring( 0, Console.WindowWidth - 1 );
						}
						Console.BackgroundColor = tipsbgcolor;
						Console.ForegroundColor = tipsfgcolor;
						Console.Write( msgline );
						WriteLineHTML( msgline );
						Console.ResetColor( );
						Console.WriteLine( );
					}
				}
				errinline = false;
				lasterrline = linenum;
				rc = linenum;
			}
		}


		public static void DisplayMessagesSummary( )
		{
			// Summary
			if ( lineswitherrors == 1 )
			{
				allerrsum += string.Format( "{0}1   line generated a warning and should be examined", newline );
			}
			if ( lineswitherrors > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} lines generated warnings and should be examined", newline, lineswitherrors );
			}
			// Unterminated %
			if ( unterminatedpercentsigns == 1 )
			{
				allerrsum += string.Format( "{0}1   unterminated percent sign was found", newline );
			}
			if ( unterminatedpercentsigns > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} unterminated percent signs were found", newline, unterminatedpercentsigns );
			}
			// Unterminated !
			if ( unterminatedexclamations == 1 )
			{
				allerrsum += string.Format( "{0}1   unterminated exclamation mark was found while delayed variable expansion was enabled", newline );
			}
			if ( unterminatedexclamations > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} unterminated exclamation marks were found while delayed variable expansion was enabled", newline, unterminatedexclamations );
			}
			// Unterminated "
			if ( unterminateddoublequotes == 1 )
			{
				allerrsum += string.Format( "{0}1   unterminated doublequote was found", newline );
			}
			if ( unterminateddoublequotes > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} unterminated doublequotes were found", newline, unterminateddoublequotes );
			}
			// Unterminated '
			if ( unterminatedsinglequotes == 1 )
			{
				allerrsum += string.Format( "{0}1   unterminated singlequote was found in a FOR /F loop", newline );
			}
			if ( unterminatedsinglequotes > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} unterminated singlequotes were found in FOR /F loops", newline, unterminatedsinglequotes );
			}
			// Undefined environment variables
			string ignoredmsg = ( includelocalvars ? string.Empty : " (ignoring local environment variables)" );
			if ( envvarerrors.Count == 1 )
			{
				allerrsum += string.Format( "{0}1   undefined variable was detected{1}: {2}", newline, ignoredmsg, envvarerrors[0] );
			}
			if ( envvarerrors.Count > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} undefined variables were detected{2}: {3}", newline, envvarerrors.Count, ignoredmsg, string.Join( ", ", envvarerrors ) );
			}
			// Undefined labels
			if ( gotoerrors.Count == 1 )
			{
				allerrsum += string.Format( "{0}1   label was missing: {1}", newline, gotoerrors[0] );
			}
			if ( gotoerrors.Count > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} labels were missing: {2}", newline, gotoerrors.Count, string.Join( ", ", gotoerrors ) );
			}
			// Undefined subroutines
			if ( callerrors.Count == 1 )
			{
				allerrsum += string.Format( "{0}1   subroutine label was missing (note that subroutine labels are case sensitive): {1}", newline, callerrors[0] );
			}
			if ( callerrors.Count > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} subroutine labels were missing (note that subroutine labels are case sensitive): {2}", newline, callerrors.Count, string.Join( ", ", callerrors ) );
			}
			// Obsolete commands
			if ( obsoletecmd == 1 )
			{
				allerrsum += string.Format( "{0}1   obsolete or 16-bit command was found", newline );
			}
			if ( obsoletecmd > 1 )
			{
				allerrsum += string.Format( "{0}{1,-3} obsolete and/or 16-bit commands were found", newline, obsoletecmd );
			}
			// Unterminated parentheses
			if ( parenthesis > 0 )
			{
				allerrsum += string.Format( "{0}Opening parenthesis outnumber closing parenthesis by {1}", newline, parenthesis );
			}
			if ( parenthesis < 0 )
			{
				allerrsum += string.Format( "{0}Closing parenthesis outnumber opening parenthesis by {1}", newline, Math.Abs( parenthesis ) );
			}
			// Unterminated SETLOCALs
			if ( setlocal > 0 )
			{
				allerrsum += string.Format( "{0}SETLOCALs outnumber ENDLOCALs by {1}", newline, setlocal );
			}
			if ( setlocal < 0 )
			{
				allerrsum += string.Format( "{0}ENDLOCALs outnumber SETLOCALs by {1}", newline, Math.Abs( setlocal ) );
			}

			// Display warnings if applicable
			if ( !String.IsNullOrWhiteSpace( allerrors ) )
			{
				allerrors = string.Format( "{0}ERRORS / VULNERABILITIES:{1}{0}", newline, allerrors );
			}
			if ( !String.IsNullOrWhiteSpace( allwarnings ) )
			{
				allerrors = string.Format( "{0}{1}WARNINGS:{2}{1}", allerrors, newline, allwarnings );
			}
			if ( !String.IsNullOrWhiteSpace( allbadpr ) )
			{
				allerrors = string.Format( "{0}{1}RISKY CODE:{2}{1}", allerrors, newline, allbadpr );
			}
			if ( !String.IsNullOrWhiteSpace( alltips ) )
			{
				allerrors = string.Format( "{0}{1}TIPS / BEST PRACTICES:{2}{1}", allerrors, newline, alltips );
			}
			if ( !String.IsNullOrWhiteSpace( allerrsum ) )
			{
				allerrors = string.Format( "{0}{1}SUMMARY:{2}{1}", allerrors, newline, allerrsum );
			}

			Console.Write( VerboseSummary( ) );

			if ( !String.IsNullOrEmpty( allerrors ) )
			{
				allerrors += string.Format( "{0}{0}Note that some warnings are only displayed once. Correct the errors and run this test again.", newline );
				Console.ResetColor( );
				Console.WriteLine( newline );
				Console.WriteLine( "Time      :  {0}", DateTime.Now.ToString( "yyyy-MM-dd HH:mm:ss" ) );
				Console.WriteLine( "Program   :  BatCodeCheck, Version {0}", progver );
				Console.WriteLine( "Arguments :  {0}", allargs );
				Console.WriteLine( "File name :  \"{0}\"", Path.GetFullPath( source ) );
				Console.WriteLine( "File date :  {0}", File.GetLastWriteTime( source ).ToString( "yyyy-MM-dd HH:mm:ss" ) );
				if ( envvarerrors.Count > 0 )
				{
					Console.WriteLine( "Local environment variables are {0}", ( includelocalvars ? "included" : "ignored" ) );
				}
				Console.WriteLine( );
				Console.BackgroundColor = reportbgcolor;
				Console.ForegroundColor = reportfgcolor;
				if ( wrap )
				{
					string[] all_errors = allerrors.Split( "\n\r".ToCharArray( ) );
					foreach ( string all_err in all_errors )
					{
						Console.WriteLine( WordWrap( all_err, false ) );
					}
				}
				else
				{
					Console.WriteLine( allerrors );
				}
				WriteLineHTML( allerrors );
				Console.ResetColor( );
				Console.WriteLine( );
				rc = Math.Max( 1, rc );
				if ( logging )
				{
					StreamWriter log = new StreamWriter( logfile, !replacelog );
					log.WriteLine( "Time      :  {0}", DateTime.Now.ToString( "yyyy-MM-dd HH:mm:ss" ) );
					log.WriteLine( "Program   :  BatCodeCheck, Version {0}", progver );
					log.WriteLine( "Arguments :  {0}", allargs );
					log.WriteLine( "File name :  \"{0}\"", Path.GetFullPath( source ) );
					log.WriteLine( "File date :  {0}", File.GetLastWriteTime( source ).ToString( "yyyy-MM-dd HH:mm:ss" ) );
					if ( envvarerrors.Count > 0 )
					{
						log.WriteLine( "Local environment variables are {0}", ( includelocalvars ? "included" : "ignored" ) );
					}
					log.WriteLine( "{0}{1}{1}", allerrors, newline );
					log.Close( );
				}
			}
		}


		public static string EscapedHTML( char chr )
		{
			switch ( chr )
			{
				case '&':
					return "&amp;";
				case '>':
					return "&gt;";
				case '<':
					return "&lt;";
				default:
					return chr.ToString( );
			}
		}


		public static List<string> ListInternalCommands( )
		{
			string comspec = Environment.GetEnvironmentVariable( "COMSPEC" );
			StreamReader file = new StreamReader( comspec, Encoding.ASCII );
			string content = file.ReadToEnd( );
			file.Close( );

			List<string> intcmds = new List<string>( );
			string excludelist = "ABOVENORMAL,AFFINITY,ANSI,APPICON,ASCII,AZ,BAT,BELOWNORMAL,BOTH,CMD,CMDCMDLINE,CMDEXTVERSION,COM,COMSPEC,CONFIG,COPYCMD,COPYRIGHT,CRLF,CSVFS,CTRL,CURRENT,DEFINED,DIRCMD,DISABLEDELAYEDEXPANSION,DISABLEEXTENSIONS,DLL,DO,DOC,DOS,DWORD,ENABLEDELAYEDEXPANSION,ENABLEEXTENSIONS,ELSE,ENTER,EOF,EQU,ERROR,ERRORLEVEL,EXE,EXIST,EXISTS,EXPAND,FALSE,FAT,FH,GEQ,GTR,GUI,HIGH,HIGHESTNUMANODENUMBER,HH,HKEY,HSM,IDI,IDLE,IN,INFO,IS,JS,KERNEL,LEQ,LIST,LNK,LOCAL,LOW,LSS,MACHINE,MAX,MIN,MM,MSC,MUI,NEQ,NODE,NORMAL,NOT,NT,NTDLL,NTFS,NY,NYA,OFF,ON,OTHER,PATHEXT,PROCESSING,RANDOM,REALTIME,REFS,REG,REGEDT,SCRIPT,SEPARATE,SHARED,STACK,SYS,SZ,TEMP,TWO,UNC,UNCC,UNKNOWN,US,USER,VAR,VBS,VERSION,VS,WAIT,WA,WC,WD,WINDOWS,WKERNEL,WORD,WP,WS,WV,XCOPY,XP";
			List<string> exclude = excludelist.Split( ",".ToCharArray( ) ).ToList<string>( );

			string pattern = @"([A-Z]\0){2,}";
			Regex regex = new Regex( pattern );
			if ( regex.IsMatch( content ) )
			{
				foreach ( Match match in regex.Matches( content ) )
				{
					string intcmd = match.ToString( ).Replace( "\0", string.Empty );
					if ( !exclude.Contains( intcmd ) && !intcmds.Contains( intcmd ) )
					{
						intcmds.Add( intcmd );
					}
				}
				intcmds.Sort( );
			}
			if ( intcmds.Count == 0 )
			{
				// Return a default list if we could not find the internal commands in %COMSPEC%
				string defaultinternalcommands = @"ASSOC|BREAK|CALL|CD|CHDIR|CLS|COLOR|COPY|DATE|DEL|DIR|DPATH|ECHO|ENDLOCAL|ERASE|EXIT|FOR|FTYPE|GOTO|IF|KEYS|MD|MKDIR|MKLINK|MOVE|PATH|PAUSE|POPD|PROMPT|PUSHD|RD|REM|REN|RENAME|RMDIR|SET|SETLOCAL|SHIFT|START|TIME|TITLE|TYPE|VER|VERIFY|VOL";
				intcmds = defaultinternalcommands.Split( "|".ToCharArray( ), StringSplitOptions.RemoveEmptyEntries ).ToList<string>( );
			}
			return intcmds;
		}


		public static int OpenHTMLFile( )
		{
			if ( openhtml )
			{
				try
				{
					if ( File.Exists( htmlfile ) )
					{
						Process.Start( htmlfile );
					}
					else
					{
						return ShowHelp( string.Format( "Cannot find HTML log file \"{0}\"", htmlfile ) );
					}
				}
				catch ( Exception e )
				{
					return ShowHelp( e.Message );
				}
			}
			return 0;
		}


		public static int OpenLogFile( )
		{
			if ( openlog )
			{
				try
				{
					if ( File.Exists( logfile ) )
					{
						Process.Start( logfile );
					}
					else
					{
						return ShowHelp( string.Format( "Cannot find ASCII log file \"{0}\"", logfile ) );
					}
				}
				catch ( Exception e )
				{
					return ShowHelp( e.Message );
				}
			}
			return 0;
		}


		public static void ParseLine( string line )
		{
			string nocomments = StripComments( line );
			ResetInlineVariables( );
			DisplayLineNumber( linenum );
			CheckCommonMistakes( nocomments );
			CheckCommandLineArguments( nocomments );
			CheckBadPractices( nocomments );
			CheckBestPractices( nocomments );
			ParseLineAndHighlight( line );
			CheckVulnerabilities( nocomments );
			DisplayMessagesPerLine( line );
		}


		public static void ParseLineAndHighlight( string line )
		{
			// Comments are highlighted and not interpreted at all.
			// This may spell trouble in case of multiple commands on a single line.
			if ( new Regex( @"^\s*(REM($|\s)|::)", ignorecase ).IsMatch( line ) )
			{
				string match = new Regex( @"^(\s*(REM($|\s)|::))", ignorecase ).Match( line ).ToString( );
				Console.ForegroundColor = intcmdfgcolor;
				Console.Write( match );
				WriteSpanHTML( match );
				Console.ForegroundColor = commentfgscolor;
				line = line.Substring( match.Length );
				Console.WriteLine( line );
				WriteSpanHTML( line );
				Console.ResetColor( );
			}
			// do not highlight ECHO ON or ECHO OFF as ECHOed text
			else if ( new Regex( @"^\s*@?ECHO\s+(ON|OFF)\s*$", ignorecase ).IsMatch( line ) )
			{
				Console.ResetColor( );
				Console.WriteLine( line );
				WriteSpanHTML( line );
			}
			// check if delayed variable expansion is enabled (will choke on nested SETLOCALs)
			else if ( new Regex( @"^\s*SETLOCAL\s+((EN|DIS)ABLEEXTENSIONS\s+)?ENABLEDELAYEDEXPANSION(\b|$)", ignorecase ).IsMatch( line ) )
			{
				delayedvarexp = true;
				delayedvarglobal = true;
				Console.ResetColor( );
				Console.WriteLine( line );
				WriteSpanHTML( line );
			}
			// check if delayed variable expansion is disabled (will choke on nested SETLOCALs)
			else if ( new Regex( @"^\s*ENDLOCAL\b", ignorecase ).IsMatch( line ) )
			{
				delayedvarexp = false;
				Console.ResetColor( );
				Console.WriteLine( line );
				WriteSpanHTML( line );
			}
			else
			{
				// ParseLinePerCharacter( line );
				ParseLinePerCharacter2( line );
			}
		}


		public static void ParseLinePerCharacter( string line )
		{
			#region Initialize Inline Variables

			string part = string.Empty;
			string buildword = string.Empty;
			string lastword = string.Empty;
			int doublequotes = 0;
			int singlequotes = 0;
			bool doublepercent = false;
			bool doublequoted = false;
			bool echoed = false;
			bool escnext = false;
			bool forfloop = false;
			bool inexcl = false;
			bool inperc = false;
			bool isparenthesis = false;
			bool redirection = false;
			bool singlequoted = false;
			bool tempdblquoted = false;
			bool tempinexcl = false;
			bool tempinperc = false;
			bool tempsngquoted = false;
			bool tildestr = false;

			#endregion Initialize Inline Variables

			// check if inside a FOR /F loop
			forfloop = new Regex( @"(^\s*|\b|\(|\&)FOR\s+/F\s", ignorecase ).IsMatch( line );

			char prevchr = ' ';
			int index = -1;

			foreach ( char chr in line )
			{
				index += 1;

				#region Character Type

				switch ( chr )
				{
					case '"':
						doublequoted = ( doublequoted ^ !escnext ) && !echoed;
						if ( !escnext && !echoed )
						{
							doublequotes += 1;
						}
						doublepercent = false;
						escnext = false;
						inexcl = false;
						inperc = false;
						redirection = false;
						tildestr = false;
						break;
					case (char) 39:
						singlequoted = ( singlequoted ^ !escnext ) && !echoed;
						if ( !escnext && !echoed && !doublequoted )
						{
							singlequotes += 1;
						}
						doublepercent = false;
						escnext = false;
						inexcl = false;
						inperc = false;
						redirection = false;
						tildestr = false;
						break;
					case '^':
						doublepercent = false;
						escnext = ( prevchr != chr );
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case '%':
						if ( prevchr == '%' )
						{
							doublepercent = true;
						}
						else
						{
							doublepercent = false;
							inperc = !inperc;
						}
						escnext = false;
						inexcl = false;
						redirection = false;
						tildestr = false;
						break;
					case '!':
						if ( delayedvarexp )
						{
							inexcl = !inexcl;
						}
						doublepercent = false;
						escnext = false;
						inperc = false;
						redirection = false;
						tildestr = false;
						break;
					case '~':
						if ( prevchr == '%' )
						{
							inperc = false;
							tildestr = true;
						}
						else if ( prevchr == '!' )
						{
							inexcl = false;
							tildestr = true;
						}
						escnext = false;
						redirection = false;
						break;
					case '&':
						if ( prevchr == chr )
						{
							doublequoted = false;
							echoed = false;
							inperc = false;
							redirection = false;
						}
						else
						{
							redirection = !escnext;
						}
						if ( singlequoted && redirection )
						{
							message = "Unescaped ampersand(s) in singlequoted text (FOR /F loop" + ( forfloop ? string.Empty : "?" ) + ")";
							if ( errormsg.IndexOf( message ) > -1 )
							{
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
							}
							errinline = true;
						}
						doublepercent = false;
						escnext = false;
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case '|':
						if ( prevchr == chr )
						{
							doublequoted = false;
							echoed = false;
							inperc = false;
							redirection = false;
						}
						else
						{
							redirection = !escnext;
						}
						if ( singlequoted && redirection )
						{
							message = "Unescaped pipe symbol(s) in singlequoted text (FOR /F loop" + ( forfloop ? string.Empty : "?" ) + ")";
							if ( errormsg.IndexOf( message ) > -1 )
							{
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
							}
							errinline = true;
						}
						doublepercent = false;
						escnext = false;
						echoed = false;
						incomment = false;
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case '>':
						redirection = !escnext;
						if ( singlequoted && redirection )
						{
							message = "Unescaped \"greater than\" symbol(s) in singlequoted text (FOR /F loop" + ( forfloop ? string.Empty : "?" ) + ")";
							if ( errormsg.IndexOf( message ) > -1 )
							{
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
							}
							errinline = true;
						}
						doublepercent = false;
						escnext = false;
						echoed = false;
						incomment = false;
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case '<':
						redirection = !escnext;
						if ( singlequoted && redirection )
						{
							message = "Unescaped \"less than\" symbol(s) in singlequoted text (FOR /F loop" + ( forfloop ? string.Empty : "?" ) + ")";
							if ( errormsg.IndexOf( message ) > -1 )
							{
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
							}
							errinline = true;
						}
						doublepercent = false;
						escnext = false;
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case ' ':
					case '\t':
						if ( inexcl )
						{
							unterminatedexclamations += 1;
							message = "Unterminated exclamation marks or whitespace in (delayed) variable name";
							if ( errormsg.IndexOf( message ) > -1 )
							{
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
							}
							errinline = true;
						}
						if ( inperc )
						{
							unterminatedexclamations += 1;
							message = "Unterminated percent signs or whitespace in variable name";
							if ( errormsg.IndexOf( message ) > -1 )
							{
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
							}
							errinline = true;
						}
						doublepercent = false;
						escnext = false;
						inexcl = false;
						inperc = false;
						redirection = false;
						tildestr = false;
						break;
					case '(':
						if ( !echoed && !escnext )
						{
							parenthesis += 1;
						}
						doublepercent = false;
						//inexcl = false;
						//inperc = false;
						isparenthesis = true;
						redirection = false;
						tildestr = false;
						break;
					case ')':
						if ( !echoed && !escnext )
						{
							parenthesis -= 1;
						}
						if ( parenthesis < 0 )
						{
							message = "Too many closing parenthesis";
							if ( allerrors.IndexOf( message ) == -1 )
							{
								allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
								errormsg += string.Format( "{0}{1}.", newline, message );
								errinline = true;
							}
						}
						doublepercent = false;
						//inexcl = false;
						//inperc = false;
						isparenthesis = true;
						redirection = false;
						tildestr = false;
						break;
					case 'a':
					case 'd':
					case 'f':
					case 'n':
					case 'p':
					case 's':
					case 't':
					case 'x':
					case 'z':
						// "$PATH:" is ignored in the highlighting
						if ( tildestr )
						{
							inexcl = false;
							inperc = false;
							tildestr = true;
						}
						escnext = false;
						redirection = false;
						break;
					case '0':
					case '1':
					case '2':
					case '3':
					case '4':
					case '5':
					case '6':
					case '7':
					case '8':
					case '9':
						if ( ( prevchr == '%' ) || tildestr )
						{
							inexcl = false;
							inperc = false;
							tildestr = true;
						}
						escnext = false;
						redirection = false;
						break;
					default:
						doublepercent = false;
						escnext = false;
						redirection = false;
						tildestr = false;
						if ( tildestr )
						{
							if ( "ABCDEFGHIJKLMNOPQRSTUVWXYZ?".IndexOf( chr.ToString( ), StringComparison.InvariantCultureIgnoreCase ) > -1 )
							{
								if ( "adfnpstxz".IndexOf( prevchr.ToString( ) ) > -1 )
								{
									if ( line.IndexOf( "%%" + chr.ToString( ) ) > 3 && line.IndexOf( "%%" + chr.ToString( ) ) < index )
									{
										tildestr = true;
									}
								}
							}
						}
						break;
				}

				#endregion Character Type

				// check for unescaped redirection symbols in FOR /F loops
				if ( redirection && singlequoted && ( parenthesis % 2 == 1 ) )
				{
					message = "Unescaped redirection symbol(s) in single quoted text (FOR /F loop?)";
					if ( errormsg.IndexOf( message ) > -1 )
					{
						allerrors += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
						errormsg += string.Format( "{0}{1}.", newline, message );
					}
					errinline = true;
				}

				#region ECHOed text and comments

				// check if we are dealing with ECHOed text or comments
				if ( chr == ' ' || chr == '\t' )
				{
					lastword = buildword.ToUpper( ).Trim( );
					buildword = string.Empty;
				}
				else
				{
					buildword += chr.ToString( );
				}
				if ( lastword == "ECHO" || lastword == "@ECHO" )
				{
					echoed = true;
				}
				else if ( ( lastword == "REM" || lastword == "::" ) && !echoed )
				{
					incomment = true;
					commentlines += 1;
				}

				#endregion ECHOed text and comments

				// as soon as an unescaped redirection symbol is encountered, we no longer have ECHOed text
				if ( redirection && !doublequoted && !escnext )
				{
					echoed = false;
				}

				#region Highlighting

				// correctly highlight the character we just parsed
				if ( redirection )
				{
					// redirection symbols and parenthesis are highlighted in red
					Console.ForegroundColor = redirectionfgcolor;
				}
				else if ( inexcl || inperc || tildestr || doublepercent || tempinexcl || tempinperc )
				{
					// variables and parameters are highlighted in green
					Console.ForegroundColor = variablesfgcolor;
				}
				else if ( isparenthesis && !echoed )
				{
					// redirection symbols and parenthesis are highlighted in red
					Console.ForegroundColor = parenthesisfgcolor;
				}
				else if ( echoed )
				{
					// ECHOed text is highlighted in cyan, with the exception of variables
					Console.ForegroundColor = echoedtextfgcolor;
				}
				else if ( ( ( prevchr == (char) 39 ) && ( chr == ')' ) ) || singlequoted || tempsngquoted )
				{
					// singlequoted text in parenthesis is highlighted in dark gray
					Console.ForegroundColor = singlequotedfgcolor;
				}
				else if ( doublequoted || tempdblquoted )
				{
					Console.ForegroundColor = doublequotedfgcolor;
				}
				else
				{
					Console.ResetColor( );
				}
				Console.Write( chr );
				WriteSpanHTML( EscapedHTML( chr ) );

				#endregion Highlighting

				switch ( chr )
				{
					case '"':
						tempdblquoted = doublequoted;
						redirection = false;
						tildestr = false;
						break;
					case (char) 39:
						tempsngquoted = singlequoted;
						redirection = false;
						tildestr = false;
						break;
					case '%':
						tempinperc = inperc;
						redirection = false;
						break;
					case '!':
						if ( prevchr != '^' )
						{
							tempinexcl = inexcl;
							redirection = false;
						}
						break;
					case '^':
						if ( prevchr == chr )
						{
							prevchr = ' ';
						}
						escnext = false;
						tildestr = false;
						break;
					case '&':
					case '|':
					case '>':
					case '<':
						redirection = true;
						escnext = false;
						tildestr = false;
						break;
					case '0':
					case '1':
					case '2':
					case '3':
					case '4':
					case '5':
					case '6':
					case '7':
					case '8':
					case '9':
						if ( inperc && tildestr )
						{
							inperc = false;
						}
						tildestr = false;
						break;
					case ' ':
					case '\t':
					case '.':
						tildestr = false;
						break;
					default:
						redirection = false;
						tildestr = false;
						break;
				}
				isparenthesis = false;
				prevchr = chr;
			}
			Console.WriteLine( );
			if ( doublequotes % 2 == 1 )
			{
				unterminateddoublequotes += 1;
				message = "Unterminated doublequotes";
				allwarnings += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
				warnmsg += string.Format( "{0}{1}.", newline, message );
				errinline = true;
			}
			if ( singlequotes % 2 == 1 )
			{
				unterminatedsinglequotes += 1;
				message = "Unterminated singlequotes";
				allwarnings += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
				warnmsg += string.Format( "{0}{1}.", newline, message );
				errinline = true;
			}
			if ( inperc && !tildestr )
			{
				unterminatedpercentsigns += 1;
				message = "Unterminated percent signs";
				allwarnings += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
				warnmsg += string.Format( "{0}{1}.", newline, message );
				errinline = true;
			}
			if ( inexcl && delayedvarexp )
			{
				int exclmt = new Regex( @"!" ).Matches( line ).Count;
				int escexcl = new Regex( @"\^\^!" ).Matches( line ).Count; // Exclude escaped exclamation marks
				if ( ( exclmt - escexcl ) % 2 == 1 )
				{
					unterminatedexclamations += 1;
					message = "Unterminated exclamation marks";
					allwarnings += string.Format( "{0}Line {1,5:0}:\t{2}", newline, linenum, message );
					warnmsg += string.Format( "{0}{1}.", newline, message );
					errinline = true;
				}
			}
		}


		public static void ParseLinePerCharacter2( string line )
		{
			string pattern;
			Regex regex;

			// First, check if the line starts with an internal command
			pattern = string.Format( @"(^\s*)((?:{0})(?=$|\s|\b)|ECHO(?=[\s/\\[\]\(\.,;:]))", intcmdpattern );
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				foreach ( Match match in matches )
				{
					string whitespace = match.Groups[1].ToString( );
					string intcmd = match.Groups[2].ToString( );
					Console.BackgroundColor = intcmdbgcolor;
					Console.ForegroundColor = intcmdfgcolor;
					intcmd = string.Format( "{0}{1}", whitespace, intcmd );
					Console.Write( intcmd );
					WriteSpanHTML( intcmd );
					Console.ResetColor( );
					line = line.Substring( Math.Min( whitespace.Length + intcmd.Length, line.Length - 1 ) );
				}
			}
			ParseLinePerCharacter( line );
		}


		public static void ReadSource( string file )
		{
			StreamReader src = new StreamReader( file );
			// Read batch source as pure ASCII, which is an absolute requirement for batch files
			allsrc = Encoding.ASCII.GetString( Encoding.ASCII.GetBytes( src.ReadToEnd( ) ) );
			src.Close( );
			Regex rxcmnt = new Regex( @"(?:^|\n|\r|\(|&)\s*((?:REM|::)[^\n\r]+)", ignorecase );
			allsrc_nocomments = rxcmnt.Replace( allsrc, string.Empty );
		}


		public static void ResetInlineVariables( )
		{
			badprmsg = string.Empty;
			errinline = false;
			errormsg = string.Empty;
			tipsmsg = string.Empty;
			warnmsg = string.Empty;
			message = string.Empty;
			part = string.Empty;
			buildword = string.Empty;
			lastword = string.Empty;
		}


		public static void RestoreConsoleColors( )
		{
			Console.ForegroundColor = windowfgcolor;
			Console.BackgroundColor = windowbgcolor;
		}


		public static int ShowHelp( params string[] errorMessage )
		{
			// Delete HTML log file in case of errors
			if ( htmlopen )
			{
				htmlstream.Close( );
				File.Delete( htmlfile );
			}

			Console.ResetColor( );

			if ( errorMessage.Length > 0 )
			{
				List<string> errargs = new List<string>( errorMessage );
				errargs.RemoveAt( 0 );
				Console.Error.WriteLine( );
				Console.ForegroundColor = ConsoleColor.Red;
				Console.Error.Write( "ERROR:\t" );
				Console.ForegroundColor = ConsoleColor.White;
				Console.Error.WriteLine( errorMessage[0], errargs.ToArray( ) );
				Console.ResetColor( );
			}

			/*
			BatCodeCheck,  Version 0.33 beta  (unlicensed)
			Search batch source code for common errors

			Usage:   BATCODECHECK  batchfile [ logging ] [ options ]

			or:      BATCODECHECK  [ batchfile ]  /I

			Where:   batchfile       is the batch file to be checked and highlighted
			Logging: /L[:"logfile"]  Log results in ASCII format, replace file if it exists
			         /H[:"htmlfile"] log results in HTML format, replace file if it exists
			                         (default output file names and paths equal batchfile
			                         name and path, with extension .log or .html)
			Options: /C:checks       run only the specified Checks, where "checks" is a
			                         combination of the following letters:
			                         A    command line Arguments for batch commands
			                         B    Best practice tips
			                         E    Environment variables
			                         L    Labels
			                         M    common Mistakes
			                         S    verbose Summary (variables, labels, subroutines)
			                         U    Undefined environment variables
			                         V    Vulnerabilities
			         /D              Debug mode: append error stack trace to error messages
			         /E              include local Environment in defined variables list
			         /I              open Interactive settings dialog (licensed version)
			         /O              Open log file(s) when done (requires /L and/or /H)
			         /S              Split one-liners into separate command lines
			         /T              add a Timestamp to the default output file names
			         /U              check for BatCodeCheck Updates (unlicensed version)
			         /W              Wrap messages in source code (default: chop them)

			Notes:   The source code is displayed with highlighted ECHOed text,
			         comments, quoted strings, redirection, parenthesis and variables.
			         A warning message will be displayed if code errors were found.
			         Warning messages in the source code are chopped by default, and
			         repeated again (wrapped) at the end of the source code.
			         A non-zero return code means something was wrong, either on
			         the command line or in the source code. A return code greater
			         than 1 indicates the last line where an error was detected.
			         If no errors are detected, nothing will be logged.
			         False positives cannot be prevented entirely, use common sense
			         when evaluating the warnings and error messages.

			Written by Rob van der Woude
			http://www.robvanderwoude.com
			*/

			Console.Error.WriteLine( );

			Console.Error.WriteLine( "BatCodeCheck,  Version {0}{1}", progver, ( licensed ? string.Empty : "  (unlicensed)" ) );

			Console.Error.WriteLine( "Search batch source code for common errors" );

			Console.Error.WriteLine( );

			Console.Error.Write( "Usage:   " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.WriteLine( "BATCODECHECK  batchfile [ logging ] [ options ]" );
			Console.ResetColor( );

			Console.Error.WriteLine( );

			Console.Error.Write( "Or:      " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.WriteLine( "BATCODECHECK  [ batchfile ]  /I" );
			Console.ResetColor( );

			Console.Error.WriteLine( );

			Console.Error.Write( "Where:   " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "batchfile" );
			Console.ResetColor( );
			Console.Error.Write( "       is the " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "batch file" );
			Console.ResetColor( );
			Console.Error.WriteLine( " to be checked and highlighted" );

			Console.Error.Write( "Logging: " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/L[:\"logfile\"]  L" );
			Console.ResetColor( );
			Console.Error.WriteLine( "og results in ASCII format, replace file if it exists" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /H[:\"htmlfile\"]" );
			Console.ResetColor( );
			Console.Error.Write( " log results in " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "H" );
			Console.ResetColor( );
			Console.Error.WriteLine( "TML format, replace file if it exists" );

			Console.Error.Write( "                         (" );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "default" );
			Console.ResetColor( );
			Console.Error.Write( " output file names and paths equal " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.WriteLine( "batchfile" );
			Console.ResetColor( );

			Console.Error.Write( "                         name and path, with extension " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( ".log" );
			Console.ResetColor( );
			Console.Error.Write( " or " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( ".html" );
			Console.ResetColor( );
			Console.Error.WriteLine( ")" );

			Console.Error.Write( "Options: " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/C:checks" );
			Console.ResetColor( );
			Console.Error.Write( "       run only the specified " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "C" );
			Console.ResetColor( );
			Console.Error.WriteLine( "hecks, where \"checks\" is a" );

			Console.Error.WriteLine( "                         combination of the following letters:" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "                         A" );
			Console.ResetColor( );
			Console.Error.Write( "    command line " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "A" );
			Console.ResetColor( );
			Console.Error.WriteLine( "rguments for batch commands" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "                         B    B" );
			Console.ResetColor( );
			Console.Error.WriteLine( "est practice tips" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "                         E    E" );
			Console.ResetColor( );
			Console.Error.WriteLine( "nvironment variables" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "                         L    L" );
			Console.ResetColor( );
			Console.Error.WriteLine( "abels" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "                         M" );
			Console.ResetColor( );
			Console.Error.Write( "    common " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "M" );
			Console.ResetColor( );
			Console.Error.WriteLine( "istakes" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "                         S" );
			Console.ResetColor( );
			Console.Error.Write( "    verbose " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "S" );
			Console.ResetColor( );
			Console.Error.WriteLine( "ummary (variables, labels, subroutines)" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "                         U    U" );
			Console.ResetColor( );
			Console.Error.WriteLine( "ndefined environment variables" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "                         V    V" );
			Console.ResetColor( );
			Console.Error.WriteLine( "ulnerabilities" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /D              D" );
			Console.ResetColor( );
			Console.Error.WriteLine( "ebug mode: append error stack trace to error messages" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /E" );
			Console.ResetColor( );
			Console.Error.Write( "              include local " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "E" );
			Console.ResetColor( );
			Console.Error.WriteLine( "nvironment in defined variables list" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /I" );
			Console.ResetColor( );
			Console.Error.Write( "              open " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "I" );
			Console.ResetColor( );
			Console.Error.WriteLine( "nteractive settings dialog (licensed version)" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /O              O" );
			Console.ResetColor( );
			Console.Error.Write( "pen log file(s) when done (requires " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/L" );
			Console.ResetColor( );
			Console.Error.Write( " and/or " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/H" );
			Console.ResetColor( );
			Console.Error.WriteLine( ")" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /S              S" );
			Console.ResetColor( );
			Console.Error.WriteLine( "plit one-liners into separate command lines" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /T" );
			Console.ResetColor( );
			Console.Error.Write( "              add a " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "T" );
			Console.ResetColor( );
			Console.Error.Write( "imestamp to the " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "default" );
			Console.ResetColor( );
			Console.Error.WriteLine( " output file names" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /U" );
			Console.ResetColor( );
			Console.Error.Write( "              check for BatCodeCheck " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "U" );
			Console.ResetColor( );
			Console.Error.WriteLine( "pdates (unlicensed version)" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /W              W" );
			Console.ResetColor( );
			Console.Error.WriteLine( "rap messages in source code (default: chop them)" );

			Console.Error.WriteLine( );
			Console.Error.Write( "Notes:   The source code is displayed with highlighted " );
			Console.ForegroundColor = echoedtextfgcolor;
			Console.Error.Write( "ECHOed text" );
			Console.ResetColor( );
			Console.Error.WriteLine( "," );

			Console.ForegroundColor = commentfgscolor;
			Console.Error.Write( "         comments" );
			Console.ResetColor( );
			Console.Error.Write( ", " );
			Console.ForegroundColor = doublequotedfgcolor;
			Console.Error.Write( "quoted strings" );
			Console.ResetColor( );
			Console.Error.Write( ", " );
			Console.ForegroundColor = redirectionfgcolor;
			Console.Error.Write( "redirection" );
			Console.ResetColor( );
			Console.Error.Write( ", " );
			Console.ForegroundColor = parenthesisfgcolor;
			Console.Error.Write( "parenthesis" );
			Console.ResetColor( );
			Console.Error.Write( " and " );
			Console.ForegroundColor = variablesfgcolor;
			Console.Error.Write( "variables" );
			Console.ResetColor( );
			Console.Error.WriteLine( "." );

			Console.Error.WriteLine( "         A warning message will be displayed if code errors were found." );

			Console.Error.WriteLine( "         Warning messages in the source code are chopped by default, and" );

			Console.Error.WriteLine( "         repeated again (wrapped) at the end of the source code." );

			Console.Error.WriteLine( "         A non-zero return code means something was wrong, either on" );

			Console.Error.WriteLine( "         the command line or in the source code. A return code greater" );

			Console.Error.WriteLine( "         than 1 indicates the last line where an error was detected." );

			Console.Error.WriteLine( "         False positives cannot be prevented entirely, use common sense" );

			Console.Error.WriteLine( "         when evaluating the warnings and error messages." );

			Console.Error.WriteLine( );

			Console.Error.WriteLine( "Written by Rob van der Woude" );

			Console.Error.WriteLine( "http://www.robvanderwoude.com" );

			return 1;
		}


		public static string StripComments( string line )
		{
			string pattern = @"^(\s*(REM\s|::))";
			Regex regex = new Regex( pattern, RegexOptions.IgnoreCase );
			if ( regex.IsMatch( line ) )
			{
				line = regex.Match( line ).Value;
			}
			return line;
		}


		public static string VerboseSummary( )
		{
			string verbosemessage = string.Empty;
			if ( verbosesummary )
			{
				// Total number of lines
				verbosemessage = string.Format( "{0}Checked a total of {1} lines", newline, linenum );
				// Number of comment lines
				verbosemessage += string.Format( "{0}{1} comment lines", newline, commentlines );
				// Determine column width for environment variables
				int maxlen = 0;
				foreach ( string name in envvars.Keys )
				{
					maxlen = Math.Max( maxlen, name.Length );
				}
				// Number of environment variables and usage
				verbosemessage += string.Format( "{0}{0}{1} environment variables were found:", newline, envvars.Count );
				foreach ( KeyValuePair<string, int> envvar in labels )
				{
					verbosemessage += string.Format( "{0}{1,-" + maxlen + "}    ", newline, envvar.Key );
					switch ( envvar.Value )
					{
						case 0:
							verbosemessage += "(never referred to)";
							break;
						case 1:
							verbosemessage += "(referred to once)";
							break;
						case 2:
							verbosemessage += "(referred to twice)";
							break;
						default:
							verbosemessage += string.Format( "(referred to {0} times)", envvar.Value );
							break;
					}
				}
				// Determine column width for labels and subroutines
				maxlen = 0;
				foreach ( string name in subroutines.Keys )
				{
					maxlen = Math.Max( maxlen, name.Length );
				}
				foreach ( string name in labels.Keys )
				{
					maxlen = Math.Max( maxlen, name.Length );
				}
				// Number of subroutines and calls
				verbosemessage += string.Format( "{0}{0}{1} subroutines were found:", newline, subroutines.Count );
				foreach ( KeyValuePair<string, int> subroutine in subroutines )
				{
					verbosemessage += string.Format( "{0}{1,-" + maxlen + "}    ", newline, subroutine.Key );
					switch ( subroutine.Value )
					{
						case 0:
							verbosemessage += "(never called)";
							break;
						case 1:
							verbosemessage += "(called once)";
							break;
						case 2:
							verbosemessage += "(called twice)";
							break;
						default:
							verbosemessage += string.Format( "(called {0} times)", subroutine.Value );
							break;
					}
				}
				// Number of "normal" labels and jumps
				verbosemessage += string.Format( "{0}{0}{1} labels were found:", newline, labels.Count - subroutines.Count );
				foreach ( KeyValuePair<string, int> label in labels )
				{
					verbosemessage += string.Format( "{0}{1,-" + maxlen + "}    ", newline, label.Key );
					switch ( label.Value )
					{
						case 0:
							verbosemessage += "(never jumped to)";
							break;
						case 1:
							verbosemessage += "(jumped to once)";
							break;
						case 2:
							verbosemessage += "(jumped to twice)";
							break;
						default:
							verbosemessage += string.Format( "(jumped to {0} times)", label.Value );
							break;
					}
				}
			}
			return verbosemessage;
		}


		public static string Which( string prog )
		{
			bool found = false;
			string pattern = "%~(([dpnxs]|[fs])+)0";
			Regex regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( prog ) )
			{
				string fullpath = string.Empty;
				string scriptpath = regex.Match( prog ).Value;
				char[] pathcomp = regex.Match( prog.ToLower( ) ).Groups[1].Value.ToCharArray( );
				if ( pathcomp.Contains( 'd' ) )
				{
					fullpath = Path.GetPathRoot( source );
				}
				if ( pathcomp.Contains( 'p' ) )
				{
					fullpath = Path.Combine( fullpath, Directory.GetParent( source ).FullName.Substring( fullpath.Length ) ) + "\\";
				}
				if ( pathcomp.Contains( 'n' ) )
				{
					fullpath = Path.Combine( fullpath, Path.GetFileNameWithoutExtension( source ) );
				}
				if ( pathcomp.Contains( 'x' ) )
				{
					fullpath = fullpath + "." + Path.GetExtension( source );
				}
				if ( pathcomp.Contains( 'f' ) )
				{
					fullpath = Path.GetFullPath( source );
				}
				if ( pathcomp.Contains( 's' ) )
				{
					fullpath = ShortFileName( fullpath );
				}
				prog = prog.Replace( "\"", "" );
				prog = prog.Replace( scriptpath, fullpath );
				if ( File.Exists( prog ) )
				{
					return prog;
				}
				else
				{
					return string.Empty;
				}
			}
			foreach ( string folder in path )
			{
				if ( !found )
				{
					if ( !string.IsNullOrWhiteSpace( folder ) )
					{
						string dir = ( folder + "\\" ).Replace( "\\\\", "\\" );
						foreach ( string ext in pathext )
						{
							if ( !found )
							{
								// The EXTERNAL program FILE to be searched MUST have an extension, either
								// specified on the command line or one of the extensions listed in PATHEXT.
								if ( ( prog + ext ).IndexOf( '.' ) > -1 )
								{
									if ( File.Exists( dir + prog + ext ) )
									{
										return dir + prog + ext;
									}
								}
							}
						}
					}
				}
			}
			return string.Empty;
		}


		public static string WordWrap( string input, bool padright = false )
		{
			string output = string.Empty;
			string blankline = new string( ' ', Console.WindowWidth );
			while ( !string.IsNullOrEmpty( input ) )
			{
				int brpos;
				if ( input.Length < Console.WindowWidth )
				{
					if ( padright )
					{
						input = ( input + blankline ).Substring( 0, Console.WindowWidth - 1 );
						brpos = Console.WindowWidth - 1;
					}
					else
					{
						brpos = input.Length;
					}
				}
				else
				{
					brpos = input.Substring( 0, Math.Min( Console.WindowWidth - 1, input.Length ) ).LastIndexOfAny( ". -".ToCharArray( ) );
				}
				// Just break at window width if word length exceeds window width
				if ( brpos == -1 )
				{
					brpos = Math.Min( Console.WindowWidth - 1, input.Length );
				}
				string msgline = input.Substring( 0, Math.Min( brpos + 1, input.Length ) ).Trim( );
				if ( padright )
				{
					msgline = ( msgline + blankline ).Substring( 0, Console.WindowWidth - 1 );
				}
				output += msgline + newline;
				input = input.Substring( Math.Min( brpos + 1, input.Length ) ).Trim( );
			}
			return output.TrimEnd( "\n\r".ToCharArray( ) );
		}


		public static void WriteSpanHTML( string text )
		{
			if ( log2html )
			{
				if ( !htmlopen )
				{
					CreateHTML( );
				}
				ConsoleColor newbgc = Console.BackgroundColor;
				ConsoleColor newfgc = Console.ForegroundColor;
				//string backgroundcolor = newbgc.ToString( ).ToLower( ).Replace( "darkyellow", "#808000" ); // darkyellow is not a valid CSS value, reported and fixed by Alfons van Zwol
				string backgroundcolor = ConsoleColor2CSSColor( newbgc );
				string foregroundcolor = ConsoleColor2CSSColor( newfgc );
				string style = string.Empty;
				if ( newbgc != lastbgc )
				{
					style = string.Format( "background-color: {0};", backgroundcolor );
				}
				if ( newfgc != lastfgc )
				{
					style += string.Format( " color: {0};", foregroundcolor );
				}
				if ( string.IsNullOrWhiteSpace( style ) )
				{
					htmlstream.Write( text );
				}
				else
				{
					if ( spanopen )
					{
						htmlstream.Write( "</span>" );
					}
					htmlstream.Write( "<span style=\"{0}\">{1}", style.Trim( ), text );
					spanopen = true;
				}
				lastbgc = newbgc;
				lastfgc = newfgc;
			}
		}


		public static void WriteLineHTML( string text )
		{
			if ( log2html )
			{
				if ( spanopen )
				{
					htmlstream.Write( "</span>\n" );
				}
				else
				{
					htmlstream.Write( "\n" );
				}
				spanopen = false;
				WriteSpanHTML( text );
			}
		}


		#endregion Subroutines


		#region Short Name API

		// Long path to short notation by Rod Stephens
		// http://csharphelper.com/blog/2015/01/convert-between-long-and-short-file-names-in-c/

		// Define GetShortPathName API function.
		[DllImport( "kernel32.dll", CharSet = CharSet.Auto, SetLastError = true )]
		static extern uint GetShortPathName( string lpszLongPath, char[] lpszShortPath, int cchBuffer );


		// Return the short file name for a long file name.
		private static string ShortFileName( string long_name )
		{
			char[] name_chars = new char[1024];
			long length = GetShortPathName( long_name, name_chars, name_chars.Length );
			string short_name = new string( name_chars );
			return short_name.Substring( 0, (int) length );
		}

		#endregion Short Name API
	}
}
