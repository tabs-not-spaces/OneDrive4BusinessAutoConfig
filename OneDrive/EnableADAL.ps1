$reg = New-Object PSObject -Property @{
    path  = "HKCU:\SOFTWARE\Microsoft\OneDrive"
    name  = "EnableADAL"
    value = "1"
}
function Write-LogFile {
    param (
        [string]$msg,
        [string]$logfile
    )
    if (!(Test-Path -Path $logFile)) {
        New-Item -Path $logfile -ItemType File -Force | Out-Null
    }
    $timeStamp = get-date -Format "dd-MM-yyyy_HH:mm:ss"
    $log = "$timestamp : $($msg)"
    write-host $log -ForegroundColor Green
    $log | Out-File $logfile -Force -Append
}
$logFile = "$env:TEMP\Logs\OneDrive-EnableADAL.log"
Write-LogFile -msg "OneDrive - Enabling ADAL" -logfile $logFile
if (!(Test-Path $reg.path)) {
    Write-LogFile -msg "Registry path : $($reg.path) not found. Creating now." -logfile $logFile
    New-Item -Path $reg.path -Force | Out-Null
    Write-LogFile -msg "Creating item property: $($reg.name) with value: $($reg.value)" -logfile $logFile
    New-ItemProperty -Path $reg.path -Name $reg.name -Value $reg.value -PropertyType DWORD -Force | Out-Null
}
else {
    Write-LogFile -msg "Registry path : $($reg.path) found." -logfile $logFile
    Write-LogFile -msg "Creating item property: $($reg.name) with value: $($reg.value)" -logfile $logFile
    New-ItemProperty -Path $reg.path -Name $reg.name -Value $reg.value -PropertyType DWORD -Force | Out-Null
}