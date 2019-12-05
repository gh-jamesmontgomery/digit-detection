#Continue options (comment/uncomment)
#$DebugPreference = "Continue"
$DebugPreference = "SilentlyContinue"

Function testNumber 
{
    param([int64]$lookingIn, $lookingFor)
    Write-Debug "Processing $lookingIn for digits $lookingFor"
    $foundInts = $true
    #Initialise found to true and set to false if we cannot locate a digit
 
    $lookingFor | ForEach-Object {
        if ($lookingIn.tostring().Contains([string]$_))
        {
            Write-Debug "[string contains]$_"
        }
        else {
            Write-Debug "[string does not contain]$_"
            $foundInts = $false
        }
    }

    return $foundInts
}

#Initialise our variables and controls
$matchCount = 0
$confirmCount = 0

#$confirmFindings if set to true will use a second means to test our digit detection
$confirmFindings = $true

#$evaluateRegex uses $confirmRegex to match our generated regex if set to $true
$evaluateRegex = $false
$confirmRegex = "\\b\(\?\:\(\[(1|12|123|1234|12345|123456|1234567|12345678|123456789)\]\)\(\?\!\[123456789\]\*\\1\)\)\+\\b"

$lastMatchingReading = 0
$theseMatches= [ordered]@{}
$theseConfirms= [ordered]@{}

[int64]$milesA = 100
[int64]$milesB = 10000

#Randomise the starting trip value
$thisTrip = Get-Random -Minimum 0 -Maximum 999
$startingTrip = $thisTrip
write-host "=== Begin ==="
write-host "Starting trip: $thisTrip"


$milesA..$milesB | ForEach-Object {

    $thisMile = $_
    #Write-Output "loop $thisMile" 
    if($thisTrip -lt 999)
    {
        $thisTrip++
    }
    else{
        #Roll over the trip computer at 1000 miles to 0
        write-host "Reseting trip at $thisMile" -ForegroundColor RED
        $thisTrip = 0
    }
    
    $combinedNumber = ($thisMile*1000)+$thisTrip
    Write-Debug "Odometer: $thisMile Trip: $thisTrip"
    Write-Debug "Processing combined number: $combinedNumber"

    #write-host "Generated $thisMile length:" ([string]$thisMile).length
    $theseUniqueDigits = (([string]$combinedNumber).tochararray() | Select-Object -Unique)  -join ""
    $uniqueLength = $theseUniqueDigits.Length
    $thisLength = ([string]$combinedNumber).length
    $matchedNumber = $false

    if($uniqueLength -lt $thisLength -and $uniqueLength -lt 9)
    {
        #Do not evaluate. If unique length is less there are duplicate digits
        Write-Debug "Not all unique numbers: $uniqueLength found"
        #write-host "Not evaluating $combinedNumber, duplicate digits"
        
    }
    elseif($uniqueLength -lt 9){
        #Evaluate and generate regex
        $lookingForInts = 1.. $thisLength
        $matchFor = $lookingForInts -join ""
        $match1 = "\b(?:([$matchFor])(?![123456789]*\1))+\b"
        Write-Debug "Evaluating (lt 9) $combinedNumber against regex $match1 "
        $matchedNumber = $combinedNumber -match $match1
        
    }
    elseif($uniqueLength -eq 9){
        #Use static regex as 9 digit length against unique digits
        $match1 = "\b(?:([123456789])(?![123456789]*\1))+\b"
        Write-Debug "Evaluating (eq 9) $theseUniqueDigits against regex $match1"
        $matchedNumber = $theseUniqueDigits -match $match1
    }elseif($uniqueLength -gt 9)
    {
        #Expecting 1234567890
        Write-Debug "Contains > 9 digits: $theseUniqueDigits"
    }
    
    if($matchedNumber){
        Write-Host "A match is found" -ForegroundColor Green
    }
    else {
        Write-Debug "Match not found"
    }

    if($evaluateRegex){
        write-debug "Confirming regex: $($match1 -match $confirmRegex)"
    }
    
    #Write-host "---"
    
    #Write-Debug "Processing $thisMile of length $(([string]$thisMile).length)"
    
    #Initialise boolean results for match/testing
    $confirmedNumber = $false
            
    #Confirm using alternative method above if $confirmFindings = $true
    if($confirmFindings){
        $confirmedNumber = testNumber -lookingIn $combinedNumber -lookingFor ($lookingForInts)
    }

    if($matchedNumber -and $confirmedNumber){

        Write-Output "Match1 & Confirmed $combinedNumber. Odometer: $thisMile Trip: $thisTrip, distance since last match: $($thisMile-$lastMatchingReading)"
        $lastMatchingReading = $thisMile
        $matchcount++
        $confirmCount++
        $theseMatches.Add($thisMile,$thisTrip)
        $theseConfirms.Add($thisMile,$thisTrip)
    }
    elseif( $matchedNumber){
        Write-Output "Match only $combinedNumber. Odometer: $thisMile Trip: $thisTrip, distance since last match: $($thisMile-$lastMatchingReading)"
        $lastMatchingReading = $thisMile
        $matchcount++
        $theseMatches.Add($thisMile,$thisTrip)
    }
    elseif ($confirmedNumber) {
        #This case exists if our primary and secondary means of validation fail to agree.
        Write-Output "TestNumber only $combinedNumber"
    }
}
write-host "=== Sumary ==="
"Matches: $matchcount"
"Confirms: $confirmCount"
"Matches = confirms count? $($theseConfirms.Count -eq $theseMatches.Count)"
"Starting journey at $milesA with trip: $startingTrip"
"End journey at $milesB with trip: $thisTrip"
write-host "=== End ==="
