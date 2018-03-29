
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
$regArray = @()
$tmpReg = New-Object PSObject -Property @{
    path  = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
    Name  = "SilentAccountConfig"
    value = "1"
}
$regArray += $tmpReg
$tmpReg = New-Object PSObject -Property @{
    path  = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
    name  = "FilesOnDemandEnabled"
    value = "1"
}
$regArray += $tmpReg
$logFile = "$env:TEMP\Logs\OneDrive-EnableAutoConfig.log"
Write-LogFile -msg "OneDrive - Enabling AutoConfig" -logfile $logFile

foreach ($reg in $regArray) {
    if (!(Test-Path $reg.path)) {
        Write-LogFile -msg "Registry path : $($reg.path) not found. Creating now." -logfile $logFile
        New-Item -Path $reg.path -Force | Out-Null
        Write-LogFile -msg "Creating item property: $($reg.name)" -logfile $logFile
        New-ItemProperty -Path $reg.path -Name $reg.name -Value $reg.value -PropertyType DWORD -Force | Out-Null
    }
    else {
        Write-LogFile -msg "Registry path : $($reg.path) found." -logfile $logFile
        Write-LogFile -msg "Creating item property: $($reg.name)" -logfile $logFile
        New-ItemProperty -Path $reg.path -Name $reg.name -Value $reg.value -PropertyType DWORD -Force | Out-Null
    }
}