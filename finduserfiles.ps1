#powershell -executionpolicy bypass -file 'findfilesutil.ps1' -Regex 'invoice'
param (
    $Regex = 'invoice',
    $Paths = 'Documents;Desktop;Downloads;Downloads\Telegram Desktop'
)
$results = @()
$Paths = $Paths -split ';'
$users = Get-ChildItem -Path 'C:\Users' -Directory | Where-Object {
    Test-Path "$($_.FullName)\Downloads"
}
foreach ($user in $users) {
    foreach ($path in $Paths) {
        $absolutePath = "$($user.FullName)\$path"
        Get-ChildItem -Path $absolutePath -ErrorAction SilentlyContinue | Where-Object {
            $_.Name -match $Regex
        } | ForEach-Object {
            $results += $_.FullName
        }
    }
}
$results = $results -join "`n"
Write-Host "`nRegex: $Regex"
Write-Host "`nPaths: $Paths"
Write-Host "`nResults:`n"
Write-Host $results
