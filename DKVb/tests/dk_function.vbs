
Public Function myFunction(argA, argB)
    myFunction = argA + " " + argB
End Function

varA = "test function"
varB = "return string"
myString = myFunction(varA, varB)


Sub print(s) 
  On Error Resume Next
  WScript.stdout.WriteLine (s)  
  If  err= &h80070006& Then WScript.Echo " Please run this script with CScript": WScript.quit
End Sub
 
print "hello"