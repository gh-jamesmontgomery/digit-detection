#Array to store unique digits found, initially empty.
$foundInts = @()

#Generate our desired input number and initialise remainder variable
[int64]$inputNumber = Get-Random  -Minimum 1111111111 -Maximum 9999999999
[int64]$remainderFromDivision = 0

Write-host "Generated: $inputNumber"

# Division by 10 until the inputNumber gets down to 0
do
{
    #Using a division with remain function. Divide by 10 and retrieving the remainder via a reference
    $inputNumber = [System.Math]::DivRem($inputNumber, 10, [ref]$remainderFromDivision)
    write-host "Processing: $remainderFromDivision"
    #remainder evaluated against the foundInts array
    if($remainderFromDivision -notin $foundInts){
        #Add to the array if not present
        $foundInts += $remainderFromDivision
    }

} while ($inputNumber -gt 0)

#Print the found integers in ascending order of value
$foundInts | Sort-Object | ForEach-Object {Write-Host "[Math-sorted]Digit $_ detected"}
