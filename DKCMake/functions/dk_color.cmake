#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_color(on/off)
#
#	Enable / Disable console text and background coloring
#
#   on/off:  Default ON
#
#   https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
#   https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#
function(dk_color)
	dk_validateFunc(dk_debugFunc)
	dk_debugFunc()
	
	set(dk_color_ENABLE 1)
	if(ARGV)
		if(NOT ${ARGV0})
			set(dk_color_ENABLE 0)
		endif()
	endif()
	
	if(dk_color_ENABLE)

		###### ASCII ##############################################################
		#				DEC		Symbol									Description                  
		#--------------------------------------------------------------------------
#		string(ASCII 	0  		NUL)									# Null character
		string(ASCII 	1    	SOH)									# Start of Heading
		string(ASCII 	2    	STX)									# Start of Text
		string(ASCII 	3    	ETX)									# End of Text
		string(ASCII 	4    	EQT)									# End of Transmission 
		string(ASCII 	5    	ENQ)									# Enquiry
		string(ASCII 	6    	ACK)									# Acknowledge
		string(ASCII 	7    	BEL)									# Bell, Alert
		string(ASCII 	8    	BS)										# Backspace
		string(ASCII 	9    	TAB)									# Horizontal Tab
		string(ASCII 	10   	LF)										# Line Feed
		string(ASCII 	11   	VT)										# Vertical Tabulation
		string(ASCII 	12    	FF)										# Form Feed
		string(ASCII 	13    	CR)										# Carriage Return                
		string(ASCII 	14    	SO)										# Shift Out
		string(ASCII 	15    	SI)										# Shift In
		string(ASCII 	16    	DLE)									# Data Link Escape                
		string(ASCII 	17    	DC1)									# Device Control One (XON)        
		string(ASCII 	18    	DC2)									# Device Control Two              
		string(ASCII 	19    	DC3)									# Device Control Three (XOFF)     
		string(ASCII 	20    	DC4)									# Device Control Four             
		string(ASCII 	21    	NAK)									# Negative Acknowledge            
		string(ASCII 	22    	SYN)									# Synchronous Idle                
		string(ASCII 	23    	ETB)									# End of Transmission Block       
		string(ASCII 	24    	CAN)									# Cancel                          
		string(ASCII 	25    	EM)	   									# End of medium                   
		string(ASCII 	26    	SUB)									# Substitute                      
		string(ASCII 	27    	ESC)									# Escape                          
		string(ASCII 	28    	FS)										# File Separator                  
		string(ASCII 	29    	GS)										# Group Separator                 
		string(ASCII 	30    	RS)										# Record Separator                
		string(ASCII 	31    	US)										# Unit Separator                  
		string(ASCII 	32    	SP)										# Space                           
#		string(ASCII 	33    	!)										# Exclamation mark                
#		string(ASCII 	34    	")										# Double quotes                   
#		string(ASCII 	35    	#)										# Number sign                     
#		string(ASCII 	36    	$)										# Dollar    $            
#		string(ASCII 	37    	%)										# Percent sign                    
#		string(ASCII 	38    	&)										# Ampersand &            
#		string(ASCII 	39    	')										# Single quote                    
#		string(ASCII 	40    	()										# Open parenthesis                
#		string(ASCII 	41    	))										# Close parenthesis               
#		string(ASCII 	42    	*)										# Asterisk  *            
#		string(ASCII 	43    	+)										# Plus      +            
#		string(ASCII 	44    	,)										# Comma     ,            
#		string(ASCII 	45    	-)										# Hyphen or minus                 
#		string(ASCII 	46    	.)										# Period, dot or full stop        
#		string(ASCII 	47    	/)										# Slash or divide                 
#		string(ASCII 	48    	0)										# Zero      0            
#		string(ASCII 	49    	1)										# One       1            
#		string(ASCII 	50    	2)										# Two       2            
#		string(ASCII 	51    	3)										# Three     3            
#		string(ASCII 	52    	4)										# Four      4            
#		string(ASCII 	53    	5)										# Five      5            
#		string(ASCII 	54    	6)										# Six       6            
#		string(ASCII 	55    	7)										# Seven     7            
#		string(ASCII 	56    	8)										# Eight     8            
#		string(ASCII 	57    	9)										# Nine      9            
#		string(ASCII 	58    	:)										# Colon     :            
#		string(ASCII 	59    	;)										# Semicolon ;            
#		string(ASCII 	60    	<)										# Less than <            
#		string(ASCII 	61    	=)										# Equals    =                    
#		string(ASCII 	62    	>)										# Greater than                    
#		string(ASCII 	63    	?)										# Question mark                   
#		string(ASCII 	64    	@)										# At sign   @                    
#		string(ASCII 	65    	A)										# Uppercase A                     
#		string(ASCII 	66    	B)										# Uppercase B                     
#		string(ASCII 	67   	C)										# Uppercase C                     
#		string(ASCII 	68   	D)										# Uppercase D                     
#		string(ASCII 	69    	E)										# Uppercase E                     
#		string(ASCII 	70    	F)										# Uppercase F                     
#		string(ASCII 	71    	G)										# Uppercase G                     
#		string(ASCII 	72    	H)										# Uppercase H                     
#		string(ASCII 	73    	I)										# Uppercase I                     
#		string(ASCII 	74    	J)										# Uppercase J                     
#		string(ASCII 	75    	K)										# Uppercase K                     
#		string(ASCII 	76    	L)										# Uppercase L                     
#		string(ASCII 	77    	M)										# Uppercase M                     
#		string(ASCII 	78    	N)										# Uppercase N                     
#		string(ASCII 	79    	O)										# Uppercase O                     
#		string(ASCII 	80    	P)										# Uppercase P                     
#		string(ASCII 	81    	Q)										# Uppercase Q                     
#		string(ASCII 	82    	R)										# Uppercase R                     
#		string(ASCII 	83    	S)										# Uppercase S                     
#		string(ASCII 	84    	T)										# Uppercase T                     
#		string(ASCII 	85    	U)										# Uppercase U                     
#		string(ASCII 	86    	V)										# Uppercase V                     
#		string(ASCII 	87    	W)										# Uppercase W                     
#		string(ASCII 	88    	X)										# Uppercase X                     
#		string(ASCII 	89    	Y)										# Uppercase Y                     
#		string(ASCII 	90    	Z)										# Uppercase Z                     
#		string(ASCII 	91    	[)										# Opening bracket                 
#		string(ASCII 	92    	\)										# Backslash \'                    
#		string(ASCII 	93    	])										# Closing bracket                 
#		string(ASCII 	94    	^)										# Caret - circumflex              
#		string(ASCII 	95    	_)										# Underscore_'                    
#		string(ASCII 	96    	`)										# Grave accent                    
#		string(ASCII 	97    	a)										# Lowercase a                     
#		string(ASCII 	98    	b)										# Lowercase b                     
#		string(ASCII 	99    	c)										# Lowercase c                     
#		string(ASCII 	100   	d)										# Lowercase d                     
#		string(ASCII 	101   	e)										# Lowercase e                     
#		string(ASCII 	102   	f)										# Lowercase f                     
#		string(ASCII 	103   	g)										# Lowercase g                     
#		string(ASCII 	104   	h)										# Lowercase h                     
#		string(ASCII 	105   	i)										# Lowercase i                     
#		string(ASCII 	106   	j)										# Lowercase j                     
#		string(ASCII 	107   	k)										# Lowercase k                     
#		string(ASCII 	108   	l)										# Lowercase l                     
#		string(ASCII 	109   	m)										# Lowercase m                     
#		string(ASCII 	110   	n)										# Lowercase n                     
#		string(ASCII 	111   	o)										# Lowercase o                     
#		string(ASCII 	112   	p)										# Lowercase p                     
#		string(ASCII 	113   	q)										# Lowercase q                     
#		string(ASCII 	114   	r)										# Lowercase r                     
#		string(ASCII 	115   	s)										# Lowercase s                     
#		string(ASCII 	116   	t)										# Lowercase t                     
#		string(ASCII 	117   	u)										# Lowercase u                     
#		string(ASCII 	118   	v)										# Lowercase v                     
#		string(ASCII 	119   	w)										# Lowercase w                     
#		string(ASCII 	120   	x)										# Lowercase x                     
#		string(ASCII 	121   	y)										# Lowercase y                     
#		string(ASCII 	122   	z)										# Lowercase z                     
#		string(ASCII 	123   	{)										# Opening brace                   
#		string(ASCII 	124   	|)										# Vertical bar                    
#		string(ASCII 	125   	})										# Closing brace                   
#		string(ASCII 	126   	~)										# Equivalency sign - tilde
		string(ASCII 	127   	DEL)									# Delete
		
		set(NUL			"${NUL}" 				CACHE INTERNAL "") 		# Null character
		set(SOH			"${SOH}" 				CACHE INTERNAL "") 		# Start of Heading
		set(STX			"${STX}" 				CACHE INTERNAL "") 		# Start of Text
		set(ETX			"${ETX}" 				CACHE INTERNAL "") 		# End of Text
		set(EQT			"${EQT}" 				CACHE INTERNAL "") 		# End of Transmission 
		set(ENQ			"${ENQ}" 				CACHE INTERNAL "") 		# Enquiry
		set(ACK			"${ACK}" 				CACHE INTERNAL "") 		# Acknowledge
		set(BEL			"${BEL}" 				CACHE INTERNAL "") 		# Bell, Alert
		set(BS  		"${BS}" 				CACHE INTERNAL "") 		# Backspace
		set(TAB			"${TAB}" 				CACHE INTERNAL "") 		# Horizontal Tab
		set(LF 			"${LF}"					CACHE INTERNAL "") 		# Line Feed
		set(VT 			"${VT}"					CACHE INTERNAL "") 		# Vertical Tabulation
		set(FF 			"${FF}"					CACHE INTERNAL "") 		# Form Feed
		set(CR 			"${CR}"					CACHE INTERNAL "") 		# Carriage Return                
		set(SO 			"${SO}"					CACHE INTERNAL "") 		# Shift Out
		set(SI 			"${SI}"					CACHE INTERNAL "") 		# Shift In
		set(DLE			"${DLE}" 				CACHE INTERNAL "") 		# Data Link Escape                
		set(DC1			"${DC1}" 				CACHE INTERNAL "") 		# Device Control One (XON)        
		set(DC2			"${DC2}" 				CACHE INTERNAL "") 		# Device Control Two              
		set(DC3			"${DC3}" 				CACHE INTERNAL "") 		# Device Control Three (XOFF)     
		set(DC4			"${DC4}" 				CACHE INTERNAL "") 		# Device Control Four             
		set(NAK			"${NAK}" 				CACHE INTERNAL "") 		# Negative Acknowledge            
		set(SYN			"${SYN}" 				CACHE INTERNAL "") 		# Synchronous Idle                
		set(ETB			"${ETB}" 				CACHE INTERNAL "") 		# End of Transmission Block       
		set(CAN			"${CAN}" 				CACHE INTERNAL "") 		# Cancel
		set(EM	  		"${EM}" 				CACHE INTERNAL "")		# End of medium                   
		set(SUB			"${SUB}" 				CACHE INTERNAL "") 		# Substitute
		set(ESC 		"${ESC}"				CACHE INTERNAL "")		# Escape
		set(FS 			"${FS}"					CACHE INTERNAL "") 		# File Separator                  
		set(GS 			"${GS}"					CACHE INTERNAL "") 		# Group Separator                 
		set(RS 			"${RS}"					CACHE INTERNAL "") 		# Record Separator                
		set(US 			"${US}"					CACHE INTERNAL "") 		# Unit Separator                  
		set(SP 			"${SP}"					CACHE INTERNAL "") 		# Space   
		set(DEL 		"${DEL}" 				CACHE INTERNAL "")   	# Delese		
		
		############# C1 control codes #############
		set(PAD			"${ESC}@"				CACHE INTERNAL "")		# Padding Character
		set(HOP			"${ESC}A"				CACHE INTERNAL "")		# High Octet Preset
		set(BPH			"${ESC}B"				CACHE INTERNAL "")		# Break Permitted Here
		set(NBH			"${ESC}C"				CACHE INTERNAL "")		# No Break Here
		set(IND			"${ESC}D"				CACHE INTERNAL "")		# Index
		set(NEL			"${ESC}E"				CACHE INTERNAL "")		# Next Line
		set(SSA			"${ESC}F"				CACHE INTERNAL "")		# Start of Selected Area
		set(ESA			"${ESC}G"				CACHE INTERNAL "")		# End of Selected Area
		set(HTS			"${ESC}H"				CACHE INTERNAL "")		# Horizontal Tabulation Set
		set(HTJ			"${ESC}I"				CACHE INTERNAL "")		# Horizontal Tabulation With Justification
		set(VTS			"${ESC}J"				CACHE INTERNAL "")		# Vertical Tabulation Set
		set(PLD			"${ESC}K"				CACHE INTERNAL "")		# Partial Line Down
		set(PLU			"${ESC}L"				CACHE INTERNAL "")		# Partial Line Up
		set(RI			"${ESC}M"				CACHE INTERNAL "")		# Reverse Index
		set(SS2			"${ESC}N"				CACHE INTERNAL "")		# Single Shift Two
		set(SS3			"${ESC}O"				CACHE INTERNAL "")		# Single Shift Three
		set(DCS			"${ESC}P"				CACHE INTERNAL "")		# Device Control String
		set(PU1			"${ESC}Q"				CACHE INTERNAL "")		# Private Use 1
		set(PU2			"${ESC}R"				CACHE INTERNAL "")		# Private Use 2
		set(STS			"${ESC}S"				CACHE INTERNAL "")		# Set Transmit State
		set(CCH			"${ESC}T"				CACHE INTERNAL "")		# Cancel character
		set(MW			"${ESC}U"				CACHE INTERNAL "")		# Message Waiting
		set(SPA			"${ESC}V"				CACHE INTERNAL "")		# Start of Protected Area
		set(EPA			"${ESC}W"				CACHE INTERNAL "")		# End of Protected Area
		set(SOS			"${ESC}X"				CACHE INTERNAL "")		# Start of String
		set(SGC			"${ESC}Y"				CACHE INTERNAL "")		# Single Graphic Character Introducer
		set(SCI			"${ESC}Z"				CACHE INTERNAL "")		# Single Character Introducer
		set(CSI			"${ESC}["				CACHE INTERNAL "")		# Control Sequence Introducer
		set(ST			"${ESC}\\"				CACHE INTERNAL "")		# String Terminator
		set(OSC			"${ESC}]"				CACHE INTERNAL "")		# Operating System Command
		set(PM			"${ESC}^"				CACHE INTERNAL "")		# Privacy Message
		set(APC			"${ESC}_"				CACHE INTERNAL "")		# Application Program Command

		set(DECSC		"${ESC}7"				CACHE INTERNAL "")		# Save Cursor Position in Memory**
		set(DECSR		"${ESC}8"				CACHE INTERNAL "")		# Restore Cursor Position from Memory**

		set(DECSCUSR0	"${ESC}0${SP}q"			CACHE INTERNAL "")		# User Shape
		set(DECSCUSR1	"${ESC}1${SP}q"			CACHE INTERNAL "")		# Blinking Block
		set(DECSCUSR2	"${ESC}2${SP}q"			CACHE INTERNAL "")		# Steady Block
		set(DECSCUSR3	"${ESC}3${SP}q"			CACHE INTERNAL "")		# Blinking Underline
		set(DECSCUSR4	"${ESC}4${SP}q"			CACHE INTERNAL "")		# Steady Underline
		set(DECSCUSR5	"${ESC}5${SP}q"			CACHE INTERNAL "")		# Blinking Bar
		set(DECSCUSR6	"${ESC}6${SP}q"			CACHE INTERNAL "")		# Steady Bar

		############# CSI Commands #############
		set(CCU				"${CSI}A"			CACHE INTERNAL "")		# Cursor Up 1 - Moves the cursor 1 cell in the given direction. If the cursor is already at the edge of the screen, this has no effect.
		#set(CCU			"${CSI}<n>A"		CACHE INTERNAL "")		# Cursor Up -	Moves the cursor n (default 1) cells in the given direction. If the cursor is already at the edge of the screen, this has no effect.
		set(CUD				"${CSI}B"			CACHE INTERNAL "")		# Cursor Down 1
		#set(CCU			"${CSI}<n>B"		CACHE INTERNAL "")		# Cursor Down
		set(CUF				"${CSI}C"			CACHE INTERNAL "")		# Cursor Forward 1
		#set(CCU			"${CSI}<n>C"		CACHE INTERNAL "")		# Cursor Forward
		set(CUB				"${CSI}D"			CACHE INTERNAL "")		# Cursor Back 1
		#set(CCU			"${CSI}<n>D"		CACHE INTERNAL "")		# Cursor Back
		set(CNL				"${CSI}E"			CACHE INTERNAL "")		# Cursor Next Line 1 - Moves cursor to beginning of the line 1 line down. (NOT ANSI.SYS)
		#set(CCU			"${CSI}<n>E"		CACHE INTERNAL "")		# Cursor Next Line - Moves cursor to beginning of the line n (default 1) lines down. (NOT ANSI.SYS)
		set(CPL				"${CSI}F"			CACHE INTERNAL "")		# Cursor Previous Line 1 - Moves cursor to beginning of the line 1 line up. (NOT ANSI.SYS)
		#set(CCU			"${CSI}<n>F"		CACHE INTERNAL "")		# Cursor Previous Line - Moves cursor to beginning of the line n (default 1) lines up. (NOT ANSI.SYS)
		set(CHA				"${CSI}G"			CACHE INTERNAL "")		# Cursor Horizontal Absolute 1 - Moves the cursor to column 1. (NOT ANSI.SYS)
		#set(CCU			"${CSI}<n>G"		CACHE INTERNAL "")		# Cursor Horizontal Absolute - Moves the cursor to column n (default 1). (NOT ANSI.SYS)
		#set(CUP			"${CSI}<n>;<m>H"	CACHE INTERNAL "")		# Cursor Position	- Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
		#set(HVP			"${CSI}<y>;<x>f"	CACHE INTERNAL "")		# Horizontal Vertical Position - Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
		set(ANSISYSSC		"${CSI}s"			CACHE INTERNAL "")		# Save Cursor – **With no parameters, performs a save cursor operation like DECSC
		set(ANSISYSRC		"${CSI}u"			CACHE INTERNAL "")		# Restore Cursor - **With no parameters, performs a restore cursor operation like DECRC

		#CSI n J	ED													# Erase in Display - Clears part of the screen. If n is 0 (or missing), clear from cursor to end of screen. If n is 1, clear from cursor to beginning of the screen. If n is 2, clear entire screen (and moves cursor to upper left on DOS ANSI.SYS). If n is 3, clear entire screen and delete all lines saved in the scrollback buffer.
		#CSI n K	EL													# Erase in Line - Erases part of the line. If n is 0 (or missing), clear from cursor to the end of the line. If n is 1, clear from cursor to beginning of the line. If n is 2, clear entire line. Cursor position does NOT change.
		#CSI n S	SU													# Scroll Up - Scroll whole page up by n (default 1) lines. New lines are added at the bottom. (NOT ANSI.SYS)
		#CSI n T	SD													# Scroll Down	- Scroll whole page down by n (default 1) lines. New lines are added at the top. (NOT ANSI.SYS)
		#CSI n ; m f	HVP												# Horizontal Vertical Position - Same as CUP, but counts as a format effector function (like CR or LF) rather than an editor function (like CUD or CNL).
		#CSI n m	SGR													# Select Graphic Rendition - Sets colors and style of the characters following this code
		#CSI 5i															# AUX Port On	- Enable aux serial port usually for local serial printer
		#CSI 4i															# AUX Port Off - Disable aux serial port usually for local serial printer
		#CSI 6n	DSR														# Device Status Report - Reports the cursor position (CPR) by transmitting ESC[n;mR, where n is the row and m is the column.
		set(ATT160				"${CSI}?12"		CACHE INTERNAL "")		# Text Cursor Blink
		set(DECTCEM				"${CSI}?25"		CACHE INTERNAL "")		# Text Cursor Show/Hide
	
		#(SU					"${CSI}<n>S"	CACHE INTERNAL "")		# Scroll Up - Scroll text up by <n>. Also known as pan down, new lines fill in from the bottom of the screen
		#(SD					"${CSI}<n>T"	CACHE INTERNAL "")		# Scroll Down - Scroll down by <n>. Also known as pan up, new lines fill in from the top of the screen

		set(DEC					"${ESC}(0"		CACHE INTERNAL "")		# Enables DEC Line Drawing Mode
		set(ASCII				"${ESC}(B"		CACHE INTERNAL "")		# Enables ASCII Mode (Default)

		## Cursor
		set(cursor_blink_on		"${ATT160}h"	CACHE INTERNAL "")		# Text Cursor Enable Blinking
		set(cursor_blink_off	"${ATT160}l"	CACHE INTERNAL "")		# Text Cursor Disable Blinking
		set(cursor_show			"${DECTCEM}h"	CACHE INTERNAL "")		# Text Cursor Enable Mode Show
		set(cursor_hide			"${DECTCEM}l"	CACHE INTERNAL "")		# Text Cursor Enable Mode Hide
		
		
		###### COLOR ###############################################
		# Attributes on
		set(clr 		"${ESC}[0m" 			CACHE INTERNAL "")		# Default					- Returns all attributes to the default state prior to modification
		set(bold 		"${ESC}[1m" 			CACHE INTERNAL "")		# Bold/Bright 				- Applies brightness/intensity flag to foreground color
		set(dim			"${ESC}[2m"				CACHE INTERNAL "")		# Dim
		set(italic		"${ESC}[3m"				CACHE INTERNAL "")		# Italic
		set(underline 	"${ESC}[4m" 			CACHE INTERNAL "")		# Underline       			- Adds underline
		set(blink		"${ESC}[5m"				CACHE INTERNAL "")		# Blink
		set(fblink		"${ESC}[6m"				CACHE INTERNAL "")		# Rapid Blink
		set(negative 	"${ESC}[7m" 			CACHE INTERNAL "")  	# Negative	    			- Swaps foreground and background colors
		set(invisible	"${ESC}[8m"				CACHE INTERNAL "")		# Invisible
		set(strike		"${ESC}[9m"				CACHE INTERNAL "")		# Strike Through
		
		# Attributes off
		#set(20m		"${ESC}[20m"			CACHE INTERNAL "")		# 20
		#set(21m		"${ESC}[21m"			CACHE INTERNAL "")		# 21
		set(nobold 		"${ESC}[22m" 			CACHE INTERNAL "")		# No bold/bright			- Removes brightness/intensity flag from foreground color
		set(noitalic	"${ESC}[23m"			CACHE INTERNAL "")		# No italic
		set(nounderline "${ESC}[24m"			CACHE INTERNAL "")		# No underline				- Removes underline
		set(noblink		"${ESC}[25m"			CACHE INTERNAL "")		# No blink
		#set(26m		"${ESC}[26m"			CACHE INTERNAL "")		# 26
		set(nonegative 	"${ESC}[27m" 			CACHE INTERNAL "")  	# Positive(No negative)		- Returns foreground/background to normal
		set(visible		"${ESC}[28m"			CACHE INTERNAL "")		# Visible
		set(nostrike	"${ESC}[29m"			CACHE INTERNAL "")		# No Strike Through
		
		# Foreground Colors
		set(black 		"${ESC}[30m" 			CACHE INTERNAL "")		# Foreground Black			- Applies non-bold/bright black to foreground
		set(red 		"${ESC}[31m" 			CACHE INTERNAL "")		# Foreground Red			- Applies non-bold/bright red to foreground
		set(green		"${ESC}[32m" 			CACHE INTERNAL "")		# Foreground Green			- Applies non-bold/bright green to foreground
		set(yellow 		"${ESC}[33m" 			CACHE INTERNAL "")		# Foreground Yellow			- Applies non-bold/bright yellow to foreground
		set(blue 		"${ESC}[34m" 			CACHE INTERNAL "")		# Foreground Blue			- Applies non-bold/bright blue to foreground
		set(magenta 	"${ESC}[35m" 			CACHE INTERNAL "")		# Foreground Magenta		- Applies non-bold/bright magenta to foreground
		set(cyan 		"${ESC}[36m" 			CACHE INTERNAL "")		# ([36m) Foreground Cyan	- Applies non-bold/bright cyan to foreground
		set(white 		"${ESC}[37m" 			CACHE INTERNAL "")		# Foreground White			- Applies non-bold/bright white to foreground
		set(extended 	"${ESC}[38m" 			CACHE INTERNAL "")		# Foreground Extended		- Applies extended color value to the foreground
		set(default 	"${ESC}[39m" 			CACHE INTERNAL "")		# Foreground Default		- Applies only the foreground portion of the defaults
		
		# Background Colors
		set(bg_black 	"${ESC}[40m" 			CACHE INTERNAL "")		# Background Black			- Applies non-bold/bright black to background
		set(bg_red 		"${ESC}[41m" 			CACHE INTERNAL "")		# Background Red			- Applies non-bold/bright red to background
		set(bg_green 	"${ESC}[42m" 			CACHE INTERNAL "")		# Background Green			- Applies non-bold/bright green to background
		set(bg_yellow 	"${ESC}[43m" 			CACHE INTERNAL "")		# Background Yellow			- Applies non-bold/bright yellow to background
		set(bg_blue 	"${ESC}[44m" 			CACHE INTERNAL "")		# Background Blue			- Applies non-bold/bright blue to background
		set(bg_magenta 	"${ESC}[45m" 			CACHE INTERNAL "")		# Background Magenta		- Applies non-bold/bright magenta to background
		set(bg_cyan 	"${ESC}[46m" 			CACHE INTERNAL "")		# Background Cyan			- Applies non-bold/bright cyan to background
		set(bg_white 	"${ESC}[47m" 			CACHE INTERNAL "")		# Background White			- Applies non-bold/bright white to background
		set(bg_extended "${ESC}[48m" 			CACHE INTERNAL "")		# Background Extended		- Applies extended color value to the background
		set(bg_default 	"${ESC}[49m" 			CACHE INTERNAL "")		# Background Default		- Applies only the background portion of the defaults
		
		# Foreground Colors (light)
		set(lblack 		"${ESC}[90m" 			CACHE INTERNAL "")		# Bright Foreground Black	- Applies bold/bright black to foreground
		set(lred 		"${ESC}[91m" 			CACHE INTERNAL "")		# Bright Foreground Red		- Applies bold/bright red to foreground
		set(lgreen 		"${ESC}[92m" 			CACHE INTERNAL "")		# Bright Foreground Green	- Applies bold/bright green to foreground
		set(lyellow 	"${ESC}[93m" 			CACHE INTERNAL "")		# Bright Foreground Yellow	- Applies bold/bright yellow to foreground
		set(lblue 		"${ESC}[94m" 			CACHE INTERNAL "")		# Bright Foreground Blue	- Applies bold/bright blue to foreground
		set(lmagenta 	"${ESC}[95m" 			CACHE INTERNAL "")		# Bright Foreground Magenta	- Applies bold/bright magenta to foreground
		set(lcyan 		"${ESC}[96m" 			CACHE INTERNAL "")		# Bright Foreground Cyan	- Applies bold/bright cyan to foreground
		set(lwhite 		"${ESC}[97m" 			CACHE INTERNAL "")		# Bright Foreground White	- Applies bold/bright white to foreground

		# Background Colors (light)
		set(bg_lblack 	"${ESC}[100m" 			CACHE INTERNAL "")		# Bright Background Black	- Applies bold/bright black to background
		set(bg_lred 	"${ESC}[101m"			CACHE INTERNAL "")		# Bright Background Red		- Applies bold/bright red to background
		set(bg_lgreen 	"${ESC}[102m"			CACHE INTERNAL "")		# Bright Background Green	- Applies bold/bright green to background
		set(bg_lyellow 	"${ESC}[103m" 			CACHE INTERNAL "")		# Bright Background Yellow	- Applies bold/bright yellow to background
		set(bg_lblue 	"${ESC}[104m" 			CACHE INTERNAL "")		# Bright Background Blue	- Applies bold/bright blue to background
		set(bg_lmagenta "${ESC}[105m" 			CACHE INTERNAL "")		# Bright Background Magenta	- Applies bold/bright magenta to background
		set(bg_lcyan 	"${ESC}[106m" 			CACHE INTERNAL "")		# Bright Background Cyan	- Applies bold/bright cyan to background
		set(bg_lwhite 	"${ESC}[107m" 			CACHE INTERNAL "")		# Bright Background White	- Applies bold/bright white to background
		
		# Foreground RGB Colors
		set(RGB 		"${ESC}[38;2;" 			CACHE INTERNAL "")		# ${RGB}50;100;150m 	= ${ESC}[38;2;50;100;150m
		
		# Background RGB Colors
		set(bg_RGB 		"${ESC}[48;2;"			CACHE INTERNAL "")		# ${bg_RGB}150;100;50m	= ${ESC}[38;2;150;100;50m
		
		#set(??? 		"${ESC}[J"				CACHE INTERNAL "")		# erase in display (same as ESC[0J)
		#set(??? 		"${ESC}[0J"				CACHE INTERNAL "")		# erase from cursor until end of screen
		#set(??? 		"${ESC}[1J"				CACHE INTERNAL "")		# erase from cursor to beginning of screen
		#set(??? 		"${ESC}[2J"				CACHE INTERNAL "")		# erase entire screen
		#set(??? 		"${ESC}[3J"				CACHE INTERNAL "")		# erase saved lines
		#set(??? 		"${ESC}[K"				CACHE INTERNAL "")		# erase in line (same as ESC[0K)
		#set(??? 		"${ESC}[0K"				CACHE INTERNAL "")		# erase from cursor to end of line
		#set(??? 		"${ESC}[1K"				CACHE INTERNAL "")		# erase start of line to the cursor
		#set(??? 		"${ESC}[2K"				CACHE INTERNAL "")		# erase the entire line
		
		dk_call(dk_echo("123456789${clr}"))
		dk_call( dk_echo("${blue}C${green}O${red}L${magenta}O${cyan}R ${blue}O${green}N${clr}"))		
		
	else()
		#dk_unset(ESC)
		#dk_unset(clr)
		
		# Attributes on
		dk_unset(bold)
		dk_unset(dim)
		dk_unset(italic)
		dk_unset(underline)
		dk_unset(blink)
		dk_unset(fblink)
		dk_unset(negative)
		dk_unset(invisible)
		dk_unset(strike)
		
		# Attributes off
		dk_unset(nobold)
		dk_unset(noitalic)
		dk_unset(nounderline)
		dk_unset(noblink)
		dk_unset(nonegative)
		dk_unset(novisible)
		dk_unset(nostrike)
		
		# Foreground Colors
		dk_unset(black)
		dk_unset(red)
		dk_unset(green)
		dk_unset(yellow)
		dk_unset(blue)
		dk_unset(magenta)
		dk_unset(cyan)
		dk_unset(white)
		
		# Background Colors
		dk_unset(bg_black)
		dk_unset(bg_red)
		dk_unset(bg_green)
		dk_unset(bg_yellow)
		dk_unset(bg_blue)
		dk_unset(bg_magenta)
		dk_unset(bg_cyan)
		dk_unset(bg_white)
		
		# Foreground Colors (Bright)
		dk_unset(lblack)
		dk_unset(lred)
		dk_unset(lgreen)
		dk_unset(lyellow)
		dk_unset(lblue)
		dk_unset(lmagenta)
		dk_unset(lcyan)
		dk_unset(lwhite)
		
		# Background Colors (Bright)
		dk_unset(bg_lblack)
		dk_unset(bg_lred)
		dk_unset(bg_lgreen)
		dk_unset(bg_lyellow)
		dk_unset(bg_lblue)
		dk_unset(bg_lmagenta)
		dk_unset(bg_lcyan)
		dk_unset(bg_lwhite)
		
		dk_unset(RGB)
		dk_unset(bg_RGB)
	
		dk_echo("${clr} COLOR OFF")
	endif()
endfunction()
dk_color(1)





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("${black}${bg_lblack}           Styles            ${clr}")
	dk_echo("\${clr}        ${clr} default ${clr}")
	dk_echo("\${bold}       ${bold} bold ${clr}")
	dk_echo("\${dim}        ${dim} dim  ${clr}")
	dk_echo("\${italic}     ${italic} italic  ${clr}")
	dk_echo("\${underline}  ${underline} underline ${clr}")
	dk_echo("\${blink}      ${blink} blink  ${clr}")
	dk_echo("\${fblink}     ${fblink} fblink  ${clr}")
	dk_echo("\${negative}   ${negative} negative ${clr}")
	dk_echo("\${invisible}  ${invisible} invisible ${clr}")
	dk_echo("\${strike}     ${strike} strike ${clr}")
	dk_echo()
	dk_echo()
	dk_echo("${black}${bg_lblack}      Foreground Colors      ${clr}")
	dk_echo("\${black}      ${black} black ${clr}")
	dk_echo("\${red}        ${red} red ${clr}")
	dk_echo("\${green}      ${green} green ${clr}")
	dk_echo("\${yellow}     ${yellow} yellow ${clr}")
	dk_echo("\${blue}       ${blue} blue ${clr}")
	dk_echo("\${magenta}    ${magenta} magenta ${clr}")
	dk_echo("\${cyan}       ${cyan} cyan ${clr}")
	dk_echo("\${white}      ${white} white ${clr}")
	dk_echo()
	dk_echo()
	dk_echo("${black}${bg_lblack}      Background Colors      ${clr}")
	dk_echo("\${bg_black}   ${bg_black} bg_black ${clr}")
	dk_echo("\${bg_red}     ${bg_red} bg_red ${clr}")
	dk_echo("\${bg_green}   ${bg_green} bg_green ${clr}")
	dk_echo("\${bg_yellow}  ${bg_yellow} bg_yellow ${clr}")
	dk_echo("\${bg_blue}    ${bg_blue} bg_blue ${clr}")
	dk_echo("\${bg_magenta} ${bg_magenta} bg_magenta ${clr}")
	dk_echo("\${bg_cyan}    ${bg_cyan} bg_cyan ${clr}")
	dk_echo("\${bg_white}   ${bg_white} bg_white ${clr}")
	dk_echo()
	dk_echo()
	dk_echo("${black}${bg_lblack} Foreground Colors (bright)  ${clr}")
	dk_echo("\${lblack}      ${lblack} lblack ${clr}")
	dk_echo("\${lred}        ${lred} lred ${clr}")
	dk_echo("\${lgreen}      ${lgreen} lgreen ${clr}")
	dk_echo("\${lyellow}     ${lyellow} lyellow ${clr}")
	dk_echo("\${lblue}       ${lblue} lblue ${clr}")
	dk_echo("\${lmagenta}    ${lmagenta} lmagenta ${clr}")
	dk_echo("\${lcyan}       ${lcyan} lcyan ${clr}")
	dk_echo("\${lwhite}      ${lwhite} lwhite ${clr}")
	dk_echo()
	dk_echo()
	dk_echo("${black}${bg_lblack} Background Colors (bright)  ${clr}")
	dk_echo("\${bg_lblack}   ${bg_lblack} bg_lblack ${clr}")
	dk_echo("\${bg_lred}     ${bg_lred} bg_lred ${clr}")
	dk_echo("\${bg_lgreen}   ${bg_lgreen} bg_lgreen ${clr}")
	dk_echo("\${bg_lyellow}  ${bg_lyellow} bg_lyellow ${clr}")
	dk_echo("\${bg_lblue}    ${bg_lblue} bg_lblue ${clr}")
	dk_echo("\${bg_lmagenta} ${bg_lmagenta} bg_lmagenta ${clr}")
	dk_echo("\${bg_lcyan}    ${bg_lcyan} bg_lcyan ${clr}")
	dk_echo("\${bg_lwhite}   ${bg_lwhite} bg_lwhite ${clr}")
	dk_echo()
	dk_echo()
	dk_echo("${black}${bg_lblack}    RGB Foreground Colors    ${clr}")
	dk_echo("${RGB}255;10;10m    RGB test (255;0;10)    ${clr}")
	dk_echo("${RGB}10;255;10m    RGB test (0;255;10)    ${clr}")
	dk_echo("${RGB}0;0;255m    RGB test (0;0;255)     ${clr}")
	dk_echo("${RGB}0;0;250m    RGB test (0;0;250)     ${clr}")
	dk_echo("${RGB}0;0;245m    RGB test (0;0;245)     ${clr}")
	dk_echo("${RGB}0;0;240m    RGB test (0;0;240)     ${clr}")
	dk_echo("${RGB}0;0;235m    RGB test (0;0;235)     ${clr}")
	dk_echo("${RGB}0;0;230m    RGB test (0;0;230)     ${clr}")
	dk_echo("${RGB}0;0;225m    RGB test (0;0;225)     ${clr}")
	dk_echo("${RGB}0;0;220m    RGB test (0;0;220)     ${clr}")
	dk_echo("${RGB}0;0;215m    RGB test (0;0;215)     ${clr}")
	dk_echo("${RGB}0;0;210m    RGB test (0;0;210)     ${clr}")
	dk_echo("${RGB}0;0;205m    RGB test (0;0;205)     ${clr}")
	dk_echo("${RGB}0;0;200m    RGB test (0;0;200)     ${clr}")
	dk_echo("${RGB}0;0;195m    RGB test (0;0;195)     ${clr}")
	dk_echo("${RGB}0;0;190m    RGB test (0;0;190)     ${clr}")
	dk_echo("${RGB}0;0;185m    RGB test (0;0;185)     ${clr}")
	dk_echo("${RGB}0;0;180m    RGB test (0;0;180)     ${clr}")
	dk_echo("${RGB}0;0;175m    RGB test (0;0;175)     ${clr}")
	dk_echo("${RGB}0;0;170m    RGB test (0;0;170)     ${clr}")
	dk_echo("${RGB}0;0;165m    RGB test (0;0;165)     ${clr}")
	dk_echo("${RGB}0;0;160m    RGB test (0;0;160)     ${clr}")
	dk_echo("${RGB}0;0;155m    RGB test (0;0;155)     ${clr}")
	dk_echo("${RGB}0;0;150m    RGB test (0;0;150)     ${clr}")
	dk_echo("${RGB}0;0;145m    RGB test (0;0;145)     ${clr}")
	dk_echo("${RGB}0;0;140m    RGB test (0;0;140)     ${clr}")
	dk_echo("${RGB}0;0;135m    RGB test (0;0;135)     ${clr}")
	dk_echo("${RGB}0;0;130m    RGB test (0;0;130)     ${clr}")
	dk_echo("${RGB}0;0;125m    RGB test (0;0;125)     ${clr}")
	dk_echo("${RGB}0;0;120m    RGB test (0;0;120)     ${clr}")
	dk_echo("${RGB}0;0;115m    RGB test (0;0;115)     ${clr}")
	dk_echo("${RGB}0;0;110m    RGB test (0;0;110)     ${clr}")
	dk_echo("${RGB}0;0;105m    RGB test (0;0;105)     ${clr}")
	dk_echo("${RGB}0;0;100m    RGB test (0;0;100)     ${clr}")
	dk_echo("${RGB}0;0;95m    RGB test (0;0;95)      ${clr}")
	dk_echo("${RGB}0;0;90m    RGB test (0;0;90)      ${clr}")
	dk_echo("${RGB}0;0;85m    RGB test (0;0;85)      ${clr}")
	dk_echo("${RGB}0;0;80m    RGB test (0;0;80)      ${clr}")
	dk_echo("${RGB}0;0;75m    RGB test (0;0;75)      ${clr}")
	dk_echo("${RGB}0;0;70m    RGB test (0;0;70)      ${clr}")
	dk_echo("${RGB}0;0;65m    RGB test (0;0;65)      ${clr}")
	dk_echo("${RGB}0;0;60m    RGB test (0;0;60)      ${clr}")
	dk_echo("${RGB}0;0;55m    RGB test (0;0;55)      ${clr}")
	dk_echo("${RGB}0;0;50m    RGB test (0;0;50)      ${clr}")
	dk_echo("${RGB}0;0;45m    RGB test (0;0;45)      ${clr}")
	dk_echo("${RGB}0;0;40m    RGB test (0;0;40)      ${clr}")
	dk_echo("${RGB}0;0;35m    RGB test (0;0;35)      ${clr}")
	dk_echo("${RGB}0;0;30m    RGB test (0;0;30)      ${clr}")
	dk_echo("${RGB}0;0;25m    RGB test (0;0;25)      ${clr}")
	dk_echo("${RGB}0;0;20m    RGB test (0;0;20)      ${clr}")
	dk_echo("${RGB}0;0;15m    RGB test (0;0;15)      ${clr}")
	dk_echo("${RGB}0;0;10m    RGB test (0;0;10)      ${clr}")
	dk_echo("${RGB}0;0;5m    RGB test (0;0;5)       ${clr}")
	dk_echo("${RGB}0;0;0m    RGB test (0;0;0)       ${clr}")
	dk_echo()
	dk_echo()
	dk_echo("${black}${bg_lblack}    RGB Background Colors     ${clr}")
	dk_echo("${bg_RGB}255;10;10m    bg_RGB test (255;0;10)    ${clr}")
	dk_echo("${bg_RGB}10;255;10m    bg_RGB test (0;255;10)    ${clr}")
	dk_echo("${bg_RGB}0;0;255m    bg_RGB test (0;0;255)     ${clr}")
	dk_echo("${bg_RGB}0;0;250m    bg_RGB test (0;0;250)     ${clr}")
	dk_echo("${bg_RGB}0;0;245m    bg_RGB test (0;0;245)     ${clr}")
	dk_echo("${bg_RGB}0;0;240m    bg_RGB test (0;0;240)     ${clr}")
	dk_echo("${bg_RGB}0;0;235m    bg_RGB test (0;0;235)     ${clr}")
	dk_echo("${bg_RGB}0;0;230m    bg_RGB test (0;0;230)     ${clr}")
	dk_echo("${bg_RGB}0;0;225m    bg_RGB test (0;0;225)     ${clr}")
	dk_echo("${bg_RGB}0;0;220m    bg_RGB test (0;0;220)     ${clr}")
	dk_echo("${bg_RGB}0;0;215m    bg_RGB test (0;0;215)     ${clr}")
	dk_echo("${bg_RGB}0;0;210m    bg_RGB test (0;0;210)     ${clr}")
	dk_echo("${bg_RGB}0;0;205m    bg_RGB test (0;0;205)     ${clr}")
	dk_echo("${bg_RGB}0;0;200m    bg_RGB test (0;0;200)     ${clr}")
	dk_echo("${bg_RGB}0;0;195m    bg_RGB test (0;0;195)     ${clr}")
	dk_echo("${bg_RGB}0;0;190m    bg_RGB test (0;0;190)     ${clr}")
	dk_echo("${bg_RGB}0;0;185m    bg_RGB test (0;0;185)     ${clr}")
	dk_echo("${bg_RGB}0;0;180m    bg_RGB test (0;0;180)     ${clr}")
	dk_echo("${bg_RGB}0;0;175m    bg_RGB test (0;0;175)     ${clr}")
	dk_echo("${bg_RGB}0;0;170m    bg_RGB test (0;0;170)     ${clr}")
	dk_echo("${bg_RGB}0;0;165m    bg_RGB test (0;0;165)     ${clr}")
	dk_echo("${bg_RGB}0;0;160m    bg_RGB test (0;0;160)     ${clr}")
	dk_echo("${bg_RGB}0;0;155m    bg_RGB test (0;0;155)     ${clr}")
	dk_echo("${bg_RGB}0;0;150m    bg_RGB test (0;0;150)     ${clr}")
	dk_echo("${bg_RGB}0;0;145m    bg_RGB test (0;0;145)     ${clr}")
	dk_echo("${bg_RGB}0;0;140m    bg_RGB test (0;0;140)     ${clr}")
	dk_echo("${bg_RGB}0;0;135m    bg_RGB test (0;0;135)     ${clr}")
	dk_echo("${bg_RGB}0;0;130m    bg_RGB test (0;0;130)     ${clr}")
	dk_echo("${bg_RGB}0;0;125m    bg_RGB test (0;0;125)     ${clr}")
	dk_echo("${bg_RGB}0;0;120m    bg_RGB test (0;0;120)     ${clr}")
	dk_echo("${bg_RGB}0;0;115m    bg_RGB test (0;0;115)     ${clr}")
	dk_echo("${bg_RGB}0;0;110m    bg_RGB test (0;0;110)     ${clr}")
	dk_echo("${bg_RGB}0;0;105m    bg_RGB test (0;0;105)     ${clr}")
	dk_echo("${bg_RGB}0;0;100m    bg_RGB test (0;0;100)     ${clr}")
	dk_echo("${bg_RGB}0;0;95m    bg_RGB test (0;0;95)      ${clr}")
	dk_echo("${bg_RGB}0;0;90m    bg_RGB test (0;0;90)      ${clr}")
	dk_echo("${bg_RGB}0;0;85m    bg_RGB test (0;0;85)      ${clr}")
	dk_echo("${bg_RGB}0;0;80m    bg_RGB test (0;0;80)      ${clr}")
	dk_echo("${bg_RGB}0;0;75m    bg_RGB test (0;0;75)      ${clr}")
	dk_echo("${bg_RGB}0;0;70m    bg_RGB test (0;0;70)      ${clr}")
	dk_echo("${bg_RGB}0;0;65m    bg_RGB test (0;0;65)      ${clr}")
	dk_echo("${bg_RGB}0;0;60m    bg_RGB test (0;0;60)      ${clr}")
	dk_echo("${bg_RGB}0;0;55m    bg_RGB test (0;0;55)      ${clr}")
	dk_echo("${bg_RGB}0;0;50m    bg_RGB test (0;0;50)      ${clr}")
	dk_echo("${bg_RGB}0;0;45m    bg_RGB test (0;0;45)      ${clr}")
	dk_echo("${bg_RGB}0;0;40m    bg_RGB test (0;0;40)      ${clr}")
	dk_echo("${bg_RGB}0;0;35m    bg_RGB test (0;0;35)      ${clr}")
	dk_echo("${bg_RGB}0;0;30m    bg_RGB test (0;0;30)      ${clr}")
	dk_echo("${bg_RGB}0;0;25m    bg_RGB test (0;0;25)      ${clr}")
	dk_echo("${bg_RGB}0;0;20m    bg_RGB test (0;0;20)      ${clr}")
	dk_echo("${bg_RGB}0;0;15m    bg_RGB test (0;0;15)      ${clr}")
	dk_echo("${bg_RGB}0;0;10m    bg_RGB test (0;0;10)      ${clr}")
	dk_echo("${bg_RGB}0;0;5m    bg_RGB test (0;0;5)       ${clr}")
	dk_echo("${bg_RGB}0;0;0m    bg_RGB test (0;0;0)       ${clr}")
	dk_echo()
	dk_echo()
	dk_echo("${black}${bg_lblack}        Combinations         ${clr}")
	dk_echo("\${negative}                             ${negative}   inverse foreground <-> background   ${clr}")
	dk_echo("\${bg_yellow}\${red}                     ${bg_yellow}${red}   yellow backgroud / red foreground   ${clr}")
	dk_echo("\${bg_yellow}\${red}\${negative}           ${bg_yellow}${red}${negative}        yellow / red inversed          ${clr}")
	dk_echo("\${bg_red}..\${bg_green}..\${bg_blue}     ${bg_red}    nested   ${bg_green}    colors    ${bg_blue}    text    ${clr}")
	dk_echo()
	dk_echo()
	dk_echo("${black}${bg_lblack}        ASCII Color Art       ${clr}")
	dk_echo("")
	dk_echo(" ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}")
	dk_echo(" ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}")
	dk_echo(" ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}") 
	dk_echo(" ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}")
	dk_echo(" ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}")
	dk_echo(" ${bg_blue}  * * * * * * * *  ${bg_white}                                  ${clr}")
	dk_echo(" ${bg_blue} * * * * * * * * * ${bg_red}                                  ${clr}")
	dk_echo(" ${bg_white}                                                     ${clr}")
	dk_echo(" ${bg_red}                                                     ${clr}")
	dk_echo(" ${bg_white}                                                     ${clr}")
	dk_echo(" ${bg_red}                                                     ${clr}")
	dk_echo(" ${bg_white}                                                     ${clr}")
	dk_echo(" ${bg_red}                                                     ${clr}")
endfunction()