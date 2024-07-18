if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_runAsTI){ $dk_runAsTI = 1 } else{ return }

##################################################################################
# dk_runAsTI(command)
#
# Run as Trusted Installer, with ownership privileges
#
function dk_runAsTI ($cmd, $arg){ 
	$id='dk_runAsTI'; 
	$key="Registry::HKU\$(((whoami /user)-split' ')[-1])\Volatile Environment"; 
$code=@'
	$I=[int32];
	$M=[int32].module.gettype("System.Runtime.InteropServices.Marshal");
	$P=[int32].module.gettype("System.IntPtr"); 
	$D=@(); 
	$T=@();
	$DM=[AppDomain]::CurrentDomain."DefineDynamicAssembly"(1,1)."DefineDynamicModule"(1); 
	0..5|% {
		$D += $DM."DefineType"("aaaaa_$_",1179913,[ValueType])
	}; 
	$D += [uintptr]; 
	4..6|% {
		$D += $D[$_]."MakeByRefType"()
	}
	$F='kernel', 'advapi', 'advapi', ([string],[string],[int32],[int32],[int32],[int32],[int32],[string],$D[7],$D[8]), ([uintptr],[string],[int32],[int32],$D[9]), ([uintptr],[string],[int32],[int32],[byte[]],[int32])
	0..2|% {
		$9=$D[0]."DefinePInvokeMethod"(('CreateProcess','RegOpenKeyEx','RegSetValueEx')[$_],$F[$_]+'32',8214,1,[string],$F[$_+3],1,4)
	}
	$DF=($P,[int32],$P),([int32],[int32],[int32],[int32],$P,$D[1]),([int32],[string],[string],[string],[int32],[int32],[int32],[int32],[int32],[int32],[int32],[int32],[int16],[int16],$P,$P,$P,$P),($D[3],$P),($P,$P,[int32],[int32])
	1..5|% {
		$k=$_; 
		$n=1; 
		$DF[$_-1]|% {$9=$D[$k]."DefineField"('f' + $n++, $_, 6)}
	};
	0..5|% {
		$T += $D[$_]."CreateType"()
	}
	0..5|% {
		nv "A$_" ([Activator]::CreateInstance($T[$_])) -fo
	}; 
	function F ($1,$2) {
		$T[0]."GetMethod"($1).invoke(0,$2)
	}
	$TI=(whoami /groups)-like'*1-16-16384*'; 
	$As=0; 
	if(!$cmd){	
		$cmd='control';
		$arg='admintools'
	}; 
	if($cmd -eq 'This PC'){
		$cmd='file:'
	}
	if(!$TI){
		'TrustedInstaller','lsass','winlogon'|% {
			if(!$As){
				$9=sc.exe start $_; 
				$As=@(get-process -name $_ -ea 0|% {$_})[0]
			}
		}
		function M ($1,$2,$3) {
			$M."GetMethod"($1,[type[]]$2).invoke(0,$3)}; 
			$H=@(); 
			[uintptr]::size,(4*[uintptr]::size+16)|% {
				$H += M "AllocHGlobal" $I $_
			}
		M "WriteIntPtr" ($P,$P) ($H[0],$As.Handle); 
		$A1.f1=131072; 
		$A1.f2=[uintptr]::size; 
		$A1.f3=$H[0]; 
		$A2.f1=1; 
		$A2.f2=1; 
		$A2.f3=1; 
		$A2.f4=1
		$A2.f6=$A1; 
		$A3.f1=10*[uintptr]::size+32; 
		$A4.f1=$A3; 
		$A4.f2=$H[1]; 
		M "StructureToPtr" ($D[2],$P,[boolean]) (($A2 -as $D[2]),$A4.f2,$false)
		$Run=@($null, "powershell -win 1 -nop -c iex `$env:R; # dk_runAsTI", 0, 0, 0, 0x0E080600, 0, $null, ($A4 -as $T[4]), ($A5 -as $T[5]))
		F 'CreateProcess' $Run; 
		return
	}; 
	$env:R=''; 
	rp $key dk_runAsTI -force; 
	$priv=[diagnostics.process]."GetMember"('SetPrivilege',42)[0]
	'SeSecurityPrivilege','SeTakeOwnershipPrivilege','SeBackupPrivilege','SeRestorePrivilege' |% {$priv.Invoke($null, @("$_",2))}
	$reg=([uintptr][uint32]2147483651,'S-1-5-18',8,2,([uintptr][uint32]2147483651 -as $D[9])); 
	F 'RegOpenKeyEx' $reg; 
	function L ($1,$2,$3) {
		sp 'HKLM:\Software\Classes\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}' 'RunAs' $3 -force -ea 0
		$b=[Text.Encoding]::Unicode.GetBytes("\Registry\User\$1"); 
		F 'RegSetValueEx' @($2,'SymbolicLinkValue',0,6,[byte[]]$b,$b.Length)
	}
	function Q {
		[int](gwmi win32_process -filter 'name="explorer.exe"'|?{
		$_.getownersid().sid -eq 'S-1-5-18'}|select -last 1).ProcessId
	}
	$11bug=($((gwmi Win32_OperatingSystem).BuildNumber) -eq '22000') -AND (($cmd -eq 'file:') -OR (test-path -lit $cmd -PathType Container))
	if($11bug){
		'System.Windows.Forms','Microsoft.VisualBasic' |% {[Reflection.Assembly]::LoadWithPartialName("'$_")}
		$cmd='control.exe'; 
		$arg='admintools'
	}
	L ($key-split'\\')[1] $reg[4] ''; 
	$R=[diagnostics.process]::start($cmd, $arg); 
	if($R){
		$R.PriorityClass='High'; 
		$R.WaitForExit()
	}
	if($11bug) {
		$w=0; 
		do {
			if($w -gt 40){
				break
			}; 
			sleep -mi 250;
			$w++
		} 
		until (Q); 
		[Microsoft.VisualBasic.Interaction]::AppActivate($(Q))
		[Windows.Forms.SendKeys]::SendWait('^(l)'+$($cmd -replace '([\+\^\%\~\(\)\[\]])','{$1}')+'{ENTER}')
	}; 
	do {sleep 7} while(Q);
	L '.Default' $reg[4] 'Interactive User' 
'@;

$V='';
'cmd','arg','id','key'|%{
	$V+="`n`$$_='$($(gv $_ -val)-replace"'","''")';
	"
}; 
	sp $key dk_runAsTI $($V,$code) -type 7 -force -ea 0
	start powershell -args "-win 1 -nop -c `n$V `$env:R=(gi `$key -ea 0).getvalue(`$id)-join''; 
	iex `$env:R" -verb runas
} 




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_runAsTI cmd
}