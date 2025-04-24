import sys 
sys.path.append(".")
from DK import *

##################################################################################
# dk_color(on/off)
#
# Enable / Disable console text and background coloring
#
#   on/off:  Default ON
#
#   https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
#   https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#   https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
#
def dk_color(*args):
    #dk_debugFunc 0 1

    global USE_COLOR;   USE_COLOR=1
    #if defined args[0] if args[0] equ 0 USE_COLOR=

    # https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
    # https://en.wikipedia.org/wiki/C0_and_C1_control_codes

    ############ C0 control codes #############
    # Sequences		Hexadecimal   Unicode   Decimal    Octal    Ctrl-Key:
	#global NUL; NUL="tODO"	# Null - Does nothing. The code of blank paper tape, and also used for padding to slow transmission
    global SOH; SOH=""		# Start of Heading - First character of the heading of a message
    global STX; STX=""		# Start of Text - Terminates the header and starts the message text
    global ETX; ETX=""		# End of Text - Ends the message text, starts a footer (up to the next TC character"
    global EOT; EOT=""		# End of Transmission - Ends the transmission of one or more messages. May place terminals on standby.
    global EQN; EQN=""		# Enquiry - Trigger a response at the receiving end, to see if it is still present.
    global ACK; ACK=""		# Acknowledge - Indication of successful receipt of a message.
    global BEL; BEL=""		# Bell, Alert	- Call for attention from an operator.
    global BS;  BS=""		# Backspace - Move one position leftwards. Next character may overprint or replace the character that was there.
    global HT;  HT="	"   # Character Tabulation, Horizontal Tabulation	- Move right to the next tab stop.
    #global LF;  LF="TODO"  # Line Feed - Move down to the same position on the next line (some devices also moved to the left column).
    global VT;  VT=""		# Line Tabulation, Vertical Tabulation - Move down to the next vertical tab stop.
    global FF;  FF=""		# Form Feed - Move down to the top of the next page.
    #global CR;  CR="TODO"	# Carriage Return - Move to column zero while staying on the same line.
    global SO;  SO=""		# Shift Out - Switch to an alternative character set.
    global SI;  SI=""		# Shift In - Return to regular character set after SO.
    global DLE; DLE=""		# Data Link Escape - Cause a number of contiguously following characters to be interpreted in some different way
    global DC1; DC1=""		# Device Control One - Turn on (DC1 and DC2) or off (DC3 and DC4) devices.
    global DC2; DC2=""		# Device Control Two
    global DC3; DC3=""		# Device Control Three
    global DC4; DC4=""		# Device Control Four
    global NAK; NAK=""		# Negative Acknowledge - Negative response to a sender, such as a detected error.
    global SYN; SYN=""		# Synchronous Idle - Sent in synchronous transmission systems when no other character is being transmitted.
    global ETB; ETB=""		# End of Transmission Block - End of a transmission block of data when data are divided into such blocks.
    global CAN; CAN=""		# Cancel - Indicates that the data preceding it are in error or are to be disregarded.
    global EM;  EM=""		# End of medium - Indicates on paper or magnetic tapes that the end of the usable tape had been reached.
    global SUB; SUB=""		# Substitute -Replaces a character that was found to be invalid or in error. Should be ignored.
    global ESC; ESC=""		# Escape - Alters the meaning of a limited number of following bytes.
    global FS;  FS=""		# File Separator - Can be used as delimiters to mark fields of data structures. 
    global GS;  GS=""		# Group Separator
    global RS;  RS=""		# Record Separator
    global US;  US=""		# Unit Separator - US is the lowest level
    global SP;  SP=" "		# Space - Move right one character position.
    global DEL; DEL=""		# Delete - Should be ignored. Used to delete characters on punched tape by punching out all the holes.
       
    ############ C1 control codes #############
    global PAD; PAD=ESC+"@" # Padding Character
    global HOP; HOP=ESC+"A" # High Octet Preset
    global BPH; BPH=ESC+"B" # Break Permitted Here
    global NBH; NBH=ESC+"C" # No Break Here
    global IND; IND=ESC+"D" # Index
    global NEL; NEL=ESC+"E" # Next Line
    global SSA; SSA=ESC+"F" # Start of Selected Area
    global ESA; ESA=ESC+"G" # End of Selected Area
    global HTS; HTS=ESC+"H" # Horizontal Tabulation Set
    global HTJ; HTJ=ESC+"I" # Horizontal Tabulation With Justification
    global VTS; VTS=ESC+"J" # Vertical Tabulation Set
    global PLD; PLD=ESC+"K" # Partial Line Down
    global PLU; PLU=ESC+"L" # Partial Line Up
    global RI;  RI=ESC+"M"  # Reverse Index
    global SS2; SS2=ESC+"N" # Single Shift Two
    global SS3; SS3=ESC+"O" # Single Shift Three
    global DCS; DCS=ESC+"P" # Device Control String
    global PU1; PU1=ESC+"Q" # Private Use 1
    global PU2; PU2=ESC+"R" # Private Use 2
    global STS; STS=ESC+"S" # Set Transmit State
    global CCH; CCH=ESC+"T" # Cancel character
    global MW;  MW=ESC+"U"  # Message Waiting
    global SPA; SPA=ESC+"V" # Start of Protected Area
    global EPA; EPA=ESC+"W" # End of Protected Area
    global SOS; SOS=ESC+"X" # Start of String
    global SGC; SGC=ESC+"Y" # Single Graphic Character Introducer
    global SCI; SCI=ESC+"Z" # Single Character Introducer
    global CSI; CSI=ESC+"[" # Control Sequence Introducer
    global ST;  ST=ESC+"\\" # String Terminator
    global OSC; OSC=ESC+"]" # Operating System Command
    global PM;  PM=ESC+"^^" # Privacy Message
    global APC; APC=ESC+"_" # Application Program Command
    
    ############# CSI Commands #############
    global ANSI0;   ANSI0 = CSI+"0m";       global clr;         clr = ESC+"[0m";        # Default - Returns all attributes to the default state prior to modification
    global ANSI1;   ANSI1 = CSI+"1m";       global bold;        bold = ESC+"[1m";       # Bold/Bright - Applies brightness/intensity flag to foreground color
    global ANSI2;   ANSI2 = CSI+"2m";       global dim;         dim = ESC+"[2m";        # Dim
    global ANSI3;   ANSI3 = CSI+"3m";       global italic;      italic = ESC+"[3m";         # Italic
    global ANSI4;   ANSI4 = CSI+"4m";       global underline;   underline = ESC+"[4m";      # Underline - Adds underline
    global ANSI5;   ANSI5 = CSI+"5m";       global blink;       blink = ESC+"[5m";          # Blink
    global ANSI6;   ANSI6 = CSI+"6m";       global fblink;      fblink = ESC+"[6m";         # Rapid Blink
    global ANSI7;   ANSI7 = CSI+"7m";       global negative;    negative = ESC+"[7m";       # Negative - Swaps foreground and background colors
    global ANSI8;   ANSI8 = CSI+"8m";       global invisible;   invisible = ESC+"[8m";      # Invisible
    global ANSI9;   ANSI9 = CSI+"9m";       global strike;      strike = ESC+"[9m";         # Strike Through
#   global ANSI10;  ANSI10 = CSI+"10m";#    global ???;         ??? = ESC+"[10m";           # UNKNOWN
#   global ANSI11;  ANSI11 = CSI+"11m";#    global ???;         ??? = ESC+"[11m";           # UNKNOWN 
#   global ANSI12;  ANSI12 = CSI+"12m";#    global ???;         ??? = ESC+"[12m";           # UNKNOWN
#   global ANSI13;  ANSI13 = ESC+"[13m";#   global ???;         ??? = ESC+"[13m";           # UNKNOWN
#   global ANSI14;  ANSI14 = ESC+"[14m";#   global ???;         ??? = ESC+"[14m";           # UNKNOWN
#   global ANSI15;  ANSI15 = ESC+"[15m";#   global ???;         ??? = ESC+"[15m";           # UNKNOWN
#   global ANSI16;  ANSI16 = ESC+"[16m";#   global ???;         ??? = ESC+"[16m";           # UNKNOWN
#   global ANSI17;  ANSI17 = ESC+"[17m";#   global ???;         ??? = ESC+"[17m";           # UNKNOWN
#   global ANSI18;  ANSI18 = ESC+"[18m";#   global ???;         ??? = ESC+"[18m";           # UNKNOWN
#   global ANSI19;  ANSI19 = ESC+"[19m";#   global ???;         ??? = ESC+"[19m";           # UNKNOWN
#   global ANSI20;  ANSI20 = ESC+"[20m";#   global ???;         ??? = ESC+"[20m";           # UNKNOWN
#   global ANSI21;  ANSI21 = ESC+"[21m";#   global ???;         ??? = ESC+"[21m";           # UNKNOWN
    global ANSI22;  ANSI22 = ESC+"[22m";    global nobold;      nobold = ESC+"[22m";        # No bold/bright - Removes brightness/intensity flag from foreground color
    global ANSI23;  ANSI23 = ESC+"[23m";    global noitalic;    noitalic = ESC+"[23m";      # No Italic
    global ANSI24;  ANSI24 = ESC+"[24m";    global nounderline; nounderline = ESC+"[24m";   # No underline              - Removes underline
    global ANSI25;  ANSI25 = ESC+"[25m";    global noblink;     noblink = ESC+"[25m";       # No Blink
#   global ANSI26;  ANSI26 = ESC+"[26m";#   global ???;         ??? = ESC+"[26m";           # UNKNOWN
    global ANSI27;  ANSI27 = ESC+"[27m";    global nonegative;  nonegative = ESC+"[27m";    # Positive(No negative)     - Returns foreground/background to normal
    global ANSI28;  ANSI28 = ESC+"[28m";    global visible;     visible = ESC+"[28m";       # Visible(No invisible)
    global ANSI29;  ANSI29 = ESC+"[29m";    global nostrike;    nostrike = ESC+"[29m";      # No Strike Through
    global ANSI30;  ANSI30 = ESC+"[30m";    global black;       black = ESC+"[30m";         # Foreground Black    - Applies non-bold/bright black to foreground
    global ANSI31;  ANSI31 = ESC+"[31m";    global red;         red = ESC+"[31m";           # Foreground Red      - Applies non-bold/bright red to foreground
    global ANSI32;  ANSI32 = ESC+"[32m";    global green;       green = ESC+"[32m";         # Foreground Green    - Applies non-bold/bright green to foreground
    global ANSI33;  ANSI33 = ESC+"[33m";    global yellow;      yellow = ESC+"[33m";        # Foreground Yellow   - Applies non-bold/bright yellow to foreground
    global ANSI34;  ANSI34 = ESC+"[34m";    global blue;        blue = ESC+"[34m";          # Foreground Blue     - Applies non-bold/bright blue to foreground
    global ANSI35;  ANSI35 = ESC+"[35m";    global magenta;     magenta = ESC+"[35m";       # Foreground Magenta  - Applies non-bold/bright magenta to foreground
    global ANSI36;  ANSI36 = ESC+"[36m";    global cyan;        cyan = ESC+"[36m";          # Foreground Cyan     - Applies non-bold/bright cyan to foreground
    global ANSI37;  ANSI37 = ESC+"[37m";    global white;       white = ESC+"[37m";         # Foreground White    - Applies non-bold/bright white to foreground
    global ANSI38;  ANSI38 = ESC+"[38;2;";  global RGB;         RGB = ESC+"[38;2;";         # Foreground EXTENDED - Applies extended colors to forecround      RGB+"50;100;150m"
    global ANSI39;  ANSI39 = ESC+"[39m";    global default_;    default_ = ESC+"[39m";      # Foreground Default  - Applies only the foreground portion of the defaults
    global ANSI40;  ANSI40 = ESC+"[40m";    global bg_black;    bg_black = ESC+"[40m";      # Background Black    - Applies non-bold/bright black to background
    global ANSI41;  ANSI41 = ESC+"[41m";    global bg_red;      bg_red = ESC+"[41m";        # Background Red      - Applies non-bold/bright red to background
    global ANSI42;  ANSI42 = ESC+"[42m";    global bg_green;    bg_green = ESC+"[42m";      # Background Green    - Applies non-bold/bright green to background
    global ANSI43;  ANSI43 = ESC+"[43m";    global bg_yellow;   bg_yellow = ESC+"[43m";     # Background Yellow   - Applies non-bold/bright yellow to background
    global ANSI44;  ANSI44 = ESC+"[44m";    global bg_blue;     bg_blue = ESC+"[44m";       # Background Blue     - Applies non-bold/bright blue to background
    global ANSI45;  ANSI45 = ESC+"[45m";    global bg_magenta;  bg_magenta = ESC+"[45m";    # Background Magenta  - Applies non-bold/bright magenta to background
    global ANSI46;  ANSI46 = ESC+"[46m";    global bg_cyan;     bg_cyan = ESC+"[46m";       # Background Cyan     - Applies non-bold/bright cyan to background
    global ANSI47;  ANSI47 = ESC+"[47m";    global bg_white;    bg_white = ESC+"[47m";       # Background White    - Applies non-bold/bright white to background
    global ANSI48;  ANSI48 = ESC+"[48;2;";  global bg_RGB;      bg_RGB = ESC+"[48;2;";      # Background EXTENDED - Applies exteneded colors to background bg_RGB+"150;100;50m"
    global ANSI49;  ANSI49 = ESC+"[49m";    global bg_default;  bg_default = ESC+"[49m";    # Background Default  - Applies only the background portion of the defaults
#    global ANSI50 = ESC+"[50m";#    global ???        = ESC+"[50m";   # UNKNOWN
#    global ANSI51 = ESC+"[51m";#    global ???        = ESC+"[51m";   # UNKNOWN
#    global ANSI52 = ESC+"[52m";#    global ???        = ESC+"[52m";   # UNKNOWN
#    global ANSI53 = ESC+"[53m";#    global ???        = ESC+"[53m";   # UNKNOWN
#    global ANSI54 = ESC+"[54m";#    global ???        = ESC+"[54m";   # UNKNOWN
#    global ANSI55 = ESC+"[55m";#    global ???        = ESC+"[55m";   # UNKNOWN
#    global ANSI56 = ESC+"[56m";#    global ???        = ESC+"[56m";   # UNKNOWN
#    global ANSI57 = ESC+"[57m";#    global ???        = ESC+"[57m";   # UNKNOWN
#    global ANSI58 = ESC+"[58m";#    global ???        = ESC+"[58m";   # UNKNOWN
#    global ANSI59 = ESC+"[59m";#    global ???        = ESC+"[59m";   # UNKNOWN
#    global ANSI60 = ESC+"[60m";#    global ???        = ESC+"[60m";   # UNKNOWN
#    global ANSI61 = ESC+"[61m";#    global ???        = ESC+"[61m";   # UNKNOWN
#    global ANSI62 = ESC+"[62m";#    global ???        = ESC+"[62m";   # UNKNOWN
#    global ANSI63 = ESC+"[63m";#    global ???        = ESC+"[63m";   # UNKNOWN
#    global ANSI64 = ESC+"[64m";#    global ???        = ESC+"[64m";   # UNKNOWN
#    global ANSI65 = ESC+"[65m";#    global ???        = ESC+"[65m";   # UNKNOWN
#    global ANSI66 = ESC+"[66m";#    global ???        = ESC+"[66m";   # UNKNOWN
#    global ANSI67 = ESC+"[67m";#    global ???        = ESC+"[67m";   # UNKNOWN
#    global ANSI68 = ESC+"[68m";#    global ???        = ESC+"[68m";   # UNKNOWN
#    global ANSI69 = ESC+"[69m";#    global ???        = ESC+"[69m";   # UNKNOWN
#    global ANSI70 = ESC+"[70m";#    global ???        = ESC+"[70m";   # UNKNOWN
#    global ANSI71 = ESC+"[71m";#    global ???        = ESC+"[71m";   # UNKNOWN
#    global ANSI72 = ESC+"[72m";#    global ???        = ESC+"[72m";   # UNKNOWN
#    global ANSI73 = ESC+"[73m";#    global ???        = ESC+"[73m";   # UNKNOWN
#    global ANSI74 = ESC+"[74m";#    global ???        = ESC+"[74m";   # UNKNOWN
#    global ANSI75 = ESC+"[75m";#    global ???        = ESC+"[75m";   # UNKNOWN
#    global ANSI76 = ESC+"[76m";#    global ???        = ESC+"[76m";   # UNKNOWN
#    global ANSI77 = ESC+"[77m";#    global ???        = ESC+"[77m";   # UNKNOWN
#    global ANSI78 = ESC+"[78m";#    global ???        = ESC+"[78m";   # UNKNOWN
#    global ANSI79 = ESC+"[79m";#    global ???        = ESC+"[79m";   # UNKNOWN
#    global ANSI80 = ESC+"[80m";#    global ???        = ESC+"[80m";   # UNKNOWN
#    global ANSI81 = ESC+"[81m";#    global ???        = ESC+"[81m";   # UNKNOWN
#    global ANSI82 = ESC+"[82m";#    global ???        = ESC+"[82m";   # UNKNOWN
#    global ANSI83 = ESC+"[83m";#    global ???        = ESC+"[83m";   # UNKNOWN
#    global ANSI84 = ESC+"[84m";#    global ???        = ESC+"[84m";   # UNKNOWN
#    global ANSI85 = ESC+"[85m";#    global ???        = ESC+"[85m";   # UNKNOWN
#    global ANSI86 = ESC+"[86m";#    global ???        = ESC+"[86m";   # UNKNOWN
#    global ANSI87 = ESC+"[87m";#    global ???        = ESC+"[87m";   # UNKNOWN
#    global ANSI88 = ESC+"[88m";#    global ???        = ESC+"[88m";   # UNKNOWN
#    global ANSI89 = ESC+"[89m";#    global ???        = ESC+"[89m";   # UNKNOWN
    global ANSI90;  ANSI90 = ESC+"[90m";    global lblack;      lblack = ESC+"[90m";   # Bright Foreground Black   - Applies bold/bright black to foreground
    global ANSI91;  ANSI91 = ESC+"[91m";    global lred;        lred = ESC+"[91m";   # Bright Foreground Red     - Applies bold/bright red to foreground
    global ANSI92;  ANSI92 = ESC+"[92m";    global lgreen;      lgreen = ESC+"[92m";   # Bright Foreground Green   - Applies bold/bright green to foreground
    global ANSI93;  ANSI93 = ESC+"[93m";    global lyellow;     lyellow = ESC+"[93m";   # Bright Foreground Yellow  - Applies bold/bright yellow to foreground
    global ANSI94;  ANSI94 = ESC+"[94m";    global lblue;       lblue = ESC+"[94m";   # Bright Foreground Blue    - Applies bold/bright blue to foreground
    global ANSI95;  ANSI95 = ESC+"[95m";    global lmagenta;    lmagenta = ESC+"[95m";   # Bright Foreground Magenta - Applies bold/bright magenta to foreground
    global ANSI96;  ANSI96 = ESC+"[96m";    global lcyan;       lcyan = ESC+"[96m";   # Bright Foreground Cyan    - Applies bold/bright cyan to foreground
    global ANSI97;  ANSI97 = ESC+"[97m";    global lwhite;      lwhite = ESC+"[97m";   # Bright Foreground White   - Applies bold/bright white to foreground
#   global ANSI98;  ANSI98 = ESC+"[98m";#    global ???        = ESC+"[98m";   # UNKNOWN
#   global ANSI99;  ANSI99 = ESC+"[99m";#    global ???        = ESC+"[99m";   # UNKNOWN
    global ANSI100; ANSI100 = ESC+"[100m";     global bg_lblack;    bg_lblack = ESC+"[100m";  # Bright Background Black   - Applies bold/bright black to background
    global ANSI101; ANSI101 = ESC+"[101m";     global bg_lred;      bg_lred = ESC+"[101m";  # Bright Background Red     - Applies bold/bright red to background
    global ANSI102; ANSI102 = ESC+"[102m";     global bg_lgreen;    bg_lgreen = ESC+"[102m";  # Bright Background Green   - Applies bold/bright green to background
    global ANSI103; ANSI103 = ESC+"[103m";     global bg_lyellow;   bg_lyellow = ESC+"[103m";  # Bright Background Yellow  - Applies bold/bright yellow to background
    global ANSI104; ANSI104 = ESC+"[104m";     global bg_lblue;     bg_lblue = ESC+"[104m";  # Bright Background Blue    - Applies bold/bright blue to background
    global ANSI105; ANSI105 = ESC+"[105m";     global bg_lmagenta;  bg_lmagenta = ESC+"[105m";  # Bright Background Magenta - Applies bold/bright magenta to background
    global ANSI106; ANSI106 = ESC+"[106m";     global bg_lcyan;     bg_lcyan = ESC+"[106m";  # Bright Background Cyan    - Applies bold/bright cyan to background
    global ANSI107; ANSI107 = ESC+"[107m";     global bg_lwhite;   bg_lwhite = ESC+"[107m";  # Bright Background White   - Applies bold/bright white to background
#    global ANSI108 = ESC+"[108m";#   global ???        = ESC+"[108m";  # UNKNOWN
#    global ANSI109 = ESC+"[109m";#   global ???        = ESC+"[109m";  # UNKNOWN
#    global ANSI110 = ESC+"[110m";#   global ???        = ESC+"[111m";  # UNKNOWN
#    global ANSI111 = ESC+"[111m";#   global ???        = ESC+"[111m";  # UNKNOWN
#    global ANSI112 = ESC+"[112m";#   global ???        = ESC+"[112m";  # UNKNOWN
#    global ANSI113 = ESC+"[113m";#   global ???        = ESC+"[113m";  # UNKNOWN
#    global ANSI114 = ESC+"[114m";#   global ???        = ESC+"[114m";  # UNKNOWN
#    global ANSI115 = ESC+"[115m";#   global ???        = ESC+"[115m";  # UNKNOWN
#    global ANSI116 = ESC+"[116m";#   global ???        = ESC+"[116m";  # UNKNOWN
#    global ANSI117 = ESC+"[117m";#   global ???        = ESC+"[117m";  # UNKNOWN
#    global ANSI118 = ESC+"[118m";#   global ???        = ESC+"[118m";  # UNKNOWN
#    global ANSI119 = ESC+"[119m";#   global ???        = ESC+"[119m";  # UNKNOWN
#    global ANSI120 = ESC+"[120m";#   global ???        = ESC+"[120m";  # UNKNOWN
#    global ANSI121 = ESC+"[121m";#   global ???        = ESC+"[121m";  # UNKNOWN
#    global ANSI122 = ESC+"[122m";#   global ???        = ESC+"[122m";  # UNKNOWN
#    global ANSI123 = ESC+"[123m";#   global ???        = ESC+"[123m";  # UNKNOWN
#    global ANSI124 = ESC+"[124m";#   global ???        = ESC+"[124m";  # UNKNOWN

    ### Attributes on ##
#    global clr;         clr=ESC+"[0m"                  # Default                     - Returns all attributes to the default state prior to modification
#    global bold;        bold=ESC+"[1m"                 # Bold/Bright                 - Applies brightness/intensity flag to foreground color
#    global dim;         dim=ESC+"[2m"                  # Dim
#    global italic;      italic=ESC+"[3m"               # Italic
#    global underline;   underline=ESC+"[4m"            # Underline                   - Adds underline
#    global blink;       blink=ESC+"[5m"                # Blink
#    global fblink;      fblink=ESC+"[6m"               # Rapid Blink
#    global negative;    negative=ESC+"[7m"             # Negative                    - Swaps foreground and background colors
#    global invisible;   invisible=ESC+"[8m"            # Invisible
#    global strike;      strike=ESC+"[9m"               # Strike Through

    ### Attributes off ###
#    # global 20m;       20m=ESC+"[20m"                  # 20
#    # global 21m;       21m=ESC+"[21m"                  # 21
#    global nobold;      nobold=ESC+"[22m"               # No bold/bright              - Removes brightness/intensity flag from foreground color
#    global noitalic;    noitalic=ESC+"[23m"             # No italic
#    global nounderline; nounderline=ESC+"[24m"          # No underline                - Removes underline
#    global noblink;     noblink=ESC+"[25m"              # No Blink
#    # global 26m;       26m=ESC+"[26m"                  # 26
#    global nonegative;  nonegative=ESC+"[27m"           # Positive(No negative)       - Returns foreground/background to normal
#    global visible;     visible=ESC+"[28m"              # Visible(No invisible)
#    global nostrike;    nostrike=ESC+"[29m"             # No Strike Through

#    ### Foreground Colors ##
#    global black;       black=ESC+"[30m"               # Foreground Black            - Applies non-bold/bright black to foreground
#    global red;         red=ESC+"[31m"                 # Foreground Red              - Applies non-bold/bright red to foreground
#    global green;       green=ESC+"[32m"               # Foreground Green            - Applies non-bold/bright green to foreground
#    global yellow;      yellow=ESC+"[33m"              # Foreground Yellow           - Applies non-bold/bright yellow to foreground
#    global blue;        blue=ESC+"[34m"                # Foreground Blue             - Applies non-bold/bright blue to foreground
#    global magenta;     magenta=ESC+"[35m"             # Foreground Magenta          - Applies non-bold/bright magenta to foreground
#    global cyan;        cyan=ESC+"[36m"                # Foreground Cyan             - Applies non-bold/bright cyan to foreground
#    global white;       white=ESC+"[37m"               # Foreground White            - Applies non-bold/bright white to foreground
#    global extended;    extended=ESC+"[38m"            # Foreground Extended         - Applies extended color value to the foreground
#    global default;     default=ESC+"[39m"             # Foreground Default          - Applies only the foreground portion of the defaults

#    ### Background Colors ###
#    global bg_black;    bg_black=ESC+"[40m"            # Background Black            - Applies non-bold/bright black to background
#    global bg_red;      bg_red=ESC+"[41m"              # Background Red              - Applies non-bold/bright red to background
#    global bg_green;    bg_green=ESC+"[42m"            # Background Green            - Applies non-bold/bright green to background
#    global bg_yellow;   bg_yellow=ESC+"[43m"           # Background Yellow           - Applies non-bold/bright yellow to background
#    global bg_blue;     bg_blue=ESC+"[44m"             # Background Blue             - Applies non-bold/bright blue to background
#    global bg_magenta;  bg_magenta=ESC+"[45m"          # Background Magenta          - Applies non-bold/bright magenta to background
#    global bg_cyan;     bg_cyan=ESC+"[46m"             # Background Cyan             - Applies non-bold/bright cyan to background
#    global bg_white;    bg_white=ESC+"[47m"            # Background White            - Applies non-bold/bright white to background
#    global bg_extended; bg_extended=ESC+"[48m"         # Background Extended         - Applies extended color value to the background
#    global bg_default;  bg_default=ESC+"[49m"          # Background Default          - Applies only the background portion of the defaults

#    ### Foreground Colors (light) ###
#    global lblack;      lblack=ESC+"[90m"              # Bright Foreground Black     - Applies bold/bright black to foreground
#    global lred;        lred=ESC+"[91m"                # Bright Foreground Red       - Applies bold/bright red to foreground
#    global lgreen;      lgreen=ESC+"[92m"              # Bright Foreground Green     - Applies bold/bright green to foreground
#    global lyellow;     lyellow=ESC+"[93m"             # Bright Foreground Yellow    - Applies bold/bright yellow to foreground
#    global lblue;       lblue=ESC+"[94m"               # Bright Foreground Blue      - Applies bold/bright blue to foreground
#    global lmagenta;    lmagenta=ESC+"[95m"            # Bright Foreground Magenta   - Applies bold/bright magenta to foreground
#    global lcyan;       lcyan=ESC+"[96m"               # Bright Foreground Cyan      - Applies bold/bright cyan to foreground
#    global lwhite;      lwhite=ESC+"[97m"              # Bright Foreground White     - Applies bold/bright white to foreground

#    ### Background Colors (light) ###
#    global bg_lblack;   bg_lblack=ESC+"[100m"          # Bright Background Black     - Applies bold/bright black to background
#    global bg_lred;     bg_lred=ESC+"[101m"            # Bright Background Red       - Applies bold/bright red to background
#    global bg_lgreen;   bg_lgreen=ESC+"[102m"          # Bright Background Green     - Applies bold/bright green to background
#    global bg_lyellow;  bg_lyellow=ESC+"[103m"         # Bright Background Yellow    - Applies bold/bright yellow to background
#    global bg_lblue;    bg_lblue=ESC+"[104m"           # Bright Background Blue      - Applies bold/bright blue to background
#    global bg_lmagenta; bg_lmagenta=ESC+"[105m"        # Bright Background Magenta   - Applies bold/bright magenta to background
#    global bg_lcyan;    bg_lcyan=ESC+"[106m"           # Bright Background Cyan      - Applies bold/bright cyan to background
#    global bg_lwhite;   bg_lwhite=ESC+"[107m"          # Bright Background White     - Applies bold/bright white to background

#    ### Foreground RGB Colors ###
#    global RGB;         RGB=ESC+"[38;2;"               # RGB+50;100;150m        = ESC+"[38;2;50;100;150m"
#    ### Background RGB Colors ###
#    global bg_RGB;      bg_RGB=ESC+"[48;2;"            # bg_RGB+150;100;50m     = ESC+"[38;2;150;100;50m"

    print(blue+"C"+green+"O"+red+"L"+magenta+"O"+cyan+"R "+blue+"O"+green+"N"+clr)
  
#    else
#       # dk_unset ESC
#        # dk_unset clr
#
#        ### Attributes on ###
#        dk_unset bold
#        dk_unset dim
#        dk_unset italic
#        dk_unset underline
#        dk_unset blink
#        dk_unset fblink
#        dk_unset negative
#        dk_unset invisible
#        dk_unset strike
#
#        ### Attributes off ###
#        dk_unset nobold
#        dk_unset noitalic
#        dk_unset nounderline
#        dk_unset noblink
#        dk_unset nonegative
#        dk_unset visible
#        dk_unset nostrike
#
#        ### Foreground Colors ###
#        dk_unset black
#        dk_unset red
#        dk_unset green
#        dk_unset yellow
#        dk_unset blue
#        dk_unset magenta
#        dk_unset cyan
#        dk_unset white
#
#       ### Background Colors ###
#        dk_unset bg_black
#        dk_unset bg_red
#        dk_unset bg_green
#        dk_unset bg_yellow
#        dk_unset bg_blue
#        dk_unset bg_magenta
#        dk_unset bg_cyan
#        dk_unset bg_white
#
#        ### Foreground Colors (bright) ###
#        dk_unset lblack
#        dk_unset lred
#        dk_unset lgreen
#        dk_unset lyellow
#        dk_unset lblue
#        dk_unset lmagenta
#        dk_unset lcyan
#        dk_unset lwhite
#
#        ### Background Colors (bright) ###
#        dk_unset bg_lblack
#        dk_unset bg_lred
#        dk_unset bg_lgreen
#        dk_unset bg_lyellow
#        dk_unset bg_lblue
#        dk_unset bg_lmagenta
#        dk_unset bg_lcyan
#        dk_unset bg_lwhite
#
#        dk_unset RGB
#        dk_unset bg_RGB
#
#        dk_echo(clr+"COLOR OFF")

dk_color()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#	dk_debugFunc 0

    print()
    print(black+bg_lblack+"           Styles            "+clr)
    print("clr        "+clr+      " default   "+clr)
    print("bold       "+bold+     " bold      "+clr)
    print("dim        "+dim+      " dim       "+clr)
    print("italic     "+italic+   " italic    "+clr)
    print("underline  "+underline+" underline "+clr)
    print("blink      "+blink+    " blink     "+clr)
    print("fblink     "+fblink+   " fblink    "+clr)
    print("negative   "+negative+ " negative  "+clr)
    print("invisible  "+invisible+" invisible "+clr)
    print("strike     "+strike+   " strike    "+clr)
    print()
    print()
    print(black+bg_lblack+"      Foreground Colors      "+clr)
    print("black      "+black+  " black   "+clr)
    print("red        "+red+    " red     "+clr)
    print("green      "+green+  " green   "+clr)
    print("yellow     "+yellow+ " yellow  "+clr)
    print("blue       "+blue+   " blue    "+clr)
    print("magenta    "+magenta+" magenta "+clr)
    print("cyan       "+cyan+   " cyan    "+clr)
    print("white      "+white+  " white   "+clr)
    print()
    print()
    print(black+bg_lblack+"      Background Colors      "+clr)
    print("bg_black   "+bg_black+  " bg_black   "+clr)
    print("bg_red     "+bg_red+    " bg_red     "+clr)
    print("bg_green   "+bg_green+  " bg_green   "+clr)
    print("bg_yellow  "+bg_yellow+ " bg_yellow  "+clr)
    print("bg_blue    "+bg_blue+   " bg_blue    "+clr)
    print("bg_magenta "+bg_magenta+" bg_magenta "+clr)
    print("bg_cyan    "+bg_cyan+   " bg_cyan    "+clr)
    print("bg_white   "+bg_white+  " bg_white   "+clr)
    print()
    print()
    print(black+bg_lblack+" Foreground Colors  bright  "+clr)
    print("lblack      "+lblack+  " lblack   "+clr)
    print("lred        "+lred+    " lred     "+clr)
    print("lgreen      "+lgreen+  " lgreen   "+clr)
    print("lyellow     "+lyellow+ " lyellow  "+clr)
    print("lblue       "+lblue+   " lblue    "+clr)
    print("lmagenta    "+lmagenta+" lmagenta "+clr)
    print("lcyan       "+lcyan+   " lcyan    "+clr)
    print("lwhite      "+lwhite+  " lwhite   "+clr)
    print()
    print()
    print(black+bg_lblack+" Background Colors  bright "+clr)
    print("bg_lblack   "+bg_lblack+  " bg_lblack   "+clr)
    print("bg_lred     "+bg_lred+    " bg_lred     "+clr)
    print("bg_lgreen   "+bg_lgreen+  " bg_lgreen   "+clr)
    print("bg_lyellow  "+bg_lyellow+ " bg_lyellow  "+clr)
    print("bg_lblue    "+bg_lblue+   " bg_lblue    "+clr)
    print("bg_lmagenta "+bg_lmagenta+" bg_lmagenta "+clr)
    print("bg_lcyan    "+bg_lcyan+   " bg_lcyan    "+clr)
    print("bg_lwhite   "+bg_lwhite+  " bg_lwhite   "+clr)
    print()
    print()
    print(black+bg_lblack+"   RGB Foreground Colors  "+clr)
    print(RGB+"255;10;10m    RGB test 255;0;10    "+clr)
    print(RGB+"10;255;10m    RGB test 0;255;10   "+clr)
    print(RGB+"0;0;255m    RGB test 0;0;255    "+clr)
    print(RGB+"0;0;250m    RGB test 0;0;250    "+clr)
    print(RGB+"0;0;245m    RGB test 0;0;245    "+clr)
    print(RGB+"0;0;240m    RGB test 0;0;240    "+clr)
    print(RGB+"0;0;235m    RGB test 0;0;235    "+clr)
    print(RGB+"0;0;230m    RGB test 0;0;230    "+clr)
    print(RGB+"0;0;225m    RGB test 0;0;225    "+clr)
    print(RGB+"0;0;220m    RGB test 0;0;220    "+clr)
    print(RGB+"0;0;215m    RGB test 0;0;215    "+clr)
    print(RGB+"0;0;210m    RGB test 0;0;210    "+clr)
    print(RGB+"0;0;205m    RGB test 0;0;205    "+clr)
    print(RGB+"0;0;200m    RGB test 0;0;200    "+clr)
    print(RGB+"0;0;195m    RGB test 0;0;195    "+clr)
    print(RGB+"0;0;190m    RGB test 0;0;190    "+clr)
    print(RGB+"0;0;185m    RGB test 0;0;185    "+clr)
    print(RGB+"0;0;180m    RGB test 0;0;180    "+clr)
    print(RGB+"0;0;175m    RGB test 0;0;175    "+clr)
    print(RGB+"0;0;170m    RGB test 0;0;170    "+clr)
    print(RGB+"0;0;165m    RGB test 0;0;165    "+clr)
    print(RGB+"0;0;160m    RGB test 0;0;160    "+clr)
    print(RGB+"0;0;155m    RGB test 0;0;155    "+clr)
    print(RGB+"0;0;150m    RGB test 0;0;150    "+clr)
    print(RGB+"0;0;145m    RGB test 0;0;145    "+clr)
    print(RGB+"0;0;140m    RGB test 0;0;140    "+clr)
    print(RGB+"0;0;135m    RGB test 0;0;135    "+clr)
    print(RGB+"0;0;130m    RGB test 0;0;130    "+clr)
    print(RGB+"0;0;125m    RGB test 0;0;125    "+clr)
    print(RGB+"0;0;120m    RGB test 0;0;120    "+clr)
    print(RGB+"0;0;115m    RGB test 0;0;115    "+clr)
    print(RGB+"0;0;110m    RGB test 0;0;110    "+clr)
    print(RGB+"0;0;105m    RGB test 0;0;105    "+clr)
    print(RGB+"0;0;100m    RGB test 0;0;100    "+clr)
    print(RGB+"0;0;95m    RGB test 0;0;95     "+clr)
    print(RGB+"0;0;90m    RGB test 0;0;90     "+clr)
    print(RGB+"0;0;85m    RGB test 0;0;85     "+clr)
    print(RGB+"0;0;80m    RGB test 0;0;80     "+clr)
    print(RGB+"0;0;75m    RGB test 0;0;75     "+clr)
    print(RGB+"0;0;70m    RGB test 0;0;70     "+clr)
    print(RGB+"0;0;65m    RGB test 0;0;65     "+clr)
    print(RGB+"0;0;60m    RGB test 0;0;60     "+clr)
    print(RGB+"0;0;55m    RGB test 0;0;55     "+clr)
    print(RGB+"0;0;50m    RGB test 0;0;50     "+clr)
    print(RGB+"0;0;45m    RGB test 0;0;45     "+clr)
    print(RGB+"0;0;40m    RGB test 0;0;40     "+clr)
    print(RGB+"0;0;35m    RGB test 0;0;35     "+clr)
    print(RGB+"0;0;30m    RGB test 0;0;30     "+clr)
    print(RGB+"0;0;25m    RGB test 0;0;25     "+clr)
    print(RGB+"0;0;20m    RGB test 0;0;20     "+clr)
    print(RGB+"0;0;15m    RGB test 0;0;15     "+clr)
    print(RGB+"0;0;10m    RGB test 0;0;10     "+clr)
    print(RGB+"0;0;5m    RGB test 0;0;5      "+clr)
    print(RGB+"0;0;0m    RGB test 0;0;0      "+clr)
    print()
    print()
    print(black+bg_lblack+"   RGB Background Colors   "+clr)
    print(bg_RGB+"255;10;10m    bg_RGB test 255;0;10   "+clr)
    print(bg_RGB+"10;255;10m    bg_RGB test 0;255;10   "+clr)
    print(bg_RGB+"0;0;255m    bg_RGB test 0;0;255    "+clr)
    print(bg_RGB+"0;0;250m    bg_RGB test 0;0;250    "+clr)
    print(bg_RGB+"0;0;245m    bg_RGB test 0;0;245    "+clr)
    print(bg_RGB+"0;0;240m    bg_RGB test 0;0;240    "+clr)
    print(bg_RGB+"0;0;235m    bg_RGB test 0;0;235    "+clr)
    print(bg_RGB+"0;0;230m    bg_RGB test 0;0;230    "+clr)
    print(bg_RGB+"0;0;225m    bg_RGB test 0;0;225    "+clr)
    print(bg_RGB+"0;0;220m    bg_RGB test 0;0;220    "+clr)
    print(bg_RGB+"0;0;215m    bg_RGB test 0;0;215    "+clr)
    print(bg_RGB+"0;0;210m    bg_RGB test 0;0;210    "+clr)
    print(bg_RGB+"0;0;205m    bg_RGB test 0;0;205    "+clr)
    print(bg_RGB+"0;0;200m    bg_RGB test 0;0;200    "+clr)
    print(bg_RGB+"0;0;195m    bg_RGB test 0;0;195    "+clr)
    print(bg_RGB+"0;0;190m    bg_RGB test 0;0;190    "+clr)
    print(bg_RGB+"0;0;185m    bg_RGB test 0;0;185    "+clr)
    print(bg_RGB+"0;0;180m    bg_RGB test 0;0;180    "+clr)
    print(bg_RGB+"0;0;175m    bg_RGB test 0;0;175    "+clr)
    print(bg_RGB+"0;0;170m    bg_RGB test 0;0;170    "+clr)
    print(bg_RGB+"0;0;165m    bg_RGB test 0;0;165    "+clr)
    print(bg_RGB+"0;0;160m    bg_RGB test 0;0;160    "+clr)
    print(bg_RGB+"0;0;155m    bg_RGB test 0;0;155    "+clr)
    print(bg_RGB+"0;0;150m    bg_RGB test 0;0;150    "+clr)
    print(bg_RGB+"0;0;145m    bg_RGB test 0;0;145    "+clr)
    print(bg_RGB+"0;0;140m    bg_RGB test 0;0;140    "+clr)
    print(bg_RGB+"0;0;135m    bg_RGB test 0;0;135    "+clr)
    print(bg_RGB+"0;0;130m    bg_RGB test 0;0;130    "+clr)
    print(bg_RGB+"0;0;125m    bg_RGB test 0;0;125    "+clr)
    print(bg_RGB+"0;0;120m    bg_RGB test 0;0;120    "+clr)
    print(bg_RGB+"0;0;115m    bg_RGB test 0;0;115    "+clr)
    print(bg_RGB+"0;0;110m    bg_RGB test 0;0;110    "+clr)
    print(bg_RGB+"0;0;105m    bg_RGB test 0;0;105    "+clr)
    print(bg_RGB+"0;0;100m    bg_RGB test 0;0;100    "+clr)
    print(bg_RGB+"0;0;95m    bg_RGB test 0;0;95     "+clr)
    print(bg_RGB+"0;0;90m    bg_RGB test 0;0;90     "+clr)
    print(bg_RGB+"0;0;85m    bg_RGB test 0;0;85     "+clr)
    print(bg_RGB+"0;0;80m    bg_RGB test 0;0;80     "+clr)
    print(bg_RGB+"0;0;75m    bg_RGB test 0;0;75     "+clr)
    print(bg_RGB+"0;0;70m    bg_RGB test 0;0;70     "+clr)
    print(bg_RGB+"0;0;65m    bg_RGB test 0;0;65     "+clr)
    print(bg_RGB+"0;0;60m    bg_RGB test 0;0;60     "+clr)
    print(bg_RGB+"0;0;55m    bg_RGB test 0;0;55     "+clr)
    print(bg_RGB+"0;0;50m    bg_RGB test 0;0;50     "+clr)
    print(bg_RGB+"0;0;45m    bg_RGB test 0;0;45     "+clr)
    print(bg_RGB+"0;0;40m    bg_RGB test 0;0;40     "+clr)
    print(bg_RGB+"0;0;35m    bg_RGB test 0;0;35     "+clr)
    print(bg_RGB+"0;0;30m    bg_RGB test 0;0;30     "+clr)
    print(bg_RGB+"0;0;25m    bg_RGB test 0;0;25     "+clr)
    print(bg_RGB+"0;0;20m    bg_RGB test 0;0;20     "+clr)
    print(bg_RGB+"0;0;15m    bg_RGB test 0;0;15     "+clr)
    print(bg_RGB+"0;0;10m    bg_RGB test 0;0;10     "+clr)
    print(bg_RGB+"0;0;5m    bg_RGB test 0;0;5      "+clr)
    print(bg_RGB+"0;0;0m    bg_RGB test 0;0;0      "+clr)
    print()
    print()
    print(black+bg_lblack+"        Combinations        "+clr)
    print("negative                        "+negative+"   inverse foreground <-> background  "+clr)
    print("bg_yellow red                   "+bg_yellow+red+"  yellow backgroud / red foreground   "+clr)
    print("bg_yellow red negative          "+bg_yellow+red+negative+"        yellow / red inversed         "+clr)
    print("bg_red.. bg_green.. bg_blue     "+bg_red+"    nested   "+bg_green+"    colors    "+bg_blue+"    text   "+clr)
    print()
    print()
    print(black+bg_lblack+"        ASCII Color Art      "+clr)
    print()
    print(bg_blue+" * * * * * * * * * "+bg_red+"                                 "+clr)
    print(bg_blue+"  * * * * * * * *  "+bg_white+"                                 "+clr)
    print(bg_blue+" * * * * * * * * * "+bg_red+"                                 "+clr) 
    print(bg_blue+"  * * * * * * * *  "+bg_white+"                                 "+clr)
    print(bg_blue+" * * * * * * * * * "+bg_red+"                                 "+clr)
    print(bg_blue+"  * * * * * * * *  "+bg_white+"                                 "+clr)
    print(bg_blue+" * * * * * * * * * "+bg_red+"                                 "+clr)
    print(bg_white+"                                                    "+clr)
    print(bg_red+"                                                    "+clr)
    print(bg_white+"                                                    "+clr)
    print(bg_red+"                                                    "+clr)
    print(bg_white+"                                                    "+clr)
    print(bg_red+"                                                    "+clr)

#DKTEST()