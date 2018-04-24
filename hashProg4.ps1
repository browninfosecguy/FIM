function Get-Fim{
    param (
            $directory = 'C:\sunny'

    )

$filehash = @{}
Get-ChildItem -Path $directory -File -Recurse | Get-FileHash | Select-Object Path,Hash | foreach{$filehash[$_.path] = $_.hash}
$readcsv = Import-Csv ".\test.csv"
$filehashCount = $filehash.Count
$csvcount = $readcsv.Count
if($filehashCount -eq $csvcount)
{
    $readcsv|foreach{if($filehash.Contains($_.Path)){if($filehash.Values -eq $_.hash){Write-Host "Success "}else{Write-Host "Failure"}}}
}
else
{
   
    foreach($test in $filehash.Keys)
    {
        if($test -notin $readcsv.Path)
        {
            Write-Host $test
        }
    }
   
        
    
  }
}
Get-Fim
