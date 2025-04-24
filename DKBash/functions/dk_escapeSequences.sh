<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

# https://www.ascii-code.com
# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
##################################################################################
# dk_escapeSequences()
#
#
dk_escapeSequences() {
	dk_debugFunc 0
	
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

#	dk_call dk_echo
#	dk_call dk_echo "	SYMBOL	DEC	OCT	HEX	HTML	Description"
#	ASCII_size=${#ASCII[@]}
#	for (( i=0; i<${ASCII_size}; i++ ));
#	do
#		ASCII_SHOW ${i}
#	done
#	dk_call dk_echo

	dk_call dk_hexToVariable 0x00 NUL
	#dk_call dk_hexToVariable 0x01 SOH
	#dk_call dk_hexToVariable 0x02 STX
	#dk_call dk_hexToVariable 0x03 ETX
	#dk_call dk_hexToVariable 0x04 EOT
	#dk_call dk_hexToVariable 0x05 ENQ
	#dk_call dk_hexToVariable 0x06 ACK
	dk_call dk_hexToVariable 0x07 BEL
	#dk_call dk_hexToVariable 0x08 BS
	dk_call dk_hexToVariable 0x09 TAB
	#dk_call dk_hexToVariable 0x0a LF
	#dk_call dk_hexToVariable 0x0b VT
	#dk_call dk_hexToVariable 0x0c FF
	#dk_call dk_hexToVariable 0x0d CR
	#dk_call dk_hexToVariable 0x0e SO
	#dk_call dk_hexToVariable 0x0f SI
	#dk_call dk_hexToVariable 0x10 DLE
	#dk_call dk_hexToVariable 0x11 DC1
	#dk_call dk_hexToVariable 0x12 DC2
	#dk_call dk_hexToVariable 0x13 DC3
	#dk_call dk_hexToVariable 0x14 DC4
	#dk_call dk_hexToVariable 0x15 NAK
	#dk_call dk_hexToVariable 0x16 SYN
	#dk_call dk_hexToVariable 0x17 ETB
	#dk_call dk_hexToVariable 0x18 CAN
	#dk_call dk_hexToVariable 0x19 EM
	#dk_call dk_hexToVariable 0x1a SUB
	dk_call dk_hexToVariable 0x1b ESC
	#dk_call dk_hexToVariable 0x1c FS
	#dk_call dk_hexToVariable 0x1d GS
	#dk_call dk_hexToVariable 0x1e RS
	#dk_call dk_hexToVariable 0x1f US

	#dk_call dk_decimalToVariable 0 NUL
	#dk_call dk_decimalToVariable 1 SOH
	#dk_call dk_decimalToVariable 2 STX
	#dk_call dk_decimalToVariable 3 ETX
	#dk_call dk_decimalToVariable 4 EOT
	#dk_call dk_decimalToVariable 5 ENQ
	#dk_call dk_decimalToVariable 6 ACK
	#dk_call dk_decimalToVariable 7 BEL 
	#dk_call dk_decimalToVariable 8 BS
	#dk_call dk_decimalToVariable 9 TAB
	#dk_call dk_decimalToVariable 10 LF
	#dk_call dk_decimalToVariable 11 VT
	#dk_call dk_decimalToVariable 12 FF
	#dk_call dk_decimalToVariable 13 CR
	#dk_call dk_decimalToVariable 14 SO
	#dk_call dk_decimalToVariable 15 SI
	#dk_call dk_decimalToVariable 16 DLE
	#dk_call dk_decimalToVariable 17 DC1
	#dk_call dk_decimalToVariable 18 DC2
	#dk_call dk_decimalToVariable 19 DC3
	#dk_call dk_decimalToVariable 20 DC4
	#dk_call dk_decimalToVariable 21 NAK
	#dk_call dk_decimalToVariable 22 SYN
	#dk_call dk_decimalToVariable 23 ETB
	#dk_call dk_decimalToVariable 24 CAN
	#dk_call dk_decimalToVariable 25 EM
	#dk_call dk_decimalToVariable 26 SUB
	#dk_call dk_decimalToVariable 27 ESC
	#dk_call dk_decimalToVariable 28 FS
	#dk_call dk_decimalToVariable 29 GS
	#dk_call dk_decimalToVariable 30 RS
	#dk_call dk_decimalToVariable 31 US

	dk_call dk_set clear      "${ESC}[2J"
}

ASCII_ADD() {
	dk_debugFunc 6
	
	#https://linuxsimply.com/bash-scripting-tutorial/array/array-of-arrays/
	
	ID=0
	SYMBOL=1
	DEC=2
	OCT=3
	HEX=4
	HTML=5
	INFO=6
	
	ITEM[$ID]=${2}
	ITEM[$SYMBOL]=${1}
	ITEM[$DEC]=${2}
	ITEM[$OCT]=${3}
	ITEM[$HEX]=${4}
	ITEM[$HTML]=${5}
	ITEM[$INFO]=${6}
	#dk_call dk_echo "\${ITEM[@]::1} = ${ITEM[@]::1}"

	ASCII_size=${#ASCII[@]}
	ASCII[$ASCII_size]="${ITEM[@]}"

	# Associative array
	#ASCII[$ID,SYMBOL]=${1}
	#ASCII[$ID,DEC]=${2}
	#ASCII[$ID,OCT]=${3}
	#ASCII[$ID,HEX]=${4}
	#ASCII[$ID,HTML]=${5}
	#ASCII[$ID,INFO]=${6}
	#ASCII_length=$(( ASCII_length + 1 ))
}

ASCII_SHOW() {
	dk_debugFunc 1
	
	ITEM=(${ASCII[${1}]})
	dk_call dk_echo "${ITEM[$DEC]}	${ITEM[$SYMBOL]}	${ITEM[$DEC]}	${ITEM[$OCT]}	${ITEM[$HEX]}	${ITEM[$HTML]}	${ITEM[$INFO]}"
	
	# Associative array
	#dk_call dk_echo "${ASCII[${1},DEC]}	${ASCII[${1},SYMBOL]}	${ASCII[${1},DEC]}	${ASCII[${1},OCT]}	${ASCII[${1},HEX]}	${ASCII[${1},HTML]}	${ASCII[${1},INFO]}"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_escapeSequences
}
