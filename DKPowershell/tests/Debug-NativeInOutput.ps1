<#

  Prerequisites: PowerShell v3+
  License: MIT
  Author:  Michael Klement <mklement0@gmail.com>

  DOWNLOAD and DEFINITION OF THE FUNCTION:

    irm https://gist.github.com/mklement0/eac1f18fbe0fc2798b214229b747e5dd/raw/Debug-NativeInOutput.ps1 | iex

  The above directly defines the function below in your session and offers guidance for making it available in future
  sessions too.

  DOWNLOAD ONLY:

    irm https://gist.github.com/mklement0/eac1f18fbe0fc2798b214229b747e5dd/raw > Debug-NativeInOutput.ps1

  The above downloads to the specified file, which you then need to dot-source to make the function available
  in the current session:

     . ./Debug-NativeInOutput.ps1
   
  To learn what the function does:
    * see the next comment block
    * or, once downloaded and defined, invoke the function with -? or pass its name to Get-Help.

  To define an ALIAS for the function, (also) add something like the following to your $PROFILE:
  
    Set-Alias dbn Debug-NativeInOutput

#>

function Debug-NativeInOutput {

<#
.SYNOPSIS
Diagnoses how text comprising non-ASCII character is piped to and received
from native (external) programs.

.DESCRIPTION
Diagnoses character-encoding problems potentially arising from:

* sending text with non-ASCII characters via the pipeline to native programs,
  which read it via their stdin stream.

* capturing such text output by native programs via their stdout stream.

If input text is provided, the input text's byte representation, as it will
be sent to the external program based on $OutputEncoding, is reported, along
with interpretations of these bytes with the following encodings, if 
different from $OutputEncoding: ANSI, OEM, UTF-8.

The output text received from the native programs is printed:

* Then via a decoding by PowerShell, which capturing output in a variable
  always entails; that is, the output is decoded into a regular .NET string.
  The resulting string's hexadecimal UTF-16 code units are also printed,
  along with the input and the native command, all as part of a [pscustomobject]
  instance.

* Then, on Windows only, by direct output, which by default prints directly to 
  the console, with no attempt by PowerShell to decode it. Since some
  external programs detect the direct-to-console output case and then utilize
  full Unicode support, direct-to-console output can mask encoding problems.

In PowerShell, it is $OutputEncoding, [Console]::InputEncoding and 
[Console]::OutputEncoding that control the encoding and decoding that is 
involved. See the NOTES section (Get-Help -Full) for more information.

Note that this command displays verbose output *by default*; pass -Verbose:$false
to turn it off.

.PARAMETER InputText
The optional text to pipe to the command(s) specified via -Command.
The easiest way to provide this text is by piping it to this command too.

Note: 
 * Text comprising solely ASCII-range characters is typically handled
   correctly. Problems usually surface with Unicode characters outside the ASCII 
   range, both on input and output.
 * For simplicity, non-text objects piped to this command is stringified with 
   mere .ToString() calls, so that, say piping `Get-Item /` provides just '/'
   (or 'C:\' on Windows) as input. By contrast, piping such objects directly
   to an external program would send the lines of the object's
   *formatted representation*.

.PARAMETER Command
The native-program command(s) to pipe the text to, passed as a single string
each.

IMPORTANT:
 * Be sure to trust those commands, as they are blindly executed with 
   Invoke-Expression.

 * Be sure that the commands expect *stdin* input (input via the *pipeline*),
   as that how the input text is sent.
   Note that passing text via *arguments* is generally *not* plagued by 
   character-encoding problems.
 
Beware PowerShell's broken argument-passing when passing commands with 
embedded " chars. (double quotes). Up to at least v7.1, you have to *additionally*
\-escape them.

Purely for quoting convenience you may use script-block literals to 
pass the commands (see the example), but note that on parameter binding they 
are converted to strings.

.PARAMETER Encoding
The character encoding to use as a temporary override while executing the 
command(s).

By default, the current console settings are used.

You may pass a [System.Text.Encoding] instance directly, a code-page number (e.g. 850),
or an encoding name (e.g. 'utf-8').
Additionally, 'ansi' and 'oem' are supported to refer to the system's active ANSI/OEM
code page.

The resulting encoding is temporarily set as follows:

  $OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = <encoding>

Note that $OutputEncoding is also set, to ensure consistency with the console 
settings, whereas the default $OutputEncoding value is *not* consistent with the
console settings - except if you use PowerShell (Core) 7+ *and* have *system-wide* 
UTF-8 support enabled (available in Windows 10).

See the NOTES section (Get-Help -Full) for more information.

.EXAMPLE
'eé' | Debug-NativeInOutput { node -pe "require('fs').readFileSync(0).toString().trim()" } 

Pipes string 'eé' to a Node.js command that simply relays its stdin input to stdout,
and analyzes the in- and ouput.

.EXAMPLE
'eé' |  Debug-NativeInOutput -Encoding utf8 { node -pe "require('fs').readFileSync(0).toString().trim()" }

Pipes string 'eé' to a Node.js command that simply relays its stdin input to stdout, with
$OutputEncoding, [Console]::InputEncoding, and [console]::OutputEncoding temporarily
set to UTF-8, and analyzes the in- and ouput.

.EXAMPLE
Debug-NativeInOutput { node -pe "'eé'" }

Calls a Node.js command that simply prints to stdout, and analyzes the output.

.NOTES
Given that most Unix-like system nowadays default to UTF-8 encoding, where
no encoding problems are to be expected, this command is primarily useful
on Windows.

To make a console / Windows Terminal window use UTF-8 consistently, run the
following (which you may place in your $PROFILE file):

  $global:OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

For background information, including how to enable UTF-8 system-wide
in Windows 10, see https://stackoverflow.com/a/57134096/45375

#>

# ALSO STORED AS A GIST AT: https://gist.github.com/mklement0/eac1f18fbe0fc2798b214229b747e5dd

[OutputType([pscustomobject])]
[CmdletBinding(PositionalBinding = $false)]
param(
  [Parameter(Mandatory, Position = 0)] [string[]] $Command,
  [Parameter(ValueFromPipeline)] [string] $InputText,
  [Parameter(Position = 1)] $Encoding # [System.Text.Encoding] instance, code-page number, or encoding name.
)

begin {

  Set-StrictMode -Version 1; $ErrorActionPreference = 'Stop'

  # Output verbose information *by default*; only suppress if -Verbose:$false is passed.
  $VerbosePreference = if ($PSBoundParameters.ContainsKey('Verbose')) { $VerbosePreference } else { 'Continue' }
  
  $ansiEncoding = [Text.Encoding]::GetEncoding([cultureinfo]::CurrentCulture.TextInfo.ANSICodePage)
  $oemEncoding = [Text.Encoding]::GetEncoding([cultureinfo]::CurrentCulture.TextInfo.OEMCodePage)
  $utf8Encoding = [Text.Utf8Encoding]::new()
  
  # Validate the -Encoding argument, if any:
  if ($null -ne $Encoding -and $Encoding -isnot [System.Text.Encoding]) {
    # As a courtesy, accept 'ANSI' and 'OEM' to represent the active ANSI / OEM encoding.
    if ($Encoding -is [string] -and $Encoding -in 'ansi', 'oem') {
      $Encoding = @{ ansi = $ansiEncoding; oem = $oemEncoding }[$Encoding]
    }
    else {
      # Code-page number or encoding name (e.g., 'unicode', 'utf-8')
      # As a courtesy, also accept 'utf8' instead of 'utf-8', etc.  
      # NOTE: UTF-32 is NOT supported: it fails on assigning to [Console]::InputEncoding / [Console]::OutputEncoding
      if ($Encoding -is [string]) { $Encoding = $Encoding -replace '^utf(\d)', 'utf-$1' }
      if ($Encoding -match '^(utf-|unicode$)' -and $Encoding -ne 'utf-7') {
        # !! [System.Text.Encoding]::GetEncoding('utf-.*|unicode') calls return an encoding *with BOM*, which we do NOT want.
        # !! so we explicitly create one without.
        # !! Note: UTF-32 isn't supported anyway, and identifiers such as 'utf-16be' for BE encodings are seemingly not supported.
        $Encoding = switch ($Encoding) {
          'utf-8' { [System.Text.Utf8Encoding]::new() }
          { $_ -in 'unicode', 'utf-16', 'utf-16le' } { [System.Text.UnicodeEncoding]::new($false, $false) }
          default { [System.Text.Encoding]::GetEncoding($Encoding) }
        }
      }
      else {
        $Encoding = [System.Text.Encoding]::GetEncoding($Encoding)
      }
    }
  }
  
  if ($Encoding) {
    # Save the currently active encodings for later restoration.
    $prevIn, $prevOut = [Console]::InputEncoding, [Console]::OutputEncoding
    # Set in-, output and $OutputEncoding to the specified encoding.
    $OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = $Encoding
  }

  [System.Collections.Generic.List[object]] $collectedOutput = @()

  @"

# -------------- Character-encoding settings [code pages]: 
#
$(([pscustomobject] @{
  '[Console]::InputEncoding'  = [Console]::InputEncoding.EncodingName + $(if ([Console]::InputEncoding.GetPreamble().Count) { ' WITH BOM'})  + (' [{0}]' -f [Console]::InputEncoding.CodePage)
  '[Console]::OutputEncoding' = [Console]::OutputEncoding.EncodingName + $(if ([Console]::InputEncoding.GetPreamble().Count) { ' WITH BOM'}) + (' [{0}]' -f [Console]::OutputEncoding.CodePage)
  '$OutputEncoding'     = $OutputEncoding.EncodingName + $(if ([Console]::InputEncoding.GetPreamble().Count) { ' WITH BOM'}) + (' [{0}]' -f $OutputEncoding.CodePage)
} | Out-String -Stream) -ne '' -replace '^', '#   ' -join "`n")
#
"@ | Write-Verbose

}

process {

  # Note: 
  #  * We use [string] instances with Invoke-Expression, because
  #    if we accepted [scriptblock]s directly, invoking them with & would NOT be enough
  #    because the enclosed command would NOT see input *piped* to it - that would require
  #    & { $input | <enclosedCommand> } and therefor modification of the script block.
  #  * We *capture* all output first, for two reasons:
  #    * It forces decoding of the output into .NET strings first, which
  #      prevents masking of encoding problems due to direct-to-display output
  #      always *printing* correctly on Windows.
  #    * On Unix, it is additionally necessary to restore the original 
  #      console encodings *before* printing the decoded output - otherwise
  #      even incorrectly decoded input may appear to *print* fine.
  
  $collectedOutput.AddRange(@(
      foreach ($cmd in $Command) {

        # Prepend the pipeline input command, if input was passed.
        if ($InputText) {
          $cmd = "'$($InputText -replace "'", "''")' | $cmd"
        }
        $cmd = $cmd.Trim()

        # Execute the command and capture its output.
        # Note: PowerShell returns an *array* of lines.
        #       This means that the encoding of the *newlines* is invariably lost.
        $o = Invoke-Expression $cmd
        
        # Check if NUL chars. are present and warn, if so.
        [bool] $containsNULs = $o -match "`0"
        if ($containsNULs) {
          Write-Warning "Captured output contains NUL chars., visualized as '``0' below - output encoding is likely UTF-16LE (`"Unicode`")."
        }

        $oht = [ordered] @{}
        
        $oht.Command = $cmd

        # If pipeline (stdin) input was given:
        # Show the byte representation that will be sent to external programs, based on $OutputEncoding.
        if ($InputText) {
          # Show how the input bytes would be seen by an external programs based on various encodings
          # OTHER than the one used by default ($OutputEncoding).
          $inputBytes = ([Text.Encoding] $OutputEncoding).GetBytes($InputText)

          $keys = 'InputBytesDecodedAsUTF8', 'InputBytesDecodedAsOEM', 'InputBytesDecodedAsANSI'
          $i = 0
          foreach ($enc in $utf8Encoding, $oemEncoding, $ansiEncoding) {
            if ($OutputEncoding -ne $enc) {
              $oht.($keys[$i]) = $enc.GetString($inputBytes)
            }
            ++$i
          }
  
          $oht.InputBytes = $inputBytes.ForEach( { '0x{0}' -f $_.ToString('x') }) -join ' '

        }

        # Use a dummy property to act as a separator line to highlight the decoded output.
        $separatorLineProp = '-------------'
        $oht.$separatorLineProp = $null

        # In the decoded output visualize any embedded NULs as '`0'`
        $oht.OutputDecoded         = ($o -replace "`0", '`0') -join "`n"

        # Add another separator line - note the trailing space, required to make the property name unique.
        $oht."$separatorLineProp " = $null
        
        # Show what the decoded output woud look like had it been decoded based on various encodings
        # OTHER than the one used by default ([Console]::OutputEncoding).
        # Note: We don't bother if the decoded output suggests the external program used UTF-16LE encoding.
        $bytes = $o.ForEach({ , [Console]::OutputEncoding.GetBytes($_) }) # Byte representation 
        $keys = 'OutputDecodedAsUTF8', 'OutputDecodedAsOEM', 'OutputDecodedAsANSI'
        $i = 0
        foreach ($enc in $utf8Encoding, $oemEncoding, $ansiEncoding) {
          if ([Console]::OutputEncoding -ne $enc) {
            $oht.($keys[$i]) = if (-not $containsNULs) { $bytes.ForEach({ $enc.GetString($_) }) -join "`n" } else { '(Not determined due to the presence of NULs.)' }
          }
          ++$i
        }

        $oht.OutputDecodedUTF16CodeUnits = $o.ForEach('ToString').ForEach({ ([int[]] $_.ToCharArray()).ForEach({ '0x{0}' -f $_.ToString('x') }) -join ' ' }) -join "`n"

      }

        [pscustomobject] $oht  # Output as object.

    ))

}

end {

  if ($Encoding) {
    # Restore original encodings.
    # Note: No need to restore $OutputEncoding - it was set as a *local*
    #       variable only that will go out of scope automatically.
    [Console]::InputEncoding, [Console]::OutputEncoding = $prevIn, $prevOut
  }

  # Only now, after having restored the console encoding, do we output
  # the captured output, so that encoding problems surface reliably.
  # (See comment above).
  foreach ($obj In $collectedOutput) {

    # Captured and decoded output.  
    # Note: We want LIST formatting, as several properties can be MULTI-LINE.
    #       Fortunately, our output objects have 5+ properties, so PowerShell uses
    #       Format-List formatting by default.
    $obj

    # On Windows only (n/a on Unix, because on Unix there is no difference between console and stdout output):
    # Show direct-to-display output, which typically works correctly even if
    # there *is* an encoding mismatch.
    if ($env:OS -eq 'Windows_NT') {
      "# Uncaptured (direct-to-display by default, no decoding involved):" | Write-Verbose

      # Note: The only way to NOT capture the output is to use NO cmdlet at all;
      #       even Out-Host, Write-Host, Tee-Object invariably involve decoding.
      Invoke-Expression $obj.Command
    
      "# `n" | Write-Verbose
    }
  }

}

} # End of function

# --------------------------------
# GENERIC INSTALLATION HELPER CODE
# --------------------------------
#    Provides guidance for making the function persistently available when
#    this script is either directly invoked from the originating Gist or
#    dot-sourced after download.
#    IMPORTANT: 
#       * DO NOT USE `exit` in the code below, because it would exit
#         the calling shell when Invoke-Expression is used to directly
#         execute this script's content from GitHub.
#       * Because the typical invocation is DOT-SOURCED (via Invoke-Expression), 
#         do not define variables or alter the session state via Set-StrictMode, ...
#         *except in child scopes*, via & { ... }
if ($MyInvocation.Line -eq '') {
  # Most likely, this code is being executed via Invoke-Expression directly 
  # from gist.github.com

  # To simulate for testing with a local script, use the following:
  # Note: Be sure to use a path and to use "/" as the separator.
  #  iex (Get-Content -Raw ./script.ps1)

  # Derive the function name from the invocation command, via the enclosing
  # script name presumed to be contained in the URL.
  # NOTE: Unfortunately, when invoked via Invoke-Expression, $MyInvocation.MyCommand.ScriptBlock
  #       with the actual script content is NOT available, so we cannot extract
  #       the function name this way.
  & {
    
    param($invocationCmdLine)
    
    # Try to extract the function name from the URL.
    $funcName = $invocationCmdLine -replace '^.+/(.+?)(?:\.ps1).*$', '$1'
    if ($funcName -eq $invocationCmdLine) {
      # Function name could not be extracted, just provide a generic message.
      # Note: Hypothetically, we could try to extract the Gist ID from the URL
      #       and use the REST API to determine the first filename.
      Write-Verbose -Verbose "Function is now defined in this session."
    } 
    else {

      # Indicate that the function is now defined and also show how to
      # add it to the $PROFILE or convert it to a script file.
      Write-Verbose -Verbose @"
Function `"$funcName`" is now defined in this session.

* If you want to add this function to your `$PROFILE, run the following:

   "``nfunction $funcName {``n`${function:$funcName}``n}" | Add-Content `$PROFILE

* If you want to convert this function into a script file that you can invoke
  directly, run:

   "`${function:$funcName}" | Set-Content $funcName.ps1 -Encoding $('utf8' + ('', 'bom')[[bool] (Get-Variable -ErrorAction Ignore IsCoreCLR -ValueOnly)])

"@
    }

  } $MyInvocation.MyCommand.Definition # Pass the original invocation command line to the script block.

}
else {
  # Invocation presumably as a local file after manual download, 
  # either dot-sourced (as it should be) or mistakenly directly.  

  & {
    param($originalInvocation)

    # Parse this file to reliably extract the name of the embedded function, 
    # irrespective of the name of the script file.
    $ast = $originalInvocation.MyCommand.ScriptBlock.Ast
    $funcName = $ast.Find( { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false).Name

    if ($originalInvocation.InvocationName -eq '.') {
      # Being dot-sourced as a file.
      
      # Provide a hint that the function is now loaded and provide
      # guidance for how to add it to the $PROFILE.
      Write-Verbose -Verbose @"
Function `"$funcName`" is now defined in this session.

If you want to add this function to your `$PROFILE, run the following:

    "``nfunction $funcName {``n`${function:$funcName}``n}" | Add-Content `$PROFILE

"@

    }
    else {
      # Mistakenly directly invoked.

      # Issue a warning that the function definition didn't effect and
      # provide guidance for reinvocation and adding to the $PROFILE.
      Write-Warning @"
This script contains a definition for function "$funcName", but this definition
only takes effect if you dot-source this script.

To define this function for the current session, run:
  
  . "$($originalInvocation.MyCommand.Path)"
  
"@
    } 

  }  $MyInvocation # Pass the original invocation info to the helper script block.

}
