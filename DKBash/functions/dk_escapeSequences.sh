#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


# https://www.ascii-code.com
# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797

##################################################################################
# dk_escapeSequences()
#
#
dk_escapeSequences () {
	dk_debugFunc
	

#	# ASCII control characters (character code 0-31)
#	#	      		SYMBOL	DEC		OCT		HEX		HTML		Description
#	ASCII_ADD		NUL		0		000		0x00	\#00		"Null character"
#	ASCII_ADD		SOH		1		001		0x01	\#01		"Start of Heading"
#	ASCII_ADD		STX		2		002		0x02	\#02		"Start of Text"
#	ASCII_ADD		ETX		3		003		0x03	\#03		"End of Text"
#	ASCII_ADD		EOT		4		004		0x04	\#04		"End of Transmission"
#	ASCII_ADD		ENQ		5		005		0x05	\#05		"Enquiry"
#	ASCII_ADD		ACK		6		006		0x06	\#06		"Acknowledge"
#	ASCII_ADD		BEL		7		007		0x07	\#07		"Bell, Alert"
#	ASCII_ADD		BS		8		010		0x08	\#08		"Backspace"
#	ASCII_ADD		HT		9		011		0x09	\#09		"Horizontal Tab"
#	ASCII_ADD		LF		10		012		0x0a	\#10		"Line Feed"
#	ASCII_ADD		VT		11		013		0x0b	\#11		"Vertical Tabulation"
#	ASCII_ADD		FF		12		014		0x0c	\#12		"Form Feed"
#	ASCII_ADD		CR		13		015		0x0d	\#13		"Carriage Return"
#	ASCII_ADD		SO		14		016		0x0e	\#14		"Shift Out"
#	ASCII_ADD		SI		15		017		0x0f	\#15		"Shift In"
#	ASCII_ADD		DLE		16		020		0x10	\#16		"Data Link Escape"
#	ASCII_ADD		DC1		17		021		0x11	\#17		"Device Control One (XON)"
#	ASCII_ADD		DC2		18		022		0x12	\#18		"Device Control Two"
#	ASCII_ADD		DC3		19		023		0x13	\#19		"Device Control Three (XOFF)"
#	ASCII_ADD		DC4		20		024		0x14	\#20		"Device Control Four"
#	ASCII_ADD		NAK		21		025		0x15	\#21		"Negative Acknowledge"
#	ASCII_ADD		SYN		22		026		0x16	\#22		"Synchronous Idle"
#	ASCII_ADD		ETB		23		027		0x17	\#23		"End of Transmission Block"
#	ASCII_ADD		CAN		24		030		0x18	\#24		"Cancel"
#	ASCII_ADD		EM		25		031		0x19	\#25		"End of medium"
#	ASCII_ADD		SUB		26		032		0x1a	\#26		"Substitute"
#	ASCII_ADD		ESC		27		033		0x1b	\#27		"Escape"
#	ASCII_ADD		FS		28		034		0x1c	\#28		"File Separator"
#	ASCII_ADD		GS		29		035		0x1d	\#29		"Group Separator"
#	ASCII_ADD		RS		30		036		0x1e	\#30		"Record Separator"
#	ASCII_ADD		US		31		037		0x1f	\#31		"Unit Separator"



#	dk_echo ""
#	dk_echo "	SYMBOL	DEC	OCT	HEX	HTML	Description"
#	ASCII_size=${#ASCII[@]}
#	for (( i=0; i<${ASCII_size}; i++ ));
#	do
#		ASCII_SHOW $i
#	done
#	dk_echo ""




	dk_hexToVariable NUL 0x00
	#dk_hexToVariable SOH 0x01
	#dk_hexToVariable STX 0x02
	#dk_hexToVariable ETX 0x03
	#dk_hexToVariable EOT 0x04
	#dk_hexToVariable ENQ 0x05
	#dk_hexToVariable ACK 0x06
	dk_hexToVariable BEL 0x07
	#dk_hexToVariable BS  0x08
	dk_hexToVariable TAB 0x09
	#dk_hexToVariable LF  0x0a
	#dk_hexToVariable VT  0x0b
	#dk_hexToVariable FF  0x0c
	#dk_hexToVariable CR  0x0d
	#dk_hexToVariable SO  0x0e
	#dk_hexToVariable SI  0x0f
	#dk_hexToVariable DLE 0x10
	#dk_hexToVariable DC1 0x11
	#dk_hexToVariable DC2 0x12
	#dk_hexToVariable DC3 0x13
	#dk_hexToVariable DC4 0x14
	#dk_hexToVariable NAK 0x15
	#dk_hexToVariable SYN 0x16
	#dk_hexToVariable ETB 0x17
	#dk_hexToVariable CAN 0x18
	#dk_hexToVariable EM  0x19
	#dk_hexToVariable SUB 0x1a
	dk_hexToVariable ESC 0x1b
	#dk_hexToVariable FS  0x1c
	#dk_hexToVariable GS  0x1d
	#dk_hexToVariable RS  0x1e
	#dk_hexToVariable US  0x1f

	#dk_decimalToVariable NUL 0
	#dk_decimalToVariable SOH 1
	#dk_decimalToVariable STX 2
	#dk_decimalToVariable ETX 3
	#dk_decimalToVariable EOT 4
	#dk_decimalToVariable ENQ 5
	#dk_decimalToVariable ACK 6
	#dk_decimalToVariable BEL 7 
	#dk_decimalToVariable BS  8
	#dk_decimalToVariable TAB 9
	#dk_decimalToVariable LF  10
	#dk_decimalToVariable VT  11
	#dk_decimalToVariable FF  12
	#dk_decimalToVariable CR  13
	#dk_decimalToVariable SO  14
	#dk_decimalToVariable SI  15
	#dk_decimalToVariable DLE 16
	#dk_decimalToVariable DC1 17
	#dk_decimalToVariable DC2 18
	#dk_decimalToVariable DC3 19
	#dk_decimalToVariable DC4 20
	#dk_decimalToVariable NAK 21
	#dk_decimalToVariable SYN 22
	#dk_decimalToVariable ETB 23
	#dk_decimalToVariable CAN 24
	#dk_decimalToVariable EM  25
	#dk_decimalToVariable SUB 26
	#dk_decimalToVariable ESC 27
	#dk_decimalToVariable FS  28
	#dk_decimalToVariable GS  29
	#dk_decimalToVariable RS  30
	#dk_decimalToVariable US  31


	dk_set clear      "$ESC[2J"

	# Attributes
	dk_set clr        "$ESC[0m"
	dk_set bold       "$ESC[1m"
	dk_set underline  "$ESC[4m"
	dk_set blink      "$ESC[5m"
	dk_set inverse    "$ESC[7m"
	dk_set invisible  "$ESC[8m"

	# Foreground Colors
	dk_set black      "$ESC[30m"
	dk_set red        "$ESC[31m"
	dk_set green      "$ESC[32m"
	dk_set yellow     "$ESC[33m"
	dk_set blue       "$ESC[34m"
	dk_set magenta    "$ESC[35m"
	dk_set cyan       "$ESC[36m"
	dk_set white      "$ESC[37m"

	# Background Colors
	dk_set bg_black   "$ESC[40m"
	dk_set bg_red     "$ESC[41m"
	dk_set bg_green   "$ESC[42m"
	dk_set bg_yellow  "$ESC[43m"
	dk_set bg_blue    "$ESC[44m"
	dk_set bg_magenta "$ESC[45m"
	dk_set bg_cyan    "$ESC[46m"
	dk_set bg_white   "$ESC[47m"

	# Foreground Colors (Bright)
	dk_set Black      "$ESC[90m"
	dk_set Red        "$ESC[91m"
	dk_set Green      "$ESC[92m"
	dk_set Yellow     "$ESC[93m"
	dk_set Blue       "$ESC[94m"
	dk_set Magenta    "$ESC[95m"
	dk_set Cyan       "$ESC[96m"
	dk_set White      "$ESC[97m"

	# Background Colors (Bright)
	dk_set BG_Black   "$ESC[100m"
	dk_set BG_Red     "$ESC[101m"
	dk_set BG_Green   "$ESC[102m"
	dk_set BG_Yellow  "$ESC[103m"
	dk_set BG_Blue    "$ESC[104m"
	dk_set BG_Magenta "$ESC[105m"
	dk_set BG_Cyan    "$ESC[106m"
	dk_set BG_White   "$ESC[107m"
}

ASCII_ADD () {
	dk_debugFunc
	
	#https://linuxsimply.com/bash-scripting-tutorial/array/array-of-arrays/
	
	ID=0
	SYMBOL=1
	DEC=2
	OCT=3
	HEX=4
	HTML=5
	INFO=6
	
	ITEM[$ID]=$2
	ITEM[$SYMBOL]=$1
	ITEM[$DEC]=$2
	ITEM[$OCT]=$3
	ITEM[$HEX]=$4
	ITEM[$HTML]=$5
	ITEM[$INFO]=$6
	#echo "\${ITEM[@]::1} = ${ITEM[@]::1}"

	ASCII_size=${#ASCII[@]}
	ASCII[$ASCII_size]="${ITEM[@]}"

	# Associative array
	#ASCII[$ID,SYMBOL]=$1
	#ASCII[$ID,DEC]=$2
	#ASCII[$ID,OCT]=$3
	#ASCII[$ID,HEX]=$4
	#ASCII[$ID,HTML]=$5
	#ASCII[$ID,INFO]=$6
	#ASCII_length=$(( ASCII_length + 1 ))
}

ASCII_SHOW () {
	dk_debugFunc
	
	ITEM=(${ASCII[$1]})
	echo "${ITEM[$DEC]}	${ITEM[$SYMBOL]}	${ITEM[$DEC]}	${ITEM[$OCT]}	${ITEM[$HEX]}	${ITEM[$HTML]}	${ITEM[$INFO]}"
	
	# Associative array
	#echo "${ASCII[$1,DEC]}	${ASCII[$1,SYMBOL]}	${ASCII[$1,DEC]}	${ASCII[$1,OCT]}	${ASCII[$1,HEX]}	${ASCII[$1,HTML]}	${ASCII[$1,INFO]}"
}
