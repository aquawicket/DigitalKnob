@echo off
Set/a "computer=ties=player=0"
:Main
Title Tic Tac Toe Trainer v1.0
Echo.Tic Tac Toe Trainer v1.0
Echo.........................
Echo.Play with Mouse.
Echo.For Quit Press Ctrl+C
Echo.Clic for Continue ...
Mouse > Nul 2>&1
Call :BMenu
Goto :Eof
:BMenu
Cls
Set/a "b=1"
:Play
If !b! Equ 1 (Call :BComputr) Else Call :BPlayer
Echo.
Echo. Clic for Continue ...
Mouse.exe > nul
Set/a "b*=-1"
Goto :Play
:IsCorner
For %%+ in (%corners%) Do If %~1 Equ %%+ Exit/b 1
Exit/b 0
:IsEdge
For %%+ in (%edges%) Do If %~1 Equ %%+ Exit/b 1
Exit/b 0
:IsCenter
For %%+ in (%center%) Do If %~1 Equ %%+ Exit/b 1
Exit/b 0
:BGame
For /L %%i in (0,1,8) Do Set/a "b[%%i]=0"
Set/a "Over=0"
Call :ShowBoard
Goto :Eof
:Winner
For %%+ in (%wp%) Do ( Call :_WinnerL %%~+
If !ErrorLevel! Neq 0 Exit/b !ErrorLevel!)
Exit/b 0
:_WinnerL
If !b[%~1]! Neq 0 (
If !b[%~1]! Equ !b[%~2]! If !b[%~3]! Equ !b[%~1]! Exit/b !b[%~1]!)
Exit/b 0
:Player
If !Over! Equ 1 Exit/b -1
Set/a "sel=-1,k=-1,c=0"
Set "cas="
For /f "tokens=1,2,3" %%a in ('Mouse.exe 2^>Nul') Do (
Set "cas=%%b%%c"
Set/a "c=%%a")
If !c! Neq 1 Goto :Player
For %%a in (00 20 40 02 22 42 04 24 44) Do (
Set/a "sel+=1"
If "%%a"=="!cas!" Set/a "k=!sel!")
If !k! Equ -1 Goto :Player
If !b[%k%]! Equ 0 (Call :UpdatePos %k% %~1
Exit/b %k%)
Goto :Player
:ShowBoard
Cls
Echo.!b.s.%b[0]%!^|!b.s.%b[1]%!^|!b.s.%b[2]%!
Echo.-----
Echo.!b.s.%b[3]%!^|!b.s.%b[4]%!^|!b.s.%b[5]%!
Echo.-----
Echo.!b.s.%b[6]%!^|!b.s.%b[7]%!^|!b.s.%b[8]%!
Echo.
Echo.  Computer     Ties       Player
Echo.     !computer!          !ties!          !player!
Goto :Eof
:WinBlock
If !Over! Equ 1 Exit/b -1
If %~1 Equ 1 (Set/a "_win_value=2,_lost_value=-2"
) Else Set/a "_win_value=-2,_lost_value=2"
Call :_WinBloc %~1 %_win_value%
If !wb_return! Neq -1 (Set/a "Over=1"
) Else Call :_WinBloc %~1 %_lost_value%
Exit/b !wb_return!
:_WinBloc
Set/a "wb_return=-1"
For %%+ in (%wp%) Do (Call :_SumLine %%~+ %~2
If ErrorLevel 1 (For %%- in (%%~+) Do (If !b[%%-]! Equ 0 (
Call :UpdatePos %%- %~1
Set/a "wb_return=%%-"
Goto :_WinBloE))))
:_WinBloE
Goto :Eof
:_SumLine
Set/a "_sum_line=!b[%~1]!+!b[%~2]!+!b[%~3]!"
If !_sum_line! Equ %~4 Exit/b 1
Exit/b 0
:FullBoard
For /L %%i in (0,1,8) Do If !b[%%i]! Equ 0 Exit/b 0
Exit/b 1
:RUpdatePos
Set "av="
Set/a "cav=0"
For %%+ in (!%~1!) Do If !b[%%+]! Equ 0 (
Set "av=!av! %%+"
Set/a "cav+=1")
If !cav! Equ 0 Exit/b -1
Set/a "rp=%random% %% !cav!+1"
For /f "tokens=%rp%" %%+ in ("!av!") Do Set/a "rp=%%+"
Call :UpdatePos !rp! %~2
Exit/b !ErrorLevel!
:UpdatePos
Set/a "b[%~1]=%~2"
Call :Winner
Set "w=!ErrorLevel!"
If !w! Equ 1 (If !b! Equ 1 (Set/a "computer+=1"
) Else Set/a "player+=1") Else If !w! Equ -1 (
If !b! Equ 1 (Set/a "player+=1") Else Set/a "computer+=1"
) Else (Call :FullBoard
If ErrorLevel 1 Set/a "ties+=1")
Call :ShowBoard
Exit/b %~1
:BPlayer
Call :BGame
Call :Player 1
Set/a "maxf=!ErrorLevel!"
Call :IsCenter %maxf%
If ErrorLevel 1 (Call :RUpdatePos corners -1
For /l %%. in (1,1,4) Do (Call :Player 1
Call :WinBlock -1
If Not ErrorLevel 0 If !Over! Equ 0 (
Call :RUpdatePos corners -1
If Not ErrorLevel 0 Call :RUpdatePos all -1))
) Else (Call :UpdatePos 4 -1
Call :Player 1
Set/a "maxc=0,maxe=0,maxcd=0,c1e1oc2nd=0"
For /L %%+ in (0,1,8) Do If !b[%%+]! Equ 1 (Call :IsEdge %%+
If ErrorLevel 1 (Set/a "maxe+=1"
) Else (Call :IsCorner %%+
If ErrorLevel 1 (Set/a "maxc+=1"
For /f %%- in ("b[!c.d.%%+!]") Do (
If !%%-! Equ 1 Set/a "maxcd=1"))))
If !maxc! Equ 1 (Set/a "c1e1oc2nd=1"
) Else If !maxc! Equ 2 If !maxcd! Equ 0 Set/a "c1e1oc2nd=1"
If !c1e1oc2nd! Equ 1 (Call :WinBlock -1
If ErrorLevel 0 (Call :Player 1
Call :WinBlock -1
Set/a _res=!ErrorLevel!
If !Over! Equ 0 (If !_res! Neq -1 (Call :Player 1
Call :WinBlock -1
If !Over! Equ 0 (Call :RUpdatePos all -1
Call :Player 1)) Else (Call :RUpdatePos edges -1
Call :Player 1
Call :WinBlock -1
If !Over! Equ 0 Call :Player 1))) Else (
For %%+ in (%corners%) Do If !b[%%+]! Equ 1 (
Call :UpdatePos !c.d.%%+! -1)
Call :Player 1
Call :WinBlock -1
If ErrorLevel 0 (Call :Player 1
Call :WinBlock -1
If Not ErrorLevel 0 (Call :RUpdatePos all -1
Call :Player 1) Else If !Over! Equ 0 (Call :Player 1
Call :RUpdatePos all -1)) Else (Call :RUpdatePos corners -1
Call :Player 1
Call :WinBlock -1
If !Over! Equ 0 Call :Player 1
))) Else If !maxc! Equ 2 (Call :RUpdatePos edges -1
Call :Player 1
For /l %%+ in (1,1,2) Do (Call :WinBlock -1
If !Over! Equ 0 Call :Player 1)) Else (Set/a "eif=0"
For %%+ in (%edges%) Do (
If !b[%%+]! Equ 1 For /f %%- in ("b[!e.f.%%+!]") Do (
If !%%-! Equ 1 Set/a "eif=1"))
If !eif! Equ 1 (Call :RUpdatePos edges -1
Call :Player 1
Call :WinBlock -1
If Not ErrorLevel 0 (Set/a "p=0"
For %%+ in (%corners%) Do If !b[%%+]! Equ 0 (
For /f "tokens=1,2" %%a in (
"b[!c.s.%%+.a!] b[!c.s.%%+.b!]") Do (
If !p! Equ 0 If !%%a! Equ -1 (Call :UpdatePos %%+ -1
Set/a "p=1") Else If !p! Equ 0 If !%%b! Equ -1 (
Call :UpdatePos %%+ -1
Set/a "p=1")))
Call :Player 1
Call :WinBlock -1)) Else (
For %%+ in (%corners%) Do If !b[%%+]! Equ 0 (
For /f "tokens=1,2" %%a in (
"b[!c.s.%%+.a!] b[!c.s.%%+.b!]") Do (
If !%%a! Equ 1 If !%%b! Equ 1 Call :UpdatePos %%+ -1))
Call :Player 1
Call :WinBlock -1
If !Over! Equ 0 (Call :RUpdatePos corners -1
Call :Player 1
Call :WinBlock -1
If !Over! Equ 0 Call :Player 1))))
Exit/b
:BComputr
Call :BGame
Call :RUpdatePos corners 1
Set/a "maxf=!ErrorLevel!"
Call :Player -1
Set/a "minf=!ErrorLevel!"
Call :IsCenter %minf%
If ErrorLevel 1 (Call :UpdatePos !c.d.%maxf%! 1
Call :Player -1
Set/a "minf=!ErrorLevel!"
Call :IsCorner !minf!
If ErrorLevel 1 (
For %%+ in (%corners%) Do If !b[%%+]! Equ 0 Call :UpdatePos %%+ 1
Call :Player -1
Call :WinBlock 1) Else (For /L %%+ in (1,1,2) Do (
If !Over! Equ 0 (Call :WinBlock 1
Call :Player -1))
If !Over! Equ 0 Call :WinBlock 1)
Goto :Eof)
Call :IsCorner %minf%
If ErrorLevel 1 (Call :RUpdatePos corners 1
Call :Player -1
Call :WinBlock 1
If !Over! Equ 0 (
For %%+ in (%corners%) Do If !b[%%+]! Equ 0 Call :UpdatePos %%+ 1
Call :Player -1
Call :WinBlock 1)) Else (Call :UpdatePos 4 1
Call :Player -1
Call :WinBlock 1
If Not ErrorLevel 0 (
For %%+ in (%corners%) Do If !b[%%+]! Equ 0 (
For /f "tokens=1,2" %%a in (
"b[!c.s.%%+.a!] b[!c.s.%%+.b!]") Do (
If !%%a! Equ 0 If !%%b! Equ 0 Call :UpdatePos %%+ 1)))
Call :Player -1
Call :WinBlock 1)
Goto :Eof
:BMouse
If Exist Mouse.exe Goto :Eof
For %%b In (
"4D53434600000000E5020000000000002C000000000000000301010001000000000000"
"00460000000100010052050000000000000000BB3CE87420004D6F7573652E65786500"
"AE44DE4B97025205434B9D54CD6B1341149F4DABC46ABB117AF1204ED05E4422E8510F"
"151D3FA0D5A1AD17A9A46B77DA0637BBCB66AA15142A6BA121047AD09B07FF88A2D14B"
"02F6500F3D7A2B9883960DF4D0839420B5DB371FE9177ED561DFFCE6FDE6CD9BF9BD9D"
"DDFE7B73A80D21D40E16C70855906ABDE8EF6D1AACEBD4872E347F64295D31FA96D243"
"13B902F6036F3CB0F278D4725D8FE3070C07932ECEB9F8DA9D419CF76C96E9ECEC38A3"
"735082509F91D893B78ECCB6A3C6E13D5CEF71E85260589F4E8C13EADC08ED204D2B5E"
"B436D9A754EC366E836C18F25DFE07AD076DC390F7DC1FE6339C4DF1D661B416B4B70C"
"42EA48C6B6B82574198A18307689DD7957B5FF3DE7DDE2B7E7AB4918CC95C90F1A8923"
"870BED66956C52E836A8F916E80AC2BD8846B386984CC92BD210DDA78F72B978977395"
"F5388E69E4404C916CC89822592E93262D419A6818F81269868BA9B05E0DEB5F147B5B"
"B2CB3335F3C52191F4357465F29D56844A5A267515761E5CF31DA987CD84395340624D"
"14360DB989F9B25654194C39917C2FD6CE261BA75B71897D711D3A2E21E3F4F6271519"
"D61266B5FFEB5831A91CE5AF80DF18027DA5969C57527DAB7EDDB2004AF26A455C3C28"
"1932A064CF643D934A4FF45855B74C56A98CA642AB285159E4B4E46C7709B8ED7DEE6F"
"C671B870AC48D64A648D46D75502D839EE19C6E21B8D7BB8C6298D4F354E6B1CD1686B"
"9CD0E848045A3EBFBB1FB378673C8FD5BD7EB38BFB09638E7FBDB60AFC22D867B015B0"
"751DD701DFE809B0B36097D2078FCD171E8D063C633B0E387E9073F9180CB2A39ECB03"
"CF19F385932D309EB57C3FCB9FF84C12E38CE7AD9C6B05E3E206B1A91C470F59E032E7"
"E2059DEA06E383DCBE69B9B6C3947BD5730B9EC3FAE1A705C4E07E628059B6666EB9FE"
"24BF227E245B") Do >>Mouse.exe (Echo.For b=1 To len^(%%b^) Step 2
Echo WScript.StdOut.Write Chr^(CByte^("&H"^&Mid^(%%b,b,2^)^)^) : Next)
Cscript /b /e:vbs Mouse.exe > Mouse.ex_
Expand -r Mouse.ex_ >nul 2>&1
Del Mouse.ex_ >nul 2>&1
Goto :Eof