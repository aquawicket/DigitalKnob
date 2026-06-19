// https://en.wikipedia.org/wiki/ASCII
// https://home.unicode.org
// https://en.wikipedia.org/wiki/Code_page_437

#pragma once
#ifndef dk_keyboardEvent_h
#define dk_keyboardEvent_h

#include "DK.h"
#include <conio.h>
#include <stdio.h>
/*
//               DEC	    OCT		HEX		  BIN			    Symbol	 HTML#		HTMLName	Description
//-----------------------------------------------------------------------------------------------------
const int  			= 0;		//000		00		00000000	  		&#00;						Null character
const int  			= 1;		//001		01		00000001			&#01;						Start of Heading
const int  			= 2;		//002		02		00000010			&#02;						Start of Text
const int  			= 3;		//003		03		00000011			&#03;						End of Text
const int  			= 4;		//004		04		00000100			&#04;						End of Transmission
const int  			= 5;		//005		05		00000101			&#05;						Enquiry
const int  			= 6;		//006		06		00000110			&#06;						Acknowledge
const int  			= 7;		//007		07		00000111			&#07;						Bell, Alert
const int  			= 8;		//010		08		00001000			&#08;						Backspace
const int  			= 9;		//011		09		00001001			&#09;						Horizontal Tab
const int  			= 10;		//012		0A		00001010	LF		&#10;						Line Feed
const int  			= 11;		//013		0B		00001011	VT		&#11;						Vertical Tabulation
const int  			= 12;		//014		0C		00001100	FF		&#12;						Form Feed
const int  			= 13;		//015		0D		00001101	CR		&#13;						Carriage Return
const int  			= 14;		//016		0E		00001110			&#14;						Shift Out
const int  			= 15;		//017		0F		00001111			&#15;						Shift In
const int  			= 16;		//020		10		00010000			&#16;						Data Link Escape
const int  			= 17;		//021		11		00010001			&#17;						Device Control One (XON)
const int  			= 18;		//022		12		00010010			&#18;						Device Control Two
const int  			= 19;		//023		13		00010011			&#19;						Device Control Three (XOFF)
const int  			= 20;		//024		14		00010100			&#20;						Device Control Four
const int  			= 21;		//025		15		00010101			&#21;						Negative Acknowledge
const int  			= 22;		//026		16		00010110			&#22;						Synchronous Idle
const int  			= 23;		//027		17		00010111			&#23;						End of Transmission Block
const int  			= 24;		//030		18		00011000			&#24;						Cancel
const int CANCEL	= 25;		//031		19		00011001			&#25;						End of medium
const int  			= 26;		//032		1A		00011010			&#26;						Substitute
const int ESC 		= 27;		//033		1B		00011011			&#27;						Escape
const int SPACE 	= 32;		//034		1C		00011100			&#28;						File Separator
const int  			= 33;		//041		21		00100001	!		&#33;		&excl;			Exclamation mark
const int  			= 34;		//042		22		00100010	"		&#34;		&quot;			Double quotes (or speech marks)
const int  			= 35;		//043		23		00100011	#		&#35;		&num;		 	Number sign
const int  			= 36;		//044		24		00100100	$		&#36;		&dollar;		Dollar
const int 			= 37;		//045		25		00100101	%%		&#37;		&percnt;		Per cent sign
const int 			= 38;		//046		26		00100110	&		&#38;		&amp;		 	Ampersand
const int 			= 39;		//047		27		00100111	'		&#39;		&apos;			Single quote
const int 			= 40;		//050		28		00101000	(		&#40;		&lparen;		Open parenthesis (or open bracket)
const int 			= 41;		//051		29		00101001	)		&#41;		&rparen;		Close parenthesis (or close bracket)
const int 			= 42;		//052		2A		00101010	*		&#42;		&ast;		 	Asterisk
const int 			= 43;		//053		2B		00101011	+		&#43;		&plus;			Plus
const int 			= 44;		//054		2C		00101100	,		&#44;		&comma;			Comma
const int 			= 45;		//055		2D		00101101	-		&#45;						Hyphen-minus
const int 			= 46;		//056		2E		00101110	.		&#46;		&period;		Period, dot or full stop
const int 			= 47;		//057		2F		00101111	/		&#47;		&sol;		 	Slash or divide
const int 			= 48;		//060		30		00110000	0		&#48;						Zero
const int 			= 49;		//061		31		00110001	1		&#49;						One
const int 			= 50;		//062		32		00110010	2		&#50;						Two
const int 			= 51;		//063		33		00110011	3		&#51;						Three
const int 			= 52;		//064		34		00110100	4		&#52;						Four
const int 			= 53;		//065		35		00110101	5		&#53;						Five
const int 			= 54;		//066		36		00110110	6		&#54;						Six
const int 			= 55;		//067		37		00110111	7		&#55;						Seven
const int 			= 56;		//070		38		00111000	8		&#56;						Eight
const int 			= 57;		//071		39		00111001	9		&#57;						Nine
const int 			= 58;		//072		3A		00111010	:		&#58;		&colon;			Colon
const int 			= 59;		//073		3B		00111011	;		&#59;		&semi;			Semicolon
const int 			= 60;		//074		3C		00111100	<		&#60;		&lt;			Less than (or open angled bracket)
const int 			= 61;		//075		3D		00111101	=		&#61;		&equals;		Equals
const int 			= 62;		//076		3E		00111110	>		&#62;		&gt;			Greater than (or close angled bracket)
const int 			= 63;		//077		3F		00111111	?		&#63;		&quest;			Question mark
const int 			= 64;		//100		40		01000000	@		&#64;		&commat;		At sign
const int 			= 65;		//101		41		01000001	A		&#65;						Uppercase A
const int 			= 66;		//102		42		01000010	B		&#66;						Uppercase B
const int 			= 67;		//103		43		01000011	C		&#67;						Uppercase C
const int 			= 68;		//104		44		01000100	D		&#68;						Uppercase D
const int 			= 69;		//105		45		01000101	E		&#69;						Uppercase E
const int 			= 70;		//106		46		01000110	F		&#70;						Uppercase F
const int 			= 71;		//107		47		01000111	G		&#71;						Uppercase G
const int 			= 72;		//110		48		01001000	H		&#72;						Uppercase H
const int 			= 73;		//111		49		01001001	I		&#73;						Uppercase I
const int 			= 74;		//112		4A		01001010	J		&#74;						Uppercase J
const int 			= 75;		//113		4B		01001011	K		&#75;						Uppercase K
const int 			= 76;		//114		4C		01001100	L		&#76;						Uppercase L
const int 			= 77;		//115		4D		01001101	M		&#77;						Uppercase M
const int 			= 78;		//116		4E		01001110	N		&#78;						Uppercase N
const int 			= 79;		//117		4F		01001111	O		&#79;						Uppercase O
const int 			= 80;		//120		50		01010000	P		&#80;						Uppercase P
const int 			= 81;		//121		51		01010001	Q		&#81;						Uppercase Q
const int 			= 82;		//122		52		01010010	R		&#82;						Uppercase R
const int 			= 83;		//123		53		01010011	S		&#83;						Uppercase S
const int 			= 84;		//124		54		01010100	T		&#84;						Uppercase T
const int 			= 85;		//125		55		01010101	U		&#85;						Uppercase U
const int 			= 86;		//126		56		01010110	V		&#86;						Uppercase V
const int 			= 87;		//127		57		01010111	W		&#87;						Uppercase W
const int 			= 88;		//130		58		01011000	X		&#88;						Uppercase X
const int 			= 89;		//131		59		01011001	Y		&#89;						Uppercase Y
const int 			= 90;		//132		5A		01011010	Z		&#90;						Uppercase Z
const int 			= 91;		//133		5B		01011011	[		&#91;		&lsqb;			Opening bracket
const int 			= 92;		//134		5C		01011100	\		&#92;		&bsol;			Backslash
const int 			= 93;		//135		5D		01011101	]		&#93;		&rsqb;			Closing bracket
const int 			= 94;		//136		5E		01011110	^		&#94;		&Hat;			Caret - circumflex
const int 			= 95;		//137		5F		01011111	_		&#95;		&lowbar;		Underscore
const int 			= 96;		//140		60		01100000	`		&#96;		&gave;			Grave accent
const int 			= 97;		//141		61		01100001	a		&#97;						Lowercase a
const int 			= 98;		//142		62		01100010	b		&#98;						Lowercase b
const int 			= 99;		//143		63		01100011	c		&#99;						Lowercase c
const int 			= 100;		//144		64		01100100	d		&#100;						Lowercase d
const int 			= 101;		//145		65		01100101	e		&#101;						Lowercase e
const int 			= 102;		//146		66		01100110	f		&#102;						Lowercase f
const int 			= 103;		//147		67		01100111	g		&#103;						Lowercase g
const int 			= 104;		//150		68		01101000	h		&#104;						Lowercase h
const int 			= 105;		//151		69		01101001	i		&#105;						Lowercase i
const int 			= 106;		//152		6A		01101010	j		&#106;						Lowercase j
const int 			= 107;		//153		6B		01101011	k		&#107;						Lowercase k
const int 			= 108;		//154		6C		01101100	l		&#108;						Lowercase l
const int 			= 109;		//155		6D		01101101	m		&#109;						Lowercase m
const int 			= 110;		//156		6E		01101110	n		&#110;						Lowercase n
const int 			= 111;		//157		6F		01101111	o		&#111;						Lowercase o
const int 			= 112;		//160		70		01110000	p		&#112;						Lowercase p
const int 			= 113;		//161		71		01110001	q		&#113;						Lowercase q
const int 			= 114;		//162		72		01110010	r		&#114;						Lowercase r
const int 			= 115;		//163		73		01110011	s		&#115;						Lowercase s
const int 			= 116;		//164		74		01110100	t		&#116;						Lowercase t
const int 			= 117;		//165		75		01110101	u		&#117;						Lowercase u
const int 			= 118;		//166		76		01110110	v		&#118;						Lowercase v
const int 			= 119;		//167		77		01110111	w		&#119;						Lowercase w
const int 			= 120;		//170		78		01111000	x		&#120;						Lowercase x
const int 			= 121;		//171		79		01111001	y		&#121;						Lowercase y
const int 			= 122;		//172		7A		01111010	z		&#122;						Lowercase z
const int 			= 123;		//173		7B		01111011	{		&#123;		&lcub;			Opening brace
const int 			= 124;		//174		7C		01111100	|		&#124;		&verbar;		Vertical bar
const int 			= 125;		//175		7D		01111101	}		&#125;		&rcub;			Closing brace
const int 			= 126;		//176		7E		01111110	~		&#126;		&tilde;			Equivalency sign - tilde
const int 			= 127;		//177		7F		01111111	DEL		&#127;						Delete
const int 			= 128;		//200		80		10000000	€		&#8364;		&euro;			Euro sign
const int 			= 129;		//201		81		10000001										Unused
const int 			= 130;		//202		82		10000010	‚		&#130;		&sbquo;			Single low-9 quotation mark
const int 			= 131;		//203		83		10000011	ƒ		&#131;		&fnof;			Latin small letter f with hook
const int 			= 132;		//204		84		10000100	„		&#132;		&bdquo;			Double low-9 quotation mark
const int 			= 133;		//205		85		10000101	…		&#133;		&hellip;		Horizontal ellipsis
const int 			= 134;		//206		86		10000110	†		&#134;		&dagger;		Dagger
const int 			= 135;		//207		87		10000111	‡		&#135;		&Dagger;		Double dagger
const int 			= 136;		//210		88		10001000	ˆ		&#136;		&circ;			Modifier letter circumflex accent
const int 			= 137;		//211		89		10001001	‰		&#137;		&permil;		Per mille sign
const int 			= 138;		//212		8A		10001010	Š		&#138;		&Scaron;		Latin capital letter S with caron
const int 			= 139;		//213		8B		10001011	‹		&#139;		&lsaquo;		Single left-pointing angle quotation
const int 			= 140;		//214		8C		10001100	Œ		&#140;		&OElig;			Latin capital ligature OE
const int 			= 141;		//215		8D		10001101						 				Unused
const int 			= 142;		//216		8E		10001110	Ž		&#142;		&Zcaron;		Latin capital letter Z with caron
const int 			= 143;		//217		8F		10001111						 				Unused
const int 			= 144;		//220		90		10010000						 				Unused
const int 			= 145;		//221		91		10010001	‘		&#145;		&lsquo;			Left single quotation mark
const int 			= 146;		//222		92		10010010	’		&#146;		&rsquo;			Right single quotation mark
const int 			= 147;		//223		93		10010011	“		&#147;		&ldquo;			Left double quotation mark
const int 			= 148;		//224		94		10010100	”		&#148;		&rdquo;			Right double quotation mark
const int 			= 149;		//225		95		10010101	•		&#149;		&bull;			Bullet
const int 			= 150;		//226		96		10010110	–		&#150;		&ndash;			En dash
const int 			= 151;		//227		97		10010111	—		&#151;		&mdash;			Em dash
const int 			= 152;		//230		98		10011000	˜		&#152;		&tilde;			Small tilde
const int 			= 153;		//231		99		10011001	™		&#153;		&trade;			Trade mark sign
const int 			= 154;		//232		9A		10011010	š		&#154;		&scaron;		Latin small letter S with caron
const int 			= 155;		//233		9B		10011011	›		&#155;		&rsaquo;		Single right-pointing angle quotation mark
const int 			= 156;		//234		9C		10011100	œ		&#156;		&oelig;			Latin small ligature oe
const int 			= 157;		//235		9D		10011101					 					Unused
const int 			= 158;		//236		9E		10011110	ž		&#158;		&zcaron;		Latin small letter z with caron
const int 			= 159;		//237		9F		10011111	Ÿ		&#159;		&Yuml;			Latin capital letter Y with diaeresis
const int 			= 160;		//240		A0		10100000	NBSP	&#160;		&nbsp;			Non-breaking space
const int 			= 161;		//241		A1		10100001	¡		&#161;		&iexcl;			Inverted exclamation mark
const int 			= 162;		//242		A2		10100010	¢		&#162;		&cent;			Cent sign
const int 			= 163;		//243		A3		10100011	£		&#163;		&pound;			Pound sign
const int 			= 164;		//244		A4		10100100	¤		&#164;		&curren;		Currency sign
const int 			= 165;		//245		A5		10100101	¥		&#165;		&yen;			Yen sign
const int 			= 166;		//246		A6		10100110	¦		&#166;		&brvbar;		Pipe, broken vertical bar
const int 			= 167;		//247		A7		10100111	§		&#167;		&sect;			Section sign
const int 			= 168;		//250		A8		10101000	¨		&#168;		&uml;			Spacing diaeresis - umlaut
const int 			= 169;		//251		A9		10101001	©		&#169;		&copy;			Copyright sign
const int 			= 170;		//252		AA		10101010	ª		&#170;		&ordf;			Feminine ordinal indicator
const int 			= 171;		//253		AB		10101011	«		&#171;		&laquo;			Left double angle quotes
const int 			= 172;		//254		AC		10101100	¬		&#172;		&not;			Negation
const int 			= 173;		//255		AD		10101101	SHY		&#173;		&shy;			Soft hyphen
const int 			= 174;		//256		AE		10101110	®		&#174;		&reg;			Registered trade mark sign
const int 			= 175;		//257		AF		10101111	¯		&#175;		&macr;			Spacing macron - overline
const int 			= 176;		//260		B0		10110000	°		&#176;		&deg;			Degree sign
const int 			= 177;		//261		B1		10110001	±		&#177;		&plusmn;		Plus-or-minus sign
const int 			= 178;		//262		B2		10110010	²		&#178;		&sup2;			Superscript two - squared
const int 			= 179;		//263		B3		10110011	³		&#179;		&sup3;			Superscript three - cubed
const int 			= 180;		//264		B4		10110100	´		&#180;		&acute;			Acute accent - spacing acute
const int 			= 181;		//265		B5		10110101	µ		&#181;		&micro;			Micro sign
const int 			= 182;		//266		B6		10110110	¶		&#182;		&para;			Pilcrow sign - paragraph sign
const int 			= 183;		//267		B7		10110111	·		&#183;		&middot;		Middle dot - Georgian comma
const int 			= 184;		//270		B8		10111000	¸		&#184;		&cedil;			Spacing cedilla
const int 			= 185;		//271		B9		10111001	¹		&#185;		&sup1;			Superscript one
const int 			= 186;		//272		BA		10111010	º		&#186;		&ordm;			Masculine ordinal indicator
const int 			= 187;		//273		BB		10111011	»		&#187;		&raquo;			Right double angle quotes
const int 			= 188;		//274		BC		10111100	¼		&#188;		&frac14;		Fraction one quarter
const int 			= 189;		//275		BD		10111101	½		&#189;		&frac12;		Fraction one half
const int 			= 190;		//276		BE		10111110	¾		&#190;		&frac34;		Fraction three quarters
const int 			= 191;		//277		BF		10111111	¿		&#191;		&iquest;		Inverted question mark
const int 			= 192;		//300		C0		11000000	À		&#192;		&Agrave;		Latin capital letter A with grave
const int 			= 193;		//301		C1		11000001	Á		&#193;		&Aacute;		Latin capital letter A with acute
const int 			= 194;		//302		C2		11000010	Â		&#194;		&Acirc;			Latin capital letter A with circumflex
const int 			= 195;		//303		C3		11000011	Ã		&#195;		&Atilde;		Latin capital letter A with tilde
const int 			= 196;		//304		C4		11000100	Ä		&#196;		&Auml;			Latin capital letter A with diaeresis
const int 			= 197;		//305		C5		11000101	Å		&#197;		&Aring;			Latin capital letter A with ring above
const int 			= 198;		//306		C6		11000110	Æ		&#198;		&AElig;			Latin capital letter AE
const int 			= 199;		//307		C7		11000111	Ç		&#199;		&Ccedil;		Latin capital letter C with cedilla
const int 			= 200;		//310		C8		11001000	È		&#200;		&Egrave;		Latin capital letter E with grave
const int 			= 201;		//311		C9		11001001	É		&#201;		&Eacute;		Latin capital letter E with acute
const int 			= 202;		//312		CA		11001010	Ê		&#202;		&Ecirc;			Latin capital letter E with circumflex
const int 			= 203;		//313		CB		11001011	Ë		&#203;		&Euml;			Latin capital letter E with diaeresis
const int 			= 204;		//314		CC		11001100	Ì		&#204;		&Igrave;		Latin capital letter I with grave
const int 			= 205;		//315		CD		11001101	Í		&#205;		&Iacute;		Latin capital letter I with acute
const int 			= 206;		//316		CE		11001110	Î		&#206;		&Icirc;			Latin capital letter I with circumflex
const int 			= 207;		//317		CF		11001111	Ï		&#207;		&Iuml;			Latin capital letter I with diaeresis
const int 			= 208;		//320		D0		11010000	Ð		&#208;		&ETH;			Latin capital letter ETH
const int 			= 209;		//321		D1		11010001	Ñ		&#209;		&Ntilde;		Latin capital letter N with tilde
const int 			= 210;		//322		D2		11010010	Ò		&#210;		&Ograve;		Latin capital letter O with grave
const int 			= 211;		//323		D3		11010011	Ó		&#211;		&Oacute;		Latin capital letter O with acute
const int 			= 212;		//324		D4		11010100	Ô		&#212;		&Ocirc;			Latin capital letter O with circumflex
const int 			= 213;		//325		D5		11010101	Õ		&#213;		&Otilde;		Latin capital letter O with tilde
const int 			= 214;		//326		D6		11010110	Ö		&#214;		&Ouml;			Latin capital letter O with diaeresis
const int 			= 215;		//327		D7		11010111	×		&#215;		&times;			Multiplication sign
const int 			= 216;		//330		D8		11011000	Ø		&#216;		&Oslash;		Latin capital letter O with slash
const int 			= 217;		//331		D9		11011001	Ù		&#217;		&Ugrave;		Latin capital letter U with grave
const int 			= 218;		//332		DA		11011010	Ú		&#218;		&Uacute;		Latin capital letter U with acute
const int 			= 219;		//333		DB		11011011	Û		&#219;		&Ucirc;			Latin capital letter U with circumflex
const int 			= 220;		//334		DC		11011100	Ü		&#220;		&Uuml;			Latin capital letter U with diaeresis
const int 			= 221;		//335		DD		11011101	Ý		&#221;		&Yacute;		Latin capital letter Y with acute
const int 			= 222;		//336		DE		11011110	Þ		&#222;		&THORN;			Latin capital letter THORN
const int 			= 223;		//337		DF		11011111	ß		&#223;		&szlig;			Latin small letter sharp s - ess-zed
const int 			= 224;		//340		E0		11100000	à		&#224;		&agrave;		Latin small letter a with grave
const int 			= 225;		//341		E1		11100001	á		&#225;		&aacute;		Latin small letter a with acute
const int 			= 226;		//342		E2		11100010	â		&#226;		&acirc;			Latin small letter a with circumflex
const int 			= 227;		//343		E3		11100011	ã		&#227;		&atilde;		Latin small letter a with tilde
const int 			= 228;		//344		E4		11100100	ä		&#228;		&auml;			Latin small letter a with diaeresis
const int 			= 229;		//345		E5		11100101	å		&#229;		&aring;			Latin small letter a with ring above
const int 			= 230;		//346		E6		11100110	æ		&#230;		&aelig;			Latin small letter ae
const int 			= 231;		//347		E7		11100111	ç		&#231;		&ccedil;		Latin small letter c with cedilla
const int 			= 232;		//350		E8		11101000	è		&#232;		&egrave;		Latin small letter e with grave
const int 			= 233;		//351		E9		11101001	é		&#233;		&eacute;		Latin small letter e with acute
const int 			= 234;		//352		EA		11101010	ê		&#234;		&ecirc;			Latin small letter e with circumflex
const int 			= 235;		//353		EB		11101011	ë		&#235;		&euml;			Latin small letter e with diaeresis
const int 			= 236;		//354		EC		11101100	ì		&#236;		&igrave;		Latin small letter i with grave
const int 			= 237;		//355		ED		11101101	í		&#237;		&iacute;		Latin small letter i with acute
const int 			= 238;		//356		E		11101110	î		&#238;		&icirc;			Latin small letter i with circumflex
const int 			= 239;		//357		EF		11101111	ï		&#239;		&iuml;			Latin small letter i with diaeresis
const int 			= 240;		//360		F0		11110000	ð		&#240;		&eth;		 	Latin small letter eth
const int 			= 241;		//361		F1		11110001	ñ		&#241;		&ntilde;		Latin small letter n with tilde
const int 			= 242;		//362		F2		11110010	ò		&#242;		&ograve;		Latin small letter o with grave
const int 			= 243;		//363		F3		11110011	ó		&#243;		&oacute;		Latin small letter o with acute
const int 			= 244;		//364		F4		11110100	ô		&#244;		&ocirc;			Latin small letter o with circumflex
const int 			= 245;		//365		F5		11110101	õ		&#245;		&otilde;		Latin small letter o with tilde
const int 			= 246;		//366		F6		11110110	ö		&#246;		&ouml;			Latin small letter o with diaeresis
const int 			= 247;		//367		F7		11110111	÷		&#247;		&divide;		Division sign
const int 			= 248;		//370		F8		11111000	ø		&#248;		&oslash;		Latin small letter o with slash
const int 			= 249;		//371		F9		11111001	ù		&#249;		&ugrave;		Latin small letter u with grave
const int 			= 250;		//372		FA		11111010	ú		&#250;		&uacute;		Latin small letter u with acute
const int 			= 251;		//373		FB		11111011	û		&#251;		&ucirc;			Latin small letter u with circumflex
const int 			= 252;		//374		FC		11111100	ü		&#252;		&uuml;			Latin small letter u with diaeresis
const int 			= 253;		//375		FD		11111101	ý		&#253;		&yacute;		Latin small letter y with acute
const int 			= 254;		//376		FE		11111110	þ		&#254;		&thorn;			Latin small letter thorn
const int 			= 255;		//377		FF		11111111
*/


//################################################################################
//# dk_keyboardEvent()
//#
void dk_keyboardEvent(char* key){

	if(_kbhit()){
		*key = _getch();
		
		if(*key == 27){
			printf("ESC\n");
		}
		return;
	}
};

#endif //dk_keyboardEvent_h



/*
int kbhit(void)
{
    int k;

    ioctl(STDIN_FILENO,FIONREAD,&k);

    return(k);
}
*/