#Digit of interest
$lookingFor = Get-Random -Minimum 0 -Maximum 9
#Initialise found to false
$fountInt = $false

#Generate our desired input number
[int64]$inputNumber = Get-Random  -Minimum 1111111111 -Maximum 9999999999
[int64]$remainderFromDivision = 0

Write-host "Generated: $inputNumber, Looking for: $lookingFor"

# Division by 10 until the inputNumber gets down to 0 unless we find our desired digit
do
{
    #Using a division with remain function. Divide by 10 and retrieving the remainder via a reference
    $inputNumber = [System.Math]::DivRem($inputNumber, 10, [ref]$remainderFromDivision)
    write-host "Processing: $remainderFromDivision"
    #remainder evaluated
    if($remainderFromDivision -eq $lookingFor){
        $fountInt = $true
    }elseif ($inputNumber -gt 0)
    {
        "Continue looking in $inputNumber"
    }

} while ($inputNumber -gt 0 -and $fountInt -eq $false)

#Print the outcome
Write-host "Found digit: $fountInt"
