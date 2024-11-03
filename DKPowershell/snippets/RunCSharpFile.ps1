$compilerParams = New-Object System.CodeDom.Compiler.CompilerParameters;
$opt.GenerateInMemory = $true;
$cr = [System.CodeDom.Compiler.CodeDomProvider]::CreateProvider("CSharp").CompileAssemblyFromFile($compilerParams, "dk_helloWorld.cs");
if($cr.CompiledAssembly){
	$instance = $cr.CompiledAssembly.CreateInstance("App");
	$instance.GetType().GetMethod("Main").Invoke($instance, $null);
}else{
	$cr.errors;
}