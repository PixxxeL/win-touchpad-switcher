$RegistryPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PrecisionTouchPad\Status'
$Name = 'Enabled'
$Value = '0'

if (Test-Path $RegistryPath) {
    $Result = Get-ItemProperty -Path $RegistryPath -Name $Name
    $Value = 1
    if ($Result.Enabled -eq 1) {
        $Value = 0
    }
    echo "Touchpad set to $Value"
    New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force
}
