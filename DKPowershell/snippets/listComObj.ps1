$objects=Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {$_.PSChildName -ne '' -and (Test-Path -Path "$($_.PSPath)\CLSID")} | Select-Object -ExpandProperty PSChildName

#As I know that Wordpad.Document.1 is a generic com object with no exposed additional 
# method and properties I'll use it to compare the rest available objexts to it
$wordpad=new-object -comobject "Wordpad.Document.1"
$generic=$wordpad|get-member   |out-string
$generic
foreach ($obj in $objects){
     $obj| out-file -filepath all.txt -encoding ascii -append
    try {
        
        $temp=new-object -comobject $obj
        #$temp|get-member|out-string
        $pam=$temp|get-member
        $pam_s=$pam|out-string
        if ($pam_s -eq $generic -or $pam_s -eq ""){
            $obj | out-file -filepath gen_2.txt -encoding ascii -append
            #$temp | out-file -filepath gen.txt -encoding ascii -append
            #$temp|get-member|out-file -filepath generic.txt -encoding ascii -append
        } else {
            $obj_name=$obj -replace ":",""
            $obj |out-file -filepath $obj_name"_.txt" -encoding ascii -append
            foreach ($p in $pam) {
                $p.Name + "  " + $p.MemberType + "  "+ $p.Definition|out-file -filepath $obj_name"_.txt" -encoding ascii -append
            }
            $obj |out-file -filepath obj_c.txt -encoding ascii -append
            #$temp|out-file -filepath obj.txt -encoding ascii -append
        }
    } catch {
        $obj|out-file -filepath not_obj.txt -encoding ascii -append
        continue;
    }

}
