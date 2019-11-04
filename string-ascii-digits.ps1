#Setup our input number as a sting
$inputText = (1601263455).ToString()
#
$thisColour = "Yellow"

#Create empty array
$foundInts = @()

#Read every character in the array of characters created from the string $inputtext
foreach($readChar in $inputtext.ToCharArray()){
    #For each character we subtract 48 from its ASCII value
    $charAsInt = $readChar - 48
    #We test if the result is in the range 0-9
    if($charAsInt -ge 0 -And $charAsInt -lt 10){
        #If the result is in the desired range, we test if found previously.
        if($charAsInt -notin $foundInts){
            #If we haven't found the digit previously, we add it to the array.
            $foundInts += $charAsInt
            #Write which digit we have located. Digits printed in the order of detection.
            Write-Host "[ASCI]Digit $charAsInt detected"
        }
    }
}
#Print how many unique digits were found.
Write-host -ForegroundColor $thisColour $foundInts.Count "found in the string"
#Re-print the digits in ascending order.
$foundInts | Sort-Object | foreach-object {Write-host "[ASCI ordered] $_ detected"}
