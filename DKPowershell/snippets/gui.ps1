# Use System.Windows.Forms and System.Drawing to create GUIs
# https://www.robvanderwoude.com/powershellsnippets.php#WinFormsDemo
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form      = New-Object System.Windows.Forms.Form
$form.Text = 'PowerShell GUI Demo'
$form.Size = '400,240'

$label1          = New-Object System.Windows.Forms.Label
$label1.Text     = 'Arial Arial Arial Arial Arial Arial Arial Arial Arial Arial Arial Arial Arial Arial Arial Arial Arial'
$label1.Font     = New-Object System.Drawing.Font( 'Arial', 10 ) # This is the "official" way to specify a font
$label1.Size     = New-Object System.Drawing.Size( 200, 40 )     # This is the "official" way to specify a size
$label1.Location = New-Object System.Drawing.Point( 10, 25 )     # This is the "official" way to specify a location
$form.Controls.Add( $label1 )

$label2          = New-Object System.Windows.Forms.Label
$label2.Text     = 'Courier Courier Courier Courier Courier Courier Courier Courier Courier Courier Courier Courier Courier'
$label2.Font     = 'Courier New,10' # This is an alternative way to specify a font
$label2.Size     = '200, 40'        # This is an alternative way to specify a size
$label2.Location = '10, 75'         # This is an alternative way to specify a location
$form.Controls.Add( $label2 )

$buttonOK              = New-Object System.Windows.Forms.Button
$buttonOK.Text         = 'OK'
$buttonOK.DialogResult = 'OK' # This should usually not be required
$buttonOK.Location     = '10, 150'
$form.Controls.Add( $buttonOK )

$buttonCancel          = New-Object System.Windows.Forms.Button
$buttonCancel.Text     = 'Cancel'
$buttonCancel.Location = '120, 150'
$form.Controls.Add( $buttonCancel )

$form.AcceptButton = $buttonOK # This should usually suffice to make the dialog return OK when OK is clicked
$form.CancelButton = $buttonCancel

# Without [void] PowerShell will write the ShowDialog result (caption of the button clicked) to screen
[void] $form.ShowDialog( )

# This is another way to get the form's ShowDialog result
Write-Host $form.DialogResult