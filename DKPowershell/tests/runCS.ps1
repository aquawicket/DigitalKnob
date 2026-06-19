#$input_image = "${ENV:USERPROFILE}/Digital Knob/Development/DKCpp/plugins/_DKIMPORT/icon.png"
#$output_icon = "${ENV:USERPROFILE}/Desktop/icon.ico"
#$keep_aspect_ratio = $true;

$source = Get-Content -Path "${ENV:USERPROFILE}/Desktop/pngToIcon.cs";
$assemblies = ("System.Drawing");
Add-Type -TypeDefinition "$source" -ReferencedAssemblies $assemblies -Language CSharp;

# Call a static method
#[PngIconConverter]::Convert($input_image, $output_icon, $keep_aspect_ratio)
[PngIconConverter]::Main();

# Create an instance and call an instance method
#$PngIconConverterObj = New-Object PngIconConverter
#$PngIconConverterObj.main()

pause