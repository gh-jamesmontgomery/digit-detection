#Setup our input number explicitly as an Integer
[int]$inputNumber = 62419
#Iterate through the full digit range
0 .. 9 | ForEach-Object{
    #Test for this number being present. -match returns true or false.
    if($inputNumber -match "$_")
    {
        write-host "[match]$_ present"
    }
    else {
        write-host "[match]$_ not present"
    }
}
