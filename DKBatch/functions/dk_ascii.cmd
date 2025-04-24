@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################
 
 
::##################################################################################
::# dk_wslFixNet(message)
::#
::# https://home.unicode.org
::#	https://en.wikipedia.org/wiki/Code_page_437
::#
:dk_wslFixNet
setlocal enableDelayedExpansion

	echo DEC	OCT		HEX		BIN			Symbol	 HTML#		HTMLName	Description
	echo ---------------------------------------------------------------------------------------
	echo 0		000		00		00000000	NULL 	^&#00;		^			Null character
	echo 1		001		01		00000001			^&#01;		^			Start of Heading
	echo 2		002		02		00000010			^&#02;		^			Start of Text
	echo 3		003		03		00000011			^&#03;		^			End of Text
	echo 4		004		04		00000100			^&#04;		^			End of Transmission
	echo 5		005		05		00000101			^&#05;		^			Enquiry
	echo 6		006		06		00000110			^&#06;		^			Acknowledge
	echo 7		007		07		00000111			^&#07;		^			Bell, Alert
	echo 8		010		08		00001000			^&#08;		^			Backspace
	echo 9		011		09		00001001			^&#09;		^			Horizontal Tab
	echo 10		012		0A		00001010	LF		^&#10;		^			Line Feed
	echo 11		013		0B		00001011	VT		^&#11;		^			Vertical Tabulation
	echo 12		014		0C		00001100	FF		^&#12;		^			Form Feed
	echo 13		015		0D		00001101	CR		^&#13;		^			Carriage Return
	echo 14		016		0E		00001110			^&#14;		^			Shift Out
	echo 15		017		0F		00001111			^&#15;		^			Shift In
	echo 16		020		10		00010000			^&#16;		^			Data Link Escape
	echo 17		021		11		00010001			^&#17;		^			Device Control One (XON)
	echo 18		022		12		00010010			^&#18;		^			Device Control Two
	echo 19		023		13		00010011			^&#19;		^			Device Control Three (XOFF)
	echo 20		024		14		00010100			^&#20;		^			Device Control Four
	echo 21		025		15		00010101			^&#21;		^			Negative Acknowledge
	echo 22		026		16		00010110			^&#22;		^			Synchronous Idle
	echo 23		027		17		00010111			^&#23;		^			End of Transmission Block
	echo 24		030		18		00011000			^&#24;		^			Cancel
	echo 25		031		19		00011001			^&#25;		^			End of medium
	echo 26		032		1A		00011010			^&#26;		^			Substitute
	echo 27		033		1B		00011011			^&#27;		^			Escape
	echo 28		034		1C		00011100			^&#28;		^			File Separator
	echo 29		035		1D		00011101			^&#29;		^			Group Separator
	echo 30		036		1E		00011110			^&#30;		^			Record Separator
	echo 31		037		1F		00011111			^&#31;		^			Unit Separator
	echo 32		040		20		00100000	 		^&#32;		^			Space
setlocal disable DelayedExpansion
	echo 33		041		21		00100001	!		^&#33;		^&excl;		Exclamation mark
endlocal
	echo 34		042		22		00100010	^"		^&#34;		^&quot;		Double quotes (or speech marks)
	echo 35		043		23		00100011	#		^&#35;		^&num;	 	Number sign
	echo 36		044		24		00100100	$		^&#36;		^&dollar;	Dollar
	echo 37		045		25		00100101	%%		^&#37;		^&percnt;	Per cent sign
	echo 38		046		26		00100110	^&		^&#38;		^&amp;	 	Ampersand
	echo 39		047		27		00100111	'		^&#39;		^&apos;		Single quote
	echo 40		050		28		00101000	(		^&#40;		^&lparen;	Open parenthesis (or open bracket)
	echo 41		051		29		00101001	)		^&#41;		^&rparen;	Close parenthesis (or close bracket)
	echo 42		052		2A		00101010	*		^&#42;		^&ast;	 	Asterisk
	echo 43		053		2B		00101011	+		^&#43;		^&plus;		Plus
	echo 44		054		2C		00101100	,		^&#44;		^&comma;	Comma
	echo 45		055		2D		00101101	-		^&#45;		^			Hyphen-minus
	echo 46		056		2E		00101110	.		^&#46;		^&period;	Period, dot or full stop
	echo 47		057		2F		00101111	/		^&#47;		^&sol;	 	Slash or divide
	echo 48		060		30		00110000	0		^&#48;		^			Zero
	echo 49		061		31		00110001	1		^&#49;		^			One
	echo 50		062		32		00110010	2		^&#50;		^			Two
	echo 51		063		33		00110011	3		^&#51;		^			Three
	echo 52		064		34		00110100	4		^&#52;		^			Four
	echo 53		065		35		00110101	5		^&#53;		^			Five
	echo 54		066		36		00110110	6		^&#54;		^			Six
	echo 55		067		37		00110111	7		^&#55;		^			Seven
	echo 56		070		38		00111000	8		^&#56;		^			Eight
	echo 57		071		39		00111001	9		^&#57;		^			Nine
	echo 58		072		3A		00111010	:		^&#58;		^&colon;	Colon
	echo 59		073		3B		00111011	;		^&#59;		^&semi;	S	emicolon
	echo 60		074		3C		00111100	^<		^&#60;		^&lt;		Less than (or open angled bracket)
	echo 61		075		3D		00111101	=		^&#61;		^&equals;	Equals
	echo 62		076		3E		00111110	^>		^&#62;		^&gt;		Greater than (or close angled bracket)
	echo 63		077		3F		00111111	?		^&#63;		^&quest;	Question mark
	echo 64		100		40		01000000	@		^&#64;		^&commat;	At sign
	echo 65		101		41		01000001	A		^&#65;		^			Uppercase A
	echo 66		102		42		01000010	B		^&#66;		^			Uppercase B
	echo 67		103		43		01000011	C		^&#67;		^			Uppercase C
	echo 68		104		44		01000100	D		^&#68;		^			Uppercase D
	echo 69		105		45		01000101	E		^&#69;		^			Uppercase E
	echo 70		106		46		01000110	F		^&#70;		^			Uppercase F
	echo 71		107		47		01000111	G		^&#71;		^			Uppercase G
	echo 72		110		48		01001000	H		^&#72;		^			Uppercase H
	echo 73		111		49		01001001	I		^&#73;		^			Uppercase I
	echo 74		112		4A		01001010	J		^&#74;		^			Uppercase J
	echo 75		113		4B		01001011	K		^&#75;		^			Uppercase K
	echo 76		114		4C		01001100	L		^&#76;		^			Uppercase L
	echo 77		115		4D		01001101	M		^&#77;		^			Uppercase M
	echo 78		116		4E		01001110	N		^&#78;		^			Uppercase N
	echo 79		117		4F		01001111	O		^&#79;		^			Uppercase O
	echo 80		120		50		01010000	P		^&#80;		^			Uppercase P
	echo 81		121		51		01010001	Q		^&#81;		^			Uppercase Q
	echo 82		122		52		01010010	R		^&#82;		^			Uppercase R
	echo 83		123		53		01010011	S		^&#83;		^			Uppercase S
	echo 84		124		54		01010100	T		^&#84;		^			Uppercase T
	echo 85		125		55		01010101	U		^&#85;		^			Uppercase U
	echo 86		126		56		01010110	V		^&#86;		^			Uppercase V
	echo 87		127		57		01010111	W		^&#87;		^			Uppercase W
	echo 88		130		58		01011000	X		^&#88;		^			Uppercase X
	echo 89		131		59		01011001	Y		^&#89;		^			Uppercase Y
	echo 90		132		5A		01011010	Z		^&#90;		^			Uppercase Z
	echo 91		133		5B		01011011	[		^&#91;		^&lsqb;		Opening bracket
	echo 92		134		5C		01011100	\		^&#92;		^&bsol;		Backslash
	echo 93		135		5D		01011101	]		^&#93;		^&rsqb;		Closing bracket
	echo 94		136		5E		01011110	^^		^&#94;		^&Hat;	 	Caret - circumflex
	echo 95		137		5F		01011111	_		^&#95;		^&lowbar;	Underscore
	echo 96		140		60		01100000	`		^&#96;		^&gave;		Grave accent
	echo 97		141		61		01100001	a		^&#97;		^			Lowercase a
	echo 98		142		62		01100010	b		^&#98;		^			Lowercase b
	echo 99		143		63		01100011	c		^&#99;		^			Lowercase c
	echo 100	144		64		01100100	d		^&#100;		^			Lowercase d
	echo 101	145		65		01100101	e		^&#101;		^			Lowercase e
	echo 102	146		66		01100110	f		^&#102;		^			Lowercase f
	echo 103	147		67		01100111	g		^&#103;		^			Lowercase g
	echo 104	150		68		01101000	h		^&#104;		^			Lowercase h
	echo 105	151		69		01101001	i		^&#105;		^			Lowercase i
	echo 106	152		6A		01101010	j		^&#106;		^			Lowercase j
	echo 107	153		6B		01101011	k		^&#107;		^			Lowercase k
	echo 108	154		6C		01101100	l		^&#108;		^			Lowercase l
	echo 109	155		6D		01101101	m		^&#109;		^			Lowercase m
	echo 110	156		6E		01101110	n		^&#110;		^			Lowercase n
	echo 111	157		6F		01101111	o		^&#111;		^			Lowercase o
	echo 112	160		70		01110000	p		^&#112;		^			Lowercase p
	echo 113	161		71		01110001	q		^&#113;		^			Lowercase q
	echo 114	162		72		01110010	r		^&#114;		^			Lowercase r
	echo 115	163		73		01110011	s		^&#115;		^			Lowercase s
	echo 116	164		74		01110100	t		^&#116;		^			Lowercase t
	echo 117	165		75		01110101	u		^&#117;		^			Lowercase u
	echo 118	166		76		01110110	v		^&#118;		^			Lowercase v
	echo 119	167		77		01110111	w		^&#119;		^			Lowercase w
	echo 120	170		78		01111000	x		^&#120;		^			Lowercase x
	echo 121	171		79		01111001	y		^&#121;		^			Lowercase y
	echo 122	172		7A		01111010	z		^&#122;		^			Lowercase z
	echo 123	173		7B		01111011	{		^&#123;		^&lcub;		Opening brace
	echo 124	174		7C		01111100	^|		^&#124;		^&verbar;	Vertical bar
	echo 125	175		7D		01111101	}		^&#125;		^&rcub;		Closing brace
	echo 126	176		7E		01111110	~		^&#126;		^&tilde;	Equivalency sign - tilde
	echo 127	177		7F		01111111	DEL		^&#127;		^			Delete
	echo 128	200		80		10000000	€		^&#8364;	^&euro;		Euro sign
	echo 129	201		81		10000001			^			^			Unused
	echo 130	202		82		10000010	‚		^&#130;		^&sbquo;	Single low-9 quotation mark
	echo 131	203		83		10000011	ƒ		^&#131;		^&fnof;		Latin small letter f with hook
	echo 132	204		84		10000100	„		^&#132;		^&bdquo;	Double low-9 quotation mark
	echo 133	205		85		10000101	…		^&#133;		^&hellip;	Horizontal ellipsis
	echo 134	206		86		10000110	†		^&#134;		^&dagger;	Dagger
	echo 135	207		87		10000111	‡		^&#135;		^&Dagger;	Double dagger
	echo 136	210		88		10001000	ˆ		^&#136;		^&circ;		Modifier letter circumflex accent
	echo 137	211		89		10001001	‰		^&#137;		^&permil;	Per mille sign
	echo 138	212		8A		10001010	Š		^&#138;		^&Scaron;	Latin capital letter S with caron
	echo 139	213		8B		10001011	‹		^&#139;		^&lsaquo;	Single left-pointing angle quotation
	echo 140	214		8C		10001100	Œ		^&#140;		^&OElig;	Latin capital ligature OE
	echo 141	215		8D		10001101			^			 ^			Unused
	echo 142	216		8E		10001110	Ž		^&#142;		^&Zcaron;	Latin capital letter Z with caron
	echo 143	217		8F		10001111			^			 ^			Unused
	echo 144	220		90		10010000			^			 ^			Unused
	echo 145	221		91		10010001	‘		^&#145;		^&lsquo;	Left single quotation mark
	echo 146	222		92		10010010	’		^&#146;		^&rsquo;	Right single quotation mark
	echo 147	223		93		10010011	“		^&#147;		^&ldquo;	Left double quotation mark
	echo 148	224		94		10010100	”		^&#148;		^&rdquo;	Right double quotation mark
	echo 149	225		95		10010101	•		^&#149;		^&bull;		Bullet
	echo 150	226		96		10010110	–		^&#150;		^&ndash;	En dash
	echo 151	227		97		10010111	—		^&#151;		^&mdash;	Em dash
	echo 152	230		98		10011000	˜		^&#152;		^&tilde;	Small tilde
	echo 153	231		99		10011001	™		^&#153;		^&trade;	Trade mark sign
	echo 154	232		9A		10011010	š		^&#154;		^&scaron;	Latin small letter S with caron
	echo 155	233		9B		10011011	›		^&#155;		^&rsaquo;	Single right-pointing angle quotation mark
	echo 156	234		9C		10011100	œ		^&#156;		^&oelig;	Latin small ligature oe
	echo 157	235		9D		10011101			^		 	^			Unused
	echo 158	236		9E		10011110	ž		^&#158;		^&zcaron;	Latin small letter z with caron
	echo 159	237		9F		10011111	Ÿ		^&#159;		^&Yuml;		Latin capital letter Y with diaeresis
	echo 160	240		A0		10100000	NBSP	^&#160;		^&nbsp;		Non-breaking space
	echo 161	241		A1		10100001	¡		^&#161;		^&iexcl;	Inverted exclamation mark
	echo 162	242		A2		10100010	¢		^&#162;		^&cent;		Cent sign
	echo 163	243		A3		10100011	£		^&#163;		^&pound;	Pound sign
	echo 164	244		A4		10100100	¤		^&#164;		^&curren;	Currency sign
	echo 165	245		A5		10100101	¥		^&#165;		^&yen;		Yen sign
	echo 166	246		A6		10100110	¦		^&#166;		^&brvbar;	Pipe, broken vertical bar
	echo 167	247		A7		10100111	§		^&#167;		^&sect;		Section sign
	echo 168	250		A8		10101000	¨		^&#168;		^&uml;		Spacing diaeresis - umlaut
	echo 169	251		A9		10101001	©		^&#169;		^&copy;		Copyright sign
	echo 170	252		AA		10101010	ª		^&#170;		^&ordf;		Feminine ordinal indicator
	echo 171	253		AB		10101011	«		^&#171;		^&laquo;	Left double angle quotes
	echo 172	254		AC		10101100	¬		^&#172;		^&not;		Negation
	echo 173	255		AD		10101101	SHY		^&#173;		^&shy;		Soft hyphen
	echo 174	256		AE		10101110	®		^&#174;		^&reg;		Registered trade mark sign
	echo 175	257		AF		10101111	¯		^&#175;		^&macr;		Spacing macron - overline
	echo 176	260		B0		10110000	°		^&#176;		^&deg;		Degree sign
	echo 177	261		B1		10110001	±		^&#177;		^&plusmn;	Plus-or-minus sign
	echo 178	262		B2		10110010	²		^&#178;		^&sup2;		Superscript two - squared
	echo 179	263		B3		10110011	³		^&#179;		^&sup3;		Superscript three - cubed
	echo 180	264		B4		10110100	´		^&#180;		^&acute;	Acute accent - spacing acute
	echo 181	265		B5		10110101	µ		^&#181;		^&micro;	Micro sign
	echo 182	266		B6		10110110	¶		^&#182;		^&para;		Pilcrow sign - paragraph sign
	echo 183	267		B7		10110111	·		^&#183;		^&middot;	Middle dot - Georgian comma
	echo 184	270		B8		10111000	¸		^&#184;		^&cedil;	Spacing cedilla
	echo 185	271		B9		10111001	¹		^&#185;		^&sup1;		Superscript one
	echo 186	272		BA		10111010	º		^&#186;		^&ordm;		Masculine ordinal indicator
	echo 187	273		BB		10111011	»		^&#187;		^&raquo;	Right double angle quotes
	echo 188	274		BC		10111100	¼		^&#188;		^&frac14;	Fraction one quarter
	echo 189	275		BD		10111101	½		^&#189;		^&frac12;	Fraction one half
	echo 190	276		BE		10111110	¾		^&#190;		^&frac34;	Fraction three quarters
	echo 191	277		BF		10111111	¿		^&#191;		^&iquest;	Inverted question mark
	echo 192	300		C0		11000000	À		^&#192;		^&Agrave;	Latin capital letter A with grave
	echo 193	301		C1		11000001	Á		^&#193;		^&Aacute;	Latin capital letter A with acute
	echo 194	302		C2		11000010	Â		^&#194;		^&Acirc;	Latin capital letter A with circumflex
	echo 195	303		C3		11000011	Ã		^&#195;		^&Atilde;	Latin capital letter A with tilde
	echo 196	304		C4		11000100	Ä		^&#196;		^&Auml;		Latin capital letter A with diaeresis
	echo 197	305		C5		11000101	Å		^&#197;		^&Aring;	Latin capital letter A with ring above
	echo 198	306		C6		11000110	Æ		^&#198;		^&AElig;	Latin capital letter AE
	echo 199	307		C7		11000111	Ç		^&#199;		^&Ccedil;	Latin capital letter C with cedilla
	echo 200	310		C8		11001000	È		^&#200;		^&Egrave;	Latin capital letter E with grave
	echo 201	311		C9		11001001	É		^&#201;		^&Eacute;	Latin capital letter E with acute
	echo 202	312		CA		11001010	Ê		^&#202;		^&Ecirc;	Latin capital letter E with circumflex
	echo 203	313		CB		11001011	Ë		^&#203;		^&Euml;		Latin capital letter E with diaeresis
	echo 204	314		CC		11001100	Ì		^&#204;		^&Igrave;	Latin capital letter I with grave
	echo 205	315		CD		11001101	Í		^&#205;		^&Iacute;	Latin capital letter I with acute
	echo 206	316		CE		11001110	Î		^&#206;		^&Icirc;	Latin capital letter I with circumflex
	echo 207	317		CF		11001111	Ï		^&#207;		^&Iuml;		Latin capital letter I with diaeresis
	echo 208	320		D0		11010000	Ð		^&#208;		^&ETH;		Latin capital letter ETH
	echo 209	321		D1		11010001	Ñ		^&#209;		^&Ntilde;	Latin capital letter N with tilde
	echo 210	322		D2		11010010	Ò		^&#210;		^&Ograve;	Latin capital letter O with grave
	echo 211	323		D3		11010011	Ó		^&#211;		^&Oacute;	Latin capital letter O with acute
	echo 212	324		D4		11010100	Ô		^&#212;		^&Ocirc;	Latin capital letter O with circumflex
	echo 213	325		D5		11010101	Õ		^&#213;		^&Otilde;	Latin capital letter O with tilde
	echo 214	326		D6		11010110	Ö		^&#214;		^&Ouml;		Latin capital letter O with diaeresis
	echo 215	327		D7		11010111	×		^&#215;		^&times;	Multiplication sign
	echo 216	330		D8		11011000	Ø		^&#216;		^&Oslash;	Latin capital letter O with slash
	echo 217	331		D9		11011001	Ù		^&#217;		^&Ugrave;	Latin capital letter U with grave
	echo 218	332		DA		11011010	Ú		^&#218;		^&Uacute;	Latin capital letter U with acute
	echo 219	333		DB		11011011	Û		^&#219;		^&Ucirc;	Latin capital letter U with circumflex
	echo 220	334		DC		11011100	Ü		^&#220;		^&Uuml;		Latin capital letter U with diaeresis
	echo 221	335		DD		11011101	Ý		^&#221;		^&Yacute;	Latin capital letter Y with acute
	echo 222	336		DE		11011110	Þ		^&#222;		^&THORN;	Latin capital letter THORN
	echo 223	337		DF		11011111	ß		^&#223;		^&szlig;	Latin small letter sharp s - ess-zed
	echo 224	340		E0		11100000	à		^&#224;		^&agrave;	Latin small letter a with grave
	echo 225	341		E1		11100001	á		^&#225;		^&aacute;	Latin small letter a with acute
	echo 226	342		E2		11100010	â		^&#226;		^&acirc;	Latin small letter a with circumflex
	echo 227	343		E3		11100011	ã		^&#227;		^&atilde;	Latin small letter a with tilde
	echo 228	344		E4		11100100	ä		^&#228;		^&auml;		Latin small letter a with diaeresis
	echo 229	345		E5		11100101	å		^&#229;		^&aring;	Latin small letter a with ring above
	echo 230	346		E6		11100110	æ		^&#230;		^&aelig;	Latin small letter ae
	echo 231	347		E7		11100111	ç		^&#231;		^&ccedil;	Latin small letter c with cedilla
	echo 232	350		E8		11101000	è		^&#232;		^&egrave;	Latin small letter e with grave
	echo 233	351		E9		11101001	é		^&#233;		^&eacute;	Latin small letter e with acute
	echo 234	352		EA		11101010	ê		^&#234;		^&ecirc;	Latin small letter e with circumflex
	echo 235	353		EB		11101011	ë		^&#235;		^&euml;		Latin small letter e with diaeresis
	echo 236	354		EC		11101100	ì		^&#236;		^&igrave;	Latin small letter i with grave
	echo 237	355		ED		11101101	í		^&#237;		^&iacute;	Latin small letter i with acute
	echo 238	356		EE		11101110	î		^&#238;		^&icirc;	Latin small letter i with circumflex
	echo 239	357		EF		11101111	ï		^&#239;		^&iuml;		Latin small letter i with diaeresis
	echo 240	360		F0		11110000	ð		^&#240;		^&eth;	 	Latin small letter eth
	echo 241	361		F1		11110001	ñ		^&#241;		^&ntilde;	Latin small letter n with tilde
	echo 242	362		F2		11110010	ò		^&#242;		^&ograve;	Latin small letter o with grave
	echo 243	363		F3		11110011	ó		^&#243;		^&oacute;	Latin small letter o with acute
	echo 244	364		F4		11110100	ô		^&#244;		^&ocirc;	Latin small letter o with circumflex
	echo 245	365		F5		11110101	õ		^&#245;		^&otilde;	Latin small letter o with tilde
	echo 246	366		F6		11110110	ö		^&#246;		^&ouml;		Latin small letter o with diaeresis
	echo 247	367		F7		11110111	÷		^&#247;		^&divide;	Division sign
	echo 248	370		F8		11111000	ø		^&#248;		^&oslash;	Latin small letter o with slash
	echo 249	371		F9		11111001	ù		^&#249;		^&ugrave;	Latin small letter u with grave
	echo 250	372		FA		11111010	ú		^&#250;		^&uacute;	Latin small letter u with acute
	echo 251	373		FB		11111011	û		^&#251;		^&ucirc;	Latin small letter u with circumflex
	echo 252	374		FC		11111100	ü		^&#252;		^&uuml;		Latin small letter u with diaeresis
	echo 253	375		FD		11111101	ý		^&#253;		^&yacute;	Latin small letter y with acute
	echo 254	376		FE		11111110	þ		^&#254;		^&thorn;	Latin small letter thorn
	echo 255	377		FF		11111111	ÿ		^&#255;		^&yuml;		Latin small letter y with diaeresis67

pause