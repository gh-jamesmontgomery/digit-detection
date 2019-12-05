$confirmRegex = "\\b\(\?\:\(\[(1|12|123|1234|12345|123456|1234567|12345678|123456789)\]\)\(\?\!\[123456789\]\*\\1\)\)\+\\b"
$testing = @()
$testing += Get-Random -Minimum 1 -Maximum 9
$testing += Get-Random -Minimum 10 -Maximum 99
$testing += Get-Random -Minimum 100 -Maximum 999
$testing += Get-Random -Minimum 1000 -Maximum 9999
$testing += Get-Random -Minimum 10000 -Maximum 99999
$testing += Get-Random -Minimum 100000 -Maximum 999999
$testing += Get-Random -Minimum 1000000 -Maximum 9999999
$testing += Get-Random -Minimum 10000000 -Maximum 99999999
$testing += Get-Random -Minimum 100000000 -Maximum 999999999
#Longer than 9
$testing += Get-Random -Minimum 1000000000 -Maximum 9999999999
$testing += Get-Random -Minimum 10000000000 -Maximum 99999999999
#Manual data
#Length 9
$testing += 123456789
$testing += 123456780
#Random generator 1-9 function?
#Length 10
$testing += 1234567891
$testing += 1234567880
$testing += 1234567890
$testing += 1234567098

$testing | ForEach-Object {
    write-host "Generated $_ length:" ([string]$_).length
    $theseUniqueDigits = (([string]$_).tochararray() | Select-Object -Unique)  -join ""
    $uniqueLength = $theseUniqueDigits.Length
    $thisLength = ([string]$_).length
    $matched = $false

    if($uniqueLength -lt $thisLength -and $uniqueLength -lt 9)
    {
        #Do not evaluate. If unique length is less there are duplicate digits
        Write-host "Not all unique numbers: $uniqueLength found" -ForegroundColor Red
        
    }
    elseif($uniqueLength -lt 9){
        #Evaluate and generate regex
        Write-Host "Less than 9 unique digits!" -ForegroundColor Gray
        $lookingForInts = 1.. $thisLength
        $matchFor = $lookingForInts -join ""
        $match1 = "\b(?:([$matchFor])(?![123456789]*\1))+\b"
        write-host "Evaluating $_ against regex $match1 :"
        $matched = $_ -match $match1
        
    }
    elseif($uniqueLength -eq 9){
        #Use static regex as 9 digit length against unique digits
        Write-Host "9 unique digits!" -ForegroundColor Blue
        $match1 = "\b(?:([123456789])(?![123456789]*\1))+\b"
        write-host "Evaluating $theseUniqueDigits against regex $match1 :"
        $matched = $theseUniqueDigits -match $match1
    }elseif($uniqueLength -gt 9)
    {
        #Expecting 1234567890
        Write-host "Contains 0 and > 9 digits: $theseUniqueDigits" -ForegroundColor Cyan
    }
    if($matched){
        Write-Host "A match is found" -ForegroundColor Green
    }
    else {
        Write-Host "Match not found" -ForegroundColor Yellow
    }
    write-debug "Confirming regex: $($match1 -match $confirmRegex)"
    Write-host "---"
    
}
