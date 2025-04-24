# Embed base-64 encoded icon
# https://www.robvanderwoude.com/powershellsnippets.php#EmbedIcon
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
# Base64 encoded icon
$b64convicon  = "AAABAAEAEBAQAAEABAAoAQAAFgAAACgAAAAQAAAAIAAAAAEABAAAAAAAAAAAAAAA"
$b64convicon += "AAAAAAAAAAAAAAAAAAAEAgQAhIKEAPz+/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
$b64convicon += "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
$b64convicon += "AAAAAAAAAAAAAAAAAAAAEiEAAAICAAEgAgEAAgEgAgAAAgARACECAAAAACAAAgIA"
$b64convicon += "AAEAIAACAgAAAgEQACEBIAIAAgABIAASIQACAAIAAAAAAAAAAAAAAAAAAAAAAAAA"
$b64convicon += "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
$b64convicon += "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
$form = New-Object System.Windows.Forms.Form
# Use Base64 encoded icon in code, by Kenny Baldwin
# https://foxdeploy.com/2013/10/23/creating-a-gui-natively-for-your-powershell-tools-using-net-methods/#comments
$form.Icon = ( [System.Drawing.Icon]( New-Object System.Drawing.Icon( ( New-Object System.IO.MemoryStream( ( $$ = [System.Convert]::FromBase64String( $b64convicon ) ), 0, $$.Length ) ) ) ) )
$form.ShowDialog( )
