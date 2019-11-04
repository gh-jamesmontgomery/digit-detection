#Setup our input number. This variable defaults to an integer type. Check via $inputNumber.GetType()
$inputNumber = 172399475680

#Setup the array to contain the full range of digits
$numbersToDetect = 0 .. 9

#Setup result text and text colour if all numbers are found
$allDigitsPresent = $true
$thisColour = "Green"

#Loop through each digit in the array
$numbersToDetect | ForEach-Object {
    #Get the count of objects in the array create by the split operation and substract 1
    $thisCount = ($inputNumber -split $_).count -1
    #If any count is equal to 0, this number is missing, therefore we do not have all the numbers we are looking for.
    if($thisCount -eq 0){
        #Change the result next now that we have found a missing number
        $allDigitsPresent = $false
        $thisColour = "Red"
    }
}
#Print the result text
Write-host -ForegroundColor $thisColour "All digits found? $allDigitsPresent "
