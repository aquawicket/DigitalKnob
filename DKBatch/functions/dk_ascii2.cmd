@echo off&::###### DK.cmd #########################################################################################################################
set "DKBATCH_FUNCTIONS_DIR_=C:/Users/Administrator/DigitalKnob/Development/DKBatch/functions/"
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::##################################################################################
::# dk_ascii()
::#
::# https://www.ascii-code.com/
::# https://en.wikipedia.org/wiki/ASCII
::# https://home.unicode.org
::# https://en.wikipedia.org/wiki/Code_page_437
::#
:dk_ascii
setlocal DisableDelayedExpansion

    echo  DEC    OCT     HEX   BIN         ^Symbol    ^HTML#     ^HTMLName     Description                     ^Printed
    echo ----------------------------------------------------------------------------------------------------------------------
    echo    0    000     00    00000000    ^NUL       ^&#00;     ^             Null character                                  
    echo    1    001     01    00000001    ^SOH       ^&#01;     ^             Start of Heading                '^'          
    echo    2    002     02    00000010    ^STX       ^&#02;     ^             Start of Text                   '^'          
    echo    3    003     03    00000011    ^ETX       ^&#03;     ^             End of Text                     '^'          
    echo    4    004     04    00000100    ^EQT       ^&#04;     ^             End of Transmission             '^'          
    echo    5    005     05    00000101    ^ENQ       ^&#05;     ^             Enquiry                         '^'          
    echo    6    006     06    00000110    ^ACK       ^&#06;     ^             Acknowledge                     '^'          
    echo    7    007     07    00000111    ^BEL       ^&#07;     ^             Bell, Alert                     '^'          
    echo    8    010     08    00001000    ^BS        ^&#08;     ^             Backspace                       '^'           
    echo    9    011     09    00001001    ^TAB       ^&#09;     ^             Horizontal Tab                  '^	'          
    echo   10    012     0A    00001010    ^LF        ^&#10;     ^             Line Feed                       '^
'           
    echo   11    013     0B    00001011    ^VT        ^&#11;     ^             Vertical Tabulation             '^'           
    echo   12    014     0C    00001100    ^FF        ^&#12;     ^             Form Feed                       '^'           
    echo   13    015     0D    00001101    ^CR        ^&#13;     ^             Carriage Return                 '^'           
    echo   14    016     0E    00001110    ^SO        ^&#14;     ^             Shift Out                       '^'           
    echo   15    017     0F    00001111    ^SI        ^&#15;     ^             Shift In                        '^'           
    echo   16    020     10    00010000    ^DLE       ^&#16;     ^             Data Link Escape                '^'          
    echo   17    021     11    00010001    ^DC1       ^&#17;     ^             Device Control One (XON)        '^'          
    echo   18    022     12    00010010    ^DC2       ^&#18;     ^             Device Control Two              '^'          
    echo   19    023     13    00010011    ^DC3       ^&#19;     ^             Device Control Three (XOFF)     '^'          
    echo   20    024     14    00010100    ^DC4       ^&#20;     ^             Device Control Four             '^'          
    echo   21    025     15    00010101    ^NAK       ^&#21;     ^             Negative Acknowledge            '^'          
    echo   22    026     16    00010110    ^SYN       ^&#22;     ^             Synchronous Idle                '^'          
    echo   23    027     17    00010111    ^ETB       ^&#23;     ^             End of Transmission Block       '^'          
    echo   24    030     18    00011000    ^CAN       ^&#24;     ^             Cancel                          '^'          
    echo   25    031     19    00011001    ^EM        ^&#25;     ^             End of medium                   '^'           
    echo   26    032     1A    00011010    ^SUB       ^&#26;     ^             Substitute                      '^'          
    echo   27    033     1B    00011011    ^ESC       ^&#27;     ^             Escape                          '^'          
    echo   28    034     1C    00011100    ^FS        ^&#28;     ^             File Separator                  '^'           
    echo   29    035     1D    00011101    ^GS        ^&#29;     ^             Group Separator                 '^'           
    echo   30    036     1E    00011110    ^RS        ^&#30;     ^             Record Separator                '^'           
    echo   31    037     1F    00011111    ^US        ^&#31;     ^             Unit Separator                  '^'           
    echo   32    040     20    00100000    ^SP        ^&#32;     ^             Space                           '^ '            
    echo   33    041     21    00100001    ^!         ^&#33;     ^&excl;       Exclamation mark                '^!'            
    echo   34    042     22    00100010    ^"         ^&#34;     ^&quot;       Double quotes                   '^"'            
    echo   35    043     23    00100011    ^#         ^&#35;     ^&num;        Number sign                     '^#'            
    echo   36    044     24    00100100    ^$         ^&#36;     ^&dollar;     Dollar                          '^$'            
    echo   37    045     25    00100101    %%         ^&#37;     ^&percnt;     Percent sign                    '%%'            
    echo   38    046     26    00100110    ^&         ^&#38;     ^&amp;        Ampersand                       '^&'            
    echo   39    047     27    00100111    ^'         ^&#39;     ^&apos;       Single quote                    '^''            
    echo   40    050     28    00101000    ^(         ^&#40;     ^&lparen;     Open parenthesis                '('             
    echo   41    051     29    00101001    ^)         ^&#41;     ^&rparen;     Close parenthesis               ')'             
    echo   42    052     2A    00101010    ^*         ^&#42;     ^&ast;        Asterisk                        '^*'            
    echo   43    053     2B    00101011    ^+         ^&#43;     ^&plus;       Plus                            '^+'            
    echo   44    054     2C    00101100    ^,         ^&#44;     ^&comma;      Comma                           '^,'            
    echo   45    055     2D    00101101    ^-         ^&#45;     ^             Hyphen or minus                 '^-'            
    echo   46    056     2E    00101110    ^.         ^&#46;     ^&period;     Period, dot or full stop        '^,'            
    echo   47    057     2F    00101111    ^/         ^&#47;     ^&sol;        Slash or divide                 '^/'            
    echo   48    060     30    00110000    ^0         ^&#48;     ^             Zero                            '^0'            
    echo   49    061     31    00110001    ^1         ^&#49;     ^             One                             '^1'            
    echo   50    062     32    00110010    ^2         ^&#50;     ^             Two                             '^2'            
    echo   51    063     33    00110011    ^3         ^&#51;     ^             Three                           '^3'            
    echo   52    064     34    00110100    ^4         ^&#52;     ^             Four                            '^4'            
    echo   53    065     35    00110101    ^5         ^&#53;     ^             Five                            '^5'            
    echo   54    066     36    00110110    ^6         ^&#54;     ^             Six                             '^6'            
    echo   55    067     37    00110111    ^7         ^&#55;     ^             Seven                           '^7'            
    echo   56    070     38    00111000    ^8         ^&#56;     ^             Eight                           '^8'            
    echo   57    071     39    00111001    ^9         ^&#57;     ^             Nine                            '^9'            
    echo   58    072     3A    00111010    ^:         ^&#58;     ^&colon;      Colon                           '^:'            
    echo   59    073     3B    00111011    ^;         ^&#59;     ^&semi;       Semicolon                       '^;'            
    echo   60    074     3C    00111100    ^<         ^&#60;     ^&lt;         Less than                       '^<'            
    echo   61    075     3D    00111101    ^=         ^&#61;     ^&equals;     Equals                          '^='            
    echo   62    076     3E    00111110    ^>         ^&#62;     ^&gt;         Greater than                    '^>'            
    echo   63    077     3F    00111111    ^?         ^&#63;     ^&quest;      Question mark                   '^?'            
    echo   64    100     40    01000000    ^@         ^&#64;     ^&commat;     At sign                         '^@'            
    echo   65    101     41    01000001    ^A         ^&#65;     ^             Uppercase A                     '^A'            
    echo   66    102     42    01000010    ^B         ^&#66;     ^             Uppercase B                     '^B'            
    echo   67    103     43    01000011    ^C         ^&#67;     ^             Uppercase C                     '^C'            
    echo   68    104     44    01000100    ^D         ^&#68;     ^             Uppercase D                     '^D'            
    echo   69    105     45    01000101    ^E         ^&#69;     ^             Uppercase E                     '^E'            
    echo   70    106     46    01000110    ^F         ^&#70;     ^             Uppercase F                     '^F'            
    echo   71    107     47    01000111    ^G         ^&#71;     ^             Uppercase G                     '^G'            
    echo   72    110     48    01001000    ^H         ^&#72;     ^             Uppercase H                     '^H'            
    echo   73    111     49    01001001    ^I         ^&#73;     ^             Uppercase I                     '^I'            
    echo   74    112     4A    01001010    ^J         ^&#74;     ^             Uppercase J                     '^J'            
    echo   75    113     4B    01001011    ^K         ^&#75;     ^             Uppercase K                     '^K'            
    echo   76    114     4C    01001100    ^L         ^&#76;     ^             Uppercase L                     '^L'            
    echo   77    115     4D    01001101    ^M         ^&#77;     ^             Uppercase M                     '^M'            
    echo   78    116     4E    01001110    ^N         ^&#78;     ^             Uppercase N                     '^N'            
    echo   79    117     4F    01001111    ^O         ^&#79;     ^             Uppercase O                     '^O'            
    echo   80    120     50    01010000    ^P         ^&#80;     ^             Uppercase P                     '^P'            
    echo   81    121     51    01010001    ^Q         ^&#81;     ^             Uppercase Q                     '^Q'            
    echo   82    122     52    01010010    ^R         ^&#82;     ^             Uppercase R                     '^R'            
    echo   83    123     53    01010011    ^S         ^&#83;     ^             Uppercase S                     '^S'            
    echo   84    124     54    01010100    ^T         ^&#84;     ^             Uppercase T                     '^T'            
    echo   85    125     55    01010101    ^U         ^&#85;     ^             Uppercase U                     '^U'            
    echo   86    126     56    01010110    ^V         ^&#86;     ^             Uppercase V                     '^V'            
    echo   87    127     57    01010111    ^W         ^&#87;     ^             Uppercase W                     '^W'            
    echo   88    130     58    01011000    ^X         ^&#88;     ^             Uppercase X                     '^X'            
    echo   89    131     59    01011001    ^Y         ^&#89;     ^             Uppercase Y                     '^Y'            
    echo   90    132     5A    01011010    ^Z         ^&#90;     ^             Uppercase Z                     '^Z'            
    echo   91    133     5B    01011011    ^[         ^&#91;     ^&lsqb;       Opening bracket                 '^['            
    echo   92    134     5C    01011100    ^\         ^&#92;     ^&bsol;       Backslash                       '^\'            
    echo   93    135     5D    01011101    ^]         ^&#93;     ^&rsqb;       Closing bracket                 '^]'            
    echo   94    136     5E    01011110    ^^         ^&#94;     ^&Hat;        Caret - circumflex              '^^'            
    echo   95    137     5F    01011111    ^_         ^&#95;     ^&lowbar;     Underscore                      '^_'            
    echo   96    140     60    01100000    ^`         ^&#96;     ^&gave;       Grave accent                    '^`'            
    echo   97    141     61    01100001    ^a         ^&#97;     ^             Lowercase a                     '^a'            
    echo   98    142     62    01100010    ^b         ^&#98;     ^             Lowercase b                     '^b'            
    echo   99    143     63    01100011    ^c         ^&#99;     ^             Lowercase c                     '^c'            
    echo  100    144     64    01100100    ^d         ^&#100;    ^             Lowercase d                     '^d'            
    echo  101    145     65    01100101    ^e         ^&#101;    ^             Lowercase e                     '^e'            
    echo  102    146     66    01100110    ^f         ^&#102;    ^             Lowercase f                     '^f'            
    echo  103    147     67    01100111    ^g         ^&#103;    ^             Lowercase g                     '^g'            
    echo  104    150     68    01101000    ^h         ^&#104;    ^             Lowercase h                     '^h'            
    echo  105    151     69    01101001    ^i         ^&#105;    ^             Lowercase i                     '^i'            
    echo  106    152     6A    01101010    ^j         ^&#106;    ^             Lowercase j                     '^j'            
    echo  107    153     6B    01101011    ^k         ^&#107;    ^             Lowercase k                     '^k'            
    echo  108    154     6C    01101100    ^l         ^&#108;    ^             Lowercase l                     '^l'            
    echo  109    155     6D    01101101    ^m         ^&#109;    ^             Lowercase m                     '^m'            
    echo  110    156     6E    01101110    ^n         ^&#110;    ^             Lowercase n                     '^n'            
    echo  111    157     6F    01101111    ^o         ^&#111;    ^             Lowercase o                     '^o'            
    echo  112    160     70    01110000    ^p         ^&#112;    ^             Lowercase p                     '^p'            
    echo  113    161     71    01110001    ^q         ^&#113;    ^             Lowercase q                     '^q'            
    echo  114    162     72    01110010    ^r         ^&#114;    ^             Lowercase r                     '^r'            
    echo  115    163     73    01110011    ^s         ^&#115;    ^             Lowercase s                     '^s'            
    echo  116    164     74    01110100    ^t         ^&#116;    ^             Lowercase t                     '^t'            
    echo  117    165     75    01110101    ^u         ^&#117;    ^             Lowercase u                     '^u'            
    echo  118    166     76    01110110    ^v         ^&#118;    ^             Lowercase v                     '^v'            
    echo  119    167     77    01110111    ^w         ^&#119;    ^             Lowercase w                     '^w'            
    echo  120    170     78    01111000    ^x         ^&#120;    ^             Lowercase x                     '^x'            
    echo  121    171     79    01111001    ^y         ^&#121;    ^             Lowercase y                     '^y'            
    echo  122    172     7A    01111010    ^z         ^&#122;    ^             Lowercase z                     '^z'            
    echo  123    173     7B    01111011    ^{         ^&#123;    ^&lcub;       Opening brace                   '^{'            
    echo  124    174     7C    01111100    ^|         ^&#124;    ^&verbar;     Vertical bar                    '^|'            
    echo  125    175     7D    01111101    ^}         ^&#125;    ^&rcub;       Closing brace                   '^}             
    echo  126    176     7E    01111110    ^~         ^&#126;    ^&tilde;      Equivalency sign - tilde        '^~'            
    echo  127    177     7F    01111111    ^DEL       ^&#127;    ^             Delete                          '^'          

exit /b 0
::%endfunction%


