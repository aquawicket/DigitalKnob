if(!$DKINIT){ . $PWD/DK.ps1 }
#if(!$DK_FRAME){ $DK_FRAME = 1 } else{ return }

##################################################################################
# __FRAME__(frame)
#
function GLOBAL:__FRAME__($_FRAME_=1) {
	$callStackFrame = $(Get-PSCallStack)[$_FRAME_]
		echo "callStackFrame = $callStackFrame"
	$functionName = $callStackFrame.FunctionName
		echo "functionName = $functionName"
	$position = $callStackFrame.Position
		echo "position = $position"
	$scriptLineNumber = $callStackFrame.ScriptLineNumber
		echo "scriptLineNumber = $scriptLineNumber"
	$scriptName = $callStackFrame.ScriptName
		echo "scriptName = $scriptName"
		
	$invocationInfo = $callStackFrame.InvocationInfo
		#echo "invocationInfo = $invocationInfo"
		$boundParameters = $invocationInfo.BoundParameters
			#echo "boundParameters = $boundParameters"
			foreach ($keyValue in $boundParameters.GetEnumerator()) { echo "$($keyValue.Key) = $($keyValue.Value)" }
		$commandOrigin = $invocationInfo.CommandOrigin
			echo "commandOrigin = $commandOrigin"
		$displayScriptPosition = $invocationInfo.DisplayScriptPosition
			echo "displayScriptPosition = $displayScriptPosition"
		$expectingInput = $invocationInfo.ExpectingInput
			echo "expectingInput = $expectingInput"
		$historyId = $invocationInfo.HistoryId
			echo "historyId = $historyId"
		$invocationName = $invocationInfo.InvocationName
			echo "invocationName = $invocationName"
		$line = $invocationInfo.Line
			echo "line = $line"
		$myCommand = $invocationInfo.MyCommand
			echo "myCommand = $myCommand"
		$offsetInLine = $invocationInfo.OffsetInLine
			echo "offsetInLine = $offsetInLine"
		$pipelineLength = $invocationInfo.PipelineLength
			echo "pipelineLength = $pipelineLength"
		$pipelinePosition = $invocationInfo.PipelinePosition
			echo "pipelinePosition = $pipelinePosition"
		$positionMessage = $invocationInfo.PositionMessage
			echo "positionMessage = $positionMessage"
		$pSCommandPath = $invocationInfo.PSCommandPath
			echo "pSCommandPath = $pSCommandPath"
		$pSScriptRoot = $invocationInfo.PSScriptRoot
			echo "pSScriptRoot = $pSScriptRoot"
		$scriptLineNumber = $invocationInfo.ScriptLineNumber
			echo "scriptLineNumber = $scriptLineNumber"
		$scriptName = $invocationInfo.ScriptName
			echo "scriptName = $scriptName"
		$statement = $invocationInfo.Statement
			echo "statement = $statement"
		$unboundArguments = $invocationInfo.UnboundArguments
			echo "unboundArguments = $unboundArguments"
}


function Global:Dummy($arg_1, $arg_2){
	__FRAME__
}

function Global:DKTEST() { ###########################################################################################
	Dummy "first arg" "2nd arg" 123 "abc"
}