#Setup our input number as a string
$inputText = (60263455).ToString()

#Create a generic list for integers
$myLOD = [System.Collections.Generic.List[int]]::new()
#Load the list with all digits of interest. In this case we add the full range.
0 .. 9 | ForEach-Object {$myLOD.Add($_)}

#Loop through each digit in the list
foreach($digit in $myLOD){
    #Test if the original input text contains the digit
    if ($inputtext.Contains($digit))
    {
        Write-Host "[list of digits]$digit"
    }
}
