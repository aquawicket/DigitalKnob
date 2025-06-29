@echo off&::###### DK.cmd #########################################################################################################################
set "DKBATCH_FUNCTIONS_DIR_=C:/Users/Administrator/DigitalKnob/Development/DKBatch/functions/"
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
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

%endfunction%


