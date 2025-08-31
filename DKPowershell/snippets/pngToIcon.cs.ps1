$file = "C:\Users\Administrator\Desktop\pngToIcon.cs"
$Source = [System.IO.File]::ReadAllText($file)
$assemblies = ("System.Drawing")
Add-Type -TypeDefinition "$Source" -ReferencedAssemblies $assemblies -Language CSharp

# Call static function
#[PngIconConverter]::Main()

# Create class instance, call class function
$PngIconConverterObj = New-Object PngIconConverter
#$PngIconConverterObj.Main()
$PngIconConverterObj.Convert("icon.png", "icon.ico", 100, $true)