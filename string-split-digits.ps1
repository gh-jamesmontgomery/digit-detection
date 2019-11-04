#Setup our input number. This will default to an integer type. Check via $inputNumber.GetType()
$inputNumber = 17239947

#Create an array of numbers we wish to detect.
#Setup the array to contain these three numbers:
$numbersToDetect = 1,7,8
#Alternatively, using the range operator, uncomment the next line to set up the array to contain a range of digits. In this case, the full range.
#$numbersToDetect = 0 .. 9

$numbersToDetect| ForEach-Object {
    $thisCount = ($inputNumber -split $_).count -1
    if($thisCount -gt 1){
        Write-Host "[Split]Digit $_ detected $thisCount times"
    }elseif ($thisCount -eq 1) {
        Write-Host "[Split]Digit $_ detected $thisCount time"
    }else{
        Write-Host "[Split]Digit $_ not detected"
    }
}
