@Echo Off
	Cd "%~p0"
	Setlocal EnableExtensions
	Set ^"Coefs="#$%%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~¨©­°±²¹º»¼¿ÀÁÂÃÄÅÈÉÊËÌÍÎÙÚÛÜÝÞßþº»"
	Set "Def=;,="
	
:main
	Set Limit=128
	
	Cls
	For %%t in (
		"+====================================+"
		"Ý EncTool v2.3                       Ý"
		"Ý Developed by Honguito98            Ý"
		"Ý 2.0 @ 10-Feb-2014                  Ý"
		"Ý 2.3 @ 11-Sep-2017                  Ý"
		"+====================================+"
		""
		"Obfuscates strings in batch files"
	) do Echo;%%~t
	Set /p "Data=> Text:"
	Set /p "Limit=> Pref. key size (default: %Limit%): "
	
	Setlocal EnableDelayedExpansion
	
	:: srtlen function
	Set "_=@!Data!"
	Set _X=0
	For /L %%` in (8,-1,0) do (
		Set /a "_X|=1<<%%`"
		For %%b in (!_X!) Do If "!_:~%%b,1!"=="" Set /a "_X&=~1<<%%`"
	)
	:: Key = Coef
	:: Com = dec
	Set "__Key=" & Set "__Com=" & Set "_=" & Set "List=-1;"
	
	:: Generate random characters, coeff table size is 128-1
	Set /a "K=Limit + _X"
	For /L %%B in (1, 1, %K%) Do (
		Set /a "_crnd=(!Random! * 127 / 32768)"
		For %%K in (!_crnd!) Do Set "__Key=!__Key!!Coefs:~%%K,1!"
	)
	
	Set /a "_X-=1"
	For /L %%C in (0, 1, %_X%) Do (
		rem 10,18,5
		rem r=5
		Call :GetRnd
		Set /a "_crnd_=_crnd + 1"
		For /F "Tokens=1-2" %%A in ("!_crnd! !_crnd_!") Do (
			Set "__Key=!__Key:~0,%%A!!Data:~%%C,1!!__Key:~%%B!"
		)
	)
	Echo;
	Echo;============================================
	Echo;* Limit: !Limit!
	Echo;
	Echo;* Enc. Key  : -^>!__Key!^<-
	Echo;
	Echo;* Dec. Key  : !List:~3!
	Echo;============================================
	Echo;& Set /p "G=> Generate test file? (Y/N):"
	If /i !G! Equ Y (
		(
			Echo;@Echo Off
			Echo;For /F "Tokens=1,* Delims=ù" %%%%A in ('Type "%%~0" ^^^| Findstr  "^{eKey}"'^) Do Set ^"__Key=%%%%B"
			Echo;Set "Text="
			Echo;SetLocal EnableDelayedExpansion
			Echo;For %%%%` in (!List:~3!^) Do Set ^"Text=^^!Text^^!^^!__Key:~%%%%`,1^^!"
			Echo;Echo;^^!Text^^!
			Echo;Pause
			Echo;Goto :Eof
			Echo;
			Echo;{eKey}ù!__Key!
		) >"Coefs-[%Date:/=-%] @ {%Time::=;%}.bat"
	)
	Echo;&Pause
	goto :main
	
	:GetRnd
	Set /a "_crnd=!Random! * K / 32768, rnd=!Random! * 3 / 32768"
	For %%# in (!List!) Do If %%# Equ !_crnd! Goto :GetRnd
	Set "List=!List!!_crnd!!Def:~%rnd%,1!"
	Exit /b 0